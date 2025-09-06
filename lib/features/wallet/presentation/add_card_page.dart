// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gap/gap.dart';
// import 'package:transferme/core/custom/custom_app_bar.dart';
// import 'package:transferme/core/custom/custom_button.dart';
// import 'package:transferme/core/custom/custom_responsive_widgets.dart';
// import 'package:transferme/core/custom/custom_textfield.dart';
// import 'package:transferme/core/util/app_color.dart';
// import 'package:transferme/core/util/app_responsive_helper.dart';
// import 'package:transferme/core/util/app_style.dart';
// import 'package:transferme/features/wallet/presentation/add_card_color_page.dart';
// import 'package:transferme/features/wallet/presentation/wallets_page.dart';

// class AddCardPage extends StatelessWidget {
//   const AddCardPage({
//     super.key,
//     required this.cardNumberController,
//     required this.holderNameController,
//     required this.expiryDateController,
//     required this.cvvController,
//   });

//   final TextEditingController cardNumberController;
//   final TextEditingController holderNameController;
//   final TextEditingController expiryDateController;
//   final TextEditingController cvvController;

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = ResponsiveHelper.isMobile;
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       persistentFooterAlignment: AlignmentDirectional.center,
//       persistentFooterButtons: [
//         CustomButton(
//           onTap: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(builder: (context) => AddCardColorScreen()),
//             );
//           },
//           width: 201,
//           buttonTitle: 'Confirm',
//         ),
//       ],
//       appBar: CustomAppBar(appBarTitle: 'Add Card'),
//       body: SafeArea(
//         child: ResponsivePadding(
//           horizontal: 25,
//           vertical: 16,
//           child: Column(
//             children: [
//               Gap(20),
//               Text(
//                 'To add a new card, please fill out the fields below carefully to add card successfully.',
//                 style: smallText(
//                   isMobile ? 10 : 8,
//                   AppColor.textLightGreyColor,
//                   null,
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//               Gap(35),
//               CustomTextfield(
//                 text: 'Card Number',
//                 controller: cardNumberController,
//                 keyboardType: TextInputType.number,
//                 obscureText: false,
//                 autocorrect: false,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.digitsOnly,
//                   LengthLimitingTextInputFormatter(19), // 16 digits + 3 spaces
//                   CardNumberFormatter(),
//                 ],
//               ),
//               isMobile ? Gap(10) : Gap(20),
//               CustomTextfield(
//                 text: "Holder's Name",
//                 controller: holderNameController,
//                 keyboardType: TextInputType.text,
//                 obscureText: false,
//                 autocorrect: false,
//               ),
//               isMobile ? Gap(10) : Gap(20),
//               CustomTextfield(
//                 text: 'Expiry Date ',
//                 controller: expiryDateController,
//                 keyboardType: TextInputType.number,
//                 obscureText: false,
//                 autocorrect: false,
//               ),
//               isMobile ? Gap(10) : Gap(20),
//               CustomTextfield(
//                 text: 'CVV ',
//                 controller: cvvController,
//                 keyboardType: TextInputType.number,
//                 obscureText: false,
//                 autocorrect: false,
//               ),
//               Gap(50),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transferme/core/custom/custom_app_bar.dart';
import 'package:transferme/core/custom/custom_button.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/custom/custom_textfield.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/features/home/data/card_remote_data_sources.dart';
import 'package:transferme/features/wallet/presentation/add_card_color_page.dart';

class AddCardPage extends ConsumerWidget {
  final CardDetails? editingCard;

  const AddCardPage({super.key, this.editingCard});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveHelper.isMobile;
    final formKey = GlobalKey<FormState>();
    final cardNumberController = TextEditingController(
      text: editingCard?.cardNumber ?? '',
    );
    final holderNameController = TextEditingController(
      text: editingCard?.holdersName ?? '',
    );
    final expiryDateController = TextEditingController(
      text: editingCard?.expiryDate ?? '',
    );
    final cvvController = TextEditingController(text: editingCard?.cvv ?? '');

    return Scaffold(
      resizeToAvoidBottomInset: true,
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        CustomButton(
          onTap: () {
            if (formKey.currentState!.validate()) {
              final card = CardDetails(
                id: editingCard?.id,
                cardNumber: cardNumberController.text,
                holdersName: holderNameController.text,
                expiryDate: expiryDateController.text,
                cvv: cvvController.text,
                color: editingCard?.color ?? 'light blue',
                date: DateTime.now(),
                cardType: CardValidator.detectCardType(
                  cardNumberController.text,
                ),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddCardColorScreen(cardDetails: card),
                ),
              );
            }
          },
          width: 201,
          buttonTitle: editingCard != null ? 'Update Details' : 'Confirm',
        ),
      ],
      appBar: CustomAppBar(
        appBarTitle: editingCard != null ? 'Edit Card Details' : 'Add Card',
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
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
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  text: 'Card Number',
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  autocorrect: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    _CardNumberInputFormatter(),
                  ],
                  validator: (value) {
                    if (value?.isEmpty ?? true)
                      return 'Please enter card number';
                    if (!CardValidator.validateCardNumber(value!))
                      return 'Invalid card number';
                    return null;
                  },
                ),
                isMobile ? Gap(10) : Gap(20),
                CustomTextfield(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  text: "Holder's Name",
                  controller: holderNameController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  autocorrect: false,
                  validator: (value) {
                    if (value?.isEmpty ?? true)
                      return 'Please enter card holder name';
                    return null;
                  },
                ),
                isMobile ? Gap(10) : Gap(20),
                CustomTextfield(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  text: 'Expiry Date',
                  controller: expiryDateController,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  autocorrect: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    _ExpiryDateInputFormatter(),
                  ],
                  validator: (value) {
                    if (value?.isEmpty ?? true)
                      return 'Please enter expiry date';
                    if (!CardValidator.validateExpiryDate(value!))
                      return 'Invalid or expired date';
                    return null;
                  },
                ),
                isMobile ? Gap(10) : Gap(20),
                CustomTextfield(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  text: 'CVV',
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  autocorrect: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Please enter CVV';
                    if (!CardValidator.validateCVV(value!))
                      return 'Invalid CVV';
                    return null;
                  },
                ),
                Gap(50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      final nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;

    if (newText.length <= 2) {
      return newValue;
    }

    if (newText.length <= 4) {
      return newValue.copyWith(
        text: '${newText.substring(0, 2)}/${newText.substring(2)}',
        selection: TextSelection.collapsed(offset: newText.length + 1),
      );
    }

    return oldValue;
  }
}
