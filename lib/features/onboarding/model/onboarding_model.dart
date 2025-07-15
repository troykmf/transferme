import 'package:transferme/core/util/app_assets.dart';

class OnboardingModel {
  final String title;
  final String subtitle;
  final String image;

  OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

final List<OnboardingModel> onboardingPages = [
  OnboardingModel(
    title: 'Easy, Fast & Trusted',
    subtitle:
        'Fast money transfer and guaranted safe transactions with others.',
    image: AppSvgs.onboarding1,
  ),
  OnboardingModel(
    title: 'Saving Your Money',
    subtitle:
        'Track the progress of your savings and start a habit of saving with TransaferMe.',
    image: AppSvgs.onboarding2,
  ),
  OnboardingModel(
    title: 'Free Transactions',
    subtitle:
        'Provides the quality of the transaction system with free money transactions without any fees.',
    image: AppSvgs.onboarding3,
  ),
  OnboardingModel(
    title: 'International Transactions',
    subtitle:
        'Provides the 100% freedom of the financial management with the lowest fees on international transactions.',
    image: AppSvgs.onboarding4,
  ),
  OnboardingModel(
    title: 'Multiple Credit Cards',
    subtitle:
        'Provides the 100% freedom of the financial management with Multiple Payment Options for local and International Payments',
    image: AppSvgs.onboarding5,
  ),
  OnboardingModel(
    title: 'Bills Payment Made Easy',
    subtitle: 'Pay monthly or daily bills at home in a site of TransferMe.',
    image: AppSvgs.onboarding6,
  ),
  OnboardingModel(
    title: 'Color Your Cards',
    subtitle:
        'Provides better cards management when using Multiple Cards by using a different color for each payment method.',
    image: AppSvgs.onboarding7,
  ),
];
