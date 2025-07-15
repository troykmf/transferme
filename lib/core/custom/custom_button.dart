import 'package:flutter/material.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.width,
    required this.buttonTitle,
  });

  final VoidCallback onTap;
  final double width;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        child: Container(
          width: ResponsiveHelper.width(width),
          height: ResponsiveHelper.height(45),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ResponsiveHelper.width(16)),
            color: AppColor.primaryColor,
          ),
          child: Center(
            child: Text(
              buttonTitle,
              style: headlineText(16, AppColor.whiteColor, null),
            ),
          ),
        ),
      ),
    );
  }
}
