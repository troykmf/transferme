import 'package:firebase_auth/firebase_auth.dart';

/// Custom exception class for authentication-related errors
/// Extends the base Exception class and includes Firebase-specific error handling
class AuthException implements Exception {
  final String message;
  final String code;
  final StackTrace? stackTrace;
  final FirebaseAuthException? firebaseException;

  const AuthException({
    required this.message,
    required this.code,
    this.stackTrace,
    this.firebaseException,
  });

  /// Factory constructor to create AuthException from FirebaseAuthException
  factory AuthException.fromFirebase(FirebaseAuthException e, StackTrace stackTrace) {
    String userFriendlyMessage;
    
    switch (e.code) {
      case 'user-not-found':
        userFriendlyMessage = 'No user found with this email address.';
        break;
      case 'wrong-password':
        userFriendlyMessage = 'Incorrect password provided.';
        break;
      case 'email-already-in-use':
        userFriendlyMessage = 'An account already exists with this email address.';
        break;
      case 'weak-password':
        userFriendlyMessage = 'Password is too weak. Please choose a stronger password.';
        break;
      case 'invalid-email':
        userFriendlyMessage = 'The email address is not valid.';
        break;
      case 'user-disabled':
        userFriendlyMessage = 'This user account has been disabled.';
        break;
      case 'too-many-requests':
        userFriendlyMessage = 'Too many failed attempts. Please try again later.';
        break;
      case 'operation-not-allowed':
        userFriendlyMessage = 'Email/password accounts are not enabled.';
        break;
      default:
        userFriendlyMessage = 'An authentication error occurred: ${e.message}';
    }

    return AuthException(
      message: userFriendlyMessage,
      code: e.code,
      stackTrace: stackTrace,
      firebaseException: e,
    );
  }

  @override
  String toString() {
    return 'AuthException: $message (Code: $code)';
  }

  /// Method to get detailed error information for debugging
  String getDetailedError() {
    return '''
AuthException Details:
- Message: $message
- Code: $code
- Firebase Error: ${firebaseException?.message ?? 'N/A'}
- Stack Trace: ${stackTrace ?? 'N/A'}
    ''';
  }
}