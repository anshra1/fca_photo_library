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
    apiKey: 'AIzaSyAehUXzi8AWTnxETEOGzEsp8uQp771g8bY',
    appId: '1:520133562211:web:baa1a29ccf693ac3294d56',
    messagingSenderId: '520133562211',
    projectId: 'fca-photo-library',
    authDomain: 'fca-photo-library.firebaseapp.com',
    storageBucket: 'fca-photo-library.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMDiLvdYBhaBC8_lL7JH7-ed1r9NJzh2A',
    appId: '1:520133562211:android:9b70ded40c19438f294d56',
    messagingSenderId: '520133562211',
    projectId: 'fca-photo-library',
    storageBucket: 'fca-photo-library.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5_ZeGxeWT9wGNSzecr0TAl9Ww7WaKAoY',
    appId: '1:520133562211:ios:a1da346b6e2a76fb294d56',
    messagingSenderId: '520133562211',
    projectId: 'fca-photo-library',
    storageBucket: 'fca-photo-library.appspot.com',
    iosBundleId: 'com.example.fcaPhotoLibrary',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD5_ZeGxeWT9wGNSzecr0TAl9Ww7WaKAoY',
    appId: '1:520133562211:ios:e81809605eb5bea2294d56',
    messagingSenderId: '520133562211',
    projectId: 'fca-photo-library',
    storageBucket: 'fca-photo-library.appspot.com',
    iosBundleId: 'com.example.fcaPhotoLibrary.RunnerTests',
  );
}
