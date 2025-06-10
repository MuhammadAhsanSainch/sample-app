import 'package:path_to_water/screens/reminder/controller/create_reminder_screen_controller.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/widgets/custom_dialog.dart';

class CreateReminderScreen extends StatelessWidget {
  const CreateReminderScreen({super.key});

  CreateReminderScreenController get controller => Get.put(CreateReminderScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Create Reminder",
        centerTitle: true,
        showBackIcon: true,
        bgColor: AppColors.appBarBgColor,
      ),
      backgroundColor: AppColors.journalBackgroundColor,
      body: Stack(
        children: [
          CustomImageView(
            imagePath:
                AppGlobals.isDarkMode.value
                    ? AppConstants.createJournalBgDarkImage
                    : AppConstants.createJournalBgImage,
            height: 150.h,
            fit: BoxFit.contain,
          ),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              50.verticalSpace,
              CustomImageView(
                imagePath: AppConstants.reminderCalendarIcon,
                height: 80.h,
                fit: BoxFit.contain,
              ),
              40.verticalSpace,
              CustomTextFormField(
                upperLabel: "Title",
                controller: controller.reminderTitleController,
                hintValue: "Enter Title",
                upperLabelReqStar: "",
                outerPadding: EdgeInsets.zero,
                maxLines: 1,
                suffixIcon: CustomImageView(
                  svgPath: AppConstants.personalCardSvgIcon,
                  height: 20.h,
                ),
              ),
              8.verticalSpace,
              CustomTextFormField(
                upperLabel: "Select Date",
                enable: false,
                controller: controller.selectedDateController,
                hintValue: "Select Date",
                upperLabelReqStar: "",
                outerPadding: EdgeInsets.zero,
                suffixIcon: CustomImageView(svgPath: AppConstants.calendarSvgIcon, height: 20.h),
              ),
              8.verticalSpace,

              CustomTextFormField(
                upperLabel: "Select Time",
                controller: controller.selectedTimeController,
                enable: false,
                hintValue: "Select Time",
                upperLabelReqStar: "",
                outerPadding: EdgeInsets.zero,
                suffixIcon: CustomImageView(svgPath: AppConstants.clockSvgIcon, height: 20.h),
              ),
              8.verticalSpace,

              CustomTextFormField(
                upperLabel: "Description",
                controller: controller.descriptionController,
                hintValue: "Enter reminder description",
                upperLabelReqStar: "",
                outerPadding: EdgeInsets.zero,
                maxLines: 4,
                type: TextInputType.multiline,
              ),
              8.verticalSpace,
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: CustomRectangleButton(
            text: "Create Reminder",
            onTap: () {
              Get.dialog(
                CustomDialog(
                  message:
                      "Your reminder has been saved successfully. We’ll notify you at the scheduled time.",
                  imageIcon: AppConstants.celebrationIcon,
                  title: "Reminder Saved",
                  btnText: "Close",
                  showCloseIcon: false,
                  onButtonTap: () {
                    Get.close(2);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
