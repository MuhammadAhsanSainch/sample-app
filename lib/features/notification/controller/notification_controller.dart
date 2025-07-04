import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:path_to_water/api_core/custom_exception_handler.dart';
import 'package:path_to_water/api_services/notification_api_service.dart';
import 'package:path_to_water/models/notification_model.dart';
import 'package:path_to_water/utilities/app_globals.dart';

class NotificationController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  int currentPage = 0;
  bool isLastPage = false;
  Timer? debounce;

  late PagingController<int, NotificationModel> pagingController;
  @override
  void onInit() {
    super.onInit();
    pagingController = PagingController(
      getNextPageKey: (state) => isLastPage ? null : currentPage + 1,
      fetchPage: (int pageKey) => getNotificationApi(pageKey),
    );
    pagingController.fetchNextPage();
  }

  Future<List<NotificationModel>> getNotificationApi([int? pageNo]) async {
    try {
      final res = await NotificationApiService.getAllNotifications({
        if (pageNo != null) "page": pageNo,
        if (searchController.text.isNotEmpty) "search": searchController.text,
      });
      isLastPage = (res?.data.length ?? 0) < (res?.limit ?? 0);
      currentPage++;

      return res?.data ?? [];
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } finally {
      AppGlobals.isLoading(false);
    }
    return [];
  }

  void onRefresh() {
    pagingController.refresh();
    currentPage = 0;
    isLastPage = false;
    pagingController.fetchNextPage();
  }

  onSearch(String? value) {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 300), () {
      onRefresh();
    });
  }
}
