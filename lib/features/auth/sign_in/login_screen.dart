import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_app_bar.dart';
import 'package:transferme/core/custom/custom_button.dart' show CustomButton;
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/custom/custom_textfield.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/core/util/helpers/validation_helper.dart';
import 'package:transferme/features/auth/sign_in/password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: 'Login'),
      body: ResponsivePadding(
        horizontal: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(40),
            Text(
              textAlign: TextAlign.center,
              'Please enter \nyour email address',
              style: mediumText(12, AppColor.lightGreyColor, null),
            ),
            Gap(30),
            CustomTextfield(
              text: 'Email Address',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => ValidationUtils.validateEmail(value),
              hintText: 'example@gmail.com',
              obscureText: false,
              autocorrect: false,
            ),
            Gap(50),
            CustomButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SetPinCodeScreen()),
                );
              },
              width: 133,
              buttonTitle: 'Proceed',
            ),
          ],
        ),
      ),
    );
  }
}
