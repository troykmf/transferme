import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_app_bar.dart';
import 'package:transferme/core/custom/custom_button.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/custom/custom_textfield.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/features/wallet/presentation/add_card_color_page.dart';
import 'package:transferme/features/wallet/presentation/wallets_page.dart';

class AddCardPage extends StatelessWidget {
  const AddCardPage({
    super.key,
    required this.cardNumberController,
    required this.holderNameController,
    required this.expiryDateController,
    required this.cvvController,
  });

  final TextEditingController cardNumberController;
  final TextEditingController holderNameController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        CustomButton(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddCardColorScreen()),
            );
          },
          width: 201,
          buttonTitle: 'Confirm',
        ),
      ],
      appBar: CustomAppBar(appBarTitle: 'Add Card'),
      body: SafeArea(
        child: ResponsivePadding(
          horizontal: 25,
          vertical: 16,
          child: Column(
            children: [
              Gap(20),
              Text(
                'To add a new card, please fill out the fields below carefully to add card successfully.',
                style: smallText(
                  isMobile ? 10 : 8,
                  AppColor.textLightGreyColor,
                  null,
                ),
                textAlign: TextAlign.start,
              ),
              Gap(35),
              CustomTextfield(
                text: 'Card Number',
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                obscureText: false,
                autocorrect: false,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(19), // 16 digits + 3 spaces
                  CardNumberFormatter(),
                ],
              ),
              isMobile ? Gap(10) : Gap(20),
              CustomTextfield(
                text: "Holder's Name",
                controller: holderNameController,
                keyboardType: TextInputType.text,
                obscureText: false,
                autocorrect: false,
              ),
              isMobile ? Gap(10) : Gap(20),
              CustomTextfield(
                text: 'Expiry Date ',
                controller: expiryDateController,
                keyboardType: TextInputType.number,
                obscureText: false,
                autocorrect: false,
              ),
              isMobile ? Gap(10) : Gap(20),
              CustomTextfield(
                text: 'CVV ',
                controller: cvvController,
                keyboardType: TextInputType.number,
                obscureText: false,
                autocorrect: false,
              ),
              Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
