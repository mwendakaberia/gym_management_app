import 'package:flutter/material.dart';
import 'package:the_bar_gym/screens/home_screen.dart';
import 'package:the_bar_gym/widgest/glowing_action_button.dart';

import '../../theme.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

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
            child: Text('Forgot Password?')),
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
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: 'Enter Email Address'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Password',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {}, child: Text('Forgot Password?')),
                        GlowingSignInButton(
                          color: AppColors.iconLight,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return HomeScreen();
                              }),
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
