import 'notification_services/fcm_controller.dart';
import 'notification_services/notification_service.dart';
import 'screens/splash.dart';
import 'firebase_options.dart';
import 'utilities/app_exports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// This function will handle background messages. It must be a top-level function.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");
  // You can perform some background processing here if needed
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String? fcmToken = await firebaseMessaging.getToken();
  log("FCM Token: $fcmToken");
  NotificationService().initNotification();
  await listenToFCM();
  await initializePreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the device is a tablet
    bool isTablet = Get.context?.isTablet ?? false;

    // Lock orientation based on device type
    if (isTablet) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return Obx(()=>GetMaterialApp(
          title: 'Path To Water',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: AppGlobals.isDarkMode.value? ThemeMode.dark : ThemeMode.light, // or ThemeMode.light/dark
          home: const SplashScreen(),
          navigatorKey: AppGlobals.appNavigationKey,
        ));
      },
    );
  }
}
