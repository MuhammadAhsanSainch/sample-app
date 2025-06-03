import 'package:path_to_water/screens/forgot-password/views/reset_password_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../utilities/app_exports.dart';
import '../forgot_password_binding.dart';
import '../forgot_password_controller.dart';

class VerifyCodeView extends StatelessWidget {
  final GlobalKey<FormState> verifyCodeFormKey = GlobalKey<FormState>();
  final String email, type;

  VerifyCodeView({super.key, required this.email, required  this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
        init: Get.put(ForgotPasswordController()),
        initState: (state) {
          ForgotPasswordController.to.otpTFController.clear();
          ForgotPasswordController.to.startTimer();
        },
        builder: (controller) => Scaffold(
              appBar: AppBar(leading: CustomBackButton()),
              body: Form(
                key: verifyCodeFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: (Get.context?.isTablet ?? false)
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height * 0.08),
                      InkWell(
                        onTap: () {
                          if (kDebugMode) {
                            controller.otpTFController.text = '1234';
                            controller.updateVerifyOTPButton();
                          }
                        },
                        child: CustomText(
                          'OTP Code',
                          style: AppTextTheme.bodyLarge,
                        ),
                      ),
                      CustomText(
                        'Your Key to Safe and Instant Verification',
                        style: AppTextTheme.bodyLarge,
                      ),
                      SizedBox(height: Get.height * 0.02),

                      ///Otp widget
                      otpWidget(context, controller),
                      Obx(
                        () => Align(
                          alignment: Alignment.centerRight,
                          child: timerWidget(context, controller),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),

                      ///Verify OTP Button
                      Obx(
                        () => CustomRoundedButton(
                          isEnabled: controller.enableVerifyOTPButton.value,
                          width: context.width,
                          text: "Verify OTP",

                          onTap: () {
                            if (!verifyCodeFormKey.currentState!.validate()) {
                              return;
                            }
                            String otp=controller.otpTFController.text;
                            controller.verifyOtp({
                              "email": email,
                              "code":
                                  int.tryParse(otp),
                              "type": type,
                            }).then((value) {
                              if(value?['status']){
                                Get.to(() => ResetPasswordView(email: email,otp: otp),
                                    binding: ForgotPasswordBinding());
                              }
                            });

                          },
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      // const CustomBackButton(),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget otpWidget(BuildContext context, ForgotPasswordController controller) {
    return PinCodeTextField(
      autoFocus: true,
      appContext: context,
      inputFormatters: [
        BlankSpaceInputFormatter(),
        FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true),
      ],
      length: 4,
      obscureText: false,
      obscuringCharacter: '*',
      // hintCharacter: "|",
      animationType: AnimationType.fade,
      autovalidateMode: AutovalidateMode.disabled,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: (Get.context?.isTablet ?? false) ? 78 : 64,
        fieldWidth: (Get.context?.isTablet ?? false) ? 188 : 70,
        inactiveColor: AppColors.borderLight,
        selectedColor: AppColors.borderLight,
        activeFillColor: AppColors.borderLight,
        activeColor: AppColors.borderLight,
        // fieldOuterPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4)
      ),
      cursorColor: AppColors.borderDark,
      animationDuration: const Duration(milliseconds: 300),
      textStyle: AppTextTheme.bodyMedium,
      enableActiveFill: false,
      showCursor: true,
      controller: controller.otpTFController,
      autoDisposeControllers: false,
      keyboardType: TextInputType.number,
      onCompleted: (v) {
        if (controller.otpTFController.text.length == 4) {
          debugPrint("Success");
        } else {
          debugPrint("Failure");
        }
      },
      errorTextSpace: 25,
      validator: (v) {
        if (v.isNullOREmpty) {
          return "Enter OTP".tr;
        } else if (v!.length < 4) {
          return "Enter 4 digits OTP sent to ${controller.emailTFController.text}"
              .tr;
        } else {
          return null;
        }
      },
      // onTap: () {
      //   print("Pressed");
      // },
      onChanged: (value) {
        debugPrint(value);
        controller.otp.value = value;
        if (controller.otpTFController.text.length == 4) {
          controller.updateVerifyOTPButton();
        }
      },
      beforeTextPaste: (text) {
        debugPrint("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return false;
      },
    );
  }

  Widget timerWidget(
      BuildContext context, ForgotPasswordController controller) {
    if (controller.timerSeconds.value > 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomText(
            "Resend OTP in ",
            style: AppTextTheme.bodyLarge,
          ),
          SizedBox(
            width: (Get.context?.isTablet ?? false) ? 70 : 55,
            child: CustomText(
              "00:${controller.timerSeconds.value.toString().padLeft(2, '0')}",
                style: AppTextTheme.bodyLarge,
            ),
          ),
        ],
      );
    } else {
      return Obx(() {
        return controller.timerSeconds.value == 0
            ? Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: (){
                    controller.resendOtp({
                      "email": email,
                      "type": type
                    });
                  },
                  child: CustomText(
                    'Resend OTP',
                      style: AppTextTheme.bodyLarge,
                    fontSize: (Get.context?.isTablet ?? false) ? 0.5 : 1,
                  ),
                ),
              )
            : const SizedBox.shrink();
      });
    }
  }
}
