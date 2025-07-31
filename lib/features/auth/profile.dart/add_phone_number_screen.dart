import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transferme/core/custom/custom_button.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/custom/custom_textfield.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transferme/core/util/helpers/validation_helper.dart';
import 'package:transferme/features/auth/data/provider/auth_provider.dart';

class AddPhoneNumberScreen extends ConsumerStatefulWidget {
  const AddPhoneNumberScreen({
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    super.key,
  });
  final String firstName;
  final String lastName;
  final XFile? profilePicture;

  @override
  ConsumerState<AddPhoneNumberScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<AddPhoneNumberScreen> {
  late final TextEditingController _phoneNumberController;
  String? _errorText;

  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    super.initState();
  }

  void _validateAndSavePhoneNumber() {
    final phoneNumber = _phoneNumberController.text.trim();
    final error = ValidationUtils.validatePhoneNumber(phoneNumber);
    if (error == null) {
      setState(() {
        _errorText = null;
      });
      ref
          .read(authProvider.notifier)
          .completeProfile(
            context: context,
            firstName: widget.firstName,
            lastName: widget.lastName,
            phoneNumber: phoneNumber,
            // profilePicture: widget.profilePicture,
          );
    } else {
      setState(() {
        _errorText = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(
            children: [
              ResponsiveContainer(
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 50,
                height: 25,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColor.whiteColor,
                  size: 15,
                ),
              ),
              Gap(65),
              Text(
                'Phone Number',
                style: headlineText(14, AppColor.blackColor, null),
              ),
            ],
          ),
        ),
      ),
      body: ResponsivePadding(
        horizontal: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(40),
            Text(
              textAlign: TextAlign.center,
              'Please add \nyour mobile phone number',
              style: mediumText(12, AppColor.lightGreyColor, null),
            ),
            Gap(30),
            if (authState.profileImagePath != null)
              Column(
                children: [
                  ResponsiveContainer(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: FileImage(File(authState.profileImagePath!)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Gap(10),
                  Text(
                    '${widget.firstName} ${widget.lastName}',
                    style: headlineText(16, AppColor.blackColor, null),
                  ),
                  Gap(20),
                ],
              ),
            CustomTextfield(
              text: 'Phone Number',
              controller: _phoneNumberController,
              keyboardType: TextInputType.number,
              obscureText: false,
              autocorrect: false,
            ),
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorText!,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            Gap(20),
            Gap(50),
            CustomButton(
              onTap: () {
                if (authState.isLoading) {
                  return;
                } else {
                  _validateAndSavePhoneNumber();
                }
              },
              width: 133,
              buttonTitle: authState.isLoading ? 'Loading...' : 'Confirm',
            ),
          ],
        ),
      ),
    );
  }
}
