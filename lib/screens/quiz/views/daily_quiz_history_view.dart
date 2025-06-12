import 'package:path_to_water/screens/quiz/quiz_controller.dart';
import 'package:path_to_water/screens/quiz/views/quiz_detail_view.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class DailyQuizHistoryView extends StatelessWidget {
  const DailyQuizHistoryView({super.key});

  QuizController get controller => Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Daily Quiz History",
        centerTitle: true,
        showBackIcon: true,
      ),
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
                  return GestureDetector(
                    onTap: () => Get.to(() => QuizDetailView()),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.dialogBgColor,
                        border: Border.all(
                          color:
                              AppGlobals.isDarkMode.value
                                  ? AppColors.strokeDarkGreyColor
                                  : AppColors.strokeColor,
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.all(12.r),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: AppColors.lightGreenColor,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(AppConstants.quizIcon2),
                          ),
                          6.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  spacing: 10,
                                  children: [
                                    CustomText(
                                      item.title,
                                      style: AppTextTheme.titleMedium,
                                    ),
                                    SvgPicture.asset(AppConstants.star)
                                  ],
                                ),
                                CustomText(
                                  item.date.toFormatDateTime(
                                    format: "dd MMM yyyy",
                                  ),
                                  style: AppTextTheme.bodySmall,
                                ),
                                8.verticalSpace,
                                CustomText(
                                  'Total Question ${item.totalQuestions} for today',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                CustomText(
                                  'Answer Right ${item.rightAnswers}',
                                  style: AppTextTheme.bodySmall.copyWith(
                                    color: AppColors.greenColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
}
