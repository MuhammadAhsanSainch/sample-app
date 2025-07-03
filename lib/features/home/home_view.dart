import 'package:flutter/cupertino.dart';
import 'package:path_to_water/features/home/home_controller.dart';
import 'package:path_to_water/features/journal/binding/create_journal_screen_binding.dart';
import 'package:path_to_water/features/journal/binding/journal_search_screen_binding.dart';
import 'package:path_to_water/features/journal/controllers/journal_screen_controller.dart';
import 'package:path_to_water/features/journal/views/create_journal_screen.dart';
import 'package:path_to_water/features/journal/views/journal_search_screen.dart';
import 'package:path_to_water/features/reminder/bindings/create_reminder_screen_binding.dart';
import 'package:path_to_water/features/reminder/bindings/reminder_search_screen_binding.dart';
import 'package:path_to_water/features/reminder/controller/reminder_screen_controller.dart';
import 'package:path_to_water/features/reminder/views/create_reminder_screen.dart';
import 'package:path_to_water/features/reminder/views/reminder_search_screen.dart';
import 'package:path_to_water/widgets/custom_advanced_drawer.dart';
import 'package:path_to_water/widgets/custom_will_pop_scope.dart';

import '../../utilities/app_exports.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  HomeController get controller => Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return CustomWillPopScope(
      onWillPop: false,
      action: () async {
        if (controller.drawerController.value.visible && controller.currentTabIndex.value != 0) {
          controller.drawerController.hideDrawer();
        } else if (controller.currentTabIndex.value != 0) {
          controller.currentTabIndex(0);
        }
      },

      child: CustomAdvancedDrawer(
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
                  if (!controller.isLogin) {
                    controller.showLoginDialog();
                    return;
                  }
                  controller.drawerController.showDrawer();
                },
                trailingWidget: Visibility(
                  visible:
                      (controller.currentTabIndex.value == 1 &&
                          controller.isReminderCreated.value) ||
                      (controller.currentTabIndex.value == 6 && controller.isJournalCreated.value),
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: IconButton(
                      onPressed: () {
                        if (controller.currentTabIndex.value == 1) {
                          Get.to(
                            () => ReminderSearchScreen(),
                            binding: ReminderScreenSearchBinding(),
                          )?.then((value) {
                            Get.put(ReminderScreenController()).onRefresh();
                          });
                        } else if (controller.currentTabIndex.value == 6) {
                          Get.to(
                            () => JournalSearchScreen(),
                            binding: JournalSearchScreenBinding(),
                          )?.then((value) {
                            Get.put(JournalScreenController()).onRefresh();
                          });
                        }
                      },
                      icon: CustomImageView(
                        imagePath: AppConstants.searchIcon,
                        height: 24.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              extendBodyBehindAppBar: controller.currentTabIndex.value == 0,
              extendBody: [0, 1, 6, 8].contains(controller.currentTabIndex.value),
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
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      // bottomLeft: Radius.circular(12),
                      // bottomRight: Radius.circular(12),
                    ),
                    color: AppColors.primary,
                  ),
                  child: SafeArea(
                    child: Obx(() {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.currentTabIndex.value = 0;
                              },
                              child: buildSvgIconWidget(
                                assetName:
                                    controller.currentTabIndex.value == 0
                                        ? AppConstants.homeFilled
                                        : AppConstants.homeOutlined,
                                label: "Home",
                                isSelected: controller.currentTabIndex.value == 0,
                              ),
                            ),
                          ),
                          4.horizontalSpace,
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (!controller.isLogin) {
                                  controller.showLoginDialog();
                                  return;
                                }
                                controller.currentTabIndex.value = 1;
                              },
                              child: buildSvgIconWidget(
                                assetName:
                                    controller.currentTabIndex.value == 1
                                        ? AppConstants.reminderFilled
                                        : AppConstants.reminderOutlined,
                                label: "Reminder",
                                isSelected: controller.currentTabIndex.value == 1,
                              ),
                            ),
                          ),
                          4.horizontalSpace,
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (!controller.isLogin) {
                                  controller.showLoginDialog();
                                  return;
                                }
                                controller.currentTabIndex.value = 2;
                              },
                              child: buildSvgIconWidget(
                                assetName:
                                    controller.currentTabIndex.value == 2
                                        ? AppConstants.calendarFilled
                                        : AppConstants.calendarOutlined,
                                label: "Calendar",
                                isSelected: controller.currentTabIndex.value == 2,
                              ),
                            ),
                          ),
                          4.horizontalSpace,
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (!controller.isLogin) {
                                  controller.showLoginDialog();
                                  return;
                                }
                                controller.currentTabIndex.value = 3;
                              },
                              child: buildSvgIconWidget(
                                assetName:
                                    controller.currentTabIndex.value == 3
                                        ? AppConstants.profileFilled
                                        : AppConstants.profileOutlined,
                                label: "Profile",
                                isSelected: controller.currentTabIndex.value == 3,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              floatingActionButton: Visibility(
                visible:
                    (controller.currentTabIndex.value == 1 && controller.isReminderCreated.value) ||
                    (controller.currentTabIndex.value == 6 && controller.isJournalCreated.value),
                child: FloatingActionButton(
                  onPressed: () {
                    if (controller.currentTabIndex.value == 1) {
                      Get.to(
                        () => CreateReminderScreen(),
                        binding: CreateReminderScreenBinding(),
                      )?.then((value) {
                        if (value == true) {
                          Get.put(ReminderScreenController()).onRefresh();
                        }
                      });
                    } else if (controller.currentTabIndex.value == 6) {
                      Get.to(
                        () => CreateJournalScreen(),
                        binding: CreateJournalScreenBinding(),
                      )?.then((value) {
                        if (value == true) {
                          Get.put(JournalScreenController()).onRefresh();
                        }
                      });
                    }
                  },
                  shape: CircleBorder(),
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildSvgIconWidget({
    required String assetName,
    required String label,
    bool isSelected = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        label == 'Profile'
            ? Icon(
              // isSelected
              //     ? CupertinoIcons.person_alt_circle_fill
              //     : CupertinoIcons.person_alt_circle,
              isSelected
                  ? CupertinoIcons.person_crop_circle_fill
                  : CupertinoIcons.person_crop_circle,
              size: 24,
              color: isSelected ? AppColors.lightColor : AppColors.lightColor.withAlpha(180),
            )
            : CustomImageView(
              svgPath: assetName,
              color: isSelected ? AppColors.lightColor : AppColors.lightColor.withAlpha(180),
            ),
        4.verticalSpace,
        CustomText(
          label,
          color: isSelected ? AppColors.lightColor : AppColors.lightColor.withAlpha(180),
        ),
      ],
    );
  }
}
