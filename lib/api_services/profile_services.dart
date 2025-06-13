import 'package:path_to_water/models/profile_model.dart';

import '../api_core/api_client.dart';
import '../utilities/app_url.dart';

class ProfileServices{
  static Future<ProfileModel?> getProfile() async {
    final res = await ApiClient().get(AppUrl.getProfileApi);
    return ProfileModel.fromJson(res.data);
  }
}