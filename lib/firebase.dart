
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_bar_gym/screens/home_screen.dart';



class FlutterFireAuthService {
  final FirebaseAuth _firebaseAuth;

  FlutterFireAuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn(
      {required String email, required String password, required BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(

          email: email, password: password);
      print("Signed In");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }

  Future<String?> signUp(
      {required String email, required String password, required BuildContext context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }
}