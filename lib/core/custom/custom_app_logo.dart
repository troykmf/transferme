import 'package:flutter/material.dart';
import 'package:transferme/core/util/app_color.dart';

class CustomAppLogo extends StatelessWidget {
  const CustomAppLogo({
    super.key,
    required this.primaryColorContainerWidth,
    required this.primaryColorContainerHeight,
    required this.secondaryColorContainerWidth,
    required this.secondaryColorContainerHeight,
  });

  final double primaryColorContainerWidth;
  final double primaryColorContainerHeight;
  final double secondaryColorContainerWidth;
  final double secondaryColorContainerHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 30,
          child: Container(
            width: primaryColorContainerWidth,
            height: primaryColorContainerHeight,
            // width: ResponsiveHelper.width(83),
            // height: ResponsiveHelper.height(83),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: secondaryColorContainerWidth,
            height: secondaryColorContainerHeight,
            // width: ResponsiveHelper.width(83),
            // height: ResponsiveHelper.height(83),
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
