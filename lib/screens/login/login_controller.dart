
import '../../network/models/auth_model.dart';
import '../../utilities/app_exports.dart';

class LoginController extends GetxController {
  final TextEditingController emailTFController =
      TextEditingController(text: kDebugMode ? "" : "");
  final TextEditingController passwordTFController =
      TextEditingController(text: kDebugMode ? "" : "");
  var enableSubmitBtn = false.obs;

  updateLoginButton() {
    if (emailTFController.text.isNotEmpty && passwordTFController.text.isNotEmpty) {
      enableSubmitBtn(true);
    } else {
      enableSubmitBtn(false);
    }
  }

  @override
  void dispose() {
    emailTFController.dispose();
    passwordTFController.dispose();
    super.dispose();
  }

  static LoginController get to {
    try {
      return Get.find<LoginController>();
    } catch (e) {
      return Get.put(LoginController());
    }
  }

  Future<AuthModel?> logIn(reqBody) {
    return NetworkService.handleApiCall<GeneralMapResponse>(
      AppUrl.apiService.signIn(reqBody),
      errorMessagePrefix: 'signIn',
      onSuccess: (response) {
        UserPreferences.loginData = response.data!;
        UserPreferences.isLogin = true;
        UserPreferences.authToken = response.data!['accessToken'];
      },
    ).then((value){
      return AuthModel.fromJson(value);
    });
  }
}
