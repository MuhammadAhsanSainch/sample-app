import 'package:path_to_water/features/journal/controllers/journal_listing_controller.dart';

import '../../../utilities/app_exports.dart';

class JournalListingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(JournalListingController());
  }
}
