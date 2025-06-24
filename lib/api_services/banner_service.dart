import 'package:path_to_water/api_core/api_client.dart';
import 'package:path_to_water/models/banners_model.dart';
import 'package:path_to_water/utilities/app_url.dart';

class BannerService {
  static Future<BannersModel> getBannerAPI() async {
    final res = await ApiClient().get(AppUrl.bannerApi);
    return BannersModel.fromJson(res.data);
  }
}
