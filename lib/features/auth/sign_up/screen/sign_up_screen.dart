import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_app_logo.dart';
import 'package:transferme/core/custom/custom_button.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/custom/custom_textfield.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  void _handleSignUp() {}

  @override
  Widget build(BuildContext context) {
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
                  'Sign Up',
                  style: extraBoldText(35, AppColor.blackColor, -1.5),
                ),
                Gap(20),
                // email textfield
                CustomTextfield(
                  text: 'Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'example@gmail.com',
                    hintStyle: mediumText(
                      13,
                      AppColor.textLightGreyColor,
                      null,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: ResponsiveHelper.height(10),
                    ),
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.textLightGreyColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.primaryColor,
                        // width: 0.5,
                      ),
                    ),
                  ),
                  obscureText: false,
                  autocorrect: false,
                ),
                Gap(20),
                // password textfield
                CustomTextfield(
                  text: 'Password',
                  controller: _passwordController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.visibility_off,
                        size: 15,
                        color: AppColor.textLightGreyColor,
                      ),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: ResponsiveHelper.height(10),
                    ),
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.textLightGreyColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.primaryColor,
                        // width: 0.5,
                      ),
                    ),
                  ),
                  obscureText: false,
                  autocorrect: false,
                ),
                Gap(20),
                // confirm password textfield
                CustomTextfield(
                  text: 'Confirm Password',
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.visibility_off,
                        size: 15,
                        color: AppColor.textLightGreyColor,
                      ),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: ResponsiveHelper.height(10),
                    ),
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.textLightGreyColor,
                        // width: 0.5,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.primaryColor,
                        // width: 0.5,
                      ),
                    ),
                  ),
                  obscureText: false,
                  autocorrect: false,
                ),
                Gap(50),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      CustomButton(
                        onTap: () {},
                        width: 201,
                        buttonTitle: 'Sign Up',
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
                            TextSpan(text: 'Already have an account? '),
                            TextSpan(
                              text: 'Login',
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
