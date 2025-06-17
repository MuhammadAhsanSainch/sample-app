import '../utilities/app_url.dart';
import '../api_core/api_client.dart';
import '../models/daily_quiz_model.dart';

class QuizServices{
  static Future<DailyQuizModel> getDailyQuiz() async {
    final res = await ApiClient().get(AppUrl.getDailyQuizApi);
    if (res.data is List) {
      return DailyQuizModel.fromJson(res.data[0]);
    } else {
      return DailyQuizModel.fromJson(res.data);
    }
  }

}