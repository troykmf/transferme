import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_app_bar.dart';
import 'package:transferme/core/custom/custom_button.dart';
import 'package:transferme/features/auth/data/biometric_auth_service.dart';

class SetPinCodeScreen extends StatefulWidget {
  const SetPinCodeScreen({super.key});

  @override
  State<SetPinCodeScreen> createState() => _SetPinCodeScreenState();
}

class _SetPinCodeScreenState extends State<SetPinCodeScreen> {
  String pinCode = '';
  final int maxPinLength = 5;
  String? _pressedButton; // Track which button is currently being pressed

  void _onNumberPressed(String number) {
    if (pinCode.length < maxPinLength) {
      setState(() {
        _pressedButton = number;
        pinCode += number;
      });

      // Remove highlight after a brief moment
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) {
          setState(() {
            _pressedButton = null;
          });
        }
      });
    }
  }

  void _onDeletePressed() {
    if (pinCode.isNotEmpty) {
      setState(() {
        _pressedButton = 'delete';
        pinCode = pinCode.substring(0, pinCode.length - 1);
      });

      // Remove highlight after a brief moment
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) {
          setState(() {
            _pressedButton = null;
          });
        }
      });
    }
  }

  Future<void> _onBiometricPressed() async {
    setState(() {
      _pressedButton = 'biometric';
    });

    // Remove highlight after a brief moment
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          _pressedButton = null;
        });
      }
    });

    try {
      // Check if biometrics are available first
      final bool isAvailable =
          await BiometricAuthService.isBiometricsAvailable();

      if (!isAvailable && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Biometric authentication is not available on this device',
            ),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final bool authenticated =
          await BiometricAuthService.authenticateWithBiometrics(
            reason: 'Use your biometric to authenticate',
          );

      if (authenticated) {
        // Auto-fill PIN or allow user to proceed
        setState(() {
          pinCode =
              '12345'; // Example auto-fill, or you can navigate to next screen
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Biometric authentication successful!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Authentication error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _onSetPressed() {
    if (pinCode.length == maxPinLength) {
      // Handle PIN setup completion
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('PIN Code set: $pinCode')));

      // You can add navigation to next screen here
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(appBarTitle: 'Enter Your Pin Code', gap: Gap(40)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 40),
            // PIN length indicator
            const Text(
              'Set Pin Code (5-digit)',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            // PIN dots indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                maxPinLength,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < pinCode.length
                        ? const Color(0xFF5B6BC0)
                        : Colors.grey[300],
                    border: Border.all(
                      color: index < pinCode.length
                          ? const Color(0xFF5B6BC0)
                          : Colors.grey[400]!,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
            // Number pad
            Expanded(
              child: Column(
                children: [
                  // First row: 1, 2, 3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumberButton('1', isPressed: _pressedButton == '1'),
                      _buildNumberButton('2', isPressed: _pressedButton == '2'),
                      _buildNumberButton('3', isPressed: _pressedButton == '3'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Second row: 4, 5, 6
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumberButton('4', isPressed: _pressedButton == '4'),
                      _buildNumberButton('5', isPressed: _pressedButton == '5'),
                      _buildNumberButton('6', isPressed: _pressedButton == '6'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Third row: 7, 8, 9
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumberButton('7', isPressed: _pressedButton == '7'),
                      _buildNumberButton('8', isPressed: _pressedButton == '8'),
                      _buildNumberButton('9', isPressed: _pressedButton == '9'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Fourth row: face (biometric), 0, fingerprint (delete)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconButton(
                        Icons.fingerprint_outlined,
                        onPressed: _onBiometricPressed,
                        isPressed: _pressedButton == 'biometric',
                      ),
                      _buildNumberButton('0', isPressed: _pressedButton == '0'),
                      _buildIconButton(
                        Icons.cancel_sharp,
                        onPressed: _onDeletePressed,
                        isPressed: _pressedButton == 'delete',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Set button
            CustomButton(
              onTap: () =>
                  pinCode.length == maxPinLength ? _onSetPressed : null,
              width: 133,
              buttonTitle: 'Login',
            ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 56,
            //   child: ElevatedButton(
            //     onPressed: pinCode.length == maxPinLength
            //         ? _onSetPressed
            //         : null,
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xFF5B6BC0),
            //       foregroundColor: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(28),
            //       ),
            //       elevation: 0,
            //     ),
            //     child: const Text(
            //       'Set',
            //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number, {bool isPressed = false}) {
    return GestureDetector(
      onTap: () => _onNumberPressed(number),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPressed ? const Color(0xFF5B6BC0) : Colors.transparent,
          border: Border.all(
            color: isPressed ? const Color(0xFF5B6BC0) : Colors.grey[400]!,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: isPressed ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(
    IconData icon, {
    required VoidCallback onPressed,
    bool isPressed = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPressed ? const Color(0xFF5B6BC0) : Colors.black87,
        ),
        child: Center(child: Icon(icon, color: Colors.white, size: 28)),
      ),
    );
  }
}
