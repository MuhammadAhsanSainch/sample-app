import 'package:path_to_water/utilities/app_exports.dart';

class NotificationBadgeService {
  static const _channel = MethodChannel('com.futurbyte.barakahbuilder/notificationBadgeChannel');

  /// Gets the current number displayed on the app icon badge.
  /// Returns 0 if the badge is not set.
  static Future<int> getBadgeCount() async {
    try {
      // The generic type <int> is important for type safety
      final int? count = await _channel.invokeMethod<int>('getNotificationBadge');
      return count ?? 0;
    } on PlatformException catch (e) {
      debugPrint("Failed to get badge count: '${e.message}'.");
      return 0;
    }
  }

  /// Updates the app icon badge with the given [count].
  /// A count of 0 will clear the badge.
  /// This will request notification permission on iOS if not already granted.
  static Future<void> updateBadgeCount(int count) async {
    try {
      await _channel.invokeMethod('updateNotificationBadge', <String, dynamic>{'count': count});
    } on PlatformException catch (e) {
      debugPrint("Failed to update badge count: '${e.message}'.");
    }
  }
}
