import '../../../utilities/app_exports.dart';
import '../../login/login_view.dart';
import '../forgot_password_controller.dart';

class ResetPasswordView extends StatelessWidget {
  final String email, otp;

  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  ResetPasswordView({super.key, required this.email, required this.otp});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      init: Get.put(ForgotPasswordController()),
      builder: (controller) => CustomLoader(
        isTrue: AppGlobals.isLoading.value,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: resetPasswordFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.08),
                  InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        controller.passwordTFController.text = '1234';
                        controller.confirmPasswordTFController.text = '1234';
                      }
                    },
                    child: CustomText(
                      'Reset Your PIN',
                      style: AppTextTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              "Forgot your PIN? No worries!",
                              style: AppTextTheme.bodyLarge,
                            ),
                            CustomText(
                              "Reset It Now And Regain Access Instantly",
                              style: AppTextTheme.bodyLarge,
                            ),
                          ],
                        ),

                  SizedBox(height: Get.height * 0.04),

                  ///New Pin
                  CustomTextFormField(
                    controller: controller.passwordTFController,
                    upperLabel: "4-digits Pin".tr,
                    upperLabelReqStar: "*",
                    hintValue: ('•' * 4).tr,
                    obscureText: true,
                    prefixIcon: SvgPicture.asset(AppConstants.lock),
                    validator: (value) => validatePIN(value),
                    type: TextInputType.number,
                    maxLength: 4,
                    inputFormatters: [
                      BlankSpaceInputFormatter(),
                      // FilteringTextInputFormatter(RegExp(AppConstants.passwordFilterPattern as String), allow: true),
                    ],
                  ),

                  ///Confirm Password
                  CustomTextFormField(
                    controller: controller.confirmPasswordTFController,
                    upperLabel: "4-digits Pin".tr,
                    upperLabelReqStar: "*",
                    hintValue: ('•' * 4).tr,
                    obscureText: true,
                    prefixIcon: SvgPicture.asset(AppConstants.lock),
                    validator: (value) => validateConfirmPassword(
                        value, controller.passwordTFController.text),
                    type: TextInputType.number,
                    maxLength: 4,
                    inputFormatters: [
                      BlankSpaceInputFormatter(),
                      // FilteringTextInputFormatter(RegExp(AppConstants.passwordFilterPattern as String), allow: true),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),

                  ///Update Password Button
                  CustomRectangleButton(
                      width: context.width,
                      text: "Reset Password",
                      onTap: () {
                        if (!resetPasswordFormKey.currentState!.validate()) {
                          return;
                        }
                        controller.resetPassword({
                          "email": email,
                          "code": int.tryParse(otp),
                          "pin": controller.confirmPasswordTFController.text,
                        }).then((value) {
                          if(value['status']){
                            Get.offAll(() => LoginView());
                          }

                        });
                      }),
                  SizedBox(height: Get.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
