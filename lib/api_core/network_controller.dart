import 'dart:async' show StreamSubscription;
import 'dart:developer' as developer show log;
import 'dart:io' show InternetAddress, SocketException;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class NetworkController extends GetxController {
  static NetworkController get find {
    try {
      return Get.find<NetworkController>();
    } catch (e) {
      return Get.put(NetworkController());
    }
  }

  ///0 = No Internet, 1 = WIFI Connected, 2 = Mobile Data Connected.
  var connectionType = 0.obs;
  RxBool isInternetAvailable = false.obs;
  bool isDialogVisible = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    await getConnectivityType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getConnectivityType() async {
    List<ConnectivityResult>? connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      developer.log("Couldn't check connectivity status", error: e);
    } on Error catch (e) {
      developer.log("Couldn't check connectivity status", error: e);
    } catch (e) {
      developer.log("Couldn't check connectivity status", error: e);
    }
    return _updateState(connectivityResult);
  }

  Future<NetworkController> init() async {
    try {
      await getConnectivityType();
    } catch (e) {
      log(e.toString());
    }
    return this;
  }

  _updateState(List<ConnectivityResult>? result) async {
    await Future.delayed(const Duration(seconds: 1));
    // print("_updateState => ${result.name}");
    switch (result?.first) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        isInternetAvailable.value = await _checkInternetConnectivity();
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        isInternetAvailable.value = await _checkInternetConnectivity();
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        isInternetAvailable.value = await _checkInternetConnectivity();
        break;
      default:
        debugPrint("Failed to get connection type");
        break;
    }
    // _printConnStatus();
  }

  showInternetErrorSnackBar() async {
    if (Get.context == null) return;
    isDialogVisible = true;
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: ListTile(
          title: Text('No Internet Connection', style: AppTextTheme.titleMedium),
          subtitle: Text('Please check your internet connection', style: AppTextTheme.titleSmall),
          leading: const Icon(Icons.wifi_off, color: Colors.white),
          contentPadding: EdgeInsets.zero,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        dismissDirection: DismissDirection.none,
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating, // Make the banner non-dismissible
        duration: const Duration(hours: 2),
      ),
    );
  }

  Future<bool> _checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // Internet connection is available
      } else {
        return false; // No internet connection
      }
    } on SocketException catch (_) {
      return false; // No internet connection
    }
  }

  // void _printConnStatus() {
  //   developer.log("Internet status: ${isInternetAvailable.value}");
  // }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
