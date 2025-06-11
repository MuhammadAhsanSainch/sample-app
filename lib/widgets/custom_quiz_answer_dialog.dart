import 'package:path_to_water/utilities/app_exports.dart';

class CustomQuizAnswerDialog extends StatelessWidget {
  final String question;
  final String givenAnswer;
  final String actualAnswer;
  final String explanation;
  final void Function()? onNextButtonTap;

  const CustomQuizAnswerDialog({
    super.key,
    required this.explanation,
    required this.givenAnswer,
    required this.actualAnswer,
    required this.question,
    this.onNextButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),

      clipBehavior: Clip.hardEdge,
      backgroundColor: AppColors.dialogBgColor,
      child: Stack(
        clipBehavior: Clip.none, // Allow close button to overflow if needed
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: AssetImage(
                        AppGlobals.isDarkMode.value
                            ? AppConstants.customDialogBgDarkImage
                            : AppConstants.customDialogBgImage,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 12.h),
                  child: SvgPicture.asset(
                    AppConstants.illustration,
                    height: 40.h,
                  ),
                ),
                CustomText(
                  'Your Answer is ${givenAnswer == actualAnswer ? 'Right' : 'Wrong'}',
                  style: AppTextTheme.titleMedium,
                ),
                Container(
                  height: 48,
                  width: Get.width,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color:
                        givenAnswer == actualAnswer
                            ? AppColors.primary
                            : AppColors.error,
                    border: Border.all(color: AppColors.textFieldBorderColor),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      SizedBox(),
                      Container(
                        height: 36,
                        width: 36,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                          child: CustomText(
                            'A',
                            style: AppTextTheme.bodyLarge.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomText(
                          givenAnswer,
                          style: AppTextTheme.bodyLarge.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomText('Correct Answer', style: AppTextTheme.titleMedium),
                Container(
                  height: 48,
                  width: Get.width,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    border: Border.all(color: AppColors.textFieldBorderColor),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      SizedBox(),
                      Container(
                        height: 36,
                        width: 36,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                          child: CustomText(
                            'A',
                            style: AppTextTheme.bodyLarge.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomText(
                          actualAnswer,
                          style: AppTextTheme.bodyLarge.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomText(
                  question,
                  style: AppTextTheme.titleMedium,
                  maxLine: 2,
                ),
                8.verticalSpace,
                CustomText(
                  explanation,
                  style: AppTextTheme.bodyLarge.copyWith(
                    color:
                        AppGlobals.isDarkMode.value
                            ? AppColors.lightColor
                            : AppColors.grey500,
                  ),
                  maxLine: 6,
                ),
              ],
            ),
          ),
          Positioned(
            top: 33.h,
            right: 23.h,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: onNextButtonTap,
                child: Row(
                  spacing: 8,
                  children: [
                    CustomText(
                      'Next',
                      style: AppTextTheme.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: AppColors.textSecondary),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
