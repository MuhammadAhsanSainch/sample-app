import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:path_to_water/screens/dashboard/dashboard_view.dart';
import 'package:path_to_water/screens/favorite_screen/favorite_screen.dart';
import 'package:path_to_water/screens/home/widgets/banner_dialog_widget.dart';
import 'package:path_to_water/screens/journal/views/journal_screen.dart';
import 'package:path_to_water/screens/login/login_binding.dart';
import 'package:path_to_water/screens/login/login_view.dart';
import 'package:path_to_water/screens/quiz/views/daily_quiz_view.dart';
import 'package:path_to_water/screens/reminder/views/reminder_screen.dart';
import 'package:path_to_water/screens/settings/views/profile_screen.dart';
import 'package:path_to_water/screens/settings/views/settings_screen.dart';
import 'package:path_to_water/widgets/custom_dialog.dart';

import '../../utilities/app_exports.dart';

class HomeController extends GetxController {
  var currentTabIndex = 0.obs;

  final AdvancedDrawerController drawerController = AdvancedDrawerController();

  static HomeController get find {
    try {
      return Get.find<HomeController>();
    } catch (e) {
      return Get.put(HomeController());
    }
  }

  var pageTitle = <String>[
    "Home",
    "Reminder",
    "Calendar",
    "My Profile",
    "Daily Quiz",
    "Quiz History",
    "Journal",
    "Notification",
    "Subscription",
    "Favorites",
    "Settings",
  ];

  var pages = <Widget>[
    DashboardView(),
    ReminderScreen(),
    Center(child: Text("Calendar")),
    ProfileScreen(),
    DailyQuizView(),
    Center(child: Text("Quiz History")),
    JournalScreen(),
    Center(child: Text("Notification")),
    Center(child: Text("Subscription")),
    FavoriteScreen(),
    SettingsScreen(),
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
        onButtonTap: () {
          Get.offAll(() => LoginView(), binding: LoginBinding());
        },
      ),
    );
  }
}
