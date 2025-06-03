import '../../utilities/app_exports.dart';
import '../forgot-password/forgot_password_binding.dart';
import '../forgot-password/views/password_recovery_view.dart';
import '../home/home_binding.dart';
import '../home/home_view.dart';
import 'login_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Check if the device is a tablet
    bool isTablet = Get.context?.isTablet ?? false;
    return GetBuilder<LoginController>(
      init: LoginController.to,
      builder: (controller) => Obx(() => CustomLoader(
            isTrue: AppGlobals.isLoading.value,
            child: Scaffold(
              body: SizedBox(
                height: size.height,
                child: SingleChildScrollView(
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: isTablet
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height * 0.12),

                        GestureDetector(
                          onTap: () {
                            if (kDebugMode) {
                              controller.emailTFController.text =
                                  "yousuf.ali@futurbyte.ae";
                              controller.passwordTFController.text = "1235";
                              controller.updateLoginButton();
                            }
                          },
                          child: CustomText(
                            "Login",
                            style: AppTextTheme.bodyLarge,
                          ),
                        ),
                        CustomText(
                          "Enter Your Details To Login Your Account",
                          style: AppTextTheme.bodyLarge,
                        ),
                        SizedBox(height: Get.height * 0.06),

                        ///Email
                        CustomTextFormField(
                          controller: controller.emailTFController,
                          prefixIcon: SvgPicture.asset(AppConstants.person),
                          upperLabel: "Email",
                          upperLabelReqStar: "*",
                          hintValue: "Enter Email Address",
                          validator: (value) => validateEmail(value),
                          type: TextInputType.emailAddress,
                          inputFormatters: [
                            FilteringTextInputFormatter(
                                RegExp(r'[a-zA-Z0-9@._-]'),
                                allow: true)
                          ],
                          onChanged: (String value) {
                            controller.updateLoginButton();
                          },
                        ),

                        ///Password
                        CustomTextFormField(
                          controller: controller.passwordTFController,
                          upperLabel: "4-digits Pin",
                          upperLabelReqStar: "*",
                          hintValue: "Enter 4-digits Pin",
                          prefixIcon: SvgPicture.asset(AppConstants.lock),
                          enableInteractiveSelection: true,
                          enableSuggestions: false,
                          obscureText: true,
                          maxLength: 4,
                          // Validator to check if the field is empty
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '4-digits Pin is required';
                            }
                            return null; // Return null if the input is valid
                          },
                          type: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter(RegExp(r'[0-9]'),
                                allow: true)
                          ],
                          onChanged: (String value) {
                            controller.updateLoginButton();
                          },
                        ),
                        SizedBox(height: Get.height * 0.01),

                        ///Forgot Password TextButton
                        Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Get.to(() => PasswordRecoveryView(),
                                  binding: ForgotPasswordBinding());
                            },
                            child: CustomText(
                              'Forgot PIN?',
                              style: AppTextTheme.bodyLarge,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),

                        ///Sign In Button
                        Obx(
                          () => CustomRoundedButton(
                            isEnabled: controller.enableSubmitBtn.value,
                            width: size.width,
                            text: "Log In",
                            onTap: () {
                              if (!loginFormKey.currentState!.validate()) {
                                return;
                              }
                              AppGlobals.isLoading(true);
                              controller.logIn({
                                "email": controller.emailTFController.text,
                                "pin": controller.passwordTFController.text,
                              }).then((value) {
                                AppGlobals.isLoading(false);
                                if (value?.status ?? false) {
                                  Get.off(() => HomeView(),
                                      binding: HomeBinding());
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
