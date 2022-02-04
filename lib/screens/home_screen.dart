

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:the_bar_gym/models/user_model.dart';
import 'package:the_bar_gym/pages/pages.dart';
import 'package:the_bar_gym/pages/qr_scanner_pagetest.dart';
import 'package:the_bar_gym/pages/support_staff_pages/trainer_expanded_list.dart';
import 'package:the_bar_gym/screens/profile_screen.dart';
import 'package:the_bar_gym/screens/screens.dart';
import 'package:the_bar_gym/widgest/SpeedDialButton.dart';
import 'package:the_bar_gym/widgest/avatars.dart';
import 'package:the_bar_gym/widgest/spped_dials/home_page_speeddial.dart';
import 'package:the_bar_gym/widgest/widgets.dart';

import '../theme.dart';
import 'auth_screens/welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );
  HomeScreen({Key? key}) : super(key: key);
String? userId;

  final _auth = FirebaseAuth.instance;
 User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Welcome To The Bar');

  final pages = [
    WelcomePage(),
    StreamPage(),
    TabBarDemo(),
    SupportStaffPage(),
  ];

  final pageTitles = const [
    'Welcome To The Bar',
    'The Locker Room',
    'Demo Library',
    'Trainers',
  ];

  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }
  @override
  void initState() {


    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value){
      this.loggedInUser = UserModel.formMap(value.data());
      // setState(() {
      //
      // });
    });
    // var userPic = loggedInUser.picURL;
print(loggedInUser.userName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MainAppBar(
      //   title: title,
      //   appBar: AppBar(),
      // ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

// class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
//   const MainAppBar({
//     Key? key,
//     required this.title,
//     required this.appBar,
//   }) : super(key: key);
//
//   final String title;
//   final AppBar appBar;
//
//   @override
//   State<MainAppBar> createState() => _MainAppBarState();
//
//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
// }
//
// class _MainAppBarState extends State<MainAppBar> {
//   bool hasBeenPressed = false;
//   late final String title;
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: false,
//       title: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.iconLight.withOpacity(0.3),
//               spreadRadius: 8,
//               blurRadius: 24,
//             ),
//           ],
//         ),
//         child: Text(title),
//       ),
//       leadingWidth: 54,
//       leading: Align(
//         alignment: Alignment.centerRight,
//         child: IconBackground(
//           icon: CupertinoIcons.camera_circle,
//           onTap: () {},
//         ),
//       ),
//       actions: [
//         Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GestureDetector(
//                 onTap: () => {
//                   setState(() {
//                     hasBeenPressed = !hasBeenPressed;
//                   }),
//                   Navigator.push(context, SupportStaffScreen.route)
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       // BoxShadow(
//                       //   color: hasBeenPressed
//                       //       ? AppColors.accent.withOpacity(0.3)
//                       //       : AppColors.iconLight,
//                       //   spreadRadius: 8,
//                       //   blurRadius: 24,
//                       // ),
//                     ],
//                   ),
//                   // child: Text(
//                   //   'LVL UP',
//                   //   style: TextStyle(
//                   //     fontWeight: FontWeight.w900,
//                   //     color: hasBeenPressed
//                   //         ? AppColors.accent
//                   //         : AppColors.iconLight,
//                   //   ),
//                   // ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 24.0),
//               child: Hero(
//                 tag: 'hero-profile-picture',
//                 child: Avatar.small(
//                   url: null,
//                   onTap: () {
//                     Navigator.of(context).push(ProfileScreen.route);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  __BottomNavigationBarState createState() => __BottomNavigationBarState();
}

class __BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return SafeArea(
      child: Card(
        color: (brightness == Brightness.light) ? Colors.transparent : null,
        elevation: 0,
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _NavigationBarItem(
                  index: 0,
                  // lable: 'Front Desk',
                  icon: CupertinoIcons.house_alt,
                  isSelected: (selectedIndex == 0),
                  onTap: handleItemSelected,
                ),
              ),
              Expanded(
                child: _NavigationBarItem(
                  index: 1,
                  // lable: 'Locker Room',
                  icon: CupertinoIcons.bubble_left_bubble_right,
                  isSelected: (selectedIndex == 1),
                  onTap: handleItemSelected,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GlowingActionButton(
                  color: AppColors.secondary,
                  icon: CupertinoIcons.qrcode_viewfinder,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Scanner();
                      }),
                    );
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) => Dialog(
                    //     child: AspectRatio(
                    //       aspectRatio: 8 / 7,
                    //       child: QRScannerPage(),
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
              Expanded(
                child: _NavigationBarItem(
                  index: 2,
                  // lable: 'Demos',
                  icon: CupertinoIcons.play_rectangle,
                  isSelected: (selectedIndex == 2),
                  onTap: handleItemSelected,
                ),
              ),

              Expanded(
                child: _NavigationBarItem(
                  index: 3,
                  // lable: 'Trainers',
                  icon: CupertinoIcons.helm,
                  isSelected: (selectedIndex == 3),
                  onTap: handleItemSelected,
                ),
              ),

              // _NavigationBarItem(
              //   index: 3,
              //   lable: 'Trainers',
              //   icon: Icons.whatshot_outlined,
              //   isSelected: (selectedIndex == 3),
              //   onTap: handleItemSelected,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.index,
    // required this.lable,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final int index;
  // final String lable;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? AppColors.secondary : null,
            ),
            // const SizedBox(
            //   height: 8,
            // ),
            // Text(
            //   lable,
            //   style: isSelected
            //       ? const TextStyle(
            //           fontSize: 11,
            //           color: AppColors.secondary,
            //         )
            //       : const TextStyle(fontSize: 11),
            // ),
          ],
        ),
      ),
    );
  }
}
