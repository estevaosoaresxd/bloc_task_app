import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC06uIbhM4vDTNvp54TOFpt4Sj357qlvQI',
    appId: '1:319953127431:android:dfab1d4beaf42e0b5682a2',
    messagingSenderId: '319953127431',
    projectId: 'bloc-task-6a454',
    storageBucket: 'bloc-task-6a454.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAk44wB7g0UBTum8k99NH3fzwuqAJ3xaqY',
    appId: '1:319953127431:ios:dc0dc38839f1b07b5682a2',
    messagingSenderId: '319953127431',
    projectId: 'bloc-task-6a454',
    storageBucket: 'bloc-task-6a454.appspot.com',
    iosClientId:
        '319953127431-v7m64n7kho8bhtern8v1tqinrj2o90jt.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterTaskAppTest',
  );
}
