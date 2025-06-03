import 'dart:async';
import '../network/models/auth_model.dart';
import '../utilities/app_exports.dart';
import 'home/home_binding.dart';
import 'home/home_view.dart';
import 'login/login_binding.dart';
import 'login/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool selected = false;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (UserPreferences.isLogin == true) {
        AuthModel.fromJson({
          "status": true,
          "code": "SUCCESS",
          "message": "Already Logged In",
          "data": UserPreferences.loginData
        });
        // Get.offAll(()=>HomeView(),binding: HomeBinding());
        Get.offAll(() => LoginView(), binding: LoginBinding());
      } else {
        Get.offAll(() => LoginView(), binding: LoginBinding());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60),
      decoration:  BoxDecoration(
        color: AppColors.primary,
      ),
      child: SvgPicture.asset(AppConstants.mail),
    );
  }
}
