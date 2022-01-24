import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_bar_gym/screens/screens.dart';
import 'package:the_bar_gym/widgest/app_bar.dart';
import 'package:the_bar_gym/widgest/avatars.dart';
import 'package:the_bar_gym/widgest/spped_dials/home_page_speeddial.dart';
import 'package:the_bar_gym/widgest/widgets.dart';

import '../theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: Text('The Bar'),
        ),
        centerTitle: false,
        leadingWidth: 54,
        leading: Align(
            alignment: Alignment.centerRight, child: HomeSpeedDialButton()),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => {
                    // setState(() {
                    //   hasBeenPressed = !hasBeenPressed;
                    // }),
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        // BoxShadow(
                        //   color: hasBeenPressed
                        //       ? AppColors.accent.withOpacity(0.3)
                        //       : AppColors.iconLight,
                        //   spreadRadius: 8,
                        //   blurRadius: 24,
                        // ),
                      ],
                    ),
                    // child: Text(
                    //   'LVL UP',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w900,
                    //     color: hasBeenPressed
                    //         ? AppColors.accent
                    //         : AppColors.iconLight,
                    //   ),
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Hero(
                  tag: 'hero-profile-picture',
                  child: Avatar.small(
                    url: null,
                    onTap: () {
                      Navigator.of(context).push(ProfileScreen.route);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(child: Text('NotificationsPage')),
    );
  }
}
