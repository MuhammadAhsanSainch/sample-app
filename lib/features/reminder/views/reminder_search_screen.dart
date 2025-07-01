import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:path_to_water/features/reminder/bindings/create_reminder_screen_binding.dart';
import 'package:path_to_water/features/reminder/controller/reminder_search_controller.dart';
import 'package:path_to_water/features/reminder/views/create_reminder_screen.dart';
import 'package:path_to_water/features/reminder/widgets/reminder_item_widget.dart';
import 'package:path_to_water/models/reminder_detail_model.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/widgets/custom_dialog.dart';

class ReminderSearchScreen extends StatelessWidget {
  ReminderSearchScreen({super.key});
  final ReminderSearchController reminderScreenController = Get.put<ReminderSearchController>(
    ReminderSearchController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Reminder", centerTitle: true, showBackIcon: true),
      backgroundColor: AppColors.scaffoldBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            CustomTextFormField(
              controller: reminderScreenController.searchController,
              upperLabel: "",
              upperLabelReqStar: "",
              hintValue: "Search",
              maxLines: 1,
              borderColor: AppColors.primary,
              outerPadding: EdgeInsets.zero,
              prefixIcon: CustomImageView(
                imagePath: AppConstants.searchIcon,
                height: 24.h,
                fit: BoxFit.contain,
              ),
              onChanged: reminderScreenController.onSearch,
            ),
            10.verticalSpace,
            Expanded(
              child: PagingListener(
                controller: reminderScreenController.pagingController,
                builder: (context, state, fetchNextPage) {
                  return PagedListView.separated(
                    state: state,
                    fetchNextPage: fetchNextPage,
                    builderDelegate: PagedChildBuilderDelegate<ReminderDetails>(
                      animateTransitions: true,
                      itemBuilder:
                          (context, item, index) => ReminderEntryItem(
                            entry: item,
                            isLast: index == (state.items?.length ?? 0) - 1,
                            index: index,
                            showLine: (state.items?.length ?? 0) > 1,
                            showTime: false,
                            onEditTap: () {
                              Get.to(
                                () => CreateReminderScreen(reminderDetails: item),
                                binding: CreateReminderScreenBinding(),
                              )?.then((value) {
                                if (value == true) {
                                  reminderScreenController.onRefresh();
                                }
                              });
                            },
                            onDeleteTap: () {
                              Get.dialog(
                                CustomDialog(
                                  message: "Are you sure you want to delete this reminder?",
                                  imageIcon: AppConstants.trashIcon,
                                  title: "Delete Reminder",
                                  btnText: "Delete",
                                  onButtonTap: () {
                                    reminderScreenController.deleteReminderApi(item.id ?? "");
                                    Get.back();
                                  },
                                ),
                              );
                            },
                          ),
                    ),

                    separatorBuilder: (context, index) => SizedBox.shrink(),
                  );
                },
              ),
              // DummyContent.allEntries.isEmpty
              //     ? Center(
              //       child: Text(
              //         'No entries for this date.',
              //         style: TextStyle(color: Colors.grey[600]),
              //       ),
              //     )
              //     : _buildEntriesList(DummyContent.allEntries, context),
            ),
          ],
        ),
      ),
    );
  }
}
