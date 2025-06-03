import 'verify_code_view.dart';
import '../../../utilities/app_exports.dart';
import '../forgot_password_controller.dart';

class PasswordRecoveryView extends StatelessWidget {
  final GlobalKey<FormState> passwordRecoveryFormKey = GlobalKey<FormState>();

  PasswordRecoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
        init: Get.put(ForgotPasswordController()),
        builder: (controller) => Obx(()=>CustomLoader(
          isTrue: AppGlobals.isLoading.value,
          child: Scaffold(
            appBar: AppBar(leading: CustomBackButton()),
            body: Form(
              key: passwordRecoveryFormKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
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
                          controller.emailTFController.text =
                          'yousuf.ali@futurbyte.ae';
                          controller.updateSendOTPButton();
                        }
                      },
                      child: Text(
                        'Password Recovery',
                        style: AppTextTheme.headlineMedium,
                      ),
                    ),
                    Text(
                      'Enter Your Details To Login Your Account',
                      style: AppTextTheme.headlineMedium,
                    ),
                    SizedBox(height: Get.height * 0.02),

                    ///Email
                    CustomTextFormField(
                      controller: controller.emailTFController,
                      upperLabel: "Email Address",
                      upperLabelReqStar: "*",
                      prefixIcon: SvgPicture.asset(AppConstants.mail),
                      hintValue: "Enter Email Address",
                      validator: (value) => validateEmail(value),
                      type: TextInputType.emailAddress,
                      inputFormatters: [
                        FilteringTextInputFormatter(
                            RegExp(r'[a-zA-Z0-9@._-]'),
                            allow: true)
                      ],
                      onChanged: (String value) =>
                          controller.updateSendOTPButton(),
                    ),
                    SizedBox(height: Get.height * 0.02),

                    ///Send OTP In Button
                    CustomRoundedButton(
                      width: context.width,
                      text: "Send OTP",
                      onTap: () {
                        if (!passwordRecoveryFormKey.currentState!
                            .validate()) {
                          return;
                        }

                        controller.sendOTP({
                          "email": ForgotPasswordController
                              .to.emailTFController.text,
                          "type": "FORGOT_PASSWORD"
                        }).then((value) {
                          if (value['status'] ?? false) {
                            Get.to(() => VerifyCodeView(
                              email: ForgotPasswordController
                                  .to.emailTFController.text,
                              type: "FORGOT_PASSWORD",
                            ));
                          }
                        });
                      },
                    ),
                    //     CustomRoundedButton(
                    //   isEnabled: controller.enableSendOTPButton.value,
                    //   width: context.width,
                    //   text: "Send OTP",
                    //   onTap: () {
                    //     if (!passwordRecoveryFormKey.currentState!
                    //         .validate()) {
                    //       return;
                    //     }
                    //     /*EasyLoading.show(status: "Sending Otp...");
                    //     controller.recoverPassword({
                    //       "email": controller.emailTFController.text,
                    //       "type": "FORGOT_PASSWORD",
                    //     }).then((value) {
                    //       EasyLoading.dismiss();
                    //       if (value['status'] == true) {
                    //         AppGlobals.showSuccessSnackBar(
                    //             heading: value['code'] ?? "",
                    //             message: value['message'] ?? "");
                    //         Get.to(
                    //             () => VerifyCodeView(
                    //                   whereFrom: 'password_recovery_view',
                    //                   email:
                    //                       controller.emailTFController.text,
                    //                 ),
                    //             binding: ForgotPasswordBinding());
                    //       } else {
                    //         AppGlobals.showErrorSnackBar(heading: value['code'] ?? "" ,message: value['message'] ?? "");
                    //       }
                    //     });*/
                    //     Get.to(() => VerifyCodeView(
                    //         email: controller.emailTFController.text));
                    //   },
                    // ),

                    SizedBox(height: Get.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
