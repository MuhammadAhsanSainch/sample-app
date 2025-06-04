import 'verify_code_view.dart';
import '../../../utilities/app_exports.dart';
import '../forgot_password_controller.dart';

class PasswordRecoveryView extends StatelessWidget {
  final GlobalKey<FormState> passwordRecoveryFormKey = GlobalKey<FormState>();

  PasswordRecoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<ForgotPasswordController>(
      init: Get.put(ForgotPasswordController()),
      builder:
          (controller) => Obx(
            () => CustomLoader(
              isTrue: AppGlobals.isLoading.value,
              child: Scaffold(
                backgroundColor: AppColors.scaffoldBackground,
                body: Stack(
                  children: [
                    Container(
                      height: size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            AppGlobals.isDarkMode.value
                                ? AppConstants.forgetPassBgDark
                                : AppConstants.forgetPassBgLight,
                          ),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16),
                        child: Form(
                          key: passwordRecoveryFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height * 0.4),
                              InkWell(
                                onTap: () {
                                  if (kDebugMode) {
                                    controller.emailTFController.text =
                                        'yousuf.ali@futurbyte.ae';
                                    controller.updateSendOTPButton();
                                  }
                                },
                                child: CustomText(
                                  'Forget Password',
                                  style: AppTextTheme.headlineSmall,
                                ),
                              ),
                              CustomText(
                                'Enter your registered email address to receive instructions on resetting your password',
                                style: AppTextTheme.bodyLarge,
                                maxLine: 3,
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
                                    allow: true,
                                  ),
                                ],
                                onChanged:
                                    (String value) =>
                                        controller.updateSendOTPButton(),
                              ),
                              SizedBox(height: Get.height * 0.02),

                              ///Send OTP In Button
                              CustomRectangleButton(
                                width: context.width,
                                text: "Send OTP",
                                onTap: () {
                                  if (!passwordRecoveryFormKey.currentState!
                                      .validate()) {
                                    return;
                                  }

                                  controller
                                      .sendOTP({
                                        "email":
                                            ForgotPasswordController
                                                .to
                                                .emailTFController
                                                .text,
                                        "type": "FORGOT_PASSWORD",
                                      })
                                      .then((value) {
                                        if (value['status'] ?? false) {
                                          Get.to(
                                            () => VerifyCodeView(
                                              email:
                                                  ForgotPasswordController
                                                      .to
                                                      .emailTFController
                                                      .text,
                                              type: "FORGOT_PASSWORD",
                                            ),
                                          );
                                        }
                                      });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 60,
                        left: 10,
                        child: CustomBackButton())
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
