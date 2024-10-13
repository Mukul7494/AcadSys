import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:acadsys/core/constants/router.dart';
import '../models/user_model.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserDocument(User user, String role) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      await userDoc.set({
        'uid': user.uid,
        'email': user.email,
        'role': role,
        'gender': '',
        'isEmailVerified': user.emailVerified,
        'createdAt': FieldValue.serverTimestamp(),
        'name': user.displayName,
        'photoUrl': user.photoURL,
        'phoneNumber': user.phoneNumber,
        'lastLoginAt': FieldValue.serverTimestamp(),
        'active': true,
      });
      if (kDebugMode) {
        print('User document created for ${user.email}');
      }
    } else {
      await userDoc.update({'lastLoginAt': FieldValue.serverTimestamp()});
      if (kDebugMode) {
        print('User document updated for ${user.email}');
      }
    }
  }

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        await createUserDocument(user, 'default_role');
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        return UserModel.fromFirestore(userDoc);
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Failed to sign in: ${e.message}');
      }
      rethrow;
    }
    return null;
  }

  Future<UserModel?> signUpUserWithEmailAndPassword(
      String email, String password, String role) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        await createUserDocument(user, role);
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        return UserModel.fromFirestore(userDoc);
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Failed to sign up: ${e.message}');
      }
      rethrow;
    }
    return null;
  }

  CollectionReference getUsersCollection() {
    return _firestore.collection('users');
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null; // The user canceled the sign-in
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        await createUserDocument(user, 'default_role');
      }
      return user;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to sign in with Google: $e');
      }
      rethrow;
    }
  }

  Future<UserModel?> fetchUserData(String uid) async {
    try {
      if (kDebugMode) {
        print('Fetching user data for $uid');
      }
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        if (kDebugMode) {
          print('Got user data: ${userDoc.data()}');
        }
        return UserModel.fromFirestore(userDoc);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
    return null;
  }

  Future<void> updateUserData(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).update(user.toMap());
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user data: $e');
      }
      rethrow;
    }
  }

  Future<void> navigateBasedOnRole(BuildContext context, UserModel user) async {
    try {
      switch (user.role) {
        case 'Admin':
          Navigator.pushReplacementNamed(context, SEMSRoute.adminHome.path);
          break;
        case 'Teacher':
          Navigator.pushReplacementNamed(context, SEMSRoute.teacherHome.path);
          break;
        case 'Student':
          Navigator.pushReplacementNamed(context, SEMSRoute.studentHome.path);
          break;
        case 'default_role':
          Navigator.pushReplacementNamed(context, SEMSRoute.roleSelection.path);
          break;
        default:
          throw Exception('Unknown user role');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error navigating based on role: $e');
      }
      rethrow;
    }
  }
}
