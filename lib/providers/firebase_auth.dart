import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show
        AuthCredential,
        FacebookAuthProvider,
        FirebaseAuth,
        FirebaseAuthException,
        GoogleAuthProvider,
        OAuthCredential,
        User,
        UserCredential;

import '../firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseAuthProvider {
  // get current user
  User? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) return user;
    return null;
  }

  // login with credential
  Future<void> loginWithCredentials({
    required AuthCredential authCredential,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      log('Error 26 ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Error 29 ${e.toString()}');
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
      log('Error 45 ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Error 48 ${e.toString()}');
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
      await FirebaseAuth.instance.currentUser!.reload();
    } on FirebaseAuthException catch (e) {
      log('Error 66 ${e.toString()}');
      if (e.code == 'requires-recent-login') await logout();
      rethrow;
    } catch (e) {
      log('Error 69 ${e.toString()}');
      rethrow;
    }
  }

  // verify email
  Future<void> sendEmailVerification() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      log('Error 79 ${e.toString()}');
      if (e.code == 'requires-recent-login') await logout();
      rethrow;
    } catch (e) {
      log('Error 82 ${e.toString()}');
      rethrow;
    }
  }

  // logout
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      log('Error 92 ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Error 95 ${e.toString()}');
      rethrow;
    }
  }

  // delete account
  Future<void> deleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      log('Error 105 ${e.toString()}');
      if (e.code == 'requires-recent-login') await logout();
      rethrow;
    } catch (e) {
      log('Error 108 ${e.toString()}');
      rethrow;
    }
  }

  // initialize firebase app
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // login with google account
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      log('Error 148 ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Error 152 ${e.toString()}');
      rethrow;
    }
  }

  // login with facebook
  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      log('Error 170 ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Error 174 ${e.toString()}');
      rethrow;
    }
  }
}
