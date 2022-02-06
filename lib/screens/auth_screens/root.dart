
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_bar_gym/screens/auth_screens/login_screen.dart';
import 'package:the_bar_gym/screens/auth_screens/welcome_screen.dart';
import 'package:the_bar_gym/screens/home_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final User? currentUser = context.watch<User?>();

    if (currentUser == null) {
      return const WelcomeScreen();
    }else {
      return HomeScreen();
    }
  }
}