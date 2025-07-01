import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:path_to_water/api_services/banner_service.dart';
import 'package:path_to_water/features/calendar/view/calendar_screen.dart';
import 'package:path_to_water/features/dashboard/dashboard_view.dart';
import 'package:path_to_water/features/favorite_screen/favorite_screen.dart';
import 'package:path_to_water/features/home/widgets/banner_dialog_widget.dart';
import 'package:path_to_water/features/journal/controllers/journal_screen_controller.dart';
import 'package:path_to_water/features/journal/views/journal_screen.dart';
import 'package:path_to_water/features/login/login_binding.dart';
import 'package:path_to_water/features/login/login_view.dart';
import 'package:path_to_water/features/quiz/views/daily_quiz_view.dart';
import 'package:path_to_water/features/reminder/controller/reminder_screen_controller.dart';
import 'package:path_to_water/features/reminder/views/reminder_screen.dart';
import 'package:path_to_water/features/settings/views/profile_screen.dart';
import 'package:path_to_water/features/settings/views/settings_screen.dart';
import 'package:path_to_water/features/subscription/view/subscription_screen.dart';
import 'package:path_to_water/widgets/custom_dialog.dart';

import '../../utilities/app_exports.dart';

class HomeController extends GetxController {
  var currentTabIndex = 0.obs;

  final AdvancedDrawerController drawerController = AdvancedDrawerController();

  bool get isLogin => UserPreferences.isLogin;

  static HomeController get find {
    try {
      return Get.find<HomeController>();
    } catch (e) {
      return Get.put(HomeController());
    }
  }

  final pageTitle = <String>[
    "", // 0
    "Reminder", // 1
    "Calendar", // 2
    "My Profile", // 3
    "Daily Quiz", // 4
    "Quiz History", //5
    "Journal", // 6
    "Notification", // 7
    "Subscription", // 8
    "Favorites", // 9
    "Settings", // 10
  ];

  final pages = <Widget>[
    DashboardView(),
    ReminderScreen(),
    CalendarScreen(),
    ProfileScreen(),
    DailyQuizView(),
    Center(child: Text("Quiz History")),
    JournalScreen(),
    Center(child: Text("Notification")),
    SubscriptionScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  RxBool get isJournalCreated => Get.put(JournalScreenController()).isJournalCreated;
  RxBool get isReminderCreated => Get.put(ReminderScreenController()).isReminderCreated;

  @override
  void onInit() {
    getBannerAPI();
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

  getBannerAPI() async {
    try {
      final res = await BannerService.getBannerAPI();

      if (res.banners.isNotEmpty) {
        final date = DateTime.now().toFormatDateTime(format: "yyyy-MM-dd");
        final isBannerShown = UserPreferences.checkBannerShownToday(date);
        if (isBannerShown) return;
        await Get.dialog(BannerDialogWidget(url: res.banners.firstOrNull));
        UserPreferences.bannerShownToday(date, true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
