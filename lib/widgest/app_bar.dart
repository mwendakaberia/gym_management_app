import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_bar_gym/screens/screens.dart';
import 'package:the_bar_gym/pages/support_staff_pages/support_staff_page.dart';

import '../theme.dart';
import 'avatars.dart';
import 'icons_buttons.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar({
    Key? key,
    required this.title,
    required this.appBar,
  }) : super(key: key);

  final String title;
  final AppBar appBar;

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class _MainAppBarState extends State<MainAppBar> {
  bool hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leadingWidth: 54,
      leading: Align(
        alignment: Alignment.centerRight,
        child: IconBackground(
          icon: CupertinoIcons.camera_circle,
          onTap: () {},
        ),
      ),
      actions: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => {
                  setState(() {
                    hasBeenPressed = !hasBeenPressed;
                  }),
                  // Navigator.push(context, SupportStaffScreen.route)
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
    );
  }
}
