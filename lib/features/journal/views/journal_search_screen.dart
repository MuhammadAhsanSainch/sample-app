import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:path_to_water/features/journal/binding/create_journal_screen_binding.dart';
import 'package:path_to_water/features/journal/controllers/journal_search_screen_controller.dart';
import 'package:path_to_water/features/journal/views/create_journal_screen.dart';
import 'package:path_to_water/features/journal/widigets/journal_item_widget.dart';
import 'package:path_to_water/models/journal_model.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/widgets/custom_dialog.dart';

class JournalSearchScreen extends StatelessWidget {
  JournalSearchScreen({super.key});
  final JournalSearchScreenController controller = Get.put(JournalSearchScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Journal", centerTitle: true, showBackIcon: true),
      backgroundColor: AppColors.scaffoldBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            CustomTextFormField(
              controller: controller.searchController,
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
              onChanged: controller.onSearch,
            ),

            10.verticalSpace,
            Expanded(
              child: PagingListener(
                controller: controller.pagingController,
                builder: (context, state, fetchNextPage) {
                  return PagedListView.separated(
                    state: state,
                    fetchNextPage: fetchNextPage,
                    builderDelegate: PagedChildBuilderDelegate<JournalDetail>(
                      animateTransitions: true,
                      itemBuilder:
                          (context, item, index) => JournalEntryItem(
                            entry: item,
                            isLast: index == (state.items?.length ?? 0) - 1,
                            context: context,
                            index: index,
                            showLine: (state.items?.length ?? 0) > 1,
                            showTime: false,
                            onEditTap: () {
                              Get.to(
                                CreateJournalScreen(journal: item),
                                binding: CreateJournalScreenBinding(),
                              )?.then((value) {
                                if (value == true) {
                                  controller.onRefresh();
                                }
                              });
                            },
                            onDeleteTap: () {
                              Get.dialog(
                                CustomDialog(
                                  message: "Are you sure you want to delete?",
                                  imageIcon: AppConstants.trashIcon,
                                  title: "Delete Journal Entry",
                                  btnText: "Delete",
                                  onButtonTap: () {
                                    controller.deleteJournalApi(item.id ?? "", index);
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
