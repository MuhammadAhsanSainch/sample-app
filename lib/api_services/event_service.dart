import 'package:path_to_water/api_core/api_client.dart';
import 'package:path_to_water/features/calendar/models/islamic_event_model.dart';
import 'package:path_to_water/utilities/app_url.dart';

class EventService {
  static Future<List<IslamicEvents>> getEvents(Map<String, dynamic> queryParameters) async {
    final res = await ApiClient().get(AppUrl.eventAPI, queryParameters: queryParameters);
    if (res.data is List) {
      return List<IslamicEvents>.from(res.data.map((x) => IslamicEvents.fromJson(x)));
    }
    return [];
  }
}
