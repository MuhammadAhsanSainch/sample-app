import '../settings_controller.dart';
import 'package:flutter/cupertino.dart';
import '../../../widgets/custom_switch_widget.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  SettingsController get controller => Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          20.verticalSpace,
          Divider(color: AppColors.dividerColor, thickness: 2.5),
          ListTile(
            leading: SvgPicture.asset(AppConstants.lock),
            contentPadding: EdgeInsets.zero,
            title: CustomText('Change Password', style: AppTextTheme.bodyLarge),
            trailing: Icon(CupertinoIcons.chevron_right,color: AppColors.primary,),
          ),
          Divider(color: AppColors.dividerColor, thickness: 2.5),
          ListTile(
            leading: SvgPicture.asset(AppConstants.notification),
            contentPadding: EdgeInsets.zero,
            title: CustomText('Notifications Preferences', style: AppTextTheme.bodyLarge),
            trailing: Obx(() {
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
          ),
          Divider(color: AppColors.dividerColor, thickness: 2.5),
          ListTile(
            leading: SvgPicture.asset(AppConstants.deleteAccount),
            contentPadding: EdgeInsets.zero,
            title: CustomText('Delete Account', style: AppTextTheme.bodyLarge.copyWith(color: AppColors.error)),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}
