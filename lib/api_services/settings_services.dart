

import '../api_core/api_client.dart';
import '../models/success_message_model.dart';
import '../utilities/app_url.dart';

class SettingsServices{
  static Future<SuccessMessageModel?> changePassword(Map<String, dynamic> data) async {
    final res = await ApiClient().post(AppUrl.changePasswordApi,data: data);
    return SuccessMessageModel.fromJson(res.data);
  }
  static Future deleteAccount() async {
    final res = await ApiClient().delete(AppUrl.deleteAccountApi);
    return res.data;
  }
}