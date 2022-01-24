import 'package:flutter/material.dart';
import 'package:the_bar_gym/utils/colors.dart';
import 'package:the_bar_gym/utils/textStyles.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 3,
        title: const Text(
          "Analytics",
          style: AppBarTitleStyle.dark,
        ),
      ),
      body: const Text("helllllllllllllllllllllllllllllllllllo"),
    );
  }
}
