import 'package:path_to_water/screens/favorite_screen/favorite_screen_controller.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/utilities/dummy_content.dart';
import 'package:path_to_water/widgets/custom_quran_info_dialog.dart';
import 'package:path_to_water/widgets/custom_tab_widget.dart';
import 'package:path_to_water/widgets/home_screen_card_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  FavoriteScreenController get controller => Get.put(FavoriteScreenController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          CustomTextFormField(
            controller: controller.searchController,
            upperLabel: "",
            upperLabelReqStar: "",
            hintValue: "Search",
            borderColor: AppColors.primary,
            outerPadding: EdgeInsets.zero,
            prefixIcon: CustomImageView(
              imagePath: AppConstants.searchIcon,
              height: 24.h,
              fit: BoxFit.contain,
            ),
          ),
          10.verticalSpace,
          Obx(() {
            return Container(
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
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onTap: (value) {
                  controller.currentTabIndex.value = value;
                },
              ),
            );
          }),
          10.verticalSpace,

          Expanded(
            child: ListView.separated(
              itemCount: 8,
              padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
              separatorBuilder: (context, index) {
                return 10.verticalSpace;
              },
              itemBuilder: (context, index) {
                return Obx(() {
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
                        isFavorite: true,
                        onFavoriteIconTap: () => controller.onFavoriteIconTap(),
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
                        isFavorite: true,
                        onFavoriteIconTap: () => controller.onFavoriteIconTap(),

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
                        isFavorite: true,
                        onFavoriteIconTap: () => controller.onFavoriteIconTap(),

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
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
