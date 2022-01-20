import 'package:flutter/material.dart';
import 'package:the_bar_gym/pages/pages.dart';
import 'package:the_bar_gym/theme.dart';

class TabBarDemo extends StatefulWidget {
  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo>
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
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
              indicatorColor: AppColors.textFaded,
              unselectedLabelColor: Colors.white,
              labelColor: Colors.red,
              tabs: [
                Tab(
                  text: 'Chest',
                ),
                Tab(
                  text: 'Back',
                ),
                Tab(
                  text: 'Legs',
                ),
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            TabBarLibrary(tabController: _tabController),
          ],
        ),
      ),
    );
  }
}
