import '../settings_controller.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  SettingsController get controller => Get.put(SettingsController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.scaffoldBackground,
      appBar: CustomAppBar(text: 'Change Password', showBackIcon: true),
      body: Obx(
        () => CustomLoader(
          isTrue: AppGlobals.isLoading.value,
          child: Stack(
            children: [
              // 1. Background Image (fixed at the bottom of the stack)
              Positioned.fill(
                // Makes the image fill the entire available space
                child: Obx(
                  () => Image.asset(
                    // Use Image.asset directly
                    AppGlobals.isDarkMode.value
                        ? AppConstants.profileBgDark
                        : AppConstants.profileBgLight,
                    fit: BoxFit.cover, // Ensures the image covers the whole area
                    // alignment: Alignment.center, // Optional: adjust alignment if needed
                  ),
                ),
              ),
              // 2. Content (scrollable on top of the background)
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      40.verticalSpace,
                      CustomText('Update Your Password', style: AppTextTheme.headlineSmall),
                      10.verticalSpace,
                      CustomText(
                        maxLine: 3,
                        style: AppTextTheme.bodyLarge,
                        'Please enter your current password and choose a new one to keep your account secure.',
                      ),
                      10.verticalSpace,

                      ///Current Password
                      CustomTextFormField(
                        controller: controller.currentPassTFController,
                        upperLabel: "Current Password",
                        upperLabelReqStar: "*",
                        hintValue: "Enter Current Password",
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

                      ///New Password
                      CustomTextFormField(
                        controller: controller.newPassTFController,
                        upperLabel: "New Password",
                        upperLabelReqStar: "*",
                        hintValue: "Enter New Password",
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

                      ///Confirm New Password
                      CustomTextFormField(
                        controller: controller.confirmNewTFController,
                        upperLabel: "Confirm New Password",
                        upperLabelReqStar: "*",
                        hintValue: "Enter Confirm New Password",
                        prefixIcon: SvgPicture.asset(AppConstants.lock),
                        enableInteractiveSelection: true,
                        enableSuggestions: false,
                        obscureText: true,
                        validator:
                            (confirmPwd) => validateConfirmPassword(
                              controller.newPassTFController.text,
                              confirmPwd,
                            ),
                      ),
                      20.verticalSpace,

                      ///Update Button
                      CustomRectangleButton(
                        width: Get.width,
                        text: "Update",
                        onTap: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          controller.changePassword();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
