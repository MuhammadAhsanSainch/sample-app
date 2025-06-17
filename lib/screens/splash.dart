import 'dart:async';

import 'package:path_to_water/screens/home/home_binding.dart';
import 'package:path_to_water/screens/home/home_view.dart';

import '../models/auth_model.dart';
import '../utilities/app_exports.dart';

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
          "data": UserPreferences.loginData,
        });
        Get.offAll(() => HomeView(), binding: HomeBinding());
        // Get.offAll(() => LoginView(), binding: LoginBinding());
      } else {
        Get.offAll(() => HomeView(), binding: HomeBinding());
        // Get.offAll(() => LoginView(), binding: LoginBinding());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(
        children: [
          Positioned.fill(
            // Makes the image fill the entire available space
            child: Image.asset(
              AppGlobals.isDarkMode.value ? AppConstants.splashBgDark : AppConstants.splashBgLight,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
