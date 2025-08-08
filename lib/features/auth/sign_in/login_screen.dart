import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_app_bar.dart';
import 'package:transferme/core/custom/custom_app_logo.dart';
import 'package:transferme/core/custom/custom_button.dart' show CustomButton;
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/custom/custom_textfield.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/core/util/helpers/validation_helper.dart';
import 'package:transferme/features/auth/data/provider/auth_provider.dart';
import 'package:transferme/features/auth/sign_in/password_screen.dart';
import 'package:transferme/features/auth/sign_up/screen/sign_up_screen.dart';

// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});
//   final TextEditingController _emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(appBarTitle: 'Login'),
//       body: ResponsivePadding(
//         horizontal: 20,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Gap(40),
//             Text(
//               textAlign: TextAlign.center,
//               'Please enter \nyour email address',
//               style: mediumText(12, AppColor.lightGreyColor, null),
//             ),
//             Gap(30),
//             CustomTextfield(
//               text: 'Email Address',
//               controller: _emailController,
//               keyboardType: TextInputType.emailAddress,
//               validator: (value) => ValidationUtils.validateEmail(value),
//               hintText: 'example@gmail.com',
//               obscureText: false,
//               autocorrect: false,
//             ),
//             Gap(50),
//             CustomButton(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => SetPinCodeScreen()),
//                 );
//               },
//               width: 133,
//               buttonTitle: 'Proceed',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late TapGestureRecognizer _textRecognizer;

  final GlobalKey _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    // Add listeners to update form validity
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);

    _textRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
          (route) => false,
        );
      };
  }

  String? _validateEmail(String value) => ValidationUtils.validateEmail(value);
  String? _validatePassword(String value) =>
      ValidationUtils.validatePassword(value);

  void _validateForm() {
    setState(() {
      _isFormValid =
          _validateEmail(_emailController.text.trim()) == null &&
          _validatePassword(_passwordController.text.trim()) == null;
    });
  }

  void handleLogin() {
    if (_isFormValid) {
      final authNotifier = ref.read(authProvider.notifier);
      authNotifier
          .login(
            context: context,
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          )
          .then((_) {
            // No need to manually update state here; AuthNotifier handles it
          })
          .catchError((error) {
            // Error is already handled by AuthNotifier with dialogs
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      body: SafeArea(
        child: ResponsivePadding(
          horizontal: 20,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: ResponsiveHelper.width(130),
                  height: ResponsiveHelper.height(60),
                  child: CustomAppLogo(
                    firstContainerLeftPosition: 0,
                    secondContainerRightPosition: 55,
                    primaryColorContainerWidth: ResponsiveHelper.width(47),
                    primaryColorContainerHeight: ResponsiveHelper.height(47),
                    secondaryColorContainerWidth: ResponsiveHelper.width(47),
                    secondaryColorContainerHeight: ResponsiveHelper.height(47),
                  ),
                ),
                Gap(10),
                Text(
                  'Log In',
                  style: extraBoldText(35, AppColor.blackColor, -1.5),
                ),
                Gap(20),
                // email textfield
                CustomTextfield(
                  text: 'Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => ValidationUtils.validateEmail(value),
                  hintText: 'example@gmail.com',
                  obscureText: false,
                  autocorrect: false,
                ),
                Gap(20),
                // password textfield
                CustomTextfield(
                  text: 'Password',
                  controller: _passwordController,
                  keyboardType: TextInputType.number,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.visibility_off,
                      size: 15,
                      color: AppColor.textLightGreyColor,
                    ),
                  ),
                  obscureText: false,
                  autocorrect: false,
                  validator: ValidationUtils.validatePassword,
                ),

                Gap(50),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      CustomButton(
                        onTap: () {
                          if (authState.isLoading || !_isFormValid) {
                            return;
                          } else {
                            handleLogin();
                          }
                        },
                        width: 201,
                        buttonTitle: 'Log In',
                      ),
                      Gap(30),
                      RichText(
                        text: TextSpan(
                          style: mediumText(
                            13,
                            AppColor.textLightGreyColor,
                            null,
                          ),
                          children: [
                            TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              recognizer: _textRecognizer,
                              text: 'Sign Up',
                              style: mediumText(
                                13,
                                AppColor.primaryColor,
                                null,
                              ).copyWith(decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
