import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transferme/core/network/auth_exceptions.dart';
import 'package:transferme/features/auth/data/models/user_model.dart';
import 'package:transferme/features/auth/sign_in/login_screen.dart';
import 'package:transferme/features/main_page.dart';
import 'package:transferme/features/splash_screen/splash_screen.dart';

// class AuthRemoteDataSource {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final FirebaseStorage storage = FirebaseStorage.instance;

//   Future<void> signUp({required String email, required String password}) async {
//     try {
//       UserCredential userCredential = await firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password);

//       // Create a minimal user record with just the UID
//       await firestore.collection('users').doc(userCredential.user!.uid).set({
//         'id': userCredential.user!.uid.hashCode,
//         'firstName': '',
//         'lastName': '',
//         'profilePicture': null,
//         'phoneNumber': null,
//       });

//       await userCredential.user!.sendEmailVerification();
//     } catch (e, stackTrace) {
//       throw AuthException.fromFirebase(e, stackTrace);
//     }
//   }

//   // Future<void> completeProfile({
//   //   required String firstName,
//   //   required String lastName,
//   //   String? phoneNumber,
//   //   String? profilePicture,
//   // }) async {
//   //   try {
//   //     User? currentUser = firebaseAuth.currentUser;
//   //     if (currentUser == null) {
//   //       throw AuthException.fromFirebase(
//   //         Exception('No user signed in'),
//   //         StackTrace.current,
//   //       );
//   //     }

//   //     String? profilePictureUrl;
//   //     if (profilePicture != null) {
//   //       profilePictureUrl = await uploadProfilePicture(
//   //         profilePicture,
//   //         currentUser.uid,
//   //       );
//   //     }

//   //     await firestore
//   //         .collection('users')
//   //         .doc(currentUser.uid)
//   //         .update(
//   //           UserModel(
//   //             id: currentUser.uid.hashCode,
//   //             firstName: firstName,
//   //             lastName: lastName,
//   //             profilePicture: profilePictureUrl,
//   //             phoneNumber: phoneNumber,
//   //           ).toJson(),
//   //         );
//   //   } catch (e, stackTrace) {
//   //     throw AuthException.fromFirebase(e, stackTrace);
//   //   }
//   // }

//   Future<void> completeProfile({
//     required String firstName,
//     required String lastName,
//     String? phoneNumber,
//     String? profilePicture,
//   }) async {
//     try {
//       User? currentUser = firebaseAuth.currentUser;
//       if (currentUser == null) {
//         throw AuthException.fromFirebase(
//           Exception('No user signed in'),
//           StackTrace.current,
//         );
//       }

//       await firestore
//           .collection('users')
//           .doc(currentUser.uid)
//           .update(
//             UserModel(
//               id: currentUser.uid.hashCode,
//               firstName: firstName,
//               lastName: lastName,
//               profilePicture: profilePicture,
//               phoneNumber: phoneNumber,
//             ).toJson(),
//           );
//     } catch (e, stackTrace) {
//       throw AuthException.fromFirebase(e, stackTrace);
//     }
//   }

//   Future<void> login({required String email, required String password}) async {
//     try {
//       UserCredential userCredential = await firebaseAuth
//           .signInWithEmailAndPassword(email: email, password: password);

//       if (!userCredential.user!.emailVerified) {
//         await firebaseAuth.signOut();
//         throw AuthException.fromFirebase(
//           Exception('Email not verified'),
//           StackTrace.current,
//         );
//       }
//     } catch (e, stackTrace) {
//       throw AuthException.fromFirebase(e, stackTrace);
//     }
//   }

//   Future<void> sendEmailVerification() async {
//     try {
//       await firebaseAuth.currentUser?.sendEmailVerification();
//     } catch (e, stackTrace) {
//       throw AuthException.fromFirebase(e, stackTrace);
//     }
//   }

//   Future<String?> uploadProfilePicture(XFile image, String userId) async {
//     try {
//       String fileName = 'profile_pictures/$userId/profile_picture.jpg';
//       await storage.ref().child(fileName).putFile(File(image.path));
//       return await storage.ref().child(fileName).getDownloadURL();
//     } catch (e, stackTrace) {
//       throw AuthException.fromFirebase(e, stackTrace);
//     }
//   }

