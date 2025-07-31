import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/types/auth_messages_ios.dart';

class BiometricAuthService {
  static final LocalAuthentication _localAuth = LocalAuthentication();

  static Future<bool> isBiometricsAvailable() async {
    try {
      final bool isAvailable = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();
      return isAvailable || isDeviceSupported;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> authenticateWithBiometrics({
    String localizedFallbackTitle = 'Use PIN',
    String reason = 'Please authenticate to access your account',
  }) async {
    try {
      final bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: localizedFallbackTitle,
        authMessages: const [
          AndroidAuthMessages(
            signInTitle: 'Biometric Authentication Required',
            cancelButton: 'Cancel',
          ),
          IOSAuthMessages(
            cancelButton: 'Cancel',
          ),
        ],
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
      return isAuthenticated;
    } on PlatformException catch (e) {
      print('Biometric authentication error: ${e.message}');
      return false;
    }
  }
}