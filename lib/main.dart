import 'utilities/app_exports.dart';
import 'screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // NotificationService notificationService = NotificationService();
  // await notificationService.initNotifications();
  // await notificationService.initNotification();
  // await listenToFCM();
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
