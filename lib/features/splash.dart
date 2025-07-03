import 'dart:async';

import 'package:path_to_water/utilities/app_routes.dart';

import '/features/home/home_binding.dart';
import '/features/home/home_view.dart';
import '../utilities/app_exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _Splashfeaturestate();
}

class _Splashfeaturestate extends State<SplashScreen> {
  bool selected = false;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => HomeView(), binding: HomeBinding(),routeName: AppRoutes.home);
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
