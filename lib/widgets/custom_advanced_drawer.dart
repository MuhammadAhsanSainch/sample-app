import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/widgets/custom_image_view.dart';
import 'package:path_to_water/widgets/custom_switch_widget.dart';

class CustomAdvancedDrawer extends StatelessWidget {
  final Widget child;
  final AdvancedDrawerController controller;
  const CustomAdvancedDrawer({super.key, required this.child, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      drawer: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(imagePath: AppConstants.logo, height: 60.h),
              40.verticalSpace,
              _DrawerItem(
                label: "Home",
                pngIcon: AppConstants.homeIcon,
                onTap: () => controller.hideDrawer(),
              ),
              _DrawerItem(label: "Today Quiz", pngIcon: AppConstants.quizDrawerIcon),
              _DrawerItem(label: "Quiz History", pngIcon: AppConstants.calendarIcon),
              _DrawerItem(label: "Journal", pngIcon: AppConstants.journalDrawerIcon),
              _DrawerItem(label: "Notification", pngIcon: AppConstants.notificationIcon),
              _DrawerItem(label: "Subscription", pngIcon: AppConstants.subscriptionIcon),
              _DrawerItem(label: "Dark Mode", pngIcon: AppConstants.themeIcon,showSwitch: true),
              _DrawerItem(label: "Favorites", pngIcon: AppConstants.favoriteIcon),
              _DrawerItem(label: "Settings", pngIcon: AppConstants.settingIcon),
              _DrawerItem(label: "Sign Out", pngIcon: AppConstants.logoutIcon),
            ],
          ),
        ),
      ),
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: AppColors.drawerBgColor),
      ),
      controller: controller,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: true,
      childDecoration: BoxDecoration(
        border: Border.all(color: AppColors.lightColor.withAlpha(AppGlobals.isDarkMode.value? 40 : 120), width: 10),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
      child: Container(
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(32))),
        clipBehavior: Clip.hardEdge,

        child: child,
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  final String pngIcon;
  final void Function()? onTap;
  final bool showSwitch;
  const _DrawerItem({
    required this.label,
    required this.pngIcon,
    this.onTap,
    this.showSwitch = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImageView(imagePath: pngIcon, height: 24.h, color: AppColors.lightColor),
                12.horizontalSpace,
                CustomText(label, fontSize: 16, color: AppColors.lightColor),
                if (showSwitch) ...[
                  Spacer(),
                  Obx(() {
                    return CustomSwitchWidget(
                      value: AppGlobals.isDarkMode.value,
                      onChanged: (value) {
                        AppGlobals.isDarkMode.toggle();
                        Get.changeThemeMode(
                          AppGlobals.isDarkMode.value ? ThemeMode.light : ThemeMode.dark,
                        );
                        Get.forceAppUpdate();
                      },
                    );
                  }),
                ],
              ],
            ),
            3.verticalSpace,
            Divider(
              color:
                  AppGlobals.isDarkMode.value
                      ? AppColors.strokeDarkGreyColor
                      : AppColors.greenStrokeColor,
            ),
          ],
        ),
      ),
    );
  }
}
