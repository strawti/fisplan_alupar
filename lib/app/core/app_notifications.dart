import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../presenter/download_data/download_data_page.dart';

class AppNotifications {
  AndroidNotificationChannel? channel;
  FlutterLocalNotificationsPlugin? localNotification;

  Future init() async {
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null) {
          FirebaseMessaging.onBackgroundMessage(_pushBackgroundHandler);
        }
      },
    );

    localNotification = FlutterLocalNotificationsPlugin();
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          localNotification?.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                icon: '@mipmap/launcher_icon',
              ),
            ),
          );

          await localNotification!
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.createNotificationChannel(channel!);

          await FirebaseMessaging.instance
              .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );
        }
      },
    );
  }

  Future<void> _pushBackgroundHandler(
    RemoteMessage message,
  ) async {
    log('_pushBackgroundHandler: ${message.toMap()}');
    Get.toNamed(DownloadDataPage.route);
  }
}
