import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transferme/app/app.dart';
import 'package:transferme/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}


// // user_model.dart
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'user_model.freezed.dart';
// part 'user_model.g.dart';

// @freezed
// class UserModel with _$UserModel {
//   const factory UserModel({
//     required int id,
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String phoneNumber,
//     String? profilePicture,
//     @Default(false) bool isEmailVerified,
//     DateTime? createdAt,
//   }) = _UserModel;

//   factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
// }

// // Alternative without freezed (if you prefer simpler approach):
// class UserModelSimple {
//   final int id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneNumber;
//   final String? profilePicture;
//   final bool isEmailVerified;
//   final DateTime? createdAt;

//   const UserModelSimple({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phoneNumber,
//     this.profilePicture,
//     this.isEmailVerified = false,
//     this.createdAt,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'firstName': firstName,
//       'lastName': lastName,
//       'email': email,
//       'phoneNumber': phoneNumber,
//       'profilePicture': profilePicture,
//       'isEmailVerified': isEmailVerified,
//       'createdAt': createdAt?.toIso8601String(),
//     };
//   }

//   factory UserModelSimple.fromJson(Map<String, dynamic> json) {
//     return UserModelSimple(
//       id: json['id'] ?? 0,
//       firstName: json['firstName'] ?? '',
//       lastName: json['lastName'] ?? '',
//       email: json['email'] ?? '',
//       phoneNumber: json['phoneNumber'] ?? '',
//       profilePicture: json['profilePicture'],
//       isEmailVerified: json['isEmailVerified'] ?? false,
//       createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
//     );
//   }

//   UserModelSimple copyWith({
//     int? id,
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? phoneNumber,
//     String? profilePicture,
//     bool? isEmailVerified,
//     DateTime? createdAt,
//   }) {
//     return UserModelSimple(
//       id: id ?? this.id,
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       email: email ?? this.email,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       profilePicture: profilePicture ?? this.profilePicture,
//       isEmailVerified: isEmailVerified ?? this.isEmailVerified,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }

// // auth_exception.dart
// class AuthException implements Exception {
//   final String message;
//   final String code;
//   final StackTrace? stackTrace;

//   const AuthException({
//     required this.message,
//     required this.code,
//     this.stackTrace,
//   });

//   factory AuthException.fromFirebase(dynamic e, StackTrace stackTrace) {
//     String userFriendlyMessage;
//     String code = 'unknown-error';

//     if (e.toString().contains('user-not-found')) {
//       userFriendlyMessage = 'No user found with this email address.';
//       code = 'user-not-found';
//     } else if (e.toString().contains('wrong-password')) {
//       userFriendlyMessage = 'Incorrect password provided.';
//       code = 'wrong-password';
//     } else if (e.toString().contains('email-already-in-use')) {
//       userFriendlyMessage = 'An account already exists with this email address.';
//       code = 'email-already-in-use';
//     } else if (e.toString().contains('weak-password')) {
//       userFriendlyMessage = 'Password is too weak. Please choose a stronger password.';
//       code = 'weak-password';
//     } else if (e.toString().contains('invalid-email')) {
//       userFriendlyMessage = 'The email address is not valid.';
//       code = 'invalid-email';
//     } else if (e.toString().contains('user-disabled')) {
//       userFriendlyMessage = 'This user account has been disabled.';
//       code = 'user-disabled';
//     } else if (e.toString().contains('too-many-requests')) {
//       userFriendlyMessage = 'Too many failed attempts. Please try again later.';
//       code = 'too-many-requests';
//     } else {
//       userFriendlyMessage = 'An authentication error occurred: ${e.toString()}';
//     }

//     return AuthException(
//       message: userFriendlyMessage,
//       code: code,
//       stackTrace: stackTrace,
//     );
//   }

//   @override
//   String toString() => 'AuthException: $message (Code: $code)';
// }

// // auth_state.dart
// import 'dart:io';
// import 'dart:math';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

// // Auth State Class
// @freezed
// class AuthState with _$AuthState {
//   const factory AuthState({
//     UserModelSimple? currentUser,
//     @Default(false) bool isLoading,
//     String? errorMessage,
//     @Default(false) bool isLoggedIn,
//   }) = _AuthState;
// }

