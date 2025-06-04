import 'package:path_to_water/screens/dashboard/dashboard_controller.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/utilities/dummy_content.dart';
import 'package:path_to_water/widgets/custom_image_view.dart';
import 'package:path_to_water/widgets/custom_quran_info_dialog.dart';
import 'package:path_to_water/widgets/home_screen_card_widget.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  DashboardController get controller => Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
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
              Obx(() {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.symmetric(vertical: 10),
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
                      _CustomTab(
                        imagePath: AppConstants.quranIcon,
                        title: "Quran",
                        isSelected: controller.currentTabIndex.value == 0,
                      ),
                      _CustomTab(
                        imagePath: AppConstants.hadithIcon,
                        title: "Hadith",
                        isSelected: controller.currentTabIndex.value == 1,
                      ),
                      _CustomTab(
                        imagePath: AppConstants.quranIcon,
                        title: "History",
                        isSelected: controller.currentTabIndex.value == 2,
                      ),
                    ],
                    isScrollable: false,
                    indicator: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    onTap: (value) {
                      controller.currentTabIndex.value = value;
                    },
                  ),
                );
              }),
            ],
          ),
          20.verticalSpace,
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              children: [
                Obx(() {
                  switch (controller.currentTabIndex.value) {
                    case 0:
                      return HomeScreenCardWidget(
                        icon: AppConstants.quranIcon,
                        dialogTitle: "Quran",
                        dialogTitleArabic: "القرآن",
                        titleArabic: "سورة الملك(٦٧ )",
                        title: DummyContent.quranAyatTitle,
                        arabicText: DummyContent.quranAyatArabic,
                        englishText: DummyContent.quranAyatEnglish,
                        detailText: DummyContent.quranDetailText,
                        onInfoTap:
                            () => showQuranInfoDialog(
                              context,

                              quranDialogTitle: "Quran",
                              quranDialogTitleArabic: "القرآن",
                              contentTitle: DummyContent.quranAyatTitle,
                              contentTitleArabic: "سورة الملك(٦٧ )",
                              englishContent: DummyContent.quranDialogDetail,
                              arabicContent: DummyContent.quranDialogDetailArabic,
                              date: DateTime.now(),
                            ),
                      );
                    case 1:
                      return HomeScreenCardWidget(
                        dialogTitle: "Hadith",
                        dialogTitleArabic: "الحديث",
                        titleArabic: "تجنب الشكوك",
                        icon: AppConstants.hadithIcon,
                        title: DummyContent.hadithTitle,
                        arabicText: DummyContent.hadithArabicText,
                        englishText: DummyContent.hadithEnglishText,
                        detailText: DummyContent.hadithDetailText,
                        onInfoTap:
                            () => showQuranInfoDialog(
                              context,

                              quranDialogTitle: "Hadith",
                              quranDialogTitleArabic: "الحديث",
                              contentTitle: DummyContent.hadithTitle,
                              contentTitleArabic: "تجنب الشكوك",
                              englishContent: DummyContent.quranDialogDetail,
                              arabicContent: DummyContent.quranDialogDetailArabic,
                              date: DateTime.now(),
                            ),
                      );
                    case 2:
                      return HomeScreenCardWidget(
                        dialogTitle: "History",
                        icon: AppConstants.historyIcon,
                        title: DummyContent.historyTitle,
                        maxLine: 7,
                        detailText: DummyContent.historyDetailText,
                        showSahihText: false,
                        onInfoTap:
                            () => showQuranInfoDialog(
                              context,
                              quranDialogTitle: "History",
                              quranDialogTitleArabic: "تاريخ",
                              contentTitle: DummyContent.historyTitle,
                              contentTitleArabic: "معاهدة الحديبية",
                              englishContent: DummyContent.historyDetailText,
                              arabicContent: DummyContent.quranDialogDetailArabic,
                              date: DateTime.now(),
                            ),
                      );
                    default:
                      return SizedBox.shrink();
                  }
                }),

                12.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: _HomeTileWidget(
                        label: "Daily Quiz",
                        svgIcon:
                            AppGlobals.isDarkMode.value
                                ? AppConstants.quizDarkIcon
                                : AppConstants.quizIcon,
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: _HomeTileWidget(
                        label: "Journal",
                        svgIcon:
                            AppGlobals.isDarkMode.value
                                ? AppConstants.journalDarkIcon
                                : AppConstants.journalIcon,
                      ),
                    ),
                  ],
                ),
                150.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
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

class _CustomTab extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String imagePath;
  const _CustomTab({required this.imagePath, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImageView(
              imagePath: imagePath,
              height: 24,
              color:
                  isSelected
                      ? AppColors.lightColor
                      : (AppGlobals.isDarkMode.value ? AppColors.lightColor : AppColors.grey),
            ),
            4.horizontalSpace,
            CustomText(
              title,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color:
                  isSelected
                      ? AppColors.lightColor
                      : (AppGlobals.isDarkMode.value ? AppColors.lightColor : AppColors.grey),
            ),
          ],
        ),
      ),
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
