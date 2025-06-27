import '../utilities/app_url.dart';
import '../api_core/api_client.dart';
import '../models/profile_model.dart';

class ProfileServices {
  static Future<ProfileModel?> getProfile() async {
    final res = await ApiClient().get(AppUrl.getProfileApi);
    return ProfileModel.fromJson(res.data);
  }

  static Future<ProfileModel?> updateProfile(Map<String, dynamic> data) async {
    final res = await ApiClient().put(AppUrl.updateProfileApi, data: data);
    return ProfileModel.fromJson(res.data);
  }

  static Future<ProfileModel?> updateProfilePic(
    Map<String, dynamic> data,
  ) async {
    final res = await ApiClient().post(
      AppUrl.updateProfilePicApi,
      data: data,
      isFormData: true,
    );
    return ProfileModel.fromJson(res.data);
  }
}
