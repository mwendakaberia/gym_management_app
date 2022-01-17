import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_bar_gym/pages/pages.dart';
import 'package:the_bar_gym/screens/home_screen.dart';
import 'package:the_bar_gym/theme.dart';
import 'firebase_options.dart';

///todo
void main() {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(MyApp(
    appTheme: AppTheme(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appTheme}) : super(key: key);
  final AppTheme appTheme;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      themeMode: ThemeMode.dark,
      home: QRScreen(),
    );
  }
}
