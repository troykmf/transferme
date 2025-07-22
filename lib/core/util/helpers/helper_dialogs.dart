import 'package:flutter/material.dart';
import 'package:transferme/core/network/auth_exceptions.dart';

class HelperDialogs {
  /// Show loading dialog
  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Please wait...'),
          ],
        ),
      ),
    );
  }

  /// Hide loading dialog
  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  /// Show error dialog with detailed error information
  void showErrorDialog(BuildContext context, AuthException error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Authentication Error'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(error.message),
            if (error.code.isNotEmpty) ...[
              SizedBox(height: 8),
              Text(
                'Error Code: ${error.code}',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Show detailed error for debugging
              debugPrint(error.message);
            },
            child: Text('Debug Info'),
          ),
        ],
      ),
    );
  }
}
