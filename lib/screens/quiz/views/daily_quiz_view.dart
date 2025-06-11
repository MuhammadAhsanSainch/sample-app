import 'package:path_to_water/screens/quiz/quiz_controller.dart';

import '../../../utilities/app_exports.dart';
import '../../../widgets/custom_arc_slider.dart';

class DailyQuizView extends StatefulWidget {
  const DailyQuizView({super.key});

  @override
  State<DailyQuizView> createState() => _DailyQuizViewState();
}

class _DailyQuizViewState extends State<DailyQuizView> {
  @override
  Widget build(BuildContext context) {
    return GetX<QuizController>(
      builder: (controller) {
        final currentQuestion =
            controller.questions[controller.currentQuestionIndex];
        return Scaffold(
          extendBody: true,
          backgroundColor: AppColors.scaffoldBackground,
          appBar: CustomAppBar(
            text: 'Daily Quiz',
            showBackIcon: true,
            trailingWidget: Visibility(
              visible: (controller.currentQuestionIndex < controller.questions.length-1),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    controller.currentQuestionIndex++;
                  });
                  controller.onInitialValueChanged(
                    controller.initialValue + 1,
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
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              // 1. Background Image (fixed at the bottom of the stack)
              Positioned.fill(
                // Makes the image fill the entire available space
                child: Obx(
                  () => Image.asset(
                    // Use Image.asset directly
                    AppGlobals.isDarkMode.value
                        ? AppConstants.quizBgDark
                        : AppConstants.quizBgLight,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // 2. Content (scrollable on top of the background)
              Stack(
                children: [
                  Positioned(
                    bottom: 2,
                    right: -2,
                    left: -2,
                    child: GetBuilder(
                      init: controller,
                      id: 'slider',
                      builder:
                          (controller) => CustomArcSlider(
                            maxValue: controller.questions.length,
                            initialValue: controller.initialValue,
                          ),
                    ),
                  ),
                  Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        20.verticalSpace,
                        CustomText(
                          currentQuestion['question'],
                          style: AppTextTheme.headlineSmall,
                          maxLine: 4,
                          textAlign: TextAlign.center,
                        ),
                        10.verticalSpace,
                        ...currentQuestion['options'].asMap().entries.map<
                          Widget
                        >((entry) {
                          int index = entry.key;
                          String option = entry.value;
                          bool isCorrect =
                              option == currentQuestion['correctAnswer'];
                          bool isSelected = controller.selectedAnswer == option;

                          String? label;
                          switch (index) {
                            case 0:
                              label = 'A';
                              break;
                            case 1:
                              label = 'B';
                              break;
                            case 2:
                              label = 'C';
                              break;
                            case 3:
                              label = 'D';
                              break;
                          }
                          Color? buttonColor;
                          // if (answerSubmitted) {
                          //   if (isSelected && isCorrect) {
                          //     buttonColor = Colors.green;
                          //   } else if (isSelected && !isCorrect) {
                          //     buttonColor = Colors.red;
                          //   } else if (isCorrect) {
                          //     buttonColor = Colors.green;
                          //   }
                          // }

                          return GestureDetector(
                            onTap:
                                controller.answerSubmitted
                                    ? null
                                    : () {
                                      setState(() {
                                        controller.selectedAnswer = option;
                                      });
                                    },
                            child: Container(
                              height: 48,
                              width: Get.width,
                              margin: EdgeInsets.symmetric(
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
                                spacing: 20,
                                children: [
                                  2.horizontalSpace,
                                  Container(
                                    height: 36,
                                    width: 36,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : AppColors.textFieldFillColor,
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
                                        style: AppTextTheme.bodyLarge.copyWith(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomText(
                                      option,
                                      style:
                                          isSelected
                                              ? AppTextTheme.bodyLarge.copyWith(
                                                color: Colors.white,
                                              )
                                              : AppTextTheme.bodyLarge.copyWith(
                                                color: AppColors.primary,
                                              ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        /* if (answerSubmitted) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explanation:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentQuestion['explanation'],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],*/
                        // const SizedBox(height: 20),
                        // ElevatedButton(
                        //   onPressed: selectedAnswer != null && !answerSubmitted
                        //       ? _submitAnswer
                        //       : null,
                        //   style: ElevatedButton.styleFrom(
                        //     padding: const EdgeInsets.symmetric(vertical: 16),
                        //   ),
                        //   child: Text(
                        //     answerSubmitted ? 'Continue' : 'Submit',
                        //     style: const TextStyle(fontSize: 16),
                        //   ),
                        // ),
                        // if (currentQuestionIndex == questions.length - 1 &&
                        //     answerSubmitted) ...[
                        //   const SizedBox(height: 10),
                        //   ElevatedButton(
                        //     onPressed: _resetQuiz,
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.orange,
                        //       padding: const EdgeInsets.symmetric(vertical: 16),
                        //     ),
                        //     child: const Text(
                        //       'Restart Quiz',
                        //       style: TextStyle(fontSize: 16),
                        //     ),
                        //   ),
                        // ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
