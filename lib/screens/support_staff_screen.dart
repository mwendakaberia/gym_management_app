import 'package:flutter/material.dart';

class SupportStaffScreen extends StatelessWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => const SupportStaffScreen(),
      );
  const SupportStaffScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff'),
      ),
    );
  }
}
