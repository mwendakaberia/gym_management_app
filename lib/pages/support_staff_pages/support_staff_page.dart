import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_bar_gym/pages/pages.dart';
import 'package:the_bar_gym/pages/support_staff_pages/trainer_tab_bar_library.dart';
import 'package:the_bar_gym/screens/home_screen.dart';
import 'package:the_bar_gym/screens/screens.dart';
import 'package:the_bar_gym/theme.dart';
import 'package:the_bar_gym/widgest/app_bar.dart';
import 'package:the_bar_gym/widgest/avatars.dart';
import 'package:the_bar_gym/widgest/icons_buttons.dart';
import 'package:the_bar_gym/widgest/spped_dials/home_page_speeddial.dart';

class SupportStaffPage extends StatefulWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => SupportStaffPage(),
      );
  @override
  _SupportStaffPageState createState() => _SupportStaffPageState();
}

class _SupportStaffPageState extends State<SupportStaffPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

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
          child: Text('Support Staff'),
        ),
        centerTitle: false,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: HomeSpeedDialButton(),
        ),
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
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
              indicatorColor: AppColors.textFaded,
              unselectedLabelColor: Colors.white,
              labelColor: Colors.red,
              tabs: const [
                Tab(
                  text: 'Trainers',
                ),
                Tab(
                  text: 'Nutritionists',
                ),
                Tab(
                  text: 'Physical Therapists',
                ),
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            TrainerTabBarLibrary(tabController: _tabController),
          ],
        ),
      ),
    );
  }
}
