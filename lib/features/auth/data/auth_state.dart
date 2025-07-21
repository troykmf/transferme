// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:transferme/core/network/auth_exceptions.dart';
// import 'package:transferme/core/util/helper_dialogs.dart';

// /// Authentication state management class
// /// Handles all Firebase authentication operations including login, signup,
// /// email verification, and profile picture upload
// class AuthState extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final HelperDialogs _helperDialogs = HelperDialogs();

//   User? _currentUser;
//   bool _isLoading = false;
//   String? _errorMessage;

//   // Getters
//   User? get currentUser => _currentUser;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   bool get isLoggedIn => _currentUser != null;
//   bool get isEmailVerified => _currentUser?.emailVerified ?? false;

//   AuthState() {
//     _initializeAuth();
//   }

//   /// Initialize authentication state listener
//   void _initializeAuth() {
//     _auth.authStateChanges().listen((User? user) {
//       _currentUser = user;
//       notifyListeners();
//     });
//   }

//   /// Set loading state and notify listeners
//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   /// Set error message and notify listeners
//   void _setError(String? error) {
//     _errorMessage = error;
//     notifyListeners();
//   }

//   /// Sign up a new user with email and password
//   /// Automatically sends email verification after successful signup
//   Future<User?> signUp(
//     String email,
//     String password, {
//     BuildContext? context,
//   }) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       if (context != null) {
//         _helperDialogs.showLoadingDialog(context);
//       }

//       // Validate input
//       if (email.trim().isEmpty || password.trim().isEmpty) {
//         throw AuthException(
//           message: 'Email and password cannot be empty',
//           code: 'invalid-input',
//           stackTrace: StackTrace.current,
//         );
//       }

//       if (password.length < 6) {
//         throw AuthException(
//           message: 'Password must be at least 6 characters long',
//           code: 'weak-password',
//           stackTrace: StackTrace.current,
//         );
//       }

//       // Create user account
//       UserCredential userCredential = await _auth
//           .createUserWithEmailAndPassword(
//             email: email.trim(),
//             password: password,
//           );

//       _currentUser = userCredential.user;

//       // Automatically send email verification
//       if (_currentUser != null) {
//         await sendEmailVerification();
//       }

//       if (context != null) {
//         _helperDialogs.hideLoadingDialog(context);
//       }

//       return _currentUser;
//     } on FirebaseAuthException catch (e, stackTrace) {
//       if (context != null) {
//         _helperDialogs.hideLoadingDialog(context);
//       }

//       final authError = AuthException.fromFirebase(e, stackTrace);
//       _setError(authError.message);

//       if (context != null) {
//         _helperDialogs.showErrorDialog(context, authError);
//       }

//       throw authError;
//     } catch (e, stackTrace) {
//       if (context != null) {
//         _helperDialogs.hideLoadingDialog(context);
//       }

//       final authError = AuthException(
//         message: 'An unexpected error occurred during signup: $e',
//         code: 'unknown-error',
//         stackTrace: stackTrace,
//       );
//       _setError(authError.message);

//       if (context != null) {
//         _helperDialogs.showErrorDialog(context, authError);
//       }

//       throw authError;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   /// Log in user with email and password
//   /// Checks for email verification before allowing login
//   Future<User?> login(
//     String email,
//     String password, {
//     BuildContext? context,
//     bool requireEmailVerification = true,
//   }) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       if (context != null) {
//         _helperDialogs.showLoadingDialog(context);
//       }

//       // Validate input
//       if (email.trim().isEmpty || password.trim().isEmpty) {
//         throw AuthException(
//           message: 'Email and password cannot be empty',
//           code: 'invalid-input',
//           stackTrace: StackTrace.current,
//         );
//       }

//       // Sign in user
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email.trim(),
//         password: password,
//       );

//       _currentUser = userCredential.user;

//       // Check email verification if required
//       if (requireEmailVerification &&
//           _currentUser != null &&
//           !_currentUser!.emailVerified) {
//         await _auth.signOut();
//         _currentUser = null;

//         throw AuthException(
//           message:
//               'Please verify your email address before logging in. Check your inbox for a verification link.',
//           code: 'email-not-verified',
//           stackTrace: StackTrace.current,
//         );
//       }

//       if (context != null) {
//         _helperDialogs.hideLoadingDialog(context);
//       }

//       return _currentUser;
//     } on FirebaseAuthException catch (e, stackTrace) {
//       if (context != null) {
//         _helperDialogs.hideLoadingDialog(context);
//       }

//       final authError = AuthException.fromFirebase(e, stackTrace);
//       _setError(authError.message);

//       if (context != null) {
//         _helperDialogs.showErrorDialog(context, authError);
//       }

//       throw authError;
//     } catch (e, stackTrace) {
//       if (context != null) {
//         _helperDialogs.hideLoadingDialog(context);
//       }

//       if (e is AuthException) {
//         _setError(e.message);
//         if (context != null) {
//           _helperDialogs.showErrorDialog(context, e);
//         }
//         rethrow;
//       }

//       final authError = AuthException(
//         message: 'An unexpected error occurred during login: $e',
//         code: 'unknown-error',
//         stackTrace: stackTrace,
//       );
//       _setError(authError.message);

//       if (context != null) {
//         _helperDialogs.showErrorDialog(context, authError);
//       }

