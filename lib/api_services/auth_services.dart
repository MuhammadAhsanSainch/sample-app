import 'package:path_to_water/api_core/api_client.dart';
import 'package:path_to_water/models/auth_model.dart';
import 'package:path_to_water/models/success_message_model.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class AuthServices {
 static Future<AuthModel?> loginIn(Map<String, dynamic> data) async {
    final res = await ApiClient().post(AppUrl.loginApi, data: data);
    return AuthModel.fromJson(res.data);
  }
 static Future<AuthModel?> signUp(Map<String, dynamic> data) async {
   final res = await ApiClient().post(AppUrl.signupApi, data: data);
   return AuthModel.fromJson(res.data);
 }
 static Future<SuccessMessageModel?> sendOTP(Map<String, dynamic> data) async {
   final res = await ApiClient().post(AppUrl.sendOTPApi, data: data);
   return SuccessMessageModel.fromJson(res.data);
 }
 static Future<SuccessMessageModel?> resetPassword(Map<String, dynamic> data) async {
   final res = await ApiClient().post(AppUrl.resetPasswordApi, data: data);
   return SuccessMessageModel.fromJson(res.data);
 }
}
