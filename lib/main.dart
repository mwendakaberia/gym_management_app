import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_bar_gym/provider/exercise_detail_provider.dart';
import 'package:the_bar_gym/screens/auth_screens/root.dart';
import 'package:the_bar_gym/screens/auth_screens/welcome_screen.dart';
import 'package:the_bar_gym/services/firestore_service.dart';

import 'package:the_bar_gym/theme.dart';
import 'package:the_bar_gym/utils/theme.dart';
import 'package:the_bar_gym/utils/units.dart';

import 'firebase.dart';
import 'firebase_options.dart';

///todo
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        Provider<FlutterFireAuthService>(
          create: (_) => FlutterFireAuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<FlutterFireAuthService>().authStateChanges,
          initialData: null,
        ),
        // Provider<AuthenticationService>(create: (_) => AuthenticationService()),
        // StreamProvider(
        //   create: (context) =>
        //   context.read<AuthenticationService>().onAuthStateChanges,
        //   initialData: null,
        // ),

        // Provider(
        //   create: (_) => AppDatabase(),
        // ),
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => UnitsNotifier(),
        ),
        Provider(create: (_) => FirestoreService()),
        Provider(create: (_) => ExerciseDetailProvider()),
      ],
      child: MyApp(
        appTheme: AppTheme(),
      ),
    ),
  );
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
      home: RootScreen(),
    );
  }
}
