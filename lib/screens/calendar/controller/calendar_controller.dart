import 'package:device_calendar/device_calendar.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class CalendarController extends GetxController {
  DateTime? selectedDate;
  final DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
  Calendar? calendar;

  @override
  onInit() {
    super.onInit();
    retrieveCalendar();
  }

  Map<DateTime, List<Event>> events = {};

  Future retrieveCalendar() async {
    try {
      var permissionsGranted = await deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess &&
          (permissionsGranted.data == null || permissionsGranted.data == false)) {
        permissionsGranted = await deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess ||
            permissionsGranted.data == null ||
            permissionsGranted.data == false) {
          return;
        }
      }

      final calendarsResult = await deviceCalendarPlugin.retrieveCalendars();
      calendar = calendarsResult.data?.firstOrNull;
      retrieveCalendarEvent();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  retrieveCalendarEvent([DateTime? date]) async {
    DateTime selectedMonth = date ?? DateTime.now();
    final startDate = DateTime(selectedMonth.year, selectedMonth.month, 1);
    final endDate = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);
    var calendarEventsResult = await deviceCalendarPlugin.retrieveEvents(
      calendar?.id,
      RetrieveEventsParams(startDate: startDate, endDate: endDate),
    );
    List<Event> calendarEvents = calendarEventsResult.data as List<Event>;
    // for (var element in calendarEvents) {
    //   DateTime? date = element.start?.toLocal();
    //   if (date == null) continue;

    //   date = DateTime(date.year, date.month, date.day);

    //   if (events[date] == null) {
    //     events[date] = [element];
    //   } else {
    //     events[date]?.add(element);
    //   }
    // }
    // update(['calendarEvents']);
  }
}
