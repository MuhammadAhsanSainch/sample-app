
import 'package:path_to_water/features/journal/controllers/journal_screen_controller.dart';

import '../../../utilities/app_exports.dart';

class JournalScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(JournalScreenController());
  }
}