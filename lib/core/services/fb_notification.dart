import 'package:firebase_messaging/firebase_messaging.dart';

class FbNotification {
  static FirebaseMessaging get I => FirebaseMessaging.instance;

  static initialize() async {
    await I.requestPermission();
    await I.setForegroundNotificationPresentationOptions(
      badge: true,
      alert: true,
      sound: true
    );
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler());
  }

  // @pragma('vm:entry-point')
  // static Future<void> Function(RemoteMessage) _firebaseMessagingBackgroundHandler(Function callback) => (RemoteMessage message) async {
  //   callback();
  //   print('Handling a background message ${message.messageId}');
  // };
}