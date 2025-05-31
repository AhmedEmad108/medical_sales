import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class InActiveItem extends StatelessWidget {
  const InActiveItem({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      width: 24,
      height: 24,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:medical_sales/features/main/domain/entities/bottom_navigation_bar_entity.dart';
// import 'package:svg_flutter/svg.dart';

// class InActiveItem extends StatelessWidget {
//   const InActiveItem({super.key, required this.bottomNavigationBarEntity});

//   final BottomNavigationBarEntity bottomNavigationBarEntity;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         height: 40,
//         // decoration: ShapeDecoration(
//         //   color: Theme.of(context).colorScheme.onSurface,
//         //   shape: RoundedRectangleBorder(
//         //     borderRadius: BorderRadius.circular(30),
//         //   ),
//         // ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 40,
//               height: 40,
//               decoration: ShapeDecoration(
//                 // color: AppColor.primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               child: Center(
//                 child: SvgPicture.asset(
//                   bottomNavigationBarEntity.inActiveImage,
//                   width: 24,
//                   height: 24,
//                   color: Theme.of(context).colorScheme.secondary,
//                 ),
//                 // child: SvgPicture.asset(
//                 //   bottomNavigationBarEntity.inActiveImage,
//                 //   width: 24,
//                 //   height: 24,
//                 //   color: Theme.of(context).colorScheme.onPrimary,
//                 // )
//               ),
//             ),
//             // const SizedBox(
//             //   width: 8,
//             // ),
//             Flexible(
//               child: FittedBox(
//                 fit: BoxFit.scaleDown,
//                 child: Text(
//                   bottomNavigationBarEntity.name,
//                   style: Theme.of(context).textTheme.bodySmall,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 5),
//           ],
//         ),
//       ),
//     );

//     // return SvgPicture.asset(
//     //   image,
//     //   width: 24,
//     //   height: 24,
//     //   color: Theme.of(context).colorScheme.secondary,
//     // );
//   }
// }
