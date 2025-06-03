import 'package:flutter/cupertino.dart';

import '../utilities/app_exports.dart';
import 'custom_network_image.dart';

/// A utility class for common AppBar widgets and styling.
class _AppBarUtils {
  /// Builds a circular icon container with a border and padding.
  static Widget buildCircularIcon(
    Widget icon, {
    Color backgroundColor = Colors.white,
    Color borderColor = Colors.black,
  }) {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: icon,
      ),
    );
  }

  static String getUserName() {
    return '${UserPreferences.loginData['firstName']} ${UserPreferences.loginData['middleName']} ${UserPreferences.loginData['lastName']}';
  }

  static String getProfilePic() {
    return '${UserPreferences.loginData['profileImg']}';
  }
}

/// AppBar for tablet layouts.
class TabletAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TabletAppBar({
    super.key,
    required this.title,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: CustomText(
        title,
        style: AppTextTheme.bodyLarge,
        fontSize: 0.25, // Use a constant for font size
      ),
      toolbarHeight: 75,
      actions: [
        Row(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          // Use min to prevent excessive spacing
          children: [
            InkWell(
              onTap: () {
                // NotificationsController.to.updateNotifications();
                // Get.to(() => NotificationsView(), binding: NotificationsBinding());
              },
              child: _AppBarUtils.buildCircularIcon(
                  SvgPicture.asset(AppConstants.mail),
                  backgroundColor: AppColors.primary,
                  borderColor: AppColors.secondary
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  CustomProfileImage(imageUrl: _AppBarUtils.getProfilePic()),
                  const SizedBox(width: 5),
                  CustomText(
                    _AppBarUtils.getUserName(),
                    style: AppTextTheme.bodyLarge,
                    fontSize: 0.35,
                  ),
                  const Icon(CupertinoIcons.chevron_down, color: Colors.black),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// AppBar configurations for mobile layouts.
class MobileAppBar {
  /// Placeholder AppBar for cases where no AppBar is needed.
  static AppBar placeholder() {
    return AppBar(
      toolbarHeight: 0,
    );
  }

  /// Main AppBar for mobile, with a menu icon and notifications/profile actions.
  static AppBar mainAppBar(String title) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Container(
              margin: const EdgeInsets.only(left: 6),
              child: _AppBarUtils.buildCircularIcon(
                SvgPicture.asset(AppConstants.mail),
                backgroundColor:
                    const Color(0xffF3F4F6), // Specific color for mobile
              ),
            ),
          );
        },
      ),
      titleSpacing: 3,
      title: CustomText(
        title,
        fontSize: 0.8, // Use consistent font sizing
        style: AppTextTheme.bodyLarge,
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            // NotificationsController.to.updateNotifications();
            // Get.to(() => NotificationsView(), binding: NotificationsBinding());
          },
          child: _AppBarUtils.buildCircularIcon(
              SvgPicture.asset(AppConstants.mail),
              backgroundColor: AppColors.primary,
              borderColor: AppColors.secondary
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            // Get.to(() => ProfileView(), binding: ProfileBinding());
          },
          child: CustomProfileImage(imageUrl: _AppBarUtils.getProfilePic()),
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  /// AppBar with a back button, suitable for detail screens.
  static AppBar backAppBar(String title) {
    // Determine if it's a tablet for responsive design
    final isTablet = Get.context?.isTablet ?? false;

    return AppBar(
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.only(left: 6),
              child: _AppBarUtils.buildCircularIcon(
                const Icon(Icons.arrow_back),
              ),
            ),
          );
        },
      ),
      titleSpacing: 3,
      title: CustomText(
        title,
        fontSize: isTablet ? 0.25 : 0.8, // Consistent font sizing
        style: isTablet
            ? AppTextTheme.bodyLarge
            : AppTextTheme.bodyLarge
      ),
      actions: isTablet
          ? [
              Row(
                spacing: 5,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      // NotificationsController.to.updateNotifications();
                      // Get.to(() => NotificationsView(), binding: NotificationsBinding());
                    },
                    child: _AppBarUtils.buildCircularIcon(
                        SvgPicture.asset(AppConstants.mail),
                        backgroundColor: AppColors.primary,
                        borderColor: AppColors.secondary
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        CustomProfileImage(imageUrl: _AppBarUtils.getProfilePic()),
                        const SizedBox(width: 5),
                        CustomText(
                          _AppBarUtils.getUserName(),
                          style: AppTextTheme.bodyLarge,
                          fontSize: 0.40,
                        ),
                        const Icon(CupertinoIcons.chevron_down,
                            color: Colors.black),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ]
          : [
              InkWell(
                onTap: () {
                  // NotificationsController.to.updateNotifications();
                  // Get.to(() => NotificationsView(), binding: NotificationsBinding());
                },
                child: _AppBarUtils.buildCircularIcon(
                    SvgPicture.asset(AppConstants.mail),
                    backgroundColor: AppColors.primary,
                    borderColor: AppColors.secondary),
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {
                  // Get.to(() => ProfileView(), binding: ProfileBinding());
                },
                child: CustomProfileImage(imageUrl: _AppBarUtils.getProfilePic()),
              ),
              const SizedBox(width: 12),
            ],
    );
  }
}
