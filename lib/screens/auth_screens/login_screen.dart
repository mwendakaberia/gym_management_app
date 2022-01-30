import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:the_bar_gym/screens/auth_screens/forgot_password.dart';
import 'package:the_bar_gym/screens/home_screen.dart';
import 'package:the_bar_gym/widgest/glowing_action_button.dart';

import '../../firebase.dart';
import '../../theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.iconLight.withOpacity(0.3),
                  spreadRadius: 8,
                  blurRadius: 24,
                ),
              ],
            ),
            child: Text('Login')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('images/bar2.jpg'),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        // image: ,
                        ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                       labelText: 'Enter Email Address'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),

                     labelText: 'Enter Password',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return ForgotPassword();
                                }),
                              );
                            },
                            child: Text('Forgot Password?')),
                        GlowingSignInButton(
                          color: AppColors.iconLight,
                          onPressed: () {
                            context.read<FlutterFireAuthService>().signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context,
                            );
                          },
                          text: 'Login',
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlowingSignInButton extends StatelessWidget {
  const GlowingSignInButton({
    Key? key,
    required this.color,
    required this.text,
    this.size = 60,
    required this.onPressed,
  }) : super(key: key);

  final Color color;

  final double size;
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            spreadRadius: 10,
            blurRadius: 24,
          ),
        ],
      ),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: AppColors.cardLight,
            onTap: onPressed,
            child: SizedBox(
              width: size,
              height: size,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: TextStyle(color: AppColors.textDark),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