// // Alternative simple AuthState without freezed
// class AuthStateSimple {
//   final UserModelSimple? currentUser;
//   final bool isLoading;
//   final String? errorMessage;
//   final bool isLoggedIn;

//   const AuthStateSimple({
//     this.currentUser,
//     this.isLoading = false,
//     this.errorMessage,
//     this.isLoggedIn = false,
//   });

//   AuthStateSimple copyWith({
//     UserModelSimple? currentUser,
//     bool? isLoading,
//     String? errorMessage,
//     bool? isLoggedIn,
//   }) {
//     return AuthStateSimple(
//       currentUser: currentUser ?? this.currentUser,
//       isLoading: isLoading ?? this.isLoading,
//       errorMessage: errorMessage ?? this.errorMessage,
//       isLoggedIn: isLoggedIn ?? this.isLoggedIn,
//     );
//   }
// }

// // Auth Notifier
// class AuthNotifier extends StateNotifier<AuthStateSimple> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   AuthNotifier() : super(const AuthStateSimple()) {
//     _initializeAuth();
//   }

//   void _initializeAuth() {
//     _auth.authStateChanges().listen((User? user) async {
//       if (user != null) {
//         UserModelSimple? userModel = await _getUserFromFirestore(user.uid);
//         state = state.copyWith(
//           currentUser: userModel,
//           isLoggedIn: true,
//           errorMessage: null,
//         );
//       } else {
//         state = state.copyWith(
//           currentUser: null,
//           isLoggedIn: false,
//           errorMessage: null,
//         );
//       }
//     });
//   }

//   void _setLoading(bool loading) {
//     state = state.copyWith(isLoading: loading);
//   }

//   void _setError(String? error) {
//     state = state.copyWith(errorMessage: error);
//   }

//   // Generate unique user ID
//   int _generateUserId() {
//     return DateTime.now().millisecondsSinceEpoch + Random().nextInt(1000);
//   }

//   // Get user from Firestore
//   Future<UserModelSimple?> _getUserFromFirestore(String uid) async {
//     try {
//       DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
//       if (doc.exists) {
//         return UserModelSimple.fromJson(doc.data() as Map<String, dynamic>);
//       }
//     } catch (e) {
//       print('Error fetching user from Firestore: $e');
//     }
//     return null;
//   }

//   // Save user to Firestore
//   Future<void> _saveUserToFirestore(String uid, UserModelSimple user) async {
//     try {
//       await _firestore.collection('users').doc(uid).set(user.toJson());
//     } catch (e) {
//       print('Error saving user to Firestore: $e');
//       throw AuthException(
//         message: 'Failed to save user data',
//         code: 'firestore-error',
//         stackTrace: StackTrace.current,
//       );
//     }
//   }

//   // Show loading dialog
//   void _showLoadingDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         content: Row(
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(width: 16),
//             Text('Please wait...'),
//           ],
//         ),
//       ),
//     );
//   }

//   // Hide loading dialog
//   void _hideLoadingDialog(BuildContext context) {
//     Navigator.of(context, rootNavigator: true).pop();
//   }

//   // Show error dialog
//   void _showErrorDialog(BuildContext context, AuthException error) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Error'),
//         content: Text(error.message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Sign up method
//   Future<UserModelSimple?> signUp({
//     required String email,
//     required String password,
//     required String firstName,
//     required String lastName,
//     required String phoneNumber,
//     BuildContext? context,
//   }) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       if (context != null) {
//         _showLoadingDialog(context);
//       }

//       // Validate input
//       if (email.trim().isEmpty || 
//           password.trim().isEmpty || 
//           firstName.trim().isEmpty || 
//           lastName.trim().isEmpty ||
//           phoneNumber.trim().isEmpty) {
//         throw AuthException(
//           message: 'All fields are required',
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

//       // Create Firebase user
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password,
//       );

//       if (userCredential.user != null) {
//         // Create user model
//         UserModelSimple newUser = UserModelSimple(
//           id: _generateUserId(),
//           firstName: firstName.trim(),
//           lastName: lastName.trim(),
//           email: email.trim(),
//           phoneNumber: phoneNumber.trim(),
//           isEmailVerified: false,
//           createdAt: DateTime.now(),
//         );

