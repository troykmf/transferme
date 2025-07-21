import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transferme/core/network/auth_exceptions.dart';
import 'package:transferme/features/auth/data/auth_data_remote_sources.dart';
import 'package:transferme/features/auth/data/models/user_model.dart';

class AuthState {
  final UserModel? currentUser;
  final bool isLoading;
  final String? errorMessage;

  AuthState({
    this.currentUser,
    this.isLoading = false,
    this.errorMessage,
  });

  AuthState copyWith({
    UserModel? currentUser,
    bool? isLoading,
    String? errorMessage,
  }) =>
      AuthState(
        currentUser: currentUser ?? this.currentUser,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
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
      // Navigate to profile completion screen
      Navigator.pushNamed(context, '/complete-profile');
      state = state.copyWith(isLoading: false);
    } catch (e) {
      Navigator.pop(context);
      if (e is AuthException) {
        state = state.copyWith(errorMessage: e.message, isLoading: false);
        showErrorDialog(context, e.message, e.stackTrace);
      } else {
        state = state.copyWith(errorMessage: 'An unexpected error occurred', isLoading: false);
        showErrorDialog(context, 'An unexpected error occurred', StackTrace.current);
      }
    }
  }

  Future<void> completeProfile({
    required BuildContext context,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    XFile? profilePicture,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      showLoadingDialog(context);
      await _authRemoteDataSource.completeProfile(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        profilePicture: profilePicture,
      );
      User? user = _authRemoteDataSource.currentUser;
      if (user != null) {
        UserModel userModel = await _fetchUserFromFirestore(user.uid);
        state = state.copyWith(currentUser: userModel, isLoading: false);
      }
      Navigator.pop(context); // Close the profile completion screen
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile completed successfully'), backgroundColor: Colors.green));
    } catch (e) {
      Navigator.pop(context);
      if (e is AuthException) {
        state = state.copyWith(errorMessage: e.message, isLoading: false);
        showErrorDialog(context, e.message, e.stackTrace);
      } else {
        state = state.copyWith(errorMessage: 'An unexpected error occurred', isLoading: false);
        showErrorDialog(context, 'An unexpected error occurred', StackTrace.current);
      }
    }
  }

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
    } catch (e) {
      Navigator.pop(context);
      if (e is AuthException) {
        state = state.copyWith(errorMessage: e.message, isLoading: false);
        showErrorDialog(context, e.message, e.stackTrace);
      } else {
        state = state.copyWith(errorMessage: 'An unexpected error occurred', isLoading: false);
        showErrorDialog(context, 'An unexpected error occurred', StackTrace.current);
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
          content: const Text('Verification email sent. Please check your inbox.'),
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
        state = state.copyWith(errorMessage: 'An unexpected error occurred', isLoading: false);
        showErrorDialog(context, 'An unexpected error occurred', StackTrace.current);
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
      User? currentUser = _authRemoteDataSource.currentUser;
      if (currentUser == null) {
        throw AuthException.fromFirebase(Exception('No user signed in'), StackTrace.current);
      }
      String? profilePictureUrl = await _authRemoteDataSource.uploadProfilePicture(image, currentUser.uid);
      UserModel updatedUser = (state.currentUser ?? UserModel(id: 0, firstName: '', lastName: '')).copyWith(profilePicture: profilePictureUrl);
      await _authRemoteDataSource.firestore.collection('users').doc(currentUser.uid).update({'profilePicture': profilePictureUrl});
      state = state.copyWith(currentUser: updatedUser, isLoading: false);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile picture uploaded'), backgroundColor: Colors.green));
    } catch (e) {
      Navigator.pop(context);
      if (e is AuthException) {
        state = state.copyWith(errorMessage: e.message, isLoading: false);
        showErrorDialog(context, e.message, e.stackTrace);
      } else {
        state = state.copyWith(errorMessage: 'An unexpected error occurred', isLoading: false);
        showErrorDialog(context, 'An unexpected error occurred', StackTrace.current);
      }
    }
  }

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
        state = state.copyWith(errorMessage: 'An unexpected error occurred', isLoading: false);
        showErrorDialog(context, 'An unexpected error occurred', StackTrace.current);
      }
    }
  }

  Future<UserModel> _fetchUserFromFirestore(String uid) async {
    try {
      DocumentSnapshot doc = await _authRemoteDataSource.firestore.collection('users').doc(uid).get();
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

void showErrorDialog(BuildContext context, String message, StackTrace? stackTrace) {
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
            const SizedBox(height: 10),
            Text('Stack Trace: $stackTrace', style: const TextStyle(fontSize: 12, color: Colors.red)),
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
  return AuthNotifier(AuthRemoteDataSource());
});