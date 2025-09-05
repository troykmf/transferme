import 'package:flutter/material.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';

// class CustomAppLogo extends StatelessWidget {
//   const CustomAppLogo({
//     super.key,
//     required this.primaryColorContainerWidth,
//     required this.primaryColorContainerHeight,
//     required this.secondaryColorContainerWidth,
//     required this.secondaryColorContainerHeight,
//     this.firstContainerLeftPosition,
//     this.secondContainerRightPosition,
//   });

//   final double primaryColorContainerWidth;
//   final double primaryColorContainerHeight;
//   final double secondaryColorContainerWidth;
//   final double secondaryColorContainerHeight;
//   final double? firstContainerLeftPosition;
//   final double? secondContainerRightPosition;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           left: firstContainerLeftPosition ?? 30,
//           child: Container(
//             width: primaryColorContainerWidth,
//             height: primaryColorContainerHeight,
//             // width: ResponsiveHelper.width(83),
//             // height: ResponsiveHelper.height(83),
//             decoration: BoxDecoration(
//               color: AppColor.primaryColor,
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),
//         Positioned(
//           right: secondContainerRightPosition ?? 0,
//           child: Container(
//             width: secondaryColorContainerWidth,
//             height: secondaryColorContainerHeight,
//             // width: ResponsiveHelper.width(83),
//             // height: ResponsiveHelper.height(83),
//             decoration: BoxDecoration(
//               color: AppColor.secondaryColor,
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class CustomAppLogo extends StatelessWidget {
  const CustomAppLogo({
    super.key,
    required this.primaryColorContainerWidth,
    required this.primaryColorContainerHeight,
    required this.secondaryColorContainerWidth,
    required this.secondaryColorContainerHeight,
    this.firstContainerLeftPosition,
    this.secondContainerRightPosition,
  });

  final double primaryColorContainerWidth;
  final double primaryColorContainerHeight;
  final double secondaryColorContainerWidth;
  final double secondaryColorContainerHeight;
  final double? firstContainerLeftPosition;
  final double? secondContainerRightPosition;

  @override
  Widget build(BuildContext context) {
    // Adjust positioning multiplier for tablets
    final positionMultiplier = ResponsiveHelper.isMobile ? 1.0 : 1.5;

    return Stack(
      children: [
        Positioned(
          left: ResponsiveHelper.width(
            (firstContainerLeftPosition ?? 30) * positionMultiplier,
          ),
          child: Container(
            width: ResponsiveHelper.size(primaryColorContainerWidth),
            height: ResponsiveHelper.size(primaryColorContainerHeight),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: ResponsiveHelper.width(
            (secondContainerRightPosition ?? 0) * positionMultiplier,
          ),
          child: Container(
            width: ResponsiveHelper.size(secondaryColorContainerWidth),
            height: ResponsiveHelper.size(secondaryColorContainerHeight),
            decoration: BoxDecoration(
              color: AppColor.secondaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
