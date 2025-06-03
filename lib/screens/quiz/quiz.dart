import '../../utilities/app_exports.dart';
import '../../widgets/custom_arc_slider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool answerSubmitted = false;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'In which Islamic month was Prophet Muhammad (PBUH) born?',
      'options': ['Rabi al Thani', 'Rabi al Awwal', 'Dhul Hijjah', 'Ramadan'],
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
  ];

  void _nextQuestion() {
    setState(() {
      currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
      selectedAnswer = null;
      answerSubmitted = false;
    });
  }

  void _previousQuestion() {
    setState(() {
      currentQuestionIndex = (currentQuestionIndex - 1) % questions.length;
      selectedAnswer = null;
      answerSubmitted = false;
    });
  }

  void _submitAnswer() {
    setState(() {
      answerSubmitted = true;
      if (selectedAnswer == questions[currentQuestionIndex]['correctAnswer']) {
        score++;
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswer = null;
      answerSubmitted = false;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Islamic Quiz'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Score: $score/${questions.length}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestionIndex == 0 ? currentQuestionIndex + 1 : currentQuestionIndex} of ${questions.length}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              currentQuestion['question'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...currentQuestion['options'].map<Widget>((option) {
              bool isCorrect = option == currentQuestion['correctAnswer'];
              bool isSelected = selectedAnswer == option;

              Color? buttonColor;
              if (answerSubmitted) {
                if (isSelected && isCorrect) {
                  buttonColor = Colors.green;
                } else if (isSelected && !isCorrect) {
                  buttonColor = Colors.red;
                } else if (isCorrect) {
                  buttonColor = Colors.green;
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: buttonColor != null ? Colors.white : null,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed:
                  answerSubmitted
                      ? null
                      : () {
                    setState(() {
                      selectedAnswer = option;
                    });
                  },
                  child: Text(option, style: const TextStyle(fontSize: 16)),
                ),
              );
            }).toList(),
            if (answerSubmitted) ...[
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
            ],
            Expanded(
              child: CustomArcSlider(
                minValue: 1,
                maxValue: 5,
                initialValue: currentQuestionIndex,
                onChanged: (newValue) {
                  setState(() {
                    if (newValue == 5) {
                      currentQuestionIndex = 4;
                    } else {
                      currentQuestionIndex = newValue;
                    }
                  });
                  print('Slider value changed to: $newValue');
                },
              ),
            ),
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
            if (currentQuestionIndex == questions.length - 1 &&
                answerSubmitted) ...[
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _resetQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Restart Quiz',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}