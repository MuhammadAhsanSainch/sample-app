import 'package:path_to_water/screens/quiz/quiz_controller.dart';
import 'package:path_to_water/screens/quiz/views/daily_quiz_history_view.dart';

import '../../../utilities/app_exports.dart';
import '../../../widgets/custom_arc_slider.dart';
import '../../../widgets/custom_quiz_answer_dialog.dart';

class DailyQuizView extends StatelessWidget {
  const DailyQuizView({super.key});

  QuizController get controller => Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentQuestion =
          controller.dailyQuizModel?.questions?[controller
              .currentQuestionIndex];
      return CustomLoader(
        isTrue: AppGlobals.isLoading.value,
        child: Scaffold(
          extendBody: true,
          backgroundColor: AppColors.scaffoldBackground,
          appBar: CustomAppBar(
            text: 'Daily Quiz',
            showBackIcon: true,
            trailingWidget: Visibility(
              visible: controller.selectedAnswer.value.isNotEmpty,
              child: IconButton(
                onPressed: () {
                  Get.dialog(
                    CustomQuizAnswerDialog(
                      question: currentQuestion?.text ?? '',
                      givenAnswer: controller.selectedAnswer.value,
                      actualAnswer:
                          currentQuestion?.options
                              ?.firstWhere((e) => e?.isCorrect == true)
                              ?.text ??
                          '',
                      explanation: currentQuestion?.description ?? '',
                      onNextButtonTap: () {
                        var totalQuestions =
                            controller.dailyQuizModel?.questions?.length ?? 0;
                        Navigator.pop(context);
                        if (controller.currentQuestionIndex <
                            totalQuestions - 1) {
                          controller.nextQuestion();
                        } else {
                          Get.dialog(
                            CustomResultDialog(
                              totalQuestions: totalQuestions,
                              correctAnswers:
                                  controller.correctAnswersCount.value,
                              onViewQuizHistoryButtonTap: () {
                                Navigator.pop(context);
                                Get.to(() => DailyQuizHistoryView());
                              },
                            ),
                            barrierDismissible: false,
                          );
                        }
                      },
                    ),
                    barrierDismissible: false,
                  );
                },
                icon: Row(
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
          body: Stack(
            children: [
              Positioned.fill(
                child: Obx(
                  () => Image.asset(
                    AppGlobals.isDarkMode.value
                        ? AppConstants.quizBgDark
                        : AppConstants.quizBgLight,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    bottom: 2,
                    right: -2,
                    left: -2,
                    child: GetBuilder<QuizController>(
                      init: controller,
                      id: 'slider',
                      builder:
                          (_) => CustomArcSlider(
                            maxValue:
                                controller.dailyQuizModel?.questions?.length ??
                                0,
                            initialValue: controller.initialValue,
                          ),
                    ),
                  ),
                  GetBuilder(
                    init: controller,
                    id: 'dailyQuiz',
                    builder: (_) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          20.verticalSpace,
                          CustomText(
                            currentQuestion?.text ?? '',
                            style: AppTextTheme.headlineSmall,
                            maxLine: 4,
                            textAlign: TextAlign.center,
                          ),
                          10.verticalSpace,
                          if (currentQuestion?.options?.isNotEmpty ?? false)
                            ...currentQuestion!.options!.asMap().entries.map((
                              entry,
                            ) {
                              int index = entry.key;
                              var option = entry.value;
                              bool isSelected =
                                  controller.selectedAnswer.value ==
                                  option?.text;

                              String label = ['A', 'B', 'C', 'D'][index];

                              return GestureDetector(
                                onTap: () {
                                  controller.selectAnswer(
                                    option?.text ?? '',
                                    label,
                                  ); // Store text or option object
                                },
                                child: Container(
                                  height: 48,
                                  width: Get.width,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? AppColors.primary
                                            : AppColors.textFieldFillColor,
                                    border: Border.all(
                                      color: AppColors.textFieldBorderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Row(
                                    children: [
                                      8.horizontalSpace,
                                      Container(
                                        height: 36,
                                        width: 36,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              isSelected
                                                  ? Colors.white
                                                  : AppColors
                                                      .textFieldFillColor,
                                          border: Border.all(
                                            color:
                                                isSelected
                                                    ? Colors.white
                                                    : AppColors.primary,
                                          ),
                                        ),
                                        child: Center(
                                          child: CustomText(
                                            label,
                                            style: AppTextTheme.bodyLarge
                                                .copyWith(
                                                  color: AppColors.primary,
                                                ),
                                          ),
                                        ),
                                      ),
                                      8.horizontalSpace,
                                      Expanded(
                                        child: CustomText(
                                          option?.text,
                                          style: AppTextTheme.bodyLarge
                                              .copyWith(
                                                color:
                                                    isSelected
                                                        ? Colors.white
                                                        : AppColors.primary,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