//   Future<void> logout() async {
//     try {
//       await firebaseAuth.signOut();
//     } catch (e, stackTrace) {
//       throw AuthException.fromFirebase(e, stackTrace);
//     }
//   }

//   User? get currentUser => firebaseAuth.currentUser;

//   Stream<bool> isSignedIn() {
//     return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
//   }
// }

// //isSignedInProvider
// final isSignedInProvider = StreamProvider<bool>((ref) {
//   return AuthRemoteDataSource().isSignedIn();
//   // return FirebaseService.instance.isSignedIn();
// });

// //isSIgnedIn Page
// class AuthPersister extends ConsumerStatefulWidget {
//   const AuthPersister({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _AuthPersisterState();
// }

// class _AuthPersisterState extends ConsumerState<AuthPersister> {
//   bool isLoading = true;
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, watch, child) {
//         final isSignedIn = ref.watch(isSignedInProvider);
//         return isSignedIn.when(
//           data: (isSignedIn) {
//             // if (isLoading) {
//             //   return SplashScreen();
//             // }

//             if (isSignedIn) {
//               // User is signed in, navigate to the main page
//               return const MainPage();
//             } else {
//               // return const WelcomeScreen();
//               return LoginScreen();
//             }
//           },
//           loading: () => SplashScreen(),
//           error: (e, s) => const Scaffold(body: Center(child: Text('Error'))),
//         );
//       },
//     );
//   }
// }

class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> signUp({required String email, required String password}) async {
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
    String? profilePicture,
  }) async {
    try {
      User? currentUser = firebaseAuth.currentUser;
      if (currentUser == null) {
        throw AuthException.fromFirebase(
          Exception('No user signed in'),
          StackTrace.current,
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
              profilePicture: profilePicture,
              phoneNumber: phoneNumber,
            ).toJson(),
          );
    } catch (e, stackTrace) {
      throw AuthException.fromFirebase(e, stackTrace);
    }
  }

  Future<void> login({required String email, required String password}) async {
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
    try {
      await firebaseAuth.currentUser?.sendEmailVerification();
    } catch (e, stackTrace) {
      throw AuthException.fromFirebase(e, stackTrace);
    }
  }

  Future<String?> uploadProfilePicture(XFile image, String userId) async {
    try {
      String fileName = 'profile_pictures/$userId/profile_picture.jpg';
      await storage.ref().child(fileName).putFile(File(image.path));
      return await storage.ref().child(fileName).getDownloadURL();
    } catch (e, stackTrace) {
      throw AuthException.fromFirebase(e, stackTrace);
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e, stackTrace) {
      throw AuthException.fromFirebase(e, stackTrace);
    }
  }

  User? get currentUser => firebaseAuth.currentUser;

  Stream<bool> isSignedIn() {
    return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
  }
}

//isSignedInProvider
final isSignedInProvider = StreamProvider<bool>((ref) {
  return AuthRemoteDataSource().isSignedIn();
});

//Authentication Persister - Fixed Version
class AuthPersister extends ConsumerStatefulWidget {
  const AuthPersister({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthPersisterState();
}

class _AuthPersisterState extends ConsumerState<AuthPersister> {
  bool splashComplete = false;

  // ADDED: initState to handle splash screen timing
  @override
  void initState() {
    super.initState();
    // ADDED: Always show splash screen for 3 seconds first
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          splashComplete = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ADDED: Always show splash screen first, regardless of auth state
    if (!splashComplete) {
      return const SplashScreen();
    }
    final isSignedIn = ref.watch(isSignedInProvider);

    return isSignedIn.when(
      data: (isSignedIn) {
        // User authentication state is determined
        if (isSignedIn) {
          // User is signed in, navigate to the main page
          return const MainPage();
        } else {
          // User is not signed in, navigate to login screen
          return LoginScreen();
        }
      },
      loading: () {
        // Show splash screen while checking authentication state
        return const SplashScreen();
      },
      error: (e, s) {
        // Show error screen if there's an authentication error
        return const Scaffold(
          body: Center(
            child: Text('Authentication Error. Please restart the app.'),
          ),
        );
      },
    );
  }
}
