import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transferme/core/network/auth_exceptions.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/helpers/helper_dialogs.dart';
import 'package:transferme/core/util/helpers/validation_helper.dart';
import 'package:transferme/features/auth/data/auth_data_remote_sources.dart';
import 'package:transferme/features/auth/data/models/user_model.dart';
import 'package:transferme/features/auth/sign_in/login_screen.dart';
import 'package:transferme/features/main_page.dart';

class AuthState {
  final UserModel? currentUser;
  final bool isLoading;
  final String? errorMessage;
  final XFile? croppedImage; // NEW: Store cropped image
  final String? profileImagePath;

  AuthState({
    this.currentUser,
    this.isLoading = false,
    this.errorMessage,
    this.croppedImage,
    this.profileImagePath,
  });

  AuthState copyWith({
    UserModel? currentUser,
    bool? isLoading,
    String? errorMessage,
    XFile? croppedImage,
    String? profileImagePath,
  }) => AuthState(
    currentUser: currentUser ?? this.currentUser,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage ?? this.errorMessage,
    croppedImage: croppedImage ?? this.croppedImage,
    profileImagePath: profileImagePath ?? this.profileImagePath,
  );
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthNotifier(this._authRemoteDataSource) : super(AuthState());

  Future<void> signUp({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      showLoadingDialog(context);
      await _authRemoteDataSource.signUp(email: email, password: password);
      Navigator.pop(context);
      HelperDialogs().showHelperDialog(
        context,
        "Verify Email",
        'Sign up successful. Please verify your mail',
        () {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
            );
          }
        },
      );
      // Navigate to profile completion screen
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginScreen()),
      //   (route) => false,
      // );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      Navigator.pop(context);
      if (e is AuthException) {
        state = state.copyWith(errorMessage: e.message, isLoading: false);
        showErrorDialog(context, e.message, e.stackTrace);
        log(e.stackTrace.toString());
      } else {
        state = state.copyWith(
          errorMessage: 'An unexpected error occurred',
          isLoading: false,
        );
        log(StackTrace.current.toString());
        showErrorDialog(
          context,
          'An unexpected error occurred',
          StackTrace.current,
        );
      }
    }
  }

  // NEW: Method for image selection and cropping with size validation
  Future<void> selectAndCropProfilePicture({
    required BuildContext context,
    required ImageSource source,
  }) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image == null) return;

      // Crop the image
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        maxWidth: 1000,
        maxHeight: 1000,
        compressQuality: 80,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile Picture',
            toolbarColor: AppColor.primaryColor,
            toolbarWidgetColor: AppColor.whiteColor,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop Profile Picture',
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
          ),
        ],
      );

      if (croppedFile != null) {
        // Validate file size (2MB - 15MB)
        final bytes = await croppedFile.readAsBytes();
        final sizeInMB = bytes.length / (1024 * 1024);

        if (sizeInMB < 2) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text('Image size must be at least 2MB'),
            ),
          );
          return;
        }

        if (sizeInMB > 15) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text('Image size must not exceed 15MB'),
            ),
          );
          return;
        }

        // Store the cropped image for preview
        state = state.copyWith(
          croppedImage: XFile(croppedFile.path),
          profileImagePath: croppedFile.path,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cropping cancelled or failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error selecting image: $e')));
    }
  }

  // NEW: Clear selected image
  void clearSelectedImage() {
    state = state.copyWith(croppedImage: null, profileImagePath: null);
  }

  Future<void> completeProfile({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    final error = ValidationUtils.validatePhoneNumber(phoneNumber);
    if (error != null) {
      state = state.copyWith(errorMessage: error, isLoading: false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.redAccent, content: Text(error)),
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      showLoadingDialog(context);

      String? profilePictureUrl;

      // Upload profile picture if one was selected and cropped
      if (state.croppedImage != null) {
        User? currentUser = _authRemoteDataSource.currentUser;
        if (currentUser != null) {
          profilePictureUrl = await _authRemoteDataSource.uploadProfilePicture(
            state.croppedImage!,
            currentUser.uid,
          );
        }
      }

      // Complete profile with all data
      await _authRemoteDataSource.completeProfile(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        profilePicture: profilePictureUrl,
      );

      log('Profile successfully completed');

      User? user = _authRemoteDataSource.currentUser;
      if (user != null) {
        UserModel userModel = await _fetchUserFromFirestore(user.uid);
        state = state.copyWith(
          currentUser: userModel,
          isLoading: false,
          croppedImage: null, // Clear after successful upload
          profileImagePath: null,
        );
      }

      Navigator.pop(context); // Close loading dialog
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      Navigator.pop(context);
      if (e is AuthException) {
        state = state.copyWith(errorMessage: e.message, isLoading: false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.redAccent, content: Text(e.message)),
        );
        log(e.code);
        log(e.message);
        log(e.stackTrace.toString());
      } else {
        state = state.copyWith(
          errorMessage: 'An unexpected error occurred',
          isLoading: false,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('An unexpected error occurred'),
          ),
        );
        log(StackTrace.current.toString());
      }
    }
  }

  // Future<void> completeProfile({
  //   required BuildContext context,
  //   required String firstName,
  //   required String lastName,
  //   required String phoneNumber,
  //   XFile? profilePicture,
  // }) async {
  //   final error = ValidationUtils.validatePhoneNumber(phoneNumber);
  //   if (error != null) {
  //     state = state.copyWith(errorMessage: error, isLoading: false);
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(error)));
  //     return;
  //   }

  //   state = state.copyWith(isLoading: true, errorMessage: null);
  //   try {
  //     showLoadingDialog(context);
  //     String? profilePictureUrl;
  //     if (profilePicture != null) {
  //       // Change: Replaced call to _uploadProfilePicture with direct use of AuthRemoteDataSource._uploadProfilePicture
  //       // with size validation (2-10 MB) to align with the original upload logic from AddPhoneNumberScreen
  //       final byteData = await profilePicture.readAsBytes();
  //       final kb = byteData.lengthInBytes / 1024;
  //       if (kb < 2048 || kb > 10240) {
  //         throw Exception('Image size must be between 2MB and 10MB');
  //       }
  //       profilePictureUrl = await _authRemoteDataSource.uploadProfilePicture(
  //         profilePicture,
  //         _authRemoteDataSource.currentUser!.uid,
  //       );
  //     }
  //     await _authRemoteDataSource.completeProfile(
  //       firstName: firstName,
  //       lastName: lastName,
  //       phoneNumber: phoneNumber,
  //       profilePicture: profilePictureUrl,
  //     );
  //     log('Profile successfully uploaded');
  //     User? user = _authRemoteDataSource.currentUser;
  //     if (user != null) {
  //       UserModel userModel = await _fetchUserFromFirestore(user.uid);
  //       state = state.copyWith(currentUser: userModel, isLoading: false);
  //     }
  //     Navigator.pop(context);
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => LoginScreen()),
  //       (route) => false,
  //     );
  //   } catch (e) {
  //     Navigator.pop(context);
  //     if (e is AuthException) {
  //       state = state.copyWith(errorMessage: e.message, isLoading: false);
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text(e.message)));
  //       log(e.code);
  //       log(e.message);
  //       log(e.stackTrace.toString());
  //     } else {
  //       state = state.copyWith(
  //         errorMessage: 'An unexpected error occurred',
  //         isLoading: false,
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('An unexpected error occurred')),
  //       );
  //       log(StackTrace.current.toString());
  //     }
  //   }
  // }

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      showLoadingDialog(context);
      await _authRemoteDataSource.login(email: email, password: password);
      User? user = _authRemoteDataSource.currentUser;
      if (user != null) {
        UserModel userModel = await _fetchUserFromFirestore(user.uid);
        state = state.copyWith(currentUser: userModel, isLoading: false);
      }
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
        (route) => false,
      );
      log('Login successful');
    } catch (e) {
      Navigator.pop(context);
      if (e is AuthException) {
        state = state.copyWith(errorMessage: e.message, isLoading: false);
        showErrorDialog(context, e.message, e.stackTrace);
      } else {
        state = state.copyWith(
          errorMessage: 'An unexpected error occurred',
          isLoading: false,
        );
        showErrorDialog(
          context,
          'An unexpected error occurred',
          StackTrace.current,
        );
        log(StackTrace.current.toString());
      }
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      showLoadingDialog(context);
      await _authRemoteDataSource.sendEmailVerification();
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text(
            'Verification email sent. Please check your inbox.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      Navigator.pop(context);
      if (e is AuthException) {
        state = state.copyWith(errorMessage: e.message, isLoading: false);
        showErrorDialog(context, e.message, e.stackTrace);
      } else {
        state = state.copyWith(
          errorMessage: 'An unexpected error occurred',
          isLoading: false,
        );
        showErrorDialog(
          context,
          'An unexpected error occurred',
          StackTrace.current,
        );
      }
    }
  }

  Future<void> uploadProfilePicture({
    required BuildContext context,
    required XFile image,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      showLoadingDialog(context);
      log('function called and loading');
      User? currentUser = _authRemoteDataSource.currentUser;
      if (currentUser == null) {
        throw AuthException.fromFirebase(
          Exception('No user signed in'),
          StackTrace.current,
        );
      }
      String? profilePictureUrl = await _authRemoteDataSource
          .uploadProfilePicture(image, currentUser.uid);
      log('profile picture url function called');
      UserModel updatedUser =
          (state.currentUser ?? UserModel(id: 0, firstName: '', lastName: ''))
              .copyWith(profilePicture: profilePictureUrl);
      await _authRemoteDataSource.firestore
          .collection('users')
          .doc(currentUser.uid)
          .update({'profilePicture': profilePictureUrl});
      log('update profile picture called');
      state = state.copyWith(currentUser: updatedUser, isLoading: false);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile picture uploaded'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      if (e is AuthException) {
        state = state.copyWith(errorMessage: e.message, isLoading: false);
        showErrorDialog(context, e.message, e.stackTrace);
        log(e.message);
        log(e.stackTrace.toString());
      } else {
        state = state.copyWith(
          errorMessage: 'An unexpected error occurred',
          isLoading: false,
        );
        showErrorDialog(
          context,
          'An unexpected error occurred',
          StackTrace.current,
        );
        log(StackTrace.current.toString());
      }
    }
  }

  // Future<void> uploadProfilePicture({
  //   required BuildContext context,
  //   required XFile image,
  // }) async {
  //   state = state.copyWith(isLoading: true, errorMessage: null);
  //   try {
  //     showLoadingDialog(context);
  //     User? currentUser = _authRemoteDataSource.currentUser;
  //     if (currentUser == null) {
  //       throw AuthException.fromFirebase(
  //         Exception('No user signed in'),
  //         StackTrace.current,
  //       );
  //     }
  //     String? profilePictureUrl = await _authRemoteDataSource
  //         .uploadProfilePicture(image, currentUser.uid);
  //     UserModel updatedUser =
  //         (state.currentUser ?? UserModel(id: 0, firstName: '', lastName: ''))
  //             .copyWith(profilePicture: profilePictureUrl);
  //     await _authRemoteDataSource.firestore
  //         .collection('users')
  //         .doc(currentUser.uid)
  //         .update({'profilePicture': profilePictureUrl});
  //     state = state.copyWith(currentUser: updatedUser, isLoading: false);
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Profile picture uploaded'),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //   } catch (e) {
  //     Navigator.pop(context);
  //     if (e is AuthException) {
  //       state = state.copyWith(errorMessage: e.message, isLoading: false);
  //       showErrorDialog(context, e.message, e.stackTrace);
  //     } else {
  //       state = state.copyWith(
  //         errorMessage: 'An unexpected error occurred',
  //         isLoading: false,
  //       );
  //       showErrorDialog(
  //         context,
  //         'An unexpected error occurred',
  //         StackTrace.current,
  //       );
  //     }
  //   }
  // }

  Future<void> logout(BuildContext context) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      showLoadingDialog(context);
      await _authRemoteDataSource.logout();
      state = state.copyWith(currentUser: null, isLoading: false);
      Navigator.pop(context);
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } catch (e) {
      Navigator.pop(context);
      if (e is AuthException) {
        state = state.copyWith(errorMessage: e.message, isLoading: false);
        showErrorDialog(context, e.message, e.stackTrace);
      } else {
        state = state.copyWith(
          errorMessage: 'An unexpected error occurred',
          isLoading: false,
        );
        showErrorDialog(
          context,
          'An unexpected error occurred',
          StackTrace.current,
        );
      }
    }
  }

  Future<UserModel> _fetchUserFromFirestore(String uid) async {
    try {
      DocumentSnapshot doc = await _authRemoteDataSource.firestore
          .collection('users')
          .doc(uid)
          .get();
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw AuthException.fromFirebase(e, StackTrace.current);
    }
  }
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );
}

void showErrorDialog(
  BuildContext context,
  String message,
  StackTrace? stackTrace,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
          if (stackTrace != null) ...[
            // const SizedBox(height: 10),
            // log('Stack Trace: $stackTrace'),
            // Text(
            //   'Stack Trace: $stackTrace',
            //   style: const TextStyle(fontSize: 12, color: Colors.red),
            // ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRemoteDataSource = AuthRemoteDataSource();
  return AuthNotifier(authRemoteDataSource);
});
