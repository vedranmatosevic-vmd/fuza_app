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
    apiKey: 'AIzaSyD8fORqP0yAf521BJOebr070WfZ7zG4DVs',
    appId: '1:704265140215:web:3ca6dff1c689ae19b260f2',
    messagingSenderId: '704265140215',
    projectId: 'fuza-app',
    authDomain: 'fuza-app.firebaseapp.com',
    storageBucket: 'fuza-app.appspot.com',
    measurementId: 'G-K9PK9V2S76',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0q6sXT7RQ3wOSd6uL5FOF5IQo7hq-oEA',
    appId: '1:704265140215:android:a104c923cce708b9b260f2',
    messagingSenderId: '704265140215',
    projectId: 'fuza-app',
    storageBucket: 'fuza-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBD1MoM7HXoqxef7Ip6l95CLDnhObDEGTQ',
    appId: '1:704265140215:ios:2f96a5800f731542b260f2',
    messagingSenderId: '704265140215',
    projectId: 'fuza-app',
    storageBucket: 'fuza-app.appspot.com',
    iosClientId: '704265140215-dndm6vloqenios0iid4i7vpsote280uc.apps.googleusercontent.com',
    iosBundleId: 'com.example.fuzaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBD1MoM7HXoqxef7Ip6l95CLDnhObDEGTQ',
    appId: '1:704265140215:ios:2f96a5800f731542b260f2',
    messagingSenderId: '704265140215',
    projectId: 'fuza-app',
    storageBucket: 'fuza-app.appspot.com',
    iosClientId: '704265140215-dndm6vloqenios0iid4i7vpsote280uc.apps.googleusercontent.com',
    iosBundleId: 'com.example.fuzaApp',
  );
}
