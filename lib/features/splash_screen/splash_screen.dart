import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_app_logo.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/core/util/app_theme.dart';
import 'package:transferme/features/onboarding/welcome_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();

  @override
  void initState() {
    super.initState();
    // Navigate to the main screen after 3 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      width: ResponsiveHelper.designWidth,
      height: ResponsiveHelper.designHeight,
      decoration: BoxDecoration(color: AppTheme.theme.scaffoldBackgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          SizedBox(
            width: ResponsiveHelper.width(170),
            height: ResponsiveHelper.height(90),
            child: CustomAppLogo(
              primaryColorContainerWidth: ResponsiveHelper.width(83),
              primaryColorContainerHeight: ResponsiveHelper.height(83),
              secondaryColorContainerWidth: ResponsiveHelper.width(83),
              secondaryColorContainerHeight: ResponsiveHelper.height(83),
            ),
          ),
          Gap(30),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'TransferMe',
                  style: headlineText(50, AppColor.primaryColor, -2),
                ),
                TextSpan(
                  text: '\nYour Best Money Transfer Partner.',
                  style: mediumText(
                    13,
                    AppColor.primaryColor,
                    -1,
                  ).copyWith(height: 2),
                ),
              ],
            ),
          ),
          Gap(30),
          Spacer(),
          ResponsivePadding(
            bottom: 16,
            child: RichText(
              text: TextSpan(
                style: regularText(14, AppColor.primaryColor, null),
                children: [
                  TextSpan(
                    text: 'Secured by ',
                    style: TextStyle(color: AppColor.textLightGreyColor),
                  ),
                  TextSpan(text: 'TransferMe'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
