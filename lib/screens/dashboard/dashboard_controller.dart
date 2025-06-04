import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt currentTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }
}
