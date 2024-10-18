import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:marvel/src/core/app/navigation/routes/routes.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.getToken();
    // print(fcm);
    await initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }
    AppRoutes.router.pushNamed(
      'heroes',
      pathParameters: {
        'heroId': message.notification!.body.toString(),
      },
    );
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
