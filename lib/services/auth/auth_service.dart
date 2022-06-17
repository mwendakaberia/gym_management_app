import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class Auth {
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> signInWithApple();
  Future<UserCredential?> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password);
  Future<void> signOut();
  Stream<User?> get onAuthStateChanges;
}

class AuthenticationService implements Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<UserCredential?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  User? get user => _firebaseAuth.currentUser;

  @override
  Future<UserCredential> signInWithApple() async {
    // final credential = await SignInWithApple.getAppleIDCredential(
    //   scopes: [
    //     AppleIDAuthorizationScopes.email,
    //     AppleIDAuthorizationScopes.fullName,
    //   ],
    //   webAuthenticationOptions: WebAuthenticationOptions(
    //     // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
    //     clientId: 'de.lunaone.flutter.signinwithappleexample.service',

    //     redirectUri:
    //         // For web your redirect URI needs to be the host of the "current page",
    //         // while for Android you will be using the API server that redirects back into your app via a deep link
    //         kIsWeb
    //             ? Uri.parse('https://${window.location.host}/')
    //             : Uri.parse(
    //                 'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
    //               ),
    //   ),
    //   // TODO: Remove these if you have no need for them
    //   nonce: 'example-nonce',
    //   state: 'example-state',
    // );

    // // ignore: avoid_print
    // print(credential);
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
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
    return await _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  Stream<User?> get onAuthStateChanges => _firebaseAuth.authStateChanges();
}
