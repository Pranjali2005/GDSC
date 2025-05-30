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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBePAiephUOMjudPS_f3A6ihFglpWW0ccw',
    appId: '1:701348151619:web:ab9fcec12d873fa9f0aff6',
    messagingSenderId: '701348151619',
    projectId: 'bmipro-b4255',
    authDomain: 'bmipro-b4255.firebaseapp.com',
    storageBucket: 'bmipro-b4255.firebasestorage.app',
    measurementId: 'G-X91B3Y7R1Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqV7QlcOCJk5sCCBIIi5G4TZ1RfE2ooa0',
    appId: '1:701348151619:android:bab6ea69dcf218c9f0aff6',
    messagingSenderId: '701348151619',
    projectId: 'bmipro-b4255',
    storageBucket: 'bmipro-b4255.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBePAiephUOMjudPS_f3A6ihFglpWW0ccw',
    appId: '1:701348151619:web:5fe2629dd42fdd76f0aff6',
    messagingSenderId: '701348151619',
    projectId: 'bmipro-b4255',
    authDomain: 'bmipro-b4255.firebaseapp.com',
    storageBucket: 'bmipro-b4255.firebasestorage.app',
    measurementId: 'G-6S1F0G6PY9',
  );
}
