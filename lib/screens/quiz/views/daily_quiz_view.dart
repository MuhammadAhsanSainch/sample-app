import 'package:path_to_water/screens/quiz/quiz_controller.dart';
import 'package:path_to_water/screens/quiz/views/daily_quiz_history_view.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/widgets/custom_arc_slider.dart';
import 'package:path_to_water/widgets/custom_quiz_answer_dialog.dart';

class DailyQuizView extends StatelessWidget {
  const DailyQuizView({super.key});

  // Using Get.find() directly in the build method or as a getter is fine,
  // but if you access it frequently or need to ensure it's initialized,
  // you might consider initializing it once if the controller is always available.
  // For a StatelessWidget, a getter is a clean approach.
  QuizController get controller => Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: controller, // Initialize the controller for this GetBuilder
      builder: (_) {
        return Scaffold(
          extendBody: true,
          backgroundColor: AppColors.scaffoldBackground,
          appBar: _buildAppBar(context), // Extracted AppBar to a separate method
          body: _buildBody(), // Extracted Body to a separate method
        );
      },
    );
  }

  // --- Widget Building Methods ---

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      text: 'Daily Quiz',
      showBackIcon: true,
      trailingWidget: Obx(
            () => Visibility(
          // Use Obx here since selectedAnswer is an RxString
          visible: controller.selectedAnswer.value.isNotEmpty,
          child: IconButton(
            onPressed: () => _showAnswerDialog(context), // Extracted dialog logic
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
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AppGlobals.isDarkMode.value
                ? AppConstants.quizBgDark
                : AppConstants.quizBgLight,
            fit: BoxFit.cover,
          ),
        ),
        Obx(
              () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator()) // Use const for performance
              : _buildQuizContent(), // Extracted quiz content
        ),
      ],
    );
  }

  Widget _buildQuizContent() {
    return GetBuilder<QuizController>(
      id: "dailyQuiz", // Ensure this ID matches the one updated in controller
      builder: (_) {
        if (controller.dailyQuizModel?.questions?.isNotEmpty ?? false) {
          return Stack(
            children: [
              Positioned(
                bottom: 2,
                right: -2,
                left: -2,
                child: GetBuilder<QuizController>(
                  id: 'slider', // Separate ID for the slider if it updates independently
                  builder: (_) {
                    return CustomArcSlider(
                      maxValue: controller.dailyQuizModel?.questions?.length ?? 0,
                      initialValue: controller.initialValue,
                    );
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  20.verticalSpace,
                  CustomText(
                    controller.currentQuestion?.text ?? '',
                    style: AppTextTheme.headlineSmall,
                    maxLine: 4,
                    textAlign: TextAlign.center,
                  ),
                  10.verticalSpace,
                  if (controller.currentQuestion?.options?.isNotEmpty ?? false)
                    ..._buildOptionButtons(), // Extracted option buttons
                ],
              ),
            ],
          );
        } else {
          return Center(
            child: CustomText(
              'No Quiz For Today!',
              style: AppTextTheme.titleLarge,
            ),
          );
        }
      },
    );
  }

  List<Widget> _buildOptionButtons() {
    return controller.currentQuestion!.options!.asMap().entries.map((entry) {
      int index = entry.key;
      var option = entry.value;
      bool isSelected = controller.selectedAnswer.value == option?.text;
      String label = ['A', 'B', 'C', 'D'][index];

      return GestureDetector(
        onTap: () {
          controller.selectAnswer(option?.text ?? '', label);
        },
        child: Container(
          height: 48,
          width: Get.width,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.textFieldFillColor,
            border: Border.all(color: AppColors.textFieldBorderColor),
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
                  color: isSelected ? Colors.white : AppColors.textFieldFillColor,
                  border: Border.all(
                    color: isSelected ? Colors.white : AppColors.primary,
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
              8.horizontalSpace,
              Expanded(
                child: CustomText(
                  option?.text,
                  style: AppTextTheme.bodyLarge.copyWith(
                    color: isSelected ? Colors.white : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(); // Convert to a list of widgets
  }

  // --- Dialog Logic ---

  void _showAnswerDialog(BuildContext context) {
    Get.dialog(
      CustomQuizAnswerDialog(
        question: controller.currentQuestion?.text ?? '',
        givenAnswer: controller.selectedAnswer.value,
        actualAnswer: controller.currentQuestion?.options
            ?.firstWhere((e) => e?.isCorrect == true)
            ?.text ??
            '',
        explanation: controller.currentQuestion?.description ?? '',
        onNextButtonTap: () => _handleNextQuestion(context), // Extracted logic
      ),
      barrierDismissible: false,
    );
  }

  void _handleNextQuestion(BuildContext context) {
    var totalQuestions = controller.dailyQuizModel?.questions?.length ?? 0;
    Navigator.pop(context); // Close the current dialog

    if (controller.currentQuestionIndex < totalQuestions - 1) {
      controller.nextQuestion();
    } else {
      _showResultDialog(totalQuestions); // Extracted result dialog
    }
  }

  void _showResultDialog(int totalQuestions) {
    Get.dialog(
      CustomResultDialog(
        totalQuestions: totalQuestions,
        correctAnswers: controller.correctAnswersCount.value,
        onViewQuizHistoryButtonTap: () {
          Navigator.pop(Get.context!); // Close result dialog
          Get.to(() => DailyQuizHistoryView());
        },
      ),
      barrierDismissible: false,
    );
  }
}