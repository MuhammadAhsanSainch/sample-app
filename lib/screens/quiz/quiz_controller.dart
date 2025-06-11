import 'package:path_to_water/screens/quiz/models/quiz_listing_model.dart';

import '../../utilities/app_exports.dart';

class QuizController extends GetxController {
  int initialValue = 1;
  final TextEditingController searchController = TextEditingController();
  final List<QuizListingModel> quizList = [
    QuizListingModel(
      title: "Lorem ipsum dolor sit amet.",
      date: DateTime.now(),
      totalQuestions: 5,
      rightAnswers: 4,
    ),
    QuizListingModel(
      title: "Lorem ipsum dolor sit amet.",
      date: DateTime.now(),
      totalQuestions: 5,
      rightAnswers: 4,
    ),
    QuizListingModel(
      title: "Lorem ipsum dolor sit amet.",
      date: DateTime.now(),
      totalQuestions: 5,
      rightAnswers: 4,
    ),
    QuizListingModel(
      title: "Lorem ipsum dolor sit amet.",
      date: DateTime.now(),
      totalQuestions: 5,
      rightAnswers: 4,
    ),
    QuizListingModel(
      title: "Lorem ipsum dolor sit amet.",
      date: DateTime.now(),
      totalQuestions: 5,
      rightAnswers: 4,
    ),
  ].obs;

  onInitialValueChanged(value) {
    initialValue = value;
    update(['slider']);
  }

  int currentQuestionIndex = 0;
  String? selectedLabel;
  String? selectedAnswer;
  bool answerSubmitted = false;
  int score = 0;

  final List<Map<String, dynamic>> questions =
      [
        {
          'question':
              'In which Islamic month was Prophet Muhammad (PBUH) born?',
          'options': [
            'Rabi al Thani',
            'Rabi al Awwal',
            'Dhul Hijjah',
            'Ramadan',
          ],
          'correctAnswer': 'Rabi al Awwal',
          'explanation':
              'The Prophet Muhammad (PBUH) was born in the month of Rabi al Awwal, specifically on the 12th day.',
        },
        {
          'question': 'Which prophet is known as the "Father of Humanity"?',
          'options': [
            'Prophet Nuh (AS)',
            'Prophet Ibrahim (AS)',
            'Prophet Adam (AS)',
            'Prophet Musa (AS)',
          ],
          'correctAnswer': 'Prophet Adam (AS)',
          'explanation':
              'Prophet Adam (AS) is considered the father of all humanity as he was the first human created by Allah.',
        },
        {
          'question':
              'What is the name of the night when the Quran was first revealed?',
          'options': [
            'Laylat al-Qadr',
            'Laylat al-Miraj',
            'Laylat al-Baraah',
            'Laylat al-Raghaib',
          ],
          'correctAnswer': 'Laylat al-Qadr',
          'explanation':
              'Laylat al-Qadr (Night of Power) is when the first verses of the Quran were revealed to Prophet Muhammad (PBUH).',
        },
        {
          'question':
              'Which angel is responsible for delivering revelations to the prophets?',
          'options': [
            'Angel Mikael',
            'Angel Israfil',
            'Angel Jibril',
            'Angel Izrail',
          ],
          'correctAnswer': 'Angel Jibril',
          'explanation':
              'Angel Jibril (Gabriel) is the angel who delivered revelations to all the prophets, including the Quran to Prophet Muhammad (PBUH).',
        },
        {
          'question': 'What is the first month of the Islamic calendar?',
          'options': ['Ramadan', 'Muharram', 'Shawwal', 'Safar'],
          'correctAnswer': 'Muharram',
          'explanation':
              'Muharram is the first month of the Islamic Hijri calendar and is one of the four sacred months.',
        },
      ].obs;
}
