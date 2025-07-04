import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:path_to_water/notification_services/notification_badge_service.dart';

import 'features/splash.dart';
import 'utilities/app_exports.dart';
import 'utilities/app_initializer.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  log(message.data.toString());
  log("Notification Received");
  debugPrint(message.data.toString());
  if (Platform.isIOS) {
    int count = await NotificationBadgeService.getBadgeCount();
    NotificationBadgeService.updateBadgeCount(count + 1);
  }
}

void main() async {
  await AppInitializer.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return Obx(
          () => GetMaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode:
                AppGlobals.isDarkMode.value
                    ? ThemeMode.dark
                    : ThemeMode.light, // or ThemeMode.light/dark
            home: const SplashScreen(),
            navigatorKey: AppGlobals.appNavigationKey,
          ),
        );
      },
    );
  }
}
