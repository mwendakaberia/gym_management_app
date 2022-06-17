import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_bar_gym/services/auth/auth_service.dart';
import 'package:the_bar_gym/validator.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get _isValid => _formKey.currentState!.validate();

  void register(BuildContext context) {
    if (_isValid) {
      _formKey.currentState!.save();

      context.read<AuthenticationService>().registerWithEmailAndPassword(
          _emailController.text.trim(), _passwordController.text.trim());
    }
  }

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
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
                  onPressed: () => register(context),
                  child: const Text('Register')),
            ],
          ),
        ),
      ),
    );
  }
}
