import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_button.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/features/wallet/data/cash_back_data_model.dart';
import 'package:transferme/features/wallet/presentation/add_card_page.dart';
import 'package:transferme/features/wallet/widgets/cash_back_view.dart';
import 'package:transferme/features/wallet/widgets/tab_bar_widget.dart';

class WalletsPage extends StatefulWidget {
  const WalletsPage({super.key});

  @override
  State<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  final List<CashBackDataModel> cashBackList = cashBackDataList;
  late final TextEditingController cardNumberController;
  late final TextEditingController holderNameController;
  late final TextEditingController expiryDateController;
  late final TextEditingController cvvController;

  @override
  void initState() {
    super.initState();
    cardNumberController = TextEditingController();
    holderNameController = TextEditingController();
    expiryDateController = TextEditingController();
    cvvController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    cardNumberController.dispose();
    holderNameController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Card Details',
          style: headlineText(17, AppColor.blackColor, -0.5),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            CurrencyTabBar(),
            Gap(30),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                onTap: () {
                  if (mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddCardPage(
                          cardNumberController: cardNumberController,
                          holderNameController: holderNameController,
                          expiryDateController: expiryDateController,
                          cvvController: cvvController,
                        ),
                      ),
                    );
                  }
                },
                width: 153,
                buttonTitle: 'Add Card',
              ),
            ),
            CashBackView(cashBackList: cashBackList),
          ],
        ),
      ),
    );
  }
}

class CardNumberField extends StatefulWidget {
  const CardNumberField({super.key});

  @override
  State<CardNumberField> createState() => _CardNumberFieldState();
}

class _CardNumberFieldState extends State<CardNumberField> {
  final TextEditingController _controller = TextEditingController();
  String _verificationResult = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Luhn algorithm to validate card number checksum
  bool _isLuhnValid(String cardNumber) {
    cardNumber = cardNumber.replaceAll(' ', ''); // Remove spaces
    if (cardNumber.length < 13 || cardNumber.length > 19) return false;

    int sum = 0;
    bool isEven = false;
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);
      if (isEven) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      isEven = !isEven;
    }
    return sum % 10 == 0;
  }

  // API call to binlist.net for card type detection
  Future<String?> _getCardType(String bin) async {
    try {
      final response = await http.get(
        Uri.parse('https://lookup.binlist.net/$bin'),
        headers: {'Accept-Version': '3'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['scheme']
            ?.toString()
            .toLowerCase(); // e.g., 'visa' or 'mastercard'
      }
    } catch (e) {
      // Handle network errors silently or log
    }
    return null;
  }

  // Verify button handler
  Future<void> _verifyCard() async {
    final cardNumber = _controller.text.trim();
    if (cardNumber.isEmpty) {
      setState(() => _verificationResult = 'Enter a card number');
      return;
    }

    setState(() {
      _isLoading = true;
      _verificationResult = '';
    });

    // Local Luhn check
    if (!_isLuhnValid(cardNumber)) {
      setState(() {
        _verificationResult = 'Invalid card number (checksum failed)';
        _isLoading = false;
      });
      return;
    }

    // Extract BIN (first 6 digits)
    final cleanNumber = cardNumber.replaceAll(' ', '');
    if (cleanNumber.length < 6) {
      setState(() {
        _verificationResult = 'Card number too short for verification';
        _isLoading = false;
      });
      return;
    }
    final bin = cleanNumber.substring(0, 6);

    // API check for type
    final scheme = await _getCardType(bin);
    setState(() {
      _isLoading = false;
      if (scheme == null) {
        _verificationResult = 'Unable to detect card type (network error)';
      } else if (scheme == 'mastercard') {
        _verificationResult = 'Valid Mastercard';
      } else if (scheme == 'visa') {
        _verificationResult = 'Valid Visa card';
      } else {
        _verificationResult = 'Valid but not Mastercard or Visa ($scheme)';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Mastercard Number',
              border: OutlineInputBorder(),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(19), // 16 digits + 3 spaces
              CardNumberFormatter(),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isLoading ? null : _verifyCard,
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Verify'),
          ),
          const SizedBox(height: 8),
          Text(
            _verificationResult,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Custom formatter to add spaces every 4 digits
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(' ', '');
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      if ((i + 1) % 4 == 0 && i + 1 != newText.length) {
        buffer.write(' ');
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
