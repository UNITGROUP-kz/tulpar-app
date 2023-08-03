import 'package:firebase_auth/firebase_auth.dart';

import 'fb_service.dart';

class FBAuthService {
  static late FirebaseAuth _instance;

  static FirebaseAuth get I => _instance;

  static User? get currentUser => _instance.currentUser;

  static setInstance() {
    _instance = FirebaseAuth.instanceFor(app: FBService.app);
  }
}