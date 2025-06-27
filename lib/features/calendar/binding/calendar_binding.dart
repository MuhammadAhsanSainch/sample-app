import 'package:path_to_water/features/calendar/controller/calendar_controller.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CalendarController());
  }
}