//         // Save to Firestore
//         await _saveUserToFirestore(userCredential.user!.uid, newUser);

//         // Send email verification
//         await sendEmailVerification();

//         // Update state
//         state = state.copyWith(
//           currentUser: newUser,
//           isLoggedIn: true,
//           errorMessage: null,
//         );

//         if (context != null) {
//           _hideLoadingDialog(context);
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Account created successfully! Please verify your email.'),
//               backgroundColor: Colors.green,
//             ),
//           );
//         }

//         return newUser;
//       }

//     } catch (e, stackTrace) {
//       if (context != null) {
//         _hideLoadingDialog(context);
//       }

//       AuthException authError;
//       if (e is AuthException) {
//         authError = e;
//       } else {
//         authError = AuthException.fromFirebase(e, stackTrace);
//       }

//       _setError(authError.message);

//       if (context != null) {
//         _showErrorDialog(context, authError);
//       }

//       throw authError;
//     } finally {
//       _setLoading(false);
//     }

//     return null;
//   }

//   // Login method
//   Future<UserModelSimple?> login({
//     required String email,
//     required String password,
//     BuildContext? context,
//     bool requireEmailVerification = true,
//   }) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       if (context != null) {
//         _showLoadingDialog(context);
//       }

//       if (email.trim().isEmpty || password.trim().isEmpty) {
//         throw AuthException(
//           message: 'Email and password cannot be empty',
//           code: 'invalid-input',
//           stackTrace: StackTrace.current,
//         );
//       }

//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email.trim(),
//         password: password,
//       );

//       if (userCredential.user != null) {
//         // Check email verification
//         if (requireEmailVerification && !userCredential.user!.emailVerified) {
//           await _auth.signOut();
//           throw AuthException(
//             message: 'Please verify your email address before logging in.',
//             code: 'email-not-verified',
//             stackTrace: StackTrace.current,
//           );
//         }

//         // Get user data from Firestore
//         UserModelSimple? user = await _getUserFromFirestore(userCredential.user!.uid);
        
//         if (user != null) {
//           state = state.copyWith(
//             currentUser: user,
//             isLoggedIn: true,
//             errorMessage: null,
//           );

//           if (context != null) {
//             _hideLoadingDialog(context);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Login successful!'),
//                 backgroundColor: Colors.green,
//               ),
//             );
//           }

//           return user;
//         }
//       }

//     } catch (e, stackTrace) {
//       if (context != null) {
//         _hideLoadingDialog(context);
//       }

//       AuthException authError;
//       if (e is AuthException) {
//         authError = e;
//       } else {
//         authError = AuthException.fromFirebase(e, stackTrace);
//       }

//       _setError(authError.message);

//       if (context != null) {
//         _showErrorDialog(context, authError);
//       }

//       throw authError;
//     } finally {
//       _setLoading(false);
//     }

//     return null;
//   }

//   // Send email verification
//   Future<void> sendEmailVerification({BuildContext? context}) async {
//     try {
//       User? currentUser = _auth.currentUser;
//       if (currentUser == null) {
//         throw AuthException(
//           message: 'No user is currently signed in',
//           code: 'no-current-user',
//           stackTrace: StackTrace.current,
//         );
//       }

//       if (currentUser.emailVerified) {
//         if (context != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Email is already verified')),
//           );
//         }
//         return;
//       }

//       await currentUser.sendEmailVerification();

//       if (context != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Verification email sent! Please check your inbox.'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }

//     } catch (e, stackTrace) {
//       AuthException authError;
//       if (e is AuthException) {
//         authError = e;
//       } else {
//         authError = AuthException.fromFirebase(e, stackTrace);
//       }

//       _setError(authError.message);

//       if (context != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(authError.message),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }

//       throw authError;
//     }
//   }

//   // Upload profile picture
//   Future<String?> uploadProfilePicture(XFile image, {BuildContext? context}) async {
//     try {
//       User? currentUser = _auth.currentUser;
//       if (currentUser == null || state.currentUser == null) {
//         throw AuthException(
//           message: 'No user is currently signed in',
//           code: 'no-current-user',
//           stackTrace: StackTrace.current,
//         );
//       }

