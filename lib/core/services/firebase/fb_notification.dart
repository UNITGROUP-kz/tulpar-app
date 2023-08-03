import 'package:firebase_messaging/firebase_messaging.dart';

import '../database/shared_preference.dart';

class FbNotification {
  static FirebaseMessaging get I => FirebaseMessaging.instance;

  static initialize() async {
    await I.requestPermission();
    await I.setForegroundNotificationPresentationOptions(
      badge: true,
      alert: true,
      sound: true
    );

    if(checkTopic() == null) {
      _setTopic(true);
    }
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler());
  }

  static toggle() async {
    await _setTopic(!(checkTopic() ?? false));
  }

  static Future _setTopic(bool isAdd) async {
    if(isAdd) {
      await FbNotification.I.subscribeToTopic('all');
    } else {
      await FbNotification.I.unsubscribeFromTopic('all');
    }
    await SPService.I.setBool('fb_topic', isAdd);
  }

  static bool? checkTopic() {
    return SPService.I.getBool('fb_topic');
  }

  // @pragma('vm:entry-point')
  // static Future<void> Function(RemoteMessage) _firebaseMessagingBackgroundHandler(Function callback) => (RemoteMessage message) async {
  //   callback();
  //   print('Handling a background message ${message.messageId}');
  // };
}