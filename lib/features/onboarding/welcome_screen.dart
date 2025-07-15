import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_app_logo.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/features/onboarding/onboarding1.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      width: ResponsiveHelper.designWidth,
      height: ResponsiveHelper.designHeight,
      decoration: BoxDecoration(color: AppColor.whiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              Gap(20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome To ',
                      style: headlineText(43, AppColor.blackColor, -2),
                    ),
                    TextSpan(
                      text: '\nTransferMe.',
                      style: headlineText(38, AppColor.primaryColor, -2),
                    ),
                    TextSpan(
                      text: '\nYour Best Money Transfer Partner.',
                      style: smallText(
                        11,
                        AppColor.textLightGreyColor,
                        -1,
                      ).copyWith(height: 4),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(120),
          ResponsiveButton(
            text: 'Get Started',
            width: 201,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OnboardingScreen()),
              );
            },
          ),
          Gap(120),
        ],
      ),
    );
  }
}
