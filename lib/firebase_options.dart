// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCLAWMId5sTNG62vw6nSE8uilY77_JmG94',
    appId: '1:59876994773:web:1798d30b7ce4c6938dfc5c',
    messagingSenderId: '59876994773',
    projectId: 'myproject-fe839',
    authDomain: 'myproject-fe839.firebaseapp.com',
    storageBucket: 'myproject-fe839.appspot.com',
    measurementId: 'G-XDW0J3H6H2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBiXZTeuD2lLEh7yH0LBhCy3RuZtydQwy8',
    appId: '1:59876994773:android:d52079414f79d44e8dfc5c',
    messagingSenderId: '59876994773',
    projectId: 'myproject-fe839',
    storageBucket: 'myproject-fe839.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBj684Cbkw657ci0kmq2ORLzP_EXEdQ8Pg',
    appId: '1:59876994773:ios:250c376e4d4152718dfc5c',
    messagingSenderId: '59876994773',
    projectId: 'myproject-fe839',
    storageBucket: 'myproject-fe839.appspot.com',
    iosClientId: '59876994773-edrgop1oqks7rh2g1ma60f3mvcgj97s7.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBj684Cbkw657ci0kmq2ORLzP_EXEdQ8Pg',
    appId: '1:59876994773:ios:250c376e4d4152718dfc5c',
    messagingSenderId: '59876994773',
    projectId: 'myproject-fe839',
    storageBucket: 'myproject-fe839.appspot.com',
    iosClientId: '59876994773-edrgop1oqks7rh2g1ma60f3mvcgj97s7.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled',
  );
}
