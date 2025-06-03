import '../../utilities/app_exports.dart';
class HomeController extends GetxController {
  var mobileSelectedIndex = 2.obs;
  var tabletSelectedIndex = 0.obs;
  var tabletScreenHeading='Dashboard'.obs;

  void updateIndex(int index) => mobileSelectedIndex.value = index;


  static HomeController get to {
    try {
      return Get.find<HomeController>();
    } catch (e) {
      return Get.put(HomeController());
    }
  }

  var mobilePages = <Widget>[
    Center(child: Text("Home")),
    Center(child: Text("Reminder")),
    Center(child: Text("Calendar")),
    Center(child: Text("Profile")),
  ].obs;


  var tabletPages = <Widget>[
    Center(child: Text("Home")),
    Center(child: Text("Reminder")),
    Center(child: Text("Calendar")),
    Center(child: Text("Profile")),
  ].obs;
}