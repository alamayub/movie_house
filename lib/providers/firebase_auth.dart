import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show AuthCredential, FirebaseAuth, FirebaseAuthException, User;

import '../firebase_options.dart';

class FirebaseAuthProvider {
  // get current user
  User? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user;
    }
    return null;
  }

  // login with credential
  Future<void> loginWithCredentials({
    required AuthCredential authCredential,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      log('Error 53 ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Error 56 ${e.toString()}');
      rethrow;
    }
  }

  // login with email and password
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      log('Error 72 ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Error 74 ${e.toString()}');
      rethrow;
    }
  }

  // register with email and password
  Future<void> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      log('Error 91 ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Error 94 ${e.toString()}');
      rethrow;
    }
  }

  // logout
  Future<void> logout() async {
    // final user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      log('Error 50 ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Error 50 ${e.toString()}');
      rethrow;
    }
  }

  // initialize firebase app
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
