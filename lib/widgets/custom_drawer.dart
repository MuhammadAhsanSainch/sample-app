import '../screens/login/login_binding.dart';
import '../screens/login/login_view.dart';
import '../utilities/app_exports.dart';
import '../screens/home/home_controller.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  bool isDrawerOpen = true;
  bool hasActivePermission(String featureName) {
    final featurePermissions =
        UserPreferences.loginData['role']?['featurePermissions'];

    if (featurePermissions is List) {
      return featurePermissions.any((perm) =>
          perm['feature']?['name'] == featureName &&
          perm['feature']?['isActive'] == true);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: isDrawerOpen ? width * 0.24 : width * 0.05,
      child: Material(
        // Add Material for theming and other properties
        color: AppColors.primary, // Background color of the drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              // Add a container for the header
              padding: EdgeInsets.only(
                  top: 24.0 + MediaQuery.of(context).padding.top,
                  bottom: 20), // Adjust padding for status bar
              child: isDrawerOpen
                  ? InkWell(
                      onTap: () {
                        if (Get.context?.isTablet ?? true) {
                          setState(() {
                            isDrawerOpen = !isDrawerOpen;
                          });
                        }
                      },
                      child: Center(
                        child: Row(
                          spacing: 22,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                width: Get.context?.isTablet ?? true
                                    ? Get.width * 0.15
                                    : Get.width * 0.50,
                                child: SvgPicture.asset(
                                    AppConstants.appLogoWhite)),
                            SvgPicture.asset(AppConstants.menuModern),
                          ],
                        ),
                      ),
                    )
                  :

              IconButton(onPressed: (){ setState(() {
                isDrawerOpen = !isDrawerOpen;
              });}, icon: SvgPicture.asset(
                AppConstants.menuModern,
                colorFilter:
                ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),)



            ),
            _buildSideBarItem(
              index: 0,
              icon: AppConstants.home,
              title: 'Dashboard',
              onTap: () {
                if (Get.context?.isTablet ?? false) {
                  HomeController.to.tabletSelectedIndex.value = 0;
                } else {
                  Scaffold.of(context).closeDrawer();
                  HomeController.to.mobileSelectedIndex.value = 2;
                  HomeController.to.tabletSelectedIndex.value = 0;
                }
                HomeController.to.tabletScreenHeading.value = "Dashboard";
              },
            ),
            if (hasActivePermission("EMPLOYEE_MANAGEMENT"))
              _buildSideBarItem(
                index: 1,
                icon: AppConstants.employeeManagementIcon,
                title: 'Employee Management',
                onTap: () {
                  log('Employee Management Tapped: Current Index: 1');
                  if (Get.context?.isTablet ?? false) {
                    HomeController.to.tabletSelectedIndex.value = 1;
                  } else {
                    Scaffold.of(context).closeDrawer();
                    HomeController.to.mobileSelectedIndex.value = 3;
                    HomeController.to.tabletSelectedIndex.value = 1;
                  }
                  HomeController.to.tabletScreenHeading.value =
                      "User Management";
                },
              ),
            if (hasActivePermission("BRANCH_MANAGEMENT"))
              _buildSideBarItem(
                index: 2,
                icon: AppConstants.branchManagementIcon,
                title: 'Branch Management',
                onTap: () {
                  if (Get.context?.isTablet ?? false) {
                    HomeController.to.tabletSelectedIndex.value = 2;
                  } else {
                    Scaffold.of(context).closeDrawer();
                    // Get.to(() => BranchListingView());
                    HomeController.to.tabletSelectedIndex.value = 2;
                  }
                  HomeController.to.tabletScreenHeading.value =
                      "Branch Management";
                },
              ),
            // if (hasActivePermission("Product"))
              _buildSideBarItem(
                index: 3,
                icon: AppConstants.productSalesReportIcon,
                title: 'Product Sales Reports',
                onTap: () {
                  if (Get.context?.isTablet ?? false) {
                    HomeController.to.tabletSelectedIndex.value = 3;
                  } else {
                    Scaffold.of(context).closeDrawer();
                    HomeController.to.mobileSelectedIndex.value = 1;
                    HomeController.to.tabletSelectedIndex.value = 3;
                  }
                  HomeController.to.tabletScreenHeading.value =
                      "Product Sales Reports";
                },
              ),
            _buildSideBarItem(
              index: 4,
              icon: AppConstants.complaintTrackerIcon,
              title: 'Complain Tracker',
              onTap: () {
                if (Get.context?.isTablet ?? false) {
                  HomeController.to.tabletSelectedIndex.value = 4;
                } else {
                  Scaffold.of(context).closeDrawer();
                  // Get.to(() => ComplainTrackerView());
                  HomeController.to.tabletSelectedIndex.value = 4;
                }
                HomeController.to.tabletScreenHeading.value =
                    "Complaint Tracker";
              },
            ),
            _buildSideBarItem(
              index: 5,
              icon: AppConstants.adminNotificationIcon,
              title: 'Admin Notification',
              onTap: () {
                if (Get.context?.isTablet ?? false) {
                  HomeController.to.tabletSelectedIndex.value = 5;
                } else {
                  Scaffold.of(context).closeDrawer();
                  // Get.to(() => AdminNotificationView());
                  HomeController.to.tabletSelectedIndex.value = 5;
                }
                HomeController.to.tabletScreenHeading.value =
                    "Admin Notification";
              },
            ),

            _buildSideBarItem(
                index: 6,
                icon: AppConstants.logoutIcon,
                title: 'Logout',
                onTap: () {
                  UserPreferences.loginData = {};
                  UserPreferences.isLogin = false;
                  UserPreferences.authToken = '';
                  Get.off(() => LoginView(), binding: LoginBinding());
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildSideBarItem({
    required String icon,
    required String title,
    required int index,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: isDrawerOpen
            ? Obx(() => Row(
                  children: <Widget>[
                    SvgPicture.asset(icon,
                        colorFilter: ColorFilter.mode(
                            HomeController.to.tabletSelectedIndex.value == index
                                ? AppColors.secondary
                                : Colors.white,
                            BlendMode.srcIn)),
                    const SizedBox(width: 16.0),
                    Text(
                      title,
                      style: TextStyle(
                          color: HomeController.to.tabletSelectedIndex.value ==
                                  index
                              ? AppColors.secondary
                              : Colors.white,
                          fontSize: 16.0),
                    ),
                  ],
                ))
            : Obx(
                () => SvgPicture.asset(
                  icon,
                  colorFilter: ColorFilter.mode(
                      HomeController.to.tabletSelectedIndex.value == index
                          ? AppColors.secondary
                          : Colors.white,
                      BlendMode.srcIn),
                ),
              ),
      ),
    );
  }
}
