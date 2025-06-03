import '../utilities/app_exports.dart';

class BaseController extends GetxController {
  static BaseController get to {
    try {
      return Get.find<BaseController>();
    } catch (e) {
      return Get.put(BaseController());
    }
  }

// Future<Map<String, dynamic>?> logout(Map<String, dynamic> reqBody) {
//   EasyLoading.show(status: "Loading...");
//
//   return BaseService().logout(reqBody).then((value) async {
//     EasyLoading.dismiss();
//
//     debugPrint("[logout CONTROLLER] (response): $value");
//     debugPrint("[logout CONTROLLER] (response status): ${value['status']}");
//     if (value['status'] == true) {
//       AppGlobals.showSuccessSnackBar(heading: value['code'], message: value['message'] ?? "");
//
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       await preferences.clear();
//       UserPreferences.loginData = {};
//       UserPreferences.isLogin = false;
//       UserPreferences.authToken = "";
//       prefs.reload();
//       Get.offAll(() => SplashScreen(), binding: LoginBinding());
//     } else {
//       AppGlobals.showErrorSnackBar(heading: value['code'], message: value['message'] ?? "");
//     }
//     return value;
//   });
// }
}
