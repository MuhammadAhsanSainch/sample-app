import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin(); // Define In TopVariable

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/ic_notification');
    var initializeSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    var initializeSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializeSettingsIOS,
    );
    await notificationsPlugin.initialize(
      initializeSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    NotificationDetails? payload,
  }) async {
    return notificationsPlugin.show(id, title, body, payload);
  }
}
