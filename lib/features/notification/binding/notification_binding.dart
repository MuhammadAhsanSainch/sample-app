import 'package:get/get.dart';
import 'package:path_to_water/features/notification/controller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
  }
}
