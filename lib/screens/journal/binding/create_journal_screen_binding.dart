import 'package:path_to_water/screens/journal/controllers/create_journal_screen_controller.dart';

import '../../../utilities/app_exports.dart';

class CreateJournalScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateJournalScreenController());
  }
}
