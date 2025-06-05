import 'package:path_to_water/screens/journal/controllers/create_journal_screen_controller.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class CreateJournalScreen extends StatelessWidget {
  const CreateJournalScreen({super.key});

  CreateJournalScreenController get controller => Get.put(CreateJournalScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Create Journal",
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
                imagePath: AppConstants.journalBookIcon,
                height: 80.h,
                fit: BoxFit.contain,
              ),
              40.verticalSpace,
              CustomTextFormField(
                upperLabel: "Title",
                controller: controller.journalTitleController,
                hintValue: "Enter journal title",
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
                hintValue: "Select Journal Date",
                upperLabelReqStar: "",
                outerPadding: EdgeInsets.zero,
                suffixIcon: CustomImageView(svgPath: AppConstants.calendarSvgIcon, height: 20.h),
              ),
              8.verticalSpace,

              CustomTextFormField(
                upperLabel: "Select Time",
                controller: controller.selectedTimeController,
                enable: false,
                hintValue: "Select journal time",
                upperLabelReqStar: "",
                outerPadding: EdgeInsets.zero,
                suffixIcon: CustomImageView(svgPath: AppConstants.clockSvgIcon, height: 20.h),
              ),
              8.verticalSpace,

              CustomTextFormField(
                upperLabel: "Description",
                controller: controller.journalTitleController,
                hintValue: "Enter journal description",
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
          child: CustomRectangleButton(text: "Create", onTap: () {})),
      ),
    );
  }
}
