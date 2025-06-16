import 'dart:async';
import '../../utilities/app_exports.dart';
import '../../api_services/auth_services.dart';
import '../../api_core/custom_exception_handler.dart';
import '../../screens/forgot-password/views/verify_code_view.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailTFController = TextEditingController(
    text: kDebugMode ? "" : "",
  );
  final TextEditingController otpTFController = TextEditingController();
  final TextEditingController passwordTFController = TextEditingController();
  final TextEditingController confirmPasswordTFController =
      TextEditingController();

  static ForgotPasswordController get to {
    try {
      return Get.find<ForgotPasswordController>();
    } catch (e) {
      return Get.put(ForgotPasswordController());
    }
  }

  var otp = ''.obs; // For storing the OTP value
  var timerSeconds = 600.obs; // Timer for countdown
  Timer? _timer;

  // Starts the countdown timer
  void startTimer() {
    timerSeconds.value = 600;
    if (_timer != null) _timer!.cancel(); // Cancel previous timer if any
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        timer.cancel(); // Cancel timer when it hits 0
      }
    });
  }

  // Resends the OTP and resets the timer
  void resendOtp(Map<String, dynamic> reqBody) async{
    try {
      AppGlobals.isLoading(true);
      final res = await AuthServices.sendOTP({"email": emailTFController.text});
      if (res != null) {
        otpTFController.clear();
        startTimer();
      }
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } catch (e) {
      log(e.toString());
    } finally {
      AppGlobals.isLoading(false);
    }
  }

  Future sendOTP() async {
    try {
      AppGlobals.isLoading(true);
      final res = await AuthServices.sendOTP({"email": emailTFController.text});
      if (res != null) {
        Get.to(
          () => VerifyCodeView(
            email: ForgotPasswordController.to.emailTFController.text,
          ),
        );
      }
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } catch (e) {
      log(e.toString());
    } finally {
      AppGlobals.isLoading(false);
    }
  }

  // // Send OTP
  // Future sendOTP(Map<String, dynamic> reqBody) {
  //   return NetworkService.handleApiCall<GeneralMapResponse>(
  //     AppUrl.apiService.sendOtp(reqBody),
  //     errorMessagePrefix: 'sendOTP',
  //   );
  // }

  // // Verify Otp
  // Future verifyOtp(Map<String, dynamic> reqBody) {
  //   return NetworkService.handleApiCall<GeneralMapResponse>(
  //     AppUrl.apiService.verifyOtp(reqBody),
  //     errorMessagePrefix: 'verifyOTP',
  //   );
  // }

  // Future resetPassword(Map<String, dynamic> reqBody) {
  //   return NetworkService.handleApiCall<GeneralMapResponse>(
  //     AppUrl.apiService.resetPassword(reqBody),
  //     errorMessagePrefix: 'resetPassword',
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) _timer!.cancel(); // Clean up timer
    emailTFController.dispose();
    otpTFController.dispose();
    passwordTFController.dispose();
    confirmPasswordTFController.dispose();
  }
}
