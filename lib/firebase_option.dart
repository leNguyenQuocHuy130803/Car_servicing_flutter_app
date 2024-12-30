import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions  {
  static FirebaseOptions  get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      // case TargetPlatform.macOS:
      //   return macos;
      // case TargetPlatform.windows:
      //   return windows;
      // case TargetPlatform.linux:
      //   return linux;
      default:
        throw UnsupportedError('This platform is not supported');
    }
  }
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyDD_CGCO1Nip3tg5g6l1kLXnfhpby8PVbs",
      authDomain: "car-service-f3b5b.firebaseapp.com",
      databaseURL: "https://car-service-f3b5b-default-rtdb.firebaseio.com",
      projectId: "car-service-f3b5b",
      storageBucket: "car-service-f3b5b.firebasestorage.app",
      messagingSenderId: "173987522263",
      appId: "1:173987522263:web:1976716ffaa63eb907f292",
      measurementId: "G-FVGTW17R7N"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyCK1ycvjMVqlkBoOCio0td0l3QGBs8j3-E",
      projectId: "car-service-f3b5b",
      messagingSenderId: "173987522263",
      appId: "1:173987522263:android:68c5afef34ef409f07f292",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyCK1ycvjMVqlkBoOCio0td0l3QGBs8j3-E",
    projectId: "car-service-f3b5b",
    messagingSenderId: "173987522263",
    appId: '1:173987522263:ios:68c5afef34ef409f07f292',
  );


}
  