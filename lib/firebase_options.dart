// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCrnYaXPce1aklastMwEhJ_sZ3wq2vguBk',
    appId: '1:456773516226:web:f4c8697b1dddb07c90b45b',
    messagingSenderId: '456773516226',
    projectId: 'socially-app-f640c',
    authDomain: 'socially-app-f640c.firebaseapp.com',
    storageBucket: 'socially-app-f640c.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDpyS-ZwUDuY6hvgcxfBRvwgXZJ7gmy0pg',
    appId: '1:456773516226:android:2cf7247521235c1390b45b',
    messagingSenderId: '456773516226',
    projectId: 'socially-app-f640c',
    storageBucket: 'socially-app-f640c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKobW_o2ROzr3ybJANcMLBda4ffiwmvyE',
    appId: '1:456773516226:ios:8de5faf6fec513ab90b45b',
    messagingSenderId: '456773516226',
    projectId: 'socially-app-f640c',
    storageBucket: 'socially-app-f640c.firebasestorage.app',
    iosBundleId: 'com.example.socially',
  );
}