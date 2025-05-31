import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_sales/contants.dart';
import 'package:medical_sales/core/services/fire_storage.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/backend_endpoint.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomImagePickier extends StatefulWidget {
  const CustomImagePickier({
    super.key,
    required this.onFileChanged,
    this.auth = false,
    this.urlImage,
    required this.radius,
    this.imageQuality = 80,
  });
 
  final ValueChanged<String?> onFileChanged;
  final bool auth;
  final String? urlImage;
  final double radius;
  final int imageQuality;

  @override
  State<CustomImagePickier> createState() => _CustomImagePickierState();
}

class _CustomImagePickierState extends State<CustomImagePickier> {
  bool isLoading = false;
  File? imageFile;
  String? url;

  Future<void> pickImage() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: widget.imageQuality,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null && mounted) {
        imageFile = File(image.path);

        final fileSize = await imageFile!.length();
        if (fileSize > 5 * 1024 * 1024) {
          throw Exception(
              'حجم الصورة كبير جداً. يجب أن يكون أقل من 5 ميجابايت');
        }

        url = await FireStorage() 
            .uploadFile(file: imageFile!, path: BackendEndpoint.images);
        widget.onFileChanged(url);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildPlaceholderIcon() {
    return Visibility(
      visible: imageFile == null &&
          widget.urlImage == null &&
          url == null &&
          widget.auth == false,
      child: const Icon(
        Icons.image_outlined,
        color: AppColor.grey,
        size: 100,
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return Positioned(
      right: 0,
      left: 0,
      bottom: -15,
      child: GestureDetector(
        onTap: isLoading ? null : pickImage,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isLoading
                ? AppColor.grey
                : widget.urlImage == null
                    ? AppColor.grey3
                    : AppColor.lightPrimaryColor,
          ),
          child: const Icon(
            Icons.add_a_photo_outlined,
            color: AppColor.black,
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Positioned(
      right: 0,
      left: -110,
      top: 15,
      child: Visibility(
        visible: url != null,
        child: GestureDetector(
          onTap: isLoading
              ? null
              : () {
                  setState(() {
                    url = null;
                    imageFile = null;
                    widget.onFileChanged(null);
                  });
                },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isLoading
                  ? AppColor.grey
                  : url == null
                      ? AppColor.grey3
                      : AppColor.lightPrimaryColor,
            ),
            child: const Icon(
              Icons.delete_outlined,
              color: AppColor.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Skeletonizer(
            enabled: isLoading,
            child: CircleAvatar(
              radius: widget.radius + 2,
              backgroundColor: widget.urlImage == null
                  ? AppColor.grey
                  : AppColor.darkPrimaryColor,
              child: CircleAvatar(
                radius: widget.radius,
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                child: ClipOval(
                  child: url != null
                      ? Image.network(
                          url!,
                          fit: BoxFit.cover,
                          width: widget.radius * 2,
                          height: widget.radius * 2,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        )
                      : widget.urlImage != null
                          ? Image.network(
                              widget.urlImage!,
                              fit: BoxFit.cover,
                              width: widget.radius * 2,
                              height: widget.radius * 2,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            )
                          : widget.auth == true
                              ? Image.network(
                                  imageProfile,
                                  fit: BoxFit.cover,
                                  width: widget.radius * 2,
                                  height: widget.radius * 2,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                )
                              : _buildPlaceholderIcon(),
                ),
              ),
            ),
          ),
        ),
        _buildAddPhotoButton(),
        _buildDeleteButton(),
      ],
    );
  }

  @override
  void dispose() {
    imageFile = null;
    super.dispose();
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:online_shop_dashboard/contants.dart';
// import 'package:online_shop_dashboard/core/services/supabase_storage.dart';
// import 'package:online_shop_dashboard/core/utils/app_color.dart';
// import 'package:online_shop_dashboard/core/utils/backend_endpoint.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class CustomImagePickier extends StatefulWidget {
//   const CustomImagePickier({
//     super.key,
//     required this.onFileChanged,
//     this.auth = false,
//     this.urlImage,
//     required this.radius,
//     this.imageQuality = 80,
//   });

//   final ValueChanged<String?> onFileChanged;
//   final bool auth;
//   final String? urlImage;
//   final double radius;
//   final int imageQuality;

//   @override
//   State<CustomImagePickier> createState() => _CustomImagePickierState();
// }

// class _CustomImagePickierState extends State<CustomImagePickier> {
//   bool isLoading = false;
//   File? imageFile;
//   String? url;

//   Future<void> pickImage() async {
//     if (mounted) {
//       setState(() {
//         isLoading = true;
//       });
//     }

//     try {
//       final ImagePicker picker = ImagePicker();
//       final XFile? image = await picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: widget.imageQuality,
//         maxWidth: 1024,
//         maxHeight: 1024,
//       );

//       if (image != null && mounted) {
//         imageFile = File(image.path);

//         final fileSize = await imageFile!.length();
//         if (fileSize > 5 * 1024 * 1024) {
//           throw Exception(
//               'حجم الصورة كبير جداً. يجب أن يكون أقل من 5 ميجابايت');
//         }

//         url = await SupabaseStorageService()
//             .uploadFile(file: imageFile!, path: BackendEndpoint.images);
//         widget.onFileChanged(url);
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('حدث خطأ: ${e.toString()}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }

//     if (mounted) {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Widget _buildPlaceholderIcon() {
//     return Visibility(
//       visible: imageFile == null &&
//           widget.urlImage == null &&
//           url == null &&
//           widget.auth == false,
//       child: const Icon(
//         Icons.image_outlined,
//         color: AppColor.grey,
//         size: 100,
//       ),
//     );
//   }

//   Widget _buildAddPhotoButton() {
//     return Positioned(
//       right: 0,
//       left: 0,
//       bottom: -15,
//       child: GestureDetector(
//         onTap: isLoading ? null : pickImage,
//         child: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: isLoading
//                 ? AppColor.grey
//                 : widget.urlImage == null
//                     ? AppColor.grey3
//                     : AppColor.lightPrimaryColor,
//           ),
//           child: const Icon(
//             Icons.add_a_photo_outlined,
//             color: AppColor.black,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDeleteButton() {
//     return Positioned(
//       right: 0,
//       left: -110,
//       top: 15,
//       child: Visibility(
//         visible: url != null,
//         child: GestureDetector(
//           onTap: isLoading
//               ? null
//               : () {
//                   setState(() {
//                     url = null;
//                     imageFile = null;
//                     widget.onFileChanged(null);
//                   });
//                 },
//           child: Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: isLoading
//                   ? AppColor.grey
//                   : url == null
//                       ? AppColor.grey3
//                       : AppColor.lightPrimaryColor,
//             ),
//             child: const Icon(
//               Icons.delete_outlined,
//               color: AppColor.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Center(
//           child: Skeletonizer(
//             enabled: isLoading,
//             child: CircleAvatar(
//               radius: widget.radius + 2,
//               backgroundColor: widget.urlImage == null
//                   ? AppColor.grey
//                   : AppColor.darkPrimaryColor,
//               child: CircleAvatar(
//                 radius: widget.radius,
//                 backgroundColor: Theme.of(context).colorScheme.onPrimary,
//                 backgroundImage: url != null
//                     ? NetworkImage(
//                         url!,
//                         // errorBuilder: (context, error, stackTrace) {
//                         //   return const Icon(
//                         //     Icons.error_outline,
//                         //     color: Colors.red,
//                         //   );
//                         // },
//                       )
//                     : widget.urlImage != null
//                         ? NetworkImage(
//                             widget.urlImage!,
//                             // errorBuilder: (context, error, stackTrace) {
//                             //   return const Icon(
//                             //     Icons.error_outline,
//                             //     color: Colors.red,
//                             //   );
//                             // },
//                           )
//                         : widget.auth == true
//                             ? const NetworkImage(imageProfile)
//                             : null,
//                 child: _buildPlaceholderIcon(),
//               ),
//             ),
//           ),
//         ),
//         _buildAddPhotoButton(),
//         _buildDeleteButton(),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     imageFile = null;
//     super.dispose();
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:online_shop_dashboard/contants.dart';
// import 'package:online_shop_dashboard/core/services/supabase_storage.dart';
// import 'package:online_shop_dashboard/core/utils/app_color.dart';
// import 'package:online_shop_dashboard/core/utils/backend_endpoint.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// // import 'package:path/path.dart' as b;

// class CustomImagePickier extends StatefulWidget {
//   const CustomImagePickier({
//     super.key,
//     required this.onFileChanged,
//     this.auth = false,
//     this.urlImage,
//     required this.radius,
//   });
//   final ValueChanged<String?> onFileChanged;
//   final bool auth;
//   final String? urlImage;
//   final double radius;

//   @override
//   State<CustomImagePickier> createState() => _CustomImagePickierState();
// }

// class _CustomImagePickierState extends State<CustomImagePickier> {
//   bool isLoading = false;
//   File? imageFile;
//   var url;
//   // final ImagePicker picker = ImagePicker();

//   Future<void> pickImage() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       final ImagePicker picker = ImagePicker();
//       final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//       // final storageReference = FirebaseStorage.instance.ref();
//       if (image != null) {
//         // final ImagePicker picker = ImagePicker();
//         // final XFile? image =
//         //     await picker.pickImage(source: ImageSource.gallery);
//         // imageFile = File(image!.path);
//         // widget.onFileChanged(imageFile!);

//         imageFile = File(image.path);
//         url = await SupabaseStorageService()
//             .uploadFile(file: imageFile!, path: BackendEndpoint.images);
//         widget.onFileChanged(url);
//         // imageFile = File(image.path);
//         // var fileName = basename(imageFile!.path);
//         // var extensionName = extension(imageFile!.path);
//         // var refStorage = storageReference
//         //     .child('${BackendEndpoint.images}/$fileName.$extensionName');
//         // await refStorage.putFile(imageFile!);
//         // url = await refStorage.getDownloadURL();
//         // widget.onFileChanged(url);
//         // print(url);
//       }
//       // imageFile = File(image!.path);
//       // widget.onFileChanged(imageFile!);
//     } catch (e) {
//       isLoading = false;
//       setState(() {});
//     }
//     setState(() {
//       isLoading = false;
//     });
//     // final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     // if (pickedFile != null) {
//     //   setState(() {
//     //     image = File(pickedFile.path);
//     //   });

//     //   widget.imagePick(File(image!.path));
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Center(
//           child: Skeletonizer(
//             enabled: isLoading,
//             child: CircleAvatar(
//               radius: widget.radius + 2,
//               backgroundColor: widget.urlImage == null
//                   ? AppColor.grey
//                   : AppColor.darkPrimaryColor,
//               child: CircleAvatar(
//                 radius: widget.radius,
//                 backgroundColor: Theme.of(context).colorScheme.onPrimary,
//                 backgroundImage: url != null
//                     // ?CustomCachedImage(image: url!, width: 50, height: 50)
//                     ? NetworkImage(url!)
//                     : widget.urlImage != null
//                         ? NetworkImage(widget.urlImage!)
//                         : widget.auth == true
//                             ? const NetworkImage(imageProfile)
//                             : null,
//                 // : imageFile != null
//                 //     ? FileImage(imageFile!)
//                 //
//                 //         : null,
//                 child: Visibility(
//                   visible: imageFile == null &&
//                       widget.urlImage == null &&
//                       url == null &&
//                       widget.auth == false,
//                   child: const Icon(
//                     Icons.image_outlined,
//                     color: AppColor.grey,
//                     size: 100,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           right: 0,
//           left: 0,
//           bottom: -15,
//           child: GestureDetector(
//             onTap: pickImage,
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: widget.urlImage == null
//                     ? AppColor.grey3
//                     : AppColor.lightPrimaryColor,
//               ),
//               child: const Center(
//                 child: Icon(
//                   Icons.add_a_photo_outlined,
//                   color: AppColor.black,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           right: 0,
//           left: -110,
//           top: 15,
//           child: Visibility(
//             visible: url != null,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   url = null;
//                   imageFile = null;
//                   widget.onFileChanged(null);
//                 });
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color:
//                       url == null ? AppColor.grey3 : AppColor.lightPrimaryColor,
//                 ),
//                 child: const Icon(
//                   Icons.delete_outlined,
//                   color: AppColor.black,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
