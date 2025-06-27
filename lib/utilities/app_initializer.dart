import 'app_exports.dart';
import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import '../notification_services/fcm_controller.dart';
import '../notification_services/notification_service.dart';
import 'package:path_to_water/api_core/network_controller.dart';

class AppInitializer {
  static Future<void> initialize() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      await initializePreferences();
      await NotificationService().initNotification();
      await listenToFCM();

      _setOrientationLock();
      await Get.putAsync<NetworkController>(() => NetworkController().init(), permanent: true);
      setTheme();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static void _setOrientationLock() {
    try {
      bool isTablet = Get.context?.isTablet ?? false;
      SystemChrome.setPreferredOrientations(
        isTablet
            ? [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]
            : [DeviceOrientation.portraitUp],
      );
    } catch (e) {
      log(e.toString());
    }
  }

  static setTheme() {
    AppGlobals.isDarkMode.value = UserPreferences.isDarkMode;
    Get.changeThemeMode(AppGlobals.isDarkMode.value ? ThemeMode.light : ThemeMode.dark);
  }
}
