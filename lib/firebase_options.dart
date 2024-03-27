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
    apiKey: 'AIzaSyAW-Yg8ySScciJOB1LSCv7uINhscaojd4w',
    appId: '1:322583660992:web:d54a46171693a9c914a025',
    messagingSenderId: '322583660992',
    projectId: 'chat-app-b351c',
    authDomain: 'chat-app-b351c.firebaseapp.com',
    storageBucket: 'chat-app-b351c.appspot.com',
    measurementId: 'G-0P3DRYNFM7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnfS6ej4MwywN3GKZ6cR5hfMt3pO0WiDo',
    appId: '1:322583660992:android:3501573d54162efc14a025',
    messagingSenderId: '322583660992',
    projectId: 'chat-app-b351c',
    storageBucket: 'chat-app-b351c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIDaYaCd1LIjNhgNmDchEkk8DQ9AanHag',
    appId: '1:322583660992:ios:0d907959cb99549014a025',
    messagingSenderId: '322583660992',
    projectId: 'chat-app-b351c',
    storageBucket: 'chat-app-b351c.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAIDaYaCd1LIjNhgNmDchEkk8DQ9AanHag',
    appId: '1:322583660992:ios:bd14aec5d9ba9bcd14a025',
    messagingSenderId: '322583660992',
    projectId: 'chat-app-b351c',
    storageBucket: 'chat-app-b351c.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}
