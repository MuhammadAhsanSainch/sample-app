import '../../utilities/app_exports.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController.to,
        builder: (controller) => (Get.context?.isTablet ?? false)
            ? buildTabletView(context, controller)
            : buildMobileView(context, controller));
  }

  Widget buildTabletView(context, HomeController controller) {
    return Scaffold(
      body: Row(
        children: [
          NavigationDrawerWidget(),
          Expanded(
              child: Column(
            children: [
              Obx(() => TabletAppBar(
                    title: controller.tabletScreenHeading.value,
                  )),
              Obx(() => Expanded(
                    child: controller.tabletPages.elementAt(
                      controller.tabletSelectedIndex.value,
                    ),
                  )),
            ],
          ))
        ],
      ),
    );
  }

  Widget buildMobileView(context, HomeController controller) {
    return Scaffold(
      body: Obx(
          () => controller.mobilePages[controller.mobileSelectedIndex.value]),
      bottomNavigationBar: Obx(() => CustomBottomBar(
            selectedIndex: controller.mobileSelectedIndex.value,
            onTap: controller.updateIndex,
          )),
    );
  }
}
