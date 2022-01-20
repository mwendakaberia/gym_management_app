import 'package:flutter/material.dart';

class TestOne extends StatelessWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => const TestOne(),
      );

  const TestOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
