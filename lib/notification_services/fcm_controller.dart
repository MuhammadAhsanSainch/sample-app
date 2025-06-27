import 'dart:math' show Random;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'notification_service.dart';

Future<void> listenToFCM() async {
  try {
    final messaging = FirebaseMessaging.instance;

    // Request user permission
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
    );

    // Get and save FCM token
    AppGlobals.fcmToken = await messaging.getToken() ?? '';
    log('FCM Token: ${AppGlobals.fcmToken}');
    messaging.onTokenRefresh.listen((newToken) {
      log('New FCM Token: $newToken');
      AppGlobals.fcmToken = newToken;
    });

    // Enable auto-init and subscribe to topic
    await messaging.setAutoInitEnabled(true);
    await messaging.subscribeToTopic("general");

    // Show foreground notifications
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Set up listeners
    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage(_handleMessage);
  } catch (e) {
    log(e.toString());
  }
}

Future<void> _handleMessage(RemoteMessage message) async {
  log("FCM Message Received: ${message.data}");

  final notification = message.notification;
  if (notification != null) {
    log("Notification Title: ${notification.title}");
    log("Notification Body: ${notification.body}");

    // Show local notification
    NotificationService().showNotification(
      id: Random().nextInt(1000),
      title: notification.title,
      body: notification.body,
      payload: const NotificationDetails(
        android: AndroidNotificationDetails(
          "channelId",
          "channelName",
          channelDescription: "Android Notification",
          importance: Importance.max,
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
