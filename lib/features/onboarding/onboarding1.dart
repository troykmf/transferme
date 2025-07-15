import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transferme/core/custom/custom_dot_indicatior.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/features/auth/sign_up/screen/sign_up_screen.dart';
import 'package:transferme/features/onboarding/model/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingPages.length,

        onPageChanged: (value) => setState(() => _currentPage = value),
        itemBuilder: (context, index) {
          final data = onboardingPages[index];
          return SafeArea(
            child: ResponsivePadding(
              child: Column(
                children: [
                  // image
                  SvgPicture.asset(data.image),

                  // title
                  Text(
                    data.title,
                    style: headlineText(30, AppColor.blackColor, null),
                  ),

                  // subtitle
                  Text(
                    data.title,
                    style: mediumText(11, AppColor.blackColor, null),
                  ),

                  // dot indicator
                  CustomDotIndicatior(
                    currentIndex: _currentPage,
                    count: onboardingPages.length,
                  ),

                  // button

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
