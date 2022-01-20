import 'package:flutter/material.dart';

class TabBarLibrary extends StatelessWidget {
  const TabBarLibrary({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          Container(
            child: Center(
              child: Text('people'),
            ),
          ),
          Text('Person'),
          Text('Person'),
        ],
        controller: _tabController,
      ),
    );
  }
}
