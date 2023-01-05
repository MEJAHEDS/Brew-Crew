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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD5uTq0CZGprjMV13O_0r80K_E5_cW0ChU',
    appId: '1:414080375771:web:1396eabecce63acc9525fe',
    messagingSenderId: '414080375771',
    projectId: 'anapixnotes',
    authDomain: 'anapixnotes.firebaseapp.com',
    storageBucket: 'anapixnotes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlZsrk1_8nPefOdSV1jWkgkDi_vU_fgUc',
    appId: '1:414080375771:ios:6d63ad1b21d622bf9525fe',
    messagingSenderId: '414080375771',
    projectId: 'anapixnotes',
    storageBucket: 'anapixnotes.appspot.com',
    iosClientId: '414080375771-uqck9vv4oaar5kqpf97cdd7ouqlo0804.apps.googleusercontent.com',
    iosBundleId: 'com.mejaheds.fireapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBlZsrk1_8nPefOdSV1jWkgkDi_vU_fgUc',
    appId: '1:414080375771:ios:6d63ad1b21d622bf9525fe',
    messagingSenderId: '414080375771',
    projectId: 'anapixnotes',
    storageBucket: 'anapixnotes.appspot.com',
    iosClientId: '414080375771-uqck9vv4oaar5kqpf97cdd7ouqlo0804.apps.googleusercontent.com',
    iosBundleId: 'com.mejaheds.fireapp',
  );
}
