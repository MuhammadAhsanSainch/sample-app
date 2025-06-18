import 'package:path_to_water/screens/dashboard/dashboard_controller.dart';
import 'package:path_to_water/screens/home/home_controller.dart';
import 'package:path_to_water/screens/quiz/quiz_binding.dart';
import 'package:path_to_water/screens/quiz/views/daily_quiz_view.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/widgets/custom_quran_info_dialog.dart';
import 'package:path_to_water/widgets/custom_tab_widget.dart';
import 'package:path_to_water/widgets/home_screen_card_widget.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  DashboardController get controller => Get.put(DashboardController());
  HomeController get homeController => Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Obx(() {
      return CustomLoader(
        isTrue: AppGlobals.isLoading.value,
        child: Padding(
          padding: EdgeInsets.only(top: kMinInteractiveDimension),
          child: Column(
            children: [
              Stack(
                // alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  CustomImageView(
                    imagePath:
                        AppGlobals.isDarkMode.value
                            ? AppConstants.homeBgDarImage
                            : AppConstants.homeBgImage,
                    height: 200.h,
                    width: size.width,
                    fit: BoxFit.fitWidth,
                  ),
                  Positioned(
                    bottom: -10.h,
                    left: 0,
                    child: Obx(() {
                      return SizedBox(
                        width: size.width,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: AppColors.scaffoldBackground,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.primary, width: 1),
                          ),
                          child: TabBar(
                            controller: controller.tabController,
                            dividerColor: Colors.transparent,
                            labelPadding: EdgeInsets.zero,
                            tabs: [
                              CustomTab(
                                imagePath: AppConstants.quranIcon,
                                title: "Quran",
                                isSelected: controller.currentTabIndex.value == 0,
                              ),
                              CustomTab(
                                imagePath: AppConstants.hadithIcon,
                                title: "Hadith",
                                isSelected: controller.currentTabIndex.value == 1,
                              ),
                              CustomTab(
                                imagePath: AppConstants.quranIcon,
                                title: "History",
                                isSelected: controller.currentTabIndex.value == 2,
                              ),
                            ],
                            isScrollable: false,
                            indicator: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            onTap: (value) {
                              controller.currentTabIndex.value = value;
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              30.verticalSpace,
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => controller.onRefresh(),
                  child: ListView(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    children: [
                      Obx(() {
                        switch (controller.currentTabIndex.value) {
                          case 0:
                            return GetBuilder(
                              init: controller,
                              id: "quranAyat",
                              builder: (_) {
                                return HomeScreenCardWidget(
                                  icon: AppConstants.quranIcon,
                                  dialogTitle: "Quran",
                                  dialogTitleArabic: "القرآن",
                                  titleArabic: "سورة الملك(٦٧ )",
                                  title: controller.quranAyatRes?.surahName ?? "-",
                                  arabicText: controller.quranAyatRes?.textArabic ?? "-",
                                  englishText: controller.quranAyatRes?.textRoman ?? "-",
                                  detailText: controller.quranAyatRes?.textEnglish ?? "-",
                                  centerTitle: true,
                                  ayatNumber: controller.quranAyatRes?.ayahNumber,
                                  isFavorite: controller.quranAyatRes?.isFavorite ?? false,
                                  onFavoriteIconTap: () {
                                    if (!homeController.isLogin) {
                                      homeController.showLoginDialog();
                                      return;
                                    }
                                    if (controller.quranAyatRes?.isFavorite ?? false) {
                                      controller.removeFromFavorite(controller.quranAyatRes?.id);
                                    } else {
                                      controller.addToFavorite(controller.quranAyatRes?.id);
                                    }
                                  },
                                  onInfoTap:
                                      () => showQuranInfoDialog(
                                        context,

                                        quranDialogTitle: "Quran",
                                        quranDialogTitleArabic: "القرآن",
                                        contentTitle: controller.quranAyatRes?.surahName ?? "-",
                                        contentTitleArabic: "سورة الملك(٦٧ )",
                                        englishContent:
                                            controller.quranAyatRes?.detailEnglishPopup ?? "-",
                                        arabicContent:
                                            controller.quranAyatRes?.detailArabicPopup ?? "-",
                                        date: controller.quranAyatRes?.publishDate ?? DateTime.now(),
                                      ),
                                );
                              },
                            );
                          case 1:
                            return GetBuilder(
                              init: controller,
                              id: "hadith",
                              builder: (_) {
                                return HomeScreenCardWidget(
                                  dialogTitle: "Hadith",
                                  dialogTitleArabic: "الحديث",
                                  titleArabic: "تجنب الشكوك",
                                  icon: AppConstants.hadithIcon,
                                  title: controller.hadithRes?.title ?? "-",
                                  arabicText: controller.hadithRes?.arabicText ?? "-",
                                  englishText: controller.hadithRes?.englishTranslation ?? "-",
                                  detailText: controller.hadithRes?.sahihReference ?? "-",
                                  isFavorite: controller.hadithRes?.isFavorite ?? false,
                                  centerTitle: true,
                                  dateTime: controller.hadithRes?.publishDate ?? DateTime.now(),
                                  onFavoriteIconTap: () {
                                    if (!homeController.isLogin) {
                                      homeController.showLoginDialog();
                                      return;
                                    }
                                    if (controller.hadithRes?.isFavorite ?? false) {
                                      controller.removeFromFavorite(controller.hadithRes?.id);
                                    } else {
                                      controller.addToFavorite(controller.hadithRes?.id);
                                    }
                                  },
                                  onInfoTap:
                                      () => showQuranInfoDialog(
                                        context,
                                        quranDialogTitle: "Hadith",
                                        quranDialogTitleArabic: "الحديث",
                                        contentTitle: controller.hadithRes?.title ?? "-",
                                        contentTitleArabic: "تجنب الشكوك",
                                        englishContent: controller.hadithRes?.explanation ?? "-",
                                        date: controller.hadithRes?.updatedAt ?? DateTime.now(),
                                        showLanguageSelectionButton: false,
                                      ),
                                );
                              },
                            );
                          case 2:
                            return GetBuilder(
                              init: controller,
                              id: "history",
                              builder: (_) {
                                return HomeScreenCardWidget(
                                  dialogTitle: "History",
                                  icon: AppConstants.historyIcon,
                                  title: controller.historyRes?.title ?? "-",
                                  maxLine: 7,
                                  detailText: controller.historyRes?.detail ?? "-",
                                  isFavorite: controller.historyRes?.isFavorite ?? false,
                                  showSahihText: false,
                                  centerTitle: true,
                                  dateTime: controller.hadithRes?.publishDate ?? DateTime.now(),

                                  onFavoriteIconTap: () {
                                    if (!homeController.isLogin) {
                                      homeController.showLoginDialog();
                                      return;
                                    }
                                    if (controller.historyRes?.isFavorite ?? false) {
                                      controller.removeFromFavorite(controller.historyRes?.id);
                                    } else {
                                      controller.addToFavorite(controller.historyRes?.id);
                                    }
                                  },
                                  onInfoTap:
                                      () => showQuranInfoDialog(
                                        context,
                                        quranDialogTitle: "History",
                                        quranDialogTitleArabic: "تاريخ",
                                        contentTitle: controller.historyRes?.title ?? "-",
                                        englishContent: controller.historyRes?.detail ?? "-",
                                        date: controller.historyRes?.updatedAt ?? DateTime.now(),
                                        showLanguageSelectionButton: false,
                                      ),
                                );
                              },
                            );
                          default:
                            return SizedBox.shrink();
                        }
                      }),

                      12.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (!homeController.isLogin) {
                                  homeController.showLoginDialog();
                                  return;
                                }
                                Get.to(DailyQuizView(), binding: QuizBinding());
                              },
                              child: _HomeTileWidget(
                                label: "Daily Quiz",
                                svgIcon:
                                    AppGlobals.isDarkMode.value
                                        ? AppConstants.quizDarkIcon
                                        : AppConstants.quizIcon,
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (!homeController.isLogin) {
                                  homeController.showLoginDialog();
                                  return;
                                }
                                Get.put(HomeController()).currentTabIndex.value = 6; // Journal
                              },
                              child: _HomeTileWidget(
                                label: "Journal",
                                svgIcon:
                                    AppGlobals.isDarkMode.value
                                        ? AppConstants.journalDarkIcon
                                        : AppConstants.journalIcon,
                              ),
                            ),
                          ),
                        ],
                      ),
                      150.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  onInfoTap(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog();
      },
    );
  }
}

class _HomeTileWidget extends StatelessWidget {
  final String label;
  final String svgIcon;
  const _HomeTileWidget({required this.label, required this.svgIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.homeScreenCardBgColor,
        border: Border.all(color: AppColors.strokeColor),
        image: DecorationImage(
          image: AssetImage(
            AppGlobals.isDarkMode.value
                ? AppConstants.homeTileBgDarkImage
                : AppConstants.homeTileBgImage,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.verticalSpace,

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomText(label, color: AppColors.lightColor),
          ),
          20.verticalSpace,
          CustomImageView(svgPath: svgIcon, height: 56.h),
          10.verticalSpace,
        ],
      ),
    );
  }
}
