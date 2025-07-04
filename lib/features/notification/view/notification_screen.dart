import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:path_to_water/features/notification/controller/notification_controller.dart';
import 'package:path_to_water/models/notification_model.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  NotificationController get controller => Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Notification", centerTitle: true, showBackIcon: true),
      backgroundColor: AppColors.scaffoldBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: RefreshIndicator(
          onRefresh: () async => controller.onRefresh(),
          child: Column(
            children: [
              CustomTextFormField(
                controller: controller.searchController,
                upperLabel: "",
                upperLabelReqStar: "",
                hintValue: "Search",
                borderColor: AppColors.primary,
                maxLines: 1,
                outerPadding: EdgeInsets.zero,
                onChanged: controller.onSearch,

                prefixIcon: CustomImageView(
                  imagePath: AppConstants.searchIcon,
                  height: 24.h,
                  fit: BoxFit.contain,
                ),
              ),
              10.verticalSpace,
              Expanded(
                child: PagingListener(
                  controller: controller.pagingController,
                  builder: (context, state, fetchNextPage) {
                    return PagedListView.separated(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      builderDelegate: PagedChildBuilderDelegate<NotificationModel>(
                        animateTransitions: true,
                        itemBuilder:
                            (context, item, index) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.dialogBgColor,
                                border: Border.all(
                                  color:
                                      AppGlobals.isDarkMode.value
                                          ? AppColors.strokeDarkGreyColor
                                          : AppColors.strokeColor,
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.all(12.r),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 4.r),
                                    padding: EdgeInsets.all(4.r),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: getStatusColor("Accepted"),
                                    ),
                                    child: Icon(
                                      getStatusIcon("Accepted"),
                                      color: AppColors.lightColor,
                                      size: 16.r,
                                    ),
                                  ),
                                  12.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                item.title,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        4.verticalSpace,
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                item.body,
                                                fontSize: 12.sp,
                                                maxLine: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        8.verticalSpace,
                                        CustomText(
                                          item.createdAt?.toLocal().toFormatDateTime(
                                            format: "hh:mm a, dd/MM/yyyy",
                                          ),
                                          fontSize: 10.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ),

                      separatorBuilder: (context, index) => 8.verticalSpace,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getStatusColor(String? status) {
    switch (status) {
      case "Accepted":
        return AppColors.success;
      case "Rejected":
        return AppColors.error;
      default:
        return AppColors.orangeColor;
    }
  }

  IconData getStatusIcon(String? status) {
    switch (status) {
      case "Accepted":
        return Icons.check;
      case "Rejected":
        return Icons.close;
      default:
        return Icons.info_outline;
    }
  }
}
