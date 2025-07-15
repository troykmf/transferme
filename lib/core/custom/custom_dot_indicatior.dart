import 'package:flutter/material.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';

class CustomDotIndicatior extends StatelessWidget {
  const CustomDotIndicatior({
    super.key,
    required this.currentIndex,
    required this.count,
  });
  final int currentIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.width(3),
            vertical: ResponsiveHelper.height(2),
          ),
          width: ResponsiveHelper.width(5),
          height: ResponsiveHelper.height(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex
                ? AppColor.primaryColor
                : AppColor.lightSeaGreenColor,
          ),
        ),
      ),
    );
  }
}
