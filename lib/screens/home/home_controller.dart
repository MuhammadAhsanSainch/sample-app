import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:path_to_water/screens/dashboard/dashboard_view.dart';
import 'package:path_to_water/screens/home/widgets/banner_dialog_widget.dart';
import 'package:path_to_water/screens/login/login_binding.dart';
import 'package:path_to_water/screens/login/login_view.dart';
import 'package:path_to_water/widgets/custom_dialog.dart';

import '../../utilities/app_exports.dart';

class HomeController extends GetxController {
  var currentTabIndex = 0.obs;

  final AdvancedDrawerController drawerController  = AdvancedDrawerController();

  static HomeController get find {
    try {
      return Get.find<HomeController>();
    } catch (e) {
      return Get.put(HomeController());
    }
  }

  var pageTitle = <String>["Home", "Reminder", "Calendar", "Profile"];

  var pages = <Widget>[
    DashboardView(),
    Center(child: Text("Reminder")),
    Center(child: Text("Calendar")),
    Center(child: Text("Profile")),
  ];

  @override
  void onInit() {
    Future.delayed(Duration(seconds: 2), () {
      Get.dialog(BannerDialogWidget());
    });
    super.onInit();
  }

  showLoginDialog() {
    Get.dialog(
      CustomDialog(
        title: "Login to your account.",
        message: "Please sign in to access your personalized settings and features.",
        imageIcon: AppConstants.personIcon,
        btnText: "Login",
        onButtonTap: (){
          Get.offAll(()=> LoginView(),binding: LoginBinding());
        },
      ),
    );
  }
}
