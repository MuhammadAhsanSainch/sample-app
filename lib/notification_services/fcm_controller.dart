import 'dart:io' show Platform;
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_to_water/utilities/app_exports.dart';

import 'notification_service.dart';

Future<void> listenToFCM() async {
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.instance.getAPNSToken().then((value) async {
    if (Platform.isAndroid) {
      // Android-specific code
    } else if (Platform.isIOS) {
      // iOS-specific code
      if (kDebugMode) {
        print("APNS Token Value = $value");
      }
      if (value == null) {
        return;
      }
    }
    AppGlobals.fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      if (kDebugMode) {
        print('New FCM Token Value: $newToken');
      }
      AppGlobals.fcmToken = newToken;
    });
    if (kDebugMode) {
      print("FCM Token Value = ${AppGlobals.fcmToken}");
    }
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.instance.subscribeToTopic("general");
    // FirebaseMessaging.instance.unsubscribeFromTopic("general");
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    if (kDebugMode) {
      print('FCM User Granted Permission: ${settings.authorizationStatus}');
    }
    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage(_handleMessage);
  });
}

Future<void> _handleMessage(RemoteMessage message) async {
  print("FCM Message Received = ${message.data.toString()}");

  if (message.notification != null) {
    // gamification();
    print('FCM Notification Received (Title) = ${message.notification?.title}');
    print('FCM Notification Received (Body) = ${message.notification?.body}');

    NotificationService().showNotification(
      id: Random().nextInt(1000),
      title: message.notification!.title,
      body: message.notification!.body,
      payload: const NotificationDetails(android: AndroidNotificationDetails("channelId", "channelName", channelDescription: "Android_Notification", importance: Importance.max, playSound: true), iOS: DarwinNotificationDetails()),
    );

    // if (Platform.isAndroid) {
    //   print('FCM Notification Received (Image) = ${message.notification!.android!.imageUrl}');
    //   final http.Response response = await http.get(Uri.parse(message.notification!.android!.imageUrl ?? ""));
    //   BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
    //     ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.bodyBytes)),
    //   );
    //   NotificationService().showNotification(
    //     id: Random().nextInt(1000),
    //     title: message.notification!.title,
    //     body: message.notification!.body,
    //     payload: NotificationDetails(android: AndroidNotificationDetails("channelId", "channelName", channelDescription: "Android_Notification", importance: Importance.max, playSound: true, styleInformation: bigPictureStyleInformation), iOS: const DarwinNotificationDetails()),
    //   );
    // }
    print("FCM Message Received = ${message.data.toString()}");
    if (Platform.isIOS) {
      if (message.notification!.apple!.badge.toString() == "0") {
        // FlutterAppBadger.removeBadge();
      } else {
        // FlutterAppBadger.updateBadgeCount(int.parse(message.notification!.apple!.badge.toString()));
      }
    }

  }
}
