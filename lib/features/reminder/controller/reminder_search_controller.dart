import 'dart:async';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:path_to_water/api_core/custom_exception_handler.dart';
import 'package:path_to_water/api_services/reminder_service.dart';
import 'package:path_to_water/models/reminder_detail_model.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class ReminderSearchController extends GetxController {
  int currentPage = 0;
  bool isLastPage = false;
  late PagingController<int, ReminderDetails> pagingController;
  RxBool isReminderCreated = false.obs;
  bool showLoader = true;
  Timer? debounce;
  final TextEditingController searchController = TextEditingController();
  @override
  void onInit() {
    super.onInit();

    pagingController = PagingController(
      getNextPageKey: (state) => isLastPage ? null : currentPage + 1,
      fetchPage: (int pageKey) => getReminderApi(pageKey),
    );

    WidgetsBinding.instance.addPostFrameCallback((d) {
      pagingController.fetchNextPage();
    });
  }

  Future<List<ReminderDetails>> getReminderApi([int? pageNo]) async {
    try {
      if (showLoader) {
        AppGlobals.isLoading(true);
        showLoader = false;
      }
      final res = await ReminderService.getAllReminder({
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

  Future deleteReminderApi(String reminderId) async {
    try {
      await ReminderService.deleteReminder(reminderId);
      onRefresh();
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    }
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
