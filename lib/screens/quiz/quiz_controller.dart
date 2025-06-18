import '../../api_core/custom_exception_handler.dart';
import '../../api_services/quiz_services.dart';
import '../../utilities/app_exports.dart';
import '../../models/daily_quiz_model.dart';
import '../../models/quiz_listing_model.dart';

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


  void selectAnswer(String option, String label) {
    selectedAnswer.value = option;
    selectedLabel.value = label;
    update(); // or call update(['slider']) if needed
  }

  void nextQuestion() {
    currentQuestionIndex++;
    initialValue++;
    selectedAnswer.value = '';
    update(); // update UI
  }

  int currentQuestionIndex = 0;
  var selectedLabel = ''.obs;
  var selectedAnswer = ''.obs;

  RxBool isLoading = false.obs;
  DailyQuizModel? dailyQuizModel;
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

  Future submitDailyQuiz() async {
    try {
      isLoading(true);
      dailyQuizModel = await QuizServices.submitQuiz(quizId: dailyQuizModel?.id??'',data: {});
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
