import 'package:hijri/hijri_calendar.dart';
import 'package:path_to_water/models/journal_model.dart';
import 'package:path_to_water/features/journal/controllers/create_journal_screen_controller.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/utilities/app_helper.dart';
import 'package:path_to_water/utilities/validators.dart';
import 'package:path_to_water/widgets/custom_calendar.dart';

class CreateJournalScreen extends StatelessWidget {
  final JournalDetail? journal;
  const CreateJournalScreen({super.key, this.journal});

  CreateJournalScreenController get controller => Get.put(CreateJournalScreenController());

  @override
  Widget build(BuildContext context) {
    if (journal != null) {
      controller.setDetails(journal);
    }
    return Scaffold(
      appBar: CustomAppBar(
        text: journal != null ? "Edit Journal" : "Create Journal",
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
          Obx(() {
            return CustomLoader(
              isTrue: AppGlobals.isLoading.value,
              child: Form(
                key: controller.formKey,
                child: ListView(
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
                      validator: Validators.required,
                    ),
                    8.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        showDualCalendar(
                          context,
                          initialDate: controller.selectedDate,
                          selectedDate: controller.selectedDate,
                          onDateSelected: (date) {
                            controller.selectedDate = date;
                            controller.selectedHijriDate = HijriCalendar.fromDate(date);
                            controller.selectedDateController.text =
                                "${date.toFormatDateTime(format: "dd MMM, yyyy")}/ ${controller.selectedHijriDate?.hDay ?? ""} ${controller.selectedHijriDate?.longMonthName ?? ""} ${controller.selectedHijriDate?.hYear ?? ""}";
                          },
                        );
                      },
                      child: CustomTextFormField(
                        upperLabel: "Select Date",
                        enabled: false,
                        controller: controller.selectedDateController,
                        hintValue: "Select Journal Date",
                        upperLabelReqStar: "",
                        outerPadding: EdgeInsets.zero,
                        suffixIcon: CustomImageView(
                          svgPath: AppConstants.calendarSvgIcon,
                          height: 20.h,
                        ),
                        validator: Validators.required,
                      ),
                    ),
                    8.verticalSpace,

                    GestureDetector(
                      onTap: () {
                        Helper.pickTime(context, controller.selectedTime).then((value) {
                          controller.selectedTime = value;
                          controller.selectedTimeController.text = value?.format(context) ?? "";
                        });
                      },
                      child: CustomTextFormField(
                        upperLabel: "Select Time",
                        controller: controller.selectedTimeController,
                        enabled: false,
                        hintValue: "Select journal time",
                        upperLabelReqStar: "",
                        outerPadding: EdgeInsets.zero,
                        suffixIcon: CustomImageView(
                          svgPath: AppConstants.clockSvgIcon,
                          height: 20.h,
                        ),
                        validator: Validators.required,
                      ),
                    ),
                    8.verticalSpace,

                    CustomTextFormField(
                      upperLabel: "Description",
                      controller: controller.descriptionController,
                      hintValue: "Enter journal description",
                      upperLabelReqStar: "",
                      outerPadding: EdgeInsets.zero,
                      maxLines: 4,
                      type: TextInputType.multiline,
                      validator: Validators.required,
                    ),
                    8.verticalSpace,
                  ],
                ),
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: CustomRectangleButton(
            text: journal != null ? "Save" : "Create",
            onTap: () {
              if (!controller.formKey.currentState!.validate()) {
                return;
              }
              controller.createJournal(isEditing: journal != null, journalDetail: journal);
            },
          ),
        ),
      ),
    );
  }
}
