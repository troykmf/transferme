import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_app_logo.dart';
import 'package:transferme/core/custom/custom_button.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/custom/custom_textfield.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/core/util/helpers/validation_helper.dart';
import 'package:transferme/features/auth/data/provider/auth_provider.dart';
import 'package:transferme/features/auth/sign_in/login_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late TapGestureRecognizer _textRecognizer;

  final GlobalKey _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    // Add listeners to update form validity
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);

    _textRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
      };
  }

  String? _validateEmail(String value) => ValidationUtils.validateEmail(value);
  String? _validatePassword(String value) =>
      ValidationUtils.validatePassword(value);
  String? _validateConfirmPassword(String value) {
    if (value.isEmpty) return 'Confirm Password is required';
    if (value != _passwordController.text.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _validateForm() {
    setState(() {
      _isFormValid =
          _validateEmail(_emailController.text.trim()) == null &&
          _validatePassword(_passwordController.text.trim()) == null &&
          _validateConfirmPassword(_confirmPasswordController.text.trim()) ==
              null;
    });
  }

  void handleSignUp() {
    if (_isFormValid) {
      final authNotifier = ref.read(authProvider.notifier);
      authNotifier
          .signUp(
            context: context,
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          )
          .then((_) {
            // No need to manually update state here; AuthNotifier handles it
          })
          .catchError((error) {
            // Error is already handled by AuthNotifier with dialogs
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isMobile = ResponsiveHelper.isMobile;
    return Scaffold(
      body: SafeArea(
        child: ResponsivePadding(
          horizontal: isMobile ? 20 : 20,
          vertical: isMobile ? 0 : 15,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: ResponsiveHelper.width(130),
                  height: ResponsiveHelper.height(60),
                  child: CustomAppLogo(
                    firstContainerLeftPosition: 0,
                    secondContainerRightPosition: isMobile ? 55 : 35,
                    primaryColorContainerWidth: ResponsiveHelper.width(47),
                    primaryColorContainerHeight: ResponsiveHelper.height(47),
                    secondaryColorContainerWidth: ResponsiveHelper.width(47),
                    secondaryColorContainerHeight: ResponsiveHelper.height(47),
                  ),
                ),
                Gap(10),
                Text(
                  'Sign Up',
                  style: extraBoldText(
                    isMobile ? 35 : 17,
                    AppColor.blackColor,
                    -1.5,
                  ),
                ),
                Gap(20),
                // email textfield
                CustomTextfield(
                  text: 'Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => ValidationUtils.validateEmail(value),
                  hintText: 'example@gmail.com',
                  obscureText: false,
                  autocorrect: false,
                ),
                Gap(20),
                // password textfield
                CustomTextfield(
                  text: 'Password',
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.visibility_off,
                      size: isMobile ? 15 : 20,
                      color: AppColor.textLightGreyColor,
                    ),
                  ),
                  obscureText: false,
                  autocorrect: false,
                  validator: (value) => ValidationUtils.validatePassword(value),
                ),
                Gap(20),
                // confirm password textfield
                CustomTextfield(
                  text: 'Confirm Password',
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.text,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.visibility_off,
                      size: isMobile ? 15 : 20,
                      color: AppColor.textLightGreyColor,
                    ),
                  ),
                  obscureText: false,
                  autocorrect: false,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Confirm Password is required';
                    }
                    if (value.trim() != _passwordController.text.trim()) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                Gap(50),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      CustomButton(
                        onTap: () {
                          if (authState.isLoading || !_isFormValid) {
                            log('Cannot sign up, form is invalid or loading');
                            return;
                          } else {
                            handleSignUp();
                          }
                        },
                        width: isMobile ? 201 : 140,
                        buttonTitle: 'Sign Up',
                      ),
                      Gap(30),
                      RichText(
                        text: TextSpan(
                          style: mediumText(
                            isMobile ? 13 : 9,
                            AppColor.textLightGreyColor,
                            null,
                          ),
                          children: [
                            TextSpan(text: 'Already have an account? '),
                            TextSpan(
                              recognizer: _textRecognizer,
                              text: 'Login',
                              style: mediumText(
                                isMobile ? 13 : 9,
                                AppColor.primaryColor,
                                null,
                              ).copyWith(decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// USAGE EXAMPLES AND EXPLANATIONS

// /// Example 1: Basic Authentication Widget
// class AuthExampleWidget extends StatefulWidget {
//   @override
//   _AuthExampleWidgetState createState() => _AuthExampleWidgetState();
// }

// class _AuthExampleWidgetState extends State<AuthExampleWidget> {
//   final AuthState _authState = AuthState();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   /// Example of how to handle signup with proper error handling
//   Future<void> _handleSignUp() async {
//     try {
//       User? user = await _authState.signUp(
//         _emailController.text,
//         _passwordController.text,
//         context: context,
//       );
      
//       if (user != null) {
//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Account created! Please check your email for verification.'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }
//     } on AuthException catch (e) {
//       // Error handling is already done in the AuthState class
//       // The error dialog will be shown automatically
//       print('Signup failed: ${e.message}');
//     }
//   }

//   /// Example of how to handle login with email verification check
//   Future<void> _handleLogin() async {
//     try {
//       User? user = await _authState.login(
//         _emailController.text,
//         _passwordController.text,
//         context: context,
//         requireEmailVerification: true, // Enforce email verification
//       );
      
//       if (user != null) {
//         // Navigate to home screen or show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Login successful!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }
//     } on AuthException catch (e) {
//       // Error handling is already done in the AuthState class
//       print('Login failed: ${e.message}');
//     }
//   }

//   /// Example of how to handle profile picture upload
//   Future<void> _handleProfilePictureUpload() async {
//     try {
//       final ImagePicker picker = ImagePicker();
//       final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      
//       if (image != null) {
//         String? downloadUrl = await _authState.uploadProfilePicture(
//           image,
//           context: context,
//         );
        
//         if (downloadUrl != null) {
//           print('Profile picture uploaded successfully: $downloadUrl');
//         }
//       }
//     } on AuthException catch (e) {
//       print('Profile picture upload failed: ${e.message}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Firebase Auth Example')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           TextField(
//             controller: _emailController,
//             decoration: InputDecoration(labelText: 'Email'),
//           ),
//           TextField(
//             controller: _passwordController,
//             decoration: InputDecoration(labelText: 'Password'),
//             obscureText: true,
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: _authState.isLoading ? null : _handleSignUp,
//             child: Text('Sign Up'),
//           ),
//           ElevatedButton(
//             onPressed: _authState.isLoading ? null : _handleLogin,
//             child: Text('Login'),
//           ),
//           ElevatedButton(
//             onPressed: _authState.isLoading ? null : () async {
//               await _authState.sendEmailVerification(context: context);
//             },
//             child: Text('Resend Verification Email'),
//           ),
//           ElevatedButton(
//             onPressed: _authState.isLoading ? null : _handleProfilePictureUpload,
//             child: Text('Upload Profile Picture'),
//           ),
//         ],
//       ),
//     );
//   }
// }

/*
DETAILED EXPLANATION OF THE CODE:

1. **AuthException Class**:
   - Custom exception class that extends Exception
   - Includes Firebase-specific error handling with user-friendly messages
   - Provides detailed error information including stack traces
   - Factory constructor to easily create from FirebaseAuthException

2. **AuthState Class**:
   - Extends ChangeNotifier for state management
   - Handles all authentication operations (login, signup, email verification, profile upload)
   - Includes comprehensive error handling with loading and error dialogs
   - Implements email verification enforcement

3. **Key Features**:

   **Error Handling**:
   - Stack traces are captured and included in custom exceptions
   - Loading dialogs are shown during async operations
   - Error dialogs display user-friendly messages with debug information
   - All Firebase errors are converted to user-friendly messages

   **Email Verification**:
   - Automatically sends verification email after signup
   - Prevents login until email is verified (configurable)
   - Provides method to resend verification emails
   - Includes methods to check verification status

   **Profile Picture Upload**:
   - Uses Firebase Storage to upload images
   - Updates user profile with photo URL
   - Includes proper error handling and progress indication
   - Supports metadata for uploaded files

   **State Management**:
   - Uses ChangeNotifier pattern for reactive UI updates
   - Provides getters for current user, loading state, and errors
   - Automatically listens to auth state changes

4. **Required Dependencies** (add to pubspec.yaml):
   ```yaml
   dependencies:
     firebase_auth: ^4.15.3
     firebase_storage: ^11.6.0
     firebase_core: ^2.24.2
     flutter: 
       sdk: flutter
     image_picker: ^1.0.4
   ```

5. **Usage Patterns**:
   - Always use try-catch blocks when calling auth methods
   - Pass BuildContext to enable loading and error dialogs
   - Check user verification status before allowing access to protected features
   - Use the provided state getters for reactive UI updates

This implementation provides a robust, production-ready authentication system with comprehensive error handling, proper user feedback, and all requested features.
*/
