import 'package:path_to_water/screens/quiz/quiz_controller.dart';
import 'package:readmore/readmore.dart';
import '../../../utilities/app_exports.dart';

class QuizDetailView extends StatelessWidget {
  const QuizDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Initialize the controller using Get.put()
    // This makes the controller available to all its descendants
    final QuizController controller = Get.put(QuizController());

    return Scaffold(
      appBar: CustomAppBar(
        text: "Quiz Detail",
        centerTitle: true,
        showBackIcon: true,
      ),
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Quiz Header Card
            _buildQuizHeaderCard(),
            const SizedBox(height: 20),
            // Question & Answer Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align( // Added Align for consistent left alignment
                alignment: Alignment.centerLeft,
                child: CustomText(
                  'Question & Answer',
                  style: AppTextTheme.headlineSmall,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Question Navigation Tabs
            // 3. Use Obx to reactively rebuild the tabs when selectedQuestion changes
            Obx(
                  () => _buildQuestionNavigationTabs(context, controller.selectedQuestion),
            ),
            const SizedBox(height: 10),
            // Question Answer Card
            // 3. Use Obx to reactively rebuild the card content when selectedQuestion changes
            Obx(
                  () => _buildQuestionAnswerCard(controller.selectedQuestion),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizHeaderCard() {
    return Column(
      children: [
        const SizedBox(height: 10),
        CustomText('Quiz 02 Dec 2024', style: AppTextTheme.headlineSmall),
        const SizedBox(height: 20),
        Container(
          height: 150.h,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.dialogImageBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.borderColor),
            image: DecorationImage(
              image: AssetImage(AppConstants.resultImage),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionNavigationTabs(BuildContext context, int currentSelectedQuestion) {
    // Get the controller instance to access its methods
    final QuizController controller = Get.find();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          5,
              (index) => GestureDetector(
            onTap: () {
              // Call the controller's method to update the selected question
              controller.setSelectedQuestion(index + 1);
            },
            child: _buildQuestionTab(
              context,
              'Q.${index + 1}',
              isSelected: (index + 1) == currentSelectedQuestion, // Use the passed value
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionTab(
      BuildContext context,
      String text, {
        bool isSelected = false,
      }) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
        // borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:
          isSelected ? Theme.of(context).primaryColor : Colors.grey[300]!,
        ),
      ),
      alignment: Alignment.center,
      child: CustomText( // Assuming CustomText works with String directly
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // This widget now takes the currently selected question to display dynamic content
  Widget _buildQuestionAnswerCard(int currentQuestionIndex) {
    // In a real application, you would fetch the question data based on currentQuestionIndex
    // For demonstration, we'll just update the question number.
    String questionText = 'In which Islamic month was Prophet Muhammad (PBUH) born?';
    String readMoreContent = 'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.';
    String givenAnswer = 'Rabi al Awwal';
    String actualAnswer = 'Rabi al Aakhir'; // Example: making it wrong for Q1 to show 'Wrong'

    if (currentQuestionIndex == 1) {
      givenAnswer = 'Rabi al Awwal';
      actualAnswer = 'Rabi al Awwal'; // Make Q1 correct
    } else if (currentQuestionIndex == 2) {
      questionText = 'What is the capital of Saudi Arabia?';
      givenAnswer = 'Jeddah'; // Wrong answer
      actualAnswer = 'Riyadh';
    } else if (currentQuestionIndex == 3) {
      questionText = 'Which surah is known as the heart of Quran?';
      givenAnswer = 'Yaseen';
      actualAnswer = 'Yaseen';
    }
    // You would add more else if blocks for other questions

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColors.textFieldFillColor,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppColors.textFieldBorderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText('Question $currentQuestionIndex', style: AppTextTheme.bodyLarge),
            const SizedBox(height: 10),
            CustomText(
              questionText,
              style: AppTextTheme.headlineSmall,
              maxLine: 4,
            ),
            const SizedBox(height: 10),
            ReadMoreText(
              readMoreContent,
              trimMode: TrimMode.Line,
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimCollapsedText: 'Read more',
              trimExpandedText: 'Read less',
              style: AppTextTheme.bodyLarge,
              moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildAnswer(
              givenAnswer: givenAnswer,
              actualAnswer: actualAnswer,
            ),
            const SizedBox(height: 15),
            _buildAnswer(
              label: 'Correct Answer',
              givenAnswer: actualAnswer, // Correct answer always uses actualAnswer
              actualAnswer: actualAnswer,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswer({
    required String actualAnswer,
    required String givenAnswer,
    String? label,
  }) {
    bool isRight = givenAnswer == actualAnswer;
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color:
        AppGlobals.isDarkMode.value
            ? AppColors.primary
            : AppColors.lightGreenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            label ?? 'Your Answer ${isRight ? 'Right' : 'Wrong'}',
            style: AppTextTheme.titleMedium,
          ),
          CustomText(
            label != null ? actualAnswer : givenAnswer,
            style: AppTextTheme.headlineSmall.copyWith(
              color:
              label != null
                  ? AppColors.textPrimary
                  : isRight
                  ? AppColors.textPrimary
                  : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
