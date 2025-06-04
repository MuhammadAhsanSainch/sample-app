import 'package:path_to_water/screens/login/login_view.dart';

import '../../utilities/app_exports.dart';
import 'signup_controller.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    // Check if the device is a tablet
    bool isTablet = Get.context?.isTablet ?? false;
    return GetBuilder<SignupController>(
      init: SignupController.to,
      builder:
          (controller) => Obx(
            () => CustomLoader(
              isTrue: AppGlobals.isLoading.value,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  height: Get.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppGlobals.isDarkMode.value
                            ? AppConstants.singUpBgDark
                            : AppConstants.singUpBgLight,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: loginFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                            isTablet
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height * 0.1),
                          GestureDetector(
                            onTap: () {
                              if (kDebugMode) {
                                controller.emailTFController.text =
                                    "ahsan@mailinator.com";
                                controller.passwordTFController.text = "1235";
                              }
                            },
                            child: CustomText(
                              "Create an Account",
                              style: AppTextTheme.headlineSmall,
                            ),
                          ),

                          ///Full Name
                          CustomTextFormField(
                            controller: controller.fullNameTFController,
                            prefixIcon: SvgPicture.asset(AppConstants.profile),
                            upperLabel: "Full Name",
                            upperLabelReqStar: "*",
                            hintValue: "Enter Full Name",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Full Name is required';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          ///User Name
                          CustomTextFormField(
                            controller: controller.userNameTFController,
                            prefixIcon: SvgPicture.asset(AppConstants.profile),
                            upperLabel: "User Name",
                            upperLabelReqStar: "*",
                            hintValue: "Enter User Name",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'User Name is required';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          ///Email
                          CustomTextFormField(
                            controller: controller.emailTFController,
                            prefixIcon: SvgPicture.asset(AppConstants.mail),
                            upperLabel: "Email Address",
                            upperLabelReqStar: "*",
                            hintValue: "Enter Email Address",
                            validator: (value) => validateEmail(value),
                            type: TextInputType.emailAddress,
                            inputFormatters: [
                              FilteringTextInputFormatter(
                                RegExp(r'[a-zA-Z0-9@._-]'),
                                allow: true,
                              ),
                            ],
                          ),
                          ///Password
                          CustomTextFormField(
                            controller: controller.passwordTFController,
                            upperLabel: "Password",
                            upperLabelReqStar: "*",
                            hintValue: "Enter Password",
                            prefixIcon: SvgPicture.asset(AppConstants.lock),
                            enableInteractiveSelection: true,
                            enableSuggestions: false,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          ///Confirm Password
                          CustomTextFormField(
                            controller: controller.confirmPasswordTFController,
                            upperLabel: "Confirm Password",
                            upperLabelReqStar: "*",
                            hintValue: "Enter Confirm Password",
                            prefixIcon: SvgPicture.asset(AppConstants.lock),
                            enableInteractiveSelection: true,
                            enableSuggestions: false,
                            obscureText: true,
                            validator: (confirmPwd)=> validateConfirmPassword(controller.passwordTFController.text, confirmPwd),
                          ),

                          SizedBox(height: Get.height * 0.025),

                          ///Sign Up Button
                          CustomRectangleButton(
                            width: Get.width,
                            text: "Create Account",
                            onTap: () {
                              AppGlobals.isDarkMode.toggle();
                              Get.changeThemeMode(
                                AppGlobals.isDarkMode.value
                                    ? ThemeMode.light
                                    : ThemeMode.dark,
                              );
                              log(AppGlobals.isDarkMode.toString());
                              /*if (!loginFormKey.currentState!.validate()) {
                                return;
                              }
                              AppGlobals.isLoading(true);
                              controller
                                  .logIn({
                                "email":
                                controller.emailTFController.text,
                                "pin":
                                controller.passwordTFController.text,
                              })
                                  .then((value) {
                                AppGlobals.isLoading(false);
                                if (value?.status ?? false) {
                                  Get.off(
                                        () => HomeView(),
                                    binding: HomeBinding(),
                                  );
                                }
                              });*/
                            },
                          ),

                          _socialSignInSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }

  Widget _socialSignInSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: Get.height * 0.02),
        // "Or Continue With" text with lines
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: SvgPicture.asset(AppConstants.leftLine)),
              CustomText(
                'Or Continue With',
                style: AppTextTheme.bodyLarge,
              ),
              Expanded(child: SvgPicture.asset(AppConstants.rightLine)),
            ],
          ),
        ),
        SizedBox(height: Get.height * 0.02),

        // Google and Apple Sign-in Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: SvgPicture.asset(AppConstants.google),
              // Replace with your Google logo asset
              onPressed: () {
                // Handle Google sign-in
              },
            ),
            const SizedBox(width: 20),
            _buildSocialButton(
              icon: SvgPicture.asset(
                AppConstants.apple,
                colorFilter: ColorFilter.mode(
                  AppGlobals.isDarkMode.value ? Colors.white : Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                // Handle Apple sign-in
              },
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.02),

        // "Don't have an account? Sign Up" text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             CustomText(
              "Already Have An Account? ",
              style: AppTextTheme.bodyLarge,
            ),
            GestureDetector(
              onTap: () {
                Get.off(()=>LoginView());
              },
              child: CustomText(
                "Sign In",
                style: TextStyle(
                  color: AppColors.textSecondary, // Or your app's primary color
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.textSecondary,
                  fontFamily: AppFonts.primary
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required Widget icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 80, // Adjust size as needed
      height: 60, // Adjust size as needed
      decoration: BoxDecoration(
        color: AppColors.textFieldFillColor, // Dark background color from image
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.textFieldBorderColor,
        ), // Subtle border
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Center(child: icon),
        ),
      ),
    );
  }
}
