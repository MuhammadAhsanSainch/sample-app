import 'package:path_to_water/features/journal/controllers/journal_search_screen_controller.dart';

import '../../../utilities/app_exports.dart';

class JournalSearchScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(JournalSearchScreenController());
  }
}
