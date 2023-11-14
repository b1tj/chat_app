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
    apiKey: 'AIzaSyCYgDO4OO0wMChtoo9bokHL1ah8HTIsZZM',
    appId: '1:48761185445:web:93f77a051862a74ef4594c',
    messagingSenderId: '48761185445',
    projectId: 'chatapp-4a17a',
    authDomain: 'chatapp-4a17a.firebaseapp.com',
    storageBucket: 'chatapp-4a17a.appspot.com',
    measurementId: 'G-CBVE4LWCQ6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxgBy4eDuVE5nxA3-O3-DN8f_3xT3Rang',
    appId: '1:48761185445:android:a8aea1d2fae75224f4594c',
    messagingSenderId: '48761185445',
    projectId: 'chatapp-4a17a',
    storageBucket: 'chatapp-4a17a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxcv-bqrf7OV66pvgB3q4inJRTMXWHOOY',
    appId: '1:48761185445:ios:245c5b8b3a575d99f4594c',
    messagingSenderId: '48761185445',
    projectId: 'chatapp-4a17a',
    storageBucket: 'chatapp-4a17a.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxcv-bqrf7OV66pvgB3q4inJRTMXWHOOY',
    appId: '1:48761185445:ios:337094206694e64ff4594c',
    messagingSenderId: '48761185445',
    projectId: 'chatapp-4a17a',
    storageBucket: 'chatapp-4a17a.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}