import 'package:get/get.dart';
import 'package:path_to_water/screens/subscription/controller/subscription_controller.dart';

class SubscriptionBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SubscriptionController());
  }
}