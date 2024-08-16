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
    apiKey: 'AIzaSyDm1NR8rUrXmg8e6rR81uzv626-x6hi7_c',
    appId: '1:422989871043:web:e35bda28368b7742706f76',
    messagingSenderId: '422989871043',
    projectId: 'stellar-wallet-7b278',
    authDomain: 'stellar-wallet-7b278.firebaseapp.com',
    storageBucket: 'stellar-wallet-7b278.appspot.com',
    measurementId: 'G-RWN1NYK63N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwSGZAwGtSAJzVznIIDW3w9OfrC1fjc2I',
    appId: '1:422989871043:android:945ba9b25047e139706f76',
    messagingSenderId: '422989871043',
    projectId: 'stellar-wallet-7b278',
    storageBucket: 'stellar-wallet-7b278.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIi7s5GEs6u9n3JEWGE6u5rzAgANkmuWI',
    appId: '1:422989871043:ios:7ccdd231c27d5c5a706f76',
    messagingSenderId: '422989871043',
    projectId: 'stellar-wallet-7b278',
    storageBucket: 'stellar-wallet-7b278.appspot.com',
    iosBundleId: 'com.example.interstellar',
  );
}
