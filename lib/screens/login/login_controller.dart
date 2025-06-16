import 'package:path_to_water/api_core/custom_exception_handler.dart';
import 'package:path_to_water/api_services/auth_services.dart';
import 'package:path_to_water/screens/home/home_binding.dart';
import 'package:path_to_water/screens/home/home_view.dart';

import '../../utilities/app_exports.dart';

class LoginController extends GetxController {
  final TextEditingController emailTFController = TextEditingController();
  final TextEditingController passwordTFController = TextEditingController();

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

  Future logIn() async {
    try {
      AppGlobals.isLoading(true);
      Map<String, dynamic> data = {
        "email": emailTFController.text,
        "password": passwordTFController.text,
      };
      final res = await AuthServices.loginIn(data);
      if (res?.user != null) {
        UserPreferences.loginData = res?.user?.toJson() ?? {};
        UserPreferences.isLogin = true;
        UserPreferences.authToken = res?.accessToken ?? "";
        Get.off(() => HomeView(), binding: HomeBinding());
      }
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } catch (e) {
      log(e.toString());
    }finally {
      AppGlobals.isLoading(false);
    }
  }
}
