import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_bar_gym/screens/auth/login_screen.dart';
import 'package:the_bar_gym/screens/auth/registration_screen.dart';
import 'package:the_bar_gym/screens/home_screen.dart';
import 'package:the_bar_gym/services/auth/auth_service.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<AuthenticationService>().onAuthStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
