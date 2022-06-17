import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:the_bar_gym/screens/auth/auth_controller.dart';
import 'package:the_bar_gym/services/auth/auth_service.dart';
import 'package:the_bar_gym/validator.dart';

enum AuthenticationWith { Apple, Google, Email_And_Password }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get _isValid => _formKey.currentState!.validate();

  void _authenticate(
      AuthenticationWith authenticationType, BuildContext context) {
    switch (authenticationType) {
      case AuthenticationWith.Google:
        context.read<AuthenticationService>().signInWithGoogle();
        break;
      case AuthenticationWith.Apple:
        context.read<AuthenticationService>().signInWithApple();
        break;
      case AuthenticationWith.Email_And_Password:
        if (_isValid) {
          context.read<AuthenticationService>().signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
              );
          break;
        }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) => EmailValidator.validate(value),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'password',
                    ),
                    validator: (value) => PasswordValidator.validate(value),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  ElevatedButton(
                      onPressed: () => _authenticate(
                          AuthenticationWith.Email_And_Password, context),
                      child: const Text('sign in ')),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () =>
                          _authenticate(AuthenticationWith.Google, context),
                      child: const Text('Google sign in')),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () =>
                          _authenticate(AuthenticationWith.Apple, context),
                      child: const Text('Apple sign in')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