//       throw authError;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   /// Send email verification link to the current user
//   Future<void> sendEmailVerification({BuildContext? context}) async {
//     try {
//       if (_currentUser == null) {
//         throw AuthException(
//           message: 'No user is currently signed in',
//           code: 'no-current-user',
//           stackTrace: StackTrace.current,
//         );
//       }

//       if (_currentUser!.emailVerified) {
//         throw AuthException(
//           message: 'Email is already verified',
//           code: 'email-already-verified',
//           stackTrace: StackTrace.current,
//         );
//       }

//       _setLoading(true);

//       if (context != null) {
//         _helperDialogs.showLoadingDialog(context);
//       }

//       await _currentUser!.sendEmailVerification();

//       if (context != null) {
//         _helperDialogs.hideLoadingDialog(context);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Verification email sent! Please check your inbox.'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }
//     } on FirebaseAuthException catch (e, stackTrace) {
//       if (context != null) {
//         _helperDialogs.hideLoadingDialog(context);
//       }

//       final authError = AuthException.fromFirebase(e, stackTrace);
//       _setError(authError.message);

//       if (context != null) {
//         _helperDialogs.showErrorDialog(context, authError);
//       }

//       throw authError;
//     } catch (e, stackTrace) {
//       if (context != null) {
//         _helperDialogs.hideLoadingDialog(context);
//       }

//       if (e is AuthException) {
//         _setError(e.message);
//         if (context != null) {
//           _helperDialogs.showErrorDialog(context, e);
//         }
//         rethrow;
//       }

//       final authError = AuthException(
//         message: 'Failed to send verification email: $e',
//         code: 'verification-send-failed',
//         stackTrace: stackTrace,
//       );
//       _setError(authError.message);

//       if (context != null) {
//         _helperDialogs.showErrorDialog(context, authError);
//       }

//       throw authError;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   /// Upload profile picture for the current user
//   /// Returns the download URL of the uploaded image
//   Future<String?> uploadProfilePicture(
//     XFile image, {
//     BuildContext? context,
//   }) async {
//     try {
//       if (_currentUser == null) {
//         throw AuthException(
//           message: 'No user is currently signed in',
//           code: 'no-current-user',
//           stackTrace: StackTrace.current,
//         );
//       }

//       _setLoading(true);

//       if (context != null) {
//         _helperDialogs.showLoadingDialog(context);
//       }

//       // Create a reference to the storage location
//       String fileName =
//           'profile_pictures/${_currentUser!.uid}/profile_picture.jpg';
//       Reference storageRef = _storage.ref().child(fileName);

//       // Upload the file
//       File imageFile = File(image.path);
//       UploadTask uploadTask = storageRef.putFile(
//         imageFile,
//         SettableMetadata(
//           contentType: 'image/jpeg',
//           customMetadata: {
//             'userId': _currentUser!.uid,
//             'uploadTime': DateTime.now().toIso8601String(),
//           },
//         ),
//       );

//       // Wait for upload to complete
//       TaskSnapshot snapshot = await uploadTask;

//       // Get download URL
//       String downloadUrl = await snapshot.ref.getDownloadURL();

//       // Update user profile with the new photo URL
//       await _currentUser!.updatePhotoURL(downloadUrl);
//       await _currentUser!.reload();
//       _currentUser = _auth.currentUser;

//       if (context != null) {
//         _helperDialogs.hideLoadingDialog(context);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Profile picture uploaded successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }

//       return downloadUrl;
//     } on FirebaseException catch (e, stackTrace) {
//       if (context != null) {
//         _helperDialogs.hideLoadingDialog(context);
//       }

//       final authError = AuthException(
//         message: 'Failed to upload profile picture: ${e.message}',
//         code: e.code,
//         stackTrace: stackTrace,
//       );
//       _setError(authError.message);

//       if (context != null) {
//         _helperDialogs.showErrorDialog(context, authError);
//       }

//       throw authError;
//     } catch (e, stackTrace) {
//       if (context != null) {
//         _helperDialogs.hideLoadingDialog(context);
//       }

//       final authError = AuthException(
//         message:
//             'An unexpected error occurred while uploading profile picture: $e',
//         code: 'upload-error',
//         stackTrace: stackTrace,
//       );
//       _setError(authError.message);

//       if (context != null) {
//         _helperDialogs.showErrorDialog(context, authError);
//       }

//       throw authError;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   /// Sign out the current user
//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//       _currentUser = null;
//       _setError(null);
//     } catch (e, stackTrace) {
//       final authError = AuthException(
//         message: 'Failed to sign out: $e',
//         code: 'signout-error',
//         stackTrace: stackTrace,
//       );
//       _setError(authError.message);
//       throw authError;
//     }
//   }

//   /// Reload current user data
//   Future<void> reloadUser() async {
//     if (_currentUser != null) {
//       await _currentUser!.reload();
//       _currentUser = _auth.currentUser;
//       notifyListeners();
//     }
//   }

//   /// Check if email is verified (useful for periodic checks)
//   Future<bool> checkEmailVerification() async {
//     if (_currentUser != null) {
//       await _currentUser!.reload();
//       _currentUser = _auth.currentUser;
//       notifyListeners();
//       return _currentUser!.emailVerified;
//     }
//     return false;
//   }
// }
