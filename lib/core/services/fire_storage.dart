import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:medical_sales/core/services/storage_service.dart';
import 'package:path/path.dart' as b;

class FireStorage implements StorageService {
  final storageReference = FirebaseStorage.instance.ref();
  @override
  Future<String> uploadFile({required File file, required String path}) async {
    String fileName = b.basename(file.path);
    String extentionName = b.extension(file.path);
    var imageRefrence =
        storageReference.child('$path/$fileName.$extentionName');
    await imageRefrence.putFile(file);
    var imageUrl = imageRefrence.getDownloadURL();
    return imageUrl;
  }
}
