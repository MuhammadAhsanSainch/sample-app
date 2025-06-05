import 'package:path_to_water/screens/journal/binding/create_journal_screen_binding.dart';
import 'package:path_to_water/screens/journal/controllers/journal_screen_controller.dart';
import 'package:path_to_water/screens/journal/views/create_journal_screen.dart';
import 'package:path_to_water/screens/journal/views/journal_listing_screen.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  JournalScreenController get controller => Get.put(JournalScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Visibility(
          // visible: controller.journalList.isNotEmpty,
          replacement: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 60.h),
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground,
              image: DecorationImage(
                image: AssetImage(
                  AppGlobals.isDarkMode.value
                      ? AppConstants.journalBgDarkImage
                      : AppConstants.journalBgImage,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                  CustomImageView(imagePath: AppConstants.journalBookIconTwo, height: 100.h),
                  24.verticalSpace,
                  CustomText(
                    'Lorem ipsum dolor sit amet consectetur. Egestas arcu tincidunt',
                    fontSize: 16.sp,
                    maxLine: 3,
                    textAlign: TextAlign.center,
                  ),
                  24.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: CustomRectangleButton(
                          text: "Add Now",
                          iconWidget: Icon(Icons.add, color: AppColors.lightColor, size: 18.h),
                          iconAlignment: IconAlignment.end,
                          onTap: () {
                            Get.to(
                              () => CreateJournalScreen(),
                              binding: CreateJournalScreenBinding(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          child: JournalListingScreen(),
        );
      },
    );
  }
}
