import '../../models/auth_model.dart';
import '../../utilities/app_exports.dart';

class SignupController extends GetxController {
  final TextEditingController fullNameTFController = TextEditingController();
  final TextEditingController userNameTFController = TextEditingController();
  final TextEditingController emailTFController = TextEditingController();
  final TextEditingController passwordTFController = TextEditingController();
  final TextEditingController confirmPasswordTFController = TextEditingController();


  @override
  void dispose() {
    emailTFController.dispose();
    passwordTFController.dispose();
    super.dispose();
  }

  static SignupController get to {
    try {
      return Get.find<SignupController>();
    } catch (e) {
      return Get.put(SignupController());
    }
  }

  // Future<AuthModel?> singUp(reqBody) {
  //   return NetworkService.handleApiCall<GeneralMapResponse>(
  //     AppUrl.apiService.signIn(reqBody),
  //     errorMessagePrefix: 'signIn',
  //     onSuccess: (response) {
  //       UserPreferences.loginData = response.data!;
  //       UserPreferences.isLogin = true;
  //       UserPreferences.authToken = response.data!['accessToken'];
  //     },
  //   ).then((value) {
  //     return AuthModel.fromJson(value);
  //   });
  // }
}
