import 'package:path_to_water/screens/notification/controller/notification_controller.dart';
import 'package:path_to_water/screens/quiz/quiz_controller.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/utilities/dummy_content.dart';

class DailyQuizHistoryScreen extends StatelessWidget {
  const DailyQuizHistoryScreen({super.key});

  QuizController get controller => Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Daily Quiz History", centerTitle: true, showBackIcon: true),
      backgroundColor: AppColors.scaffoldBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            CustomTextFormField(
              controller: controller.searchController,
              upperLabel: "",
              upperLabelReqStar: "",
              hintValue: "Search",
              borderColor: AppColors.primary,
              outerPadding: EdgeInsets.zero,
              prefixIcon: CustomImageView(
                imagePath: AppConstants.searchIcon,
                height: 24.h,
                fit: BoxFit.contain,
              ),
            ),
            10.verticalSpace,
            Expanded(
              child: ListView.separated(
                itemCount: controller.quizList.length,
                separatorBuilder: (context, index) {
                  return 8.verticalSpace;
                },
                itemBuilder: (context, index) {
                  final item = controller.quizList[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.dialogBgColor,
                      border: Border.all(color: AppGlobals.isDarkMode.value ? AppColors.strokeDarkGreyColor : AppColors.strokeColor, width: 1),
                    ),
                    padding: EdgeInsets.all(12.r),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 4.r),
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.quiz_outlined,
                            color: AppColors.primary,
                            size: 16.r,
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomText(
                                      item.title,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              8.verticalSpace,
                              CustomText(
                                item.date.toFormatDateTime(format: "hh:mm a, dd/MM/yyyy"),
                                fontSize: 10.sp,
                              ),
                              CustomText(
                                'item.title',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                item.title,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getStatusColor(String? status) {
    switch (status) {
      case "Accepted":
        return AppColors.success;
      case "Rejected":
        return AppColors.error;
      default:
        return AppColors.orangeColor;
    }
  }

  IconData getStatusIcon(String? status) {
    switch (status) {
      case "Accepted":
        return Icons.check;
      case "Rejected":
        return Icons.close;
      default:
        return Icons.info_outline;
    }
  }
}
