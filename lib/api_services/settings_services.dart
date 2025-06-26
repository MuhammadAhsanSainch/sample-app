import '../utilities/app_url.dart';
import '../api_core/api_client.dart';
import '../models/success_message_model.dart';

class SettingsServices {
  static Future<SuccessMessageModel?> changePassword(
    Map<String, dynamic> data,
  ) async {
    final res = await ApiClient().post(AppUrl.changePasswordApi, data: data);
    return SuccessMessageModel.fromJson(res.data);
  }

  static Future<SuccessMessageModel?> deleteAccount(
    Map<String, dynamic> data,
  ) async {
    final res = await ApiClient().delete(AppUrl.deleteAccountApi, data: data);
    return SuccessMessageModel.fromJson(res.data);
  }
}
