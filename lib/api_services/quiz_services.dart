import 'package:path_to_water/models/quiz_history_model.dart';
import 'package:path_to_water/models/submit_quiz_model.dart';

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

  static Future<SubmitQuizModel> submitQuiz({required String quizId, required Map<String, dynamic> data}) async {
    final res = await ApiClient().post('${AppUrl.submitQuizApi}/$quizId/submit',data: data);
    return SubmitQuizModel.fromJson(res.data);
  }
  static Future<QuizHistoryModel> getQuizHistory({required int page, required int limit}) async {
    final res = await ApiClient().get('${AppUrl.getQuizHistoryApi}?page=$page&limit=$limit');
    return QuizHistoryModel.fromJson(res.data);
  }

}