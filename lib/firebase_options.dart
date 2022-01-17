// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAezuTTkLtb0WkxawBVjs-BpX2s_uwFCvc',
    appId: '1:968654133575:android:86371b9d7b918ff65a5462',
    messagingSenderId: '968654133575',
    projectId: 'gym-management-e98f3',
    storageBucket: 'gym-management-e98f3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCfMh2p4xB4-e-c-slzUgxvOLe7vfWDVGI',
    appId: '1:968654133575:ios:9eb527d28d17e9af5a5462',
    messagingSenderId: '968654133575',
    projectId: 'gym-management-e98f3',
    storageBucket: 'gym-management-e98f3.appspot.com',
    iosClientId: '968654133575-reptg02ie32epjhkkj7q58sjjm68kou8.apps.googleusercontent.com',
    iosBundleId: 'com.example.thebargym',
  );
}