import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:path_to_water/features/home/home_binding.dart';
import 'package:path_to_water/features/home/home_controller.dart';
import 'package:path_to_water/features/home/home_view.dart';
import 'package:path_to_water/features/quiz/quiz_binding.dart';
import 'package:path_to_water/features/quiz/views/daily_quiz_view.dart';
import 'package:path_to_water/models/extra_payload.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/utilities/app_routes.dart';

class Helper {
  /// Return device based dimension
  static double getNormDim(double androidDimension, double iOSDimension) {
    if (Platform.isAndroid) {
      return androidDimension;
    } else {
      return iOSDimension;
    }
  }

  static Future<TimeOfDay?> pickTime(BuildContext context, [TimeOfDay? initialTime]) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (context, child) {
        return Theme(
          data:
              AppGlobals.isDarkMode.value
                  ? ThemeData.dark().copyWith(
                    colorScheme: ColorScheme.dark(primary: AppColors.primary),
                  )
                  : ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(primary: AppColors.primary),
                  ),
          child: child!,
        );
      },
    );
  }

  static Future<DateTime> pickDate(
    BuildContext context, {
    bool isFilterDialog = false,
    DateTime? lastDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: lastDate ?? DateTime(2101),
      confirmText: 'Ok',
      cancelText: 'Cancel',
      builder: (context, child) {
        return Theme(
          data:
              AppGlobals.isDarkMode.value
                  ? ThemeData.dark().copyWith(
                    colorScheme: ColorScheme.dark(primary: AppColors.primary),
                  )
                  : ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(primary: AppColors.primary),
                  ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != DateTime.now()) {
      return picked;
    }
    return DateTime.now();
  }

  static navigateFromNotification(ExtraPayload payload) async {
    String newRoute = AppRoutes.home;
    Bindings binding = HomeBinding();
    bool isNewRouteSameAsCurrent = false;

    final HomeController homeController = Get.put(HomeController());
    homeController.drawerController.hideDrawer();

    switch (payload.refId.toString()) {
      case AppConstants.quranAyatNotificationID:
        homeController.currentTabIndex(0);
        break;
      case AppConstants.hadithNotificationID:
        homeController.currentTabIndex(0);
        break;
      case AppConstants.historyNotificationID:
        homeController.currentTabIndex(0);
        break;
      case AppConstants.reminderNotificationID:
        homeController.currentTabIndex(1);
        break;
      case AppConstants.quizNotificationID:
        homeController.currentTabIndex(0);
        newRoute = AppRoutes.dailyQuiz;
        binding = QuizBinding();
        break;
      default:
        break;
    }
    Get.until((route) {
      if (route.settings.name == newRoute) {
        isNewRouteSameAsCurrent = true;
      }
      return true;
    });

    if (!isNewRouteSameAsCurrent) {
      if (newRoute == AppRoutes.home) {
        Get.until((route) => Get.currentRoute == AppRoutes.home);
      } else {
        Get.to(() => getRoute(newRoute), binding: binding, routeName: newRoute);
      }
    }
  }

  static Widget getRoute(String routeName) {
    switch (routeName) {
      case AppRoutes.home:
        return HomeView();
      case AppRoutes.dailyQuiz:
        return DailyQuizView();
      default:
        return HomeView();
    }
  }

  static Future<void> subscribeToTopic(String? topic) async {
    if (topic.isNullOREmpty) return;
    await FirebaseMessaging.instance.subscribeToTopic(topic!);
  }

  static Future<void> unsubscribeFromTopic(String? topic) async {
    if (topic.isNullOREmpty) return;
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic!);
  }
}