//       _setLoading(true);

//       if (context != null) {
//         _showLoadingDialog(context);
//       }

//       String fileName = 'profile_pictures/${currentUser.uid}/profile_picture.jpg';
//       Reference storageRef = _storage.ref().child(fileName);

//       File imageFile = File(image.path);
//       UploadTask uploadTask = storageRef.putFile(imageFile);
//       TaskSnapshot snapshot = await uploadTask;
//       String downloadUrl = await snapshot.ref.getDownloadURL();

//       // Update user profile in Firestore
//       UserModelSimple updatedUser = state.currentUser!.copyWith(
//         profilePicture: downloadUrl,
//       );
      
//       await _saveUserToFirestore(currentUser.uid, updatedUser);

//       state = state.copyWith(currentUser: updatedUser);

//       if (context != null) {
//         _hideLoadingDialog(context);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Profile picture uploaded successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }

//       return downloadUrl;

//     } catch (e, stackTrace) {
//       if (context != null) {
//         _hideLoadingDialog(context);
//       }

//       AuthException authError;
//       if (e is AuthException) {
//         authError = e;
//       } else {
//         authError = AuthException(
//           message: 'Failed to upload profile picture: $e',
//           code: 'upload-error',
//           stackTrace: stackTrace,
//         );
//       }

//       _setError(authError.message);

//       if (context != null) {
//         _showErrorDialog(context, authError);
//       }

//       throw authError;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Sign out
//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//       state = const AuthStateSimple();
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

//   // Check email verification
//   Future<bool> checkEmailVerification() async {
//     User? currentUser = _auth.currentUser;
//     if (currentUser != null) {
//       await currentUser.reload();
//       return currentUser.emailVerified;
//     }
//     return false;
//   }
// }

// // Providers
// final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthStateSimple>((ref) {
//   return AuthNotifier();
// });

// // Helper providers
// final currentUserProvider = Provider<UserModelSimple?>((ref) {
//   return ref.watch(authNotifierProvider).currentUser;
// });

// final isLoadingProvider = Provider<bool>((ref) {
//   return ref.watch(authNotifierProvider).isLoading;
// });

// final isLoggedInProvider = Provider<bool>((ref) {
//   return ref.watch(authNotifierProvider).isLoggedIn;
// });

// final errorMessageProvider = Provider<String?>((ref) {
//   return ref.watch(authNotifierProvider).errorMessage;
// });

// // UPDATED SIGN UP SCREEN IMPLEMENTATION
// // sign_up_screen_updated.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gap/gap.dart';

// class SignUpScreenUpdated extends ConsumerStatefulWidget {
//   const SignUpScreenUpdated({super.key});

//   @override
//   ConsumerState<SignUpScreenUpdated> createState() => _SignUpScreenUpdatedState();
// }

// class _SignUpScreenUpdatedState extends ConsumerState<SignUpScreenUpdated> {
//   late final TextEditingController _emailController;
//   late final TextEditingController _passwordController;
//   late final TextEditingController _confirmPasswordController;
//   late final TextEditingController _firstNameController;
//   late final TextEditingController _lastNameController;
//   late final TextEditingController _phoneController;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   @override
//   void initState() {
//     super.initState();
//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();
//     _confirmPasswordController = TextEditingController();
//     _firstNameController = TextEditingController();
//     _lastNameController = TextEditingController();
//     _phoneController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }

//   // Your signup function implementation
//   Future<void> _handleSignUp() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     // Check if passwords match
//     if (_passwordController.text != _confirmPasswordController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Passwords do not match'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     try {
//       final authNotifier = ref.read(authNotifierProvider.notifier);
      
//       UserModelSimple? user = await authNotifier.signUp(
//         email: _emailController.text.trim(),
//         password: _passwordController.text,
//         firstName: _firstNameController.text.trim(),
//         lastName: _lastNameController.text.trim(),
//         phoneNumber: _phoneController.text.trim(),
//         context: context,
//       );

//       if (user != null) {
//         // Navigate to verification screen or main app
//         // Navigator.pushReplacementNamed(context, '/email-verification');
//       }
//     } on AuthException catch (e) {
//       // Error handling is already done in the AuthNotifier
//       print('Signup error: ${e.message}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authState = ref.watch(authNotifierProvider);
//     final isLoading = authState.isLoading;

