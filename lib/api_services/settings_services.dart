

import '../api_core/api_client.dart';
import '../models/change_password_model.dart';
import '../utilities/app_url.dart';

class SettingsServices{
  static Future<ChangePasswordModel?> changePassword(Map<String, dynamic> data) async {
    final res = await ApiClient().post(AppUrl.changePasswordApi,data: data);
    return ChangePasswordModel.fromJson(res.data);
  }
  static Future deleteAccount() async {
    final res = await ApiClient().delete(AppUrl.deleteAccountApi);
    return res.data;
  }
}