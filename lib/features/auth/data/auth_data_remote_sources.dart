import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transferme/core/network/auth_exceptions.dart';
import 'package:transferme/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  static final AuthRemoteDataSource _instance =
      AuthRemoteDataSource._internal();
  static bool _isFirebaseInitialized = false;

  factory AuthRemoteDataSource() => _instance;

  AuthRemoteDataSource._internal();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  static Future<void> initializeFirebase() async {
    if (!_isFirebaseInitialized) {
      try {
        await Firebase.initializeApp();
        _isFirebaseInitialized = true;
      } catch (e) {
        throw AuthException.fromFirebase(e, StackTrace.current);
      }
    }
  }

  Future<void> _ensureFirebaseInitialized() async {
    if (!_isFirebaseInitialized) {
      await initializeFirebase();
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    await _ensureFirebaseInitialized();
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Create a minimal user record with just the UID
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'id': userCredential.user!.uid.hashCode,
        'firstName': '',
        'lastName': '',
        'profilePicture': null,
        'phoneNumber': null,
      });

      await userCredential.user!.sendEmailVerification();
    } catch (e, stackTrace) {
      throw AuthException.fromFirebase(e, stackTrace);
    }
  }

  Future<void> completeProfile({
    required String firstName,
    required String lastName,
    String? phoneNumber,
    XFile? profilePicture,
  }) async {
    await _ensureFirebaseInitialized();
    try {
      User? currentUser = firebaseAuth.currentUser;
      if (currentUser == null) {
        throw AuthException.fromFirebase(
          Exception('No user signed in'),
          StackTrace.current,
        );
      }

      String? profilePictureUrl;
      if (profilePicture != null) {
        profilePictureUrl = await uploadProfilePicture(
          profilePicture,
          currentUser.uid,
        );
      }

      await firestore
          .collection('users')
          .doc(currentUser.uid)
          .update(
            UserModel(
              id: currentUser.uid.hashCode,
              firstName: firstName,
              lastName: lastName,
              profilePicture: profilePictureUrl,
              phoneNumber: phoneNumber,
            ).toJson(),
          );
    } catch (e, stackTrace) {
      throw AuthException.fromFirebase(e, stackTrace);
    }
  }

  Future<void> login({required String email, required String password}) async {
    await _ensureFirebaseInitialized();
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (!userCredential.user!.emailVerified) {
        await firebaseAuth.signOut();
        throw AuthException.fromFirebase(
          Exception('Email not verified'),
          StackTrace.current,
        );
      }
    } catch (e, stackTrace) {
      throw AuthException.fromFirebase(e, stackTrace);
    }
  }

  Future<void> sendEmailVerification() async {
    await _ensureFirebaseInitialized();
    try {
      await firebaseAuth.currentUser?.sendEmailVerification();
    } catch (e, stackTrace) {
      throw AuthException.fromFirebase(e, stackTrace);
    }
  }

  Future<String?> uploadProfilePicture(XFile image, String userId) async {
    await _ensureFirebaseInitialized();
    try {
      String fileName = 'profile_pictures/$userId/profile_picture.jpg';
      await storage.ref().child(fileName).putFile(File(image.path));
      return await storage.ref().child(fileName).getDownloadURL();
    } catch (e, stackTrace) {
      throw AuthException.fromFirebase(e, stackTrace);
    }
  }

  Future<void> logout() async {
    await _ensureFirebaseInitialized();
    try {
      await firebaseAuth.signOut();
    } catch (e, stackTrace) {
      throw AuthException.fromFirebase(e, stackTrace);
    }
  }

  User? get currentUser => firebaseAuth.currentUser;
}
