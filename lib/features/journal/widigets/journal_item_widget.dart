import 'package:path_to_water/models/journal_model.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/widgets/custom_quran_info_dialog.dart';

class JournalEntryItem extends StatelessWidget {
  final JournalDetail entry;
  final bool isLast;
  final BuildContext context;
  final int index;
  final bool showLine;
  final bool showTime;
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;

  const JournalEntryItem({
    super.key,
    required this.entry,
    required this.isLast,
    required this.context,
    required this.index,
    required this.showLine,
    this.showTime = true,
    this.onDeleteTap,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: showTime,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: showLine ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: [
                if (showLine && index == 0)
                  8.verticalSpace
                else if (showLine && index != 0)
                  Container(
                    width: 1, // Line thickness
                    height: 8,
                    color: AppColors.primary, // Spacing around line
                  ),
                Container(
                  width: 60.w,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: CustomText(entry.time, color: Colors.white, fontSize: 11),
                ),
                if (showLine)
                  Expanded(
                    child: Container(
                      width: 1, // Line thickness
                      margin: isLast ? EdgeInsets.only(bottom: 16.h) : null,
                      color: AppColors.primary, // Spacing around line
                    ),
                  )
                else
                  12.verticalSpace,
              ],
            ),
          ),
          if (showTime) 22.horizontalSpace,
          // Content Card
          Expanded(
            child: GestureDetector(
              onTap: () {
                showQuranInfoDialog(
                  context,
                  quranDialogTitle: "Journal Entry",
                  contentTitle: entry.title,
                  englishContent: entry.description,
                  showLanguageSelectionButton: false,
                  date: entry.date,
                );
              },
              child: Card(
                elevation: 0,
                margin: EdgeInsets.only(bottom: 16, top: 2), // Card margin
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: AppColors.strokeColor),
                ),
                color: AppColors.dialogBgColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: CustomText(entry.title, fontWeight: FontWeight.w500)),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert, color: AppColors.primary),
                            onSelected: (value) {},
                            color:
                                AppGlobals.isDarkMode.value ? AppColors.grey700 : AppColors.grey100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              side: BorderSide(color: AppColors.greenStrokeColor),
                            ),
                            itemBuilder:
                                (BuildContext context) => <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    height: 30.h,
                                    value: 'edit',
                                    onTap: onEditTap,
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          svgPath: AppConstants.editSvgIcon,
                                          height: 14.h,
                                          color: AppColors.surface,
                                        ),
                                        SizedBox(width: 8),
                                        CustomText('Edit', fontSize: 12),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    height: 30.h,
                                    value: 'delete',
                                    onTap: onDeleteTap,
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          svgPath: AppConstants.trashSvgIcon,
                                          height: 14.h,
                                          color: Colors.redAccent,
                                        ),
                                        SizedBox(width: 8),
                                        CustomText('Delete', fontSize: 12),
                                      ],
                                    ),
                                  ),
                                ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: CustomText(entry.description, fontSize: 14, maxLine: 10),
                      ),
                      if (showTime == false)
                        Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: CustomText(
                            entry.date.toFormatDateTime(format: "dd MMM yyyy"),
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
