import 'package:path_to_water/models/submit_quiz_model.dart';
import 'package:path_to_water/screens/quiz/views/daily_quiz_history_view.dart';

import '../../api_core/custom_exception_handler.dart';
import '../../api_services/quiz_services.dart';
import '../../utilities/app_exports.dart';
import '../../models/daily_quiz_model.dart';
import '../../models/quiz_listing_model.dart';
import '../../widgets/custom_quiz_answer_dialog.dart';

class QuizController extends GetxController {
  int initialValue = 1;
  final TextEditingController searchController = TextEditingController();
  final List<QuizListingModel> quizList =
      [
        QuizListingModel(
          title: "Quiz Rating 5",
          date: DateTime.now(),
          totalQuestions: 5,
          rightAnswers: 4,
        ),
        QuizListingModel(
          title: "Quiz Rating 4",
          date: DateTime.now(),
          totalQuestions: 5,
          rightAnswers: 4,
        ),
        QuizListingModel(
          title: "Quiz Rating 3",
          date: DateTime.now(),
          totalQuestions: 5,
          rightAnswers: 4,
        ),
        QuizListingModel(
          title: "Quiz Rating 5",
          date: DateTime.now(),
          totalQuestions: 5,
          rightAnswers: 4,
        ),
        QuizListingModel(
          title: "Quiz Rating 5",
          date: DateTime.now(),
          totalQuestions: 5,
          rightAnswers: 4,
        ),
      ].obs;

  List<Map<String, dynamic>> answersPayload = [];

  void selectAnswer({required String answer, required String label}) {
    selectedOption.value = answer;
    selectedLabel.value = label;
    update(); // or call update(['slider']) if needed
  }

  void nextQuestion() {
    currentQuestionIndex++;
    initialValue++;
    selectedOption.value = '';
    currentQuestion = dailyQuizModel?.questions?[currentQuestionIndex];
  }

  // --- Dialog Logic ---

  void showAnswerDialog(BuildContext context) {
    Get.dialog(
      CustomQuizAnswerDialog(
        question: currentQuestion?.text ?? '',
        givenAnswer: selectedOption.value,
        actualAnswer:
            currentQuestion?.options
                ?.firstWhere((e) => e?.isCorrect == true)
                ?.text ??
            '',
        explanation: currentQuestion?.description ?? '',
        onNextButtonTap: () => handleNextQuestion(context), // Extracted logic
      ),
      barrierDismissible: false,
    );
  }

  void handleNextQuestion(BuildContext context) {
    var totalQuestions = dailyQuizModel?.questions?.length ?? 0;
    Navigator.pop(context); // Close the current dialog
    answersPayload.add({
      'questionId': currentQuestion?.id ?? '',
      'selectedOptionId': selectedOptionId.value,
    });
    if (currentQuestionIndex < totalQuestions - 1) {
      nextQuestion();
    } else {
      submitDailyQuiz(totalQuestions: totalQuestions);
    }
    update(["dailyQuiz"]);
  }

  void showResultDialog({required int totalQuestions,required int score}) {
    Get.dialog(
      CustomResultDialog(
        totalQuestions: totalQuestions,
        correctAnswers: score,
        onViewQuizHistoryButtonTap: () {
          Navigator.pop(Get.context!); // Close result dialog
          Get.off(() => DailyQuizHistoryView());
        },
      ),
      barrierDismissible: false,
    );
  }

  int currentQuestionIndex = 0;
  var selectedLabel = ''.obs;
  var selectedOption = ''.obs;
  var selectedOptionId = ''.obs;

  RxBool isLoading = false.obs;
  DailyQuizModel? dailyQuizModel;
  SubmitQuizModel? submitQuizModel;
  DailyQuizModelQuestions? currentQuestion;

  var correctAnswersCount = 2.obs;

  // Observable RxInt to hold the selected question index
  final RxInt _selectedQuestion = 1.obs;

  // Getter to easily access the value
  int get selectedQuestion => _selectedQuestion.value;

  // Method to update the selected question
  void setSelectedQuestion(int index) {
    _selectedQuestion.value = index;
  }

  Future getDailyQuiz() async {
    try {
      isLoading(true);
      dailyQuizModel = await QuizServices.getDailyQuiz();
      currentQuestion = dailyQuizModel?.questions?[currentQuestionIndex];
      await Future.delayed(Duration(seconds: 1));
      log('${dailyQuizModel?.questions?.isNotEmpty ?? false}');
      log('${dailyQuizModel?.questions?.length ?? 0}');
      update(["dailyQuiz"]);
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } finally {
      isLoading(false);
      update(["dailyQuiz"]);
    }
  }

  Future submitDailyQuiz({required int totalQuestions}) async {
    try {
      isLoading(true);
      submitQuizModel = await QuizServices.submitQuiz(
        quizId: dailyQuizModel?.id ?? '',
        data: {"answers": answersPayload},
      );
      showResultDialog(totalQuestions: totalQuestions,score: submitQuizModel?.score??0);
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((d) {
      getDailyQuiz();
    });
  }
}
