import 'package:path_to_water/api_core/api_client.dart';
import 'package:path_to_water/models/hadith_model.dart';
import 'package:path_to_water/models/history_model.dart';
import 'package:path_to_water/models/quran_ayat_model.dart';
import 'package:path_to_water/utilities/app_url.dart';

class AyatAndHadithService {
  static Future<QuranAyatModel> getDailyAyat() async {
    final res = await ApiClient().get(AppUrl.ayahApi);
    if (res.data is List) {
      return QuranAyatModel.fromJson(res.data[0]);
    } else {
      return QuranAyatModel.fromJson(res.data);
    }
  }

  static Future<HadithModel> getDailyHadith() async {
    final res = await ApiClient().get(AppUrl.hadithApi);
    if (res.data is List) {
      return HadithModel.fromJson(res.data[0]);
    }
    return HadithModel.fromJson(res.data);
  }

  static Future<HistoryModel> getDailyHistory() async {
    final res = await ApiClient().get(AppUrl.historyApi);
    if (res.data is List) {
      return HistoryModel.fromJson(res.data[0]);
    }
    return HistoryModel.fromJson(res.data);
  }
}
