import 'package:path_to_water/screens/home/home_controller.dart';
import 'package:path_to_water/utilities/app_helper.dart';
import 'package:path_to_water/widgets/custom_advanced_drawer.dart';
import 'package:path_to_water/widgets/custom_image_view.dart';

import '../../utilities/app_exports.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  HomeController get controller => Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return CustomAdvancedDrawer(
      controller: controller.drawerController,
      homeController: controller,
      child: GetX(
        init: controller,
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              text: controller.pageTitle[controller.currentTabIndex.value],
              showMenuIcon: true,
              centerTitle: true,
              bgColor: Colors.transparent,
              onMenuPressed: () {
                controller.drawerController.showDrawer();
              },
            ),
            extendBodyBehindAppBar: controller.currentTabIndex.value == 0,
            extendBody: controller.currentTabIndex.value == 0,
            backgroundColor: AppColors.scaffoldBackground,
            body: SizedBox(
              height: size.height,
              width: size.width,

              child: controller.pages[controller.currentTabIndex.value],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                child: BottomAppBar(
                  height: Helper.getNormDim(95.h, 85.h),
                  clipBehavior: Clip.antiAlias,
                  shape: CircularNotchedRectangle(),
                  color: AppColors.primary,
                  surfaceTintColor: AppColors.primary,
                  child: Obx(() {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.currentTabIndex.value = 0;
                          },
                          child: buildSvgIconWidget(
                            assetName: AppConstants.homeIcon,
                            label: "Home",
                            isSelected: controller.currentTabIndex.value == 0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.currentTabIndex.value = 1;
                          },
                          child: buildSvgIconWidget(
                            assetName: AppConstants.calendarIcon,
                            label: "Reminder",
                            isSelected: controller.currentTabIndex.value == 1,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.currentTabIndex.value = 2;
                          },
                          child: buildSvgIconWidget(
                            assetName: AppConstants.clockIcon,
                            label: "Calendar",
                            isSelected: controller.currentTabIndex.value == 2,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // UserPreferences.isLogin
                            //     ? controller.currentTabIndex.value = 3
                            //     : controller.showLoginDialog();
                            controller.currentTabIndex.value=3;
                          },
                          child: buildSvgIconWidget(
                            assetName: AppConstants.profileIcon,

                            label: "Profile",
                            isSelected: controller.currentTabIndex.value == 3,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSvgIconWidget({
    required String assetName,
    required String label,

    bool isSelected = false,
  }) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.lightColor : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: assetName,
                height: 22,
                width: 22,
                color: isSelected ? AppColors.primary : AppColors.lightColor,
              ),
              4.verticalSpace,
              CustomText(
                label,
                color: isSelected ? AppColors.primary : AppColors.lightColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
