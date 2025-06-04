import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/widgets/custom_dialog.dart';

class FavoriteScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt currentTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  final TextEditingController searchController = TextEditingController();

  void onFavoriteIconTap() {
    Get.dialog(
      CustomDialog(
        message: "Removing this item will no longer show it in your Favorites list.",
        imageIcon: AppConstants.trashIcon,
        title: "Removed from favorites?",
        btnText: "Remove",
        onButtonTap: () {},
      ),
    );
  }
}
