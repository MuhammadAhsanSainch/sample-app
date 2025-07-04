import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_to_water/models/extra_payload.dart';
import 'package:path_to_water/notification_services/notification_badge_service.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/utilities/app_helper.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final AndroidNotificationChannel channel = AndroidNotificationChannel(
    '1', // id
    // 'high_importance_channel', // id
    AppConstants.appName, // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.high,
  );

  static Future<void> init() async {
    try {
      await Firebase.initializeApp();

      // Get and save FCM token
      await Future.delayed(Duration(seconds: 2));

      AppGlobals.fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
      print('FCM Token: ${AppGlobals.fcmToken}');
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
        print('New FCM Token: $newToken');
        AppGlobals.fcmToken = newToken;
      });
      // Set the background messaging handler early on, as a named top-level function

      if (UserPreferences.isNotification) {
        Helper.subscribeToTopic("all");
      }
      if (Platform.isIOS) {
        NotificationBadgeService.updateBadgeCount(0);
      }

      /// Create an Android Notification Channel.
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      await FirebaseMessaging.instance.requestPermission(alert: true, badge: true, sound: true);

      if (Platform.isAndroid) {
        var initializationSettingsAndroid = const AndroidInitializationSettings('notify_icon');
        // var initializationSettingsIOS = IOSInitializationSettings();
        var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid /*, iOS: initializationSettingsIOS*/,
        );

        await flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: (value) => onSelectNotification(value),
        );
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        if (Platform.isAndroid) {
          print("onSelectNotification clicked");
          print(message.data.toString());

          var map = (message.notification);
          if (map != null) {
            flutterLocalNotificationsPlugin.show(
              int.parse(channel.id),
              // 1,
              map.title,
              map.body,
              NotificationDetails(
                iOS: const DarwinNotificationDetails(),
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: 'notify_icon',
                ),
              ),
              payload: Platform.isAndroid ? jsonEncode(message.data) : null,
            );
          }
        }
        if (Platform.isIOS) {
          print("Got new notification");
          int count = await NotificationBadgeService.getBadgeCount();
          NotificationBadgeService.updateBadgeCount(count + 1);
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
        log(message.data.toString());
        var payload = ExtraPayload.fromJson(message.data);

        Helper.navigateFromNotification(payload);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> onSelectNotification(dynamic value) async {
    debugPrint("onSelectNotification clicked");

    var map = jsonDecode(value);
    debugPrint(map.toString());

    Helper.navigateFromNotification(ExtraPayload.fromJson(map));
  }
}
