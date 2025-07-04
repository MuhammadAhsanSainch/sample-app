import 'package:path_to_water/api_core/api_client.dart';
import 'package:path_to_water/models/notification_model.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class NotificationApiService {
  static Future<NotificationsModel?> getAllNotifications(
    Map<String, dynamic> queryParameters,
  ) async {
    final res = await ApiClient().get(AppUrl.notificationAPI, queryParameters: queryParameters);
    return NotificationsModel.fromJson(res.data);
  }
}
