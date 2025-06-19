import '../../utilities/app_exports.dart';
import '../../models/daily_quiz_model.dart';
import '../../models/quiz_result_model.dart';
import '../../models/submit_quiz_model.dart';
import '../../models/quiz_listing_model.dart';
import '../../models/quiz_history_model.dart';
import '../../api_services/quiz_services.dart';
import '../../api_core/custom_exception_handler.dart';
import '../../widgets/custom_quiz_answer_dialog.dart';
import '../../screens/quiz/views/daily_quiz_history_view.dart';

class QuizController extends GetxController {
  int initialValue = 1;
  final TextEditingController searchController = TextEditingController();
  final List<QuizListingModel> quizList = <QuizListingModel>[].obs;

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

  void showResultDialog({required int totalQuestions, required int score}) {
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
  QuizResultModel? quizResultModel;
  QuizHistoryModel? quizHistoryModel;
  DailyQuizModelQuestions? currentQuestion;

  var correctAnswersCount = 2.obs;

  // Observable RxInt to hold the selected question index
  final RxInt _selectedQuestion = 0.obs;

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
      update(["dailyQuiz"]);
    } on Exception catch (e) {
      isLoading(false);
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
      showResultDialog(
        totalQuestions: totalQuestions,
        score: submitQuizModel?.score ?? 0,
      );
    } on Exception catch (e) {
      isLoading(false);
      ExceptionHandler().handleException(e);
    } finally {
      isLoading(false);
    }
  }

  Future getQuizHistory() async {
    try {
      quizList.clear();
      isLoading(true);
      quizHistoryModel = await QuizServices.getQuizHistory(page: 1, limit: 10);
      if (quizHistoryModel?.data?.isNotEmpty ?? false) {
        for (var q in quizHistoryModel!.data!) {
          quizList.add(
            QuizListingModel(
              id: q?.id??'',
              title: q?.quiz?.title ?? '',
              totalQuestions: 5,
              rightAnswers: q?.score ?? 0,
              date: DateTime.parse(q?.completedAt ?? ''),
            ),
          );
        }
      }
      update(['quizHistory']);
    } on Exception catch (e) {
      isLoading(false);
      ExceptionHandler().handleException(e);
    } finally {
      isLoading(false);
    }
  }

  Future getQuizResult({required String id}) async {
    try {
      isLoading(true);
      quizResultModel = await QuizServices.getQuizResult(id: id);
      setSelectedQuestion(1);
      update(["quizResult"]);
    } on Exception catch (e) {
      isLoading(false);
      ExceptionHandler().handleException(e);
    } finally {
      isLoading(false);
      update(["quizResult"]);
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((d) {
      // getDailyQuiz();
    });
  }
}