//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           horizontal: 20,
//           child: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Your existing logo widget here
//                   Gap(10),
//                   Text(
//                     'Sign Up',
//                     style: TextStyle(
//                       fontSize: 35,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                   Gap(20),
                  
//                   // First Name
//                   TextFormField(
//                     controller: _firstNameController,
//                     decoration: InputDecoration(
//                       labelText: 'First Name',
//                       hintText: 'Enter your first name',
//                       border: UnderlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'First name is required';
//                       }
//                       return null;
//                     },
//                   ),
//                   Gap(20),
                  
//                   // Last Name
//                   TextFormField(
//                     controller: _lastNameController,
//                     decoration: InputDecoration(
//                       labelText: 'Last Name',
//                       hintText: 'Enter your last name',
//                       border: UnderlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'Last name is required';
//                       }
//                       return null;
//                     },
//                   ),
//                   Gap(20),
                  
//                   // Phone Number
//                   TextFormField(
//                     controller: _phoneController,
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(
//                       labelText: 'Phone Number',
//                       hintText: '+1234567890',
//                       border: UnderlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'Phone number is required';
//                       }
//                       return null;
//                     },
//                   ),
//                   Gap(20),
                  
//                   // Email
//                   TextFormField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       labelText: 'Email Address',
//                       hintText: 'example@gmail.com',
//                       border: UnderlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'Email is required';
//                       }
//                       if (!value.contains('@') || !value.contains('.')) {
//                         return 'Please enter a valid email address';
//                       }
//                       return null;
//                     },
//                   ),
//                   Gap(20),
                  
//                   // Password
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: _obscurePassword,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       hintText: 'Enter your password',
//                       border: UnderlineInputBorder(),
//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           setState(() {
//                             _obscurePassword = !_obscurePassword;
//                           });
//                         },
//                         icon: Icon(
//                           _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Password is required';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be at least 6 characters';
//                       }
//                       return null;
//                     },
//                   ),
//                   Gap(20),
                  
//                   // Confirm Password
//                   TextFormField(
//                     controller: _confirmPasswordController,
//                     obscureText: _obscureConfirmPassword,
//                     decoration: InputDecoration(
//                       labelText: 'Confirm Password',
//                       hintText: 'Confirm your password',
//                       border: UnderlineInputBorder(),
//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           setState(() {
//                             _obscureConfirmPassword = !_obscureConfirmPassword;
//                           });
//                         },
//                         icon: Icon(
//                           _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please confirm your password';
//                       }
//                       if (value != _passwordController.text) {
//                         return 'Passwords do not match';
//                       }
//                       return null;
//                     },
//                   ),
//                   Gap(50),
                  
//                   Align(
//                     alignment: Alignment.center,
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           width: 201,
//                           height: 50,
//                           child: ElevatedButton(
//                             onPressed: isLoading ? null : _handleSignUp,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue, // Your primary color
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                             ),
//                             child: isLoading
//                                 ? CircularProgressIndicator(color: Colors.white)
//                                 : Text(
//                                     'Sign Up',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                         Gap(30),
//                         RichText(
//                           text: TextSpan(
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.grey,
//                             ),
//                             children: [
//                               TextSpan(text: 'Already have an account? '),
//                               WidgetSpan(
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     // Navigate to login screen
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text(
//                                     'Login',
//                                     style: TextStyle(
//                                       color: Colors.blue, // Your primary color
//                                       decoration: TextDecoration.underline,
//                                       fontSize: 13,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /*
// REQUIRED DEPENDENCIES (pubspec.yaml):

// dependencies:
//   flutter:
//     sdk: flutter
//   flutter_riverpod: ^2.4.9
//   firebase_auth: ^4.15.3
//   firebase_storage: ^11.6.0
//   cloud_firestore: ^4.14.0
//   firebase_core: ^2.24.2
//   image_picker: ^1.0.4
//   freezed_annotation: ^2.4.1  # Optional, for freezed UserModel
//   json_annotation: ^4.8.1     # Optional, for freezed UserModel

// dev_dependencies:
//   build_runner: ^2.4.7        # Optional, for