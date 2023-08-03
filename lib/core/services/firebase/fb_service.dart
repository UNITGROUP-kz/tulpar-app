import 'package:firebase_core/firebase_core.dart';
import 'package:garage/firebase_options.dart';

class FBService {
  static late FirebaseApp app;

  static Future initialize() async {
    app = await Firebase.initializeApp(
      name: 'tulpar-store',
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return app;
  }
}