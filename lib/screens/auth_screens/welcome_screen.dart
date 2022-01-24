import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_bar_gym/screens/auth_screens/register_screen.dart';

import '../../theme.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/bar2.jpg'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      clipBehavior: Clip.hardEdge,
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.cardDark,
                        elevation: 2,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.iconLight.withOpacity(0.3),
                                spreadRadius: 20,
                                blurRadius: 24,
                              ),
                            ],
                          ),
                          child: Text('Login')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      clipBehavior: Clip.hardEdge,
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        primary: AppColors.cardDark,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return RegistrationScreen();
                          }),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.iconLight.withOpacity(0.3),
                                spreadRadius: 20,
                                blurRadius: 24,
                              ),
                            ],
                          ),
                          child: Text('Register')),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
