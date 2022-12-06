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
    apiKey: 'AIzaSyDHK0Fet4_yR-JNF-n-puyJz9oNDJcBOmI',
    appId: '1:468643426117:web:34d8fd64a3b38da00b582c',
    messagingSenderId: '468643426117',
    projectId: 'fireapp-cd28a',
    authDomain: 'fireapp-cd28a.firebaseapp.com',
    storageBucket: 'fireapp-cd28a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGKnz_rdAOn0ZA7-6R9et4nfJ3XWxxeuQ',
    appId: '1:468643426117:ios:bb187c1488d379320b582c',
    messagingSenderId: '468643426117',
    projectId: 'fireapp-cd28a',
    storageBucket: 'fireapp-cd28a.appspot.com',
    iosClientId: '468643426117-57rqa36olemn9dj605oee79ncqoes144.apps.googleusercontent.com',
    iosBundleId: 'com.mejaheds.fireapp',
  );
}
