import 'package:path_to_water/features/reminder/controller/reminder_search_controller.dart';

import '../../../utilities/app_exports.dart';

class ReminderScreenSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ReminderSearchController());
  }
}
