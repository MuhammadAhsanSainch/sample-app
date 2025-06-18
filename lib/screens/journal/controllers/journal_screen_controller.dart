import 'dart:async';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:path_to_water/api_core/custom_exception_handler.dart';
import 'package:path_to_water/api_services/journal_service.dart';
import 'package:path_to_water/models/journal_model.dart';
import 'package:path_to_water/screens/journal/models/journal_model.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class JournalScreenController extends GetxController {
  List<JournalModel> journalList = [];
  int currentPage = 0;
  bool isLastPage = false;
  late PagingController<int, JournalDetail> pagingController;
  RxBool isJournalCreated = false.obs;
  bool showLoader = true;
  DateTime dateTime = DateTime.now();
  Timer? debounce;
  final TextEditingController searchController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    pagingController = PagingController(
      getNextPageKey: (state) => isLastPage ? null : currentPage + 1,
      fetchPage: (int pageKey) => getJournalApi(pageKey),
    );
    pagingController.fetchNextPage();
  }

  Future<List<JournalDetail>> getJournalApi([int? pageNo]) async {
    try {
      if (showLoader) {
        AppGlobals.isLoading(true);
        showLoader = false;
      }
      final res = await JournalServices.getAllJournal({
        if (pageNo != null) "page": pageNo,
        "startDate": dateTime.toFormatDateTime(format: "yyyy-MM-dd"),
        "endDate": dateTime.toFormatDateTime(format: "yyyy-MM-dd"),
        if (searchController.text.isNotEmpty) "search": searchController.text,
      });
      isLastPage = res?.meta?.page == res?.meta?.totalPages;
      currentPage++;
      if (isJournalCreated.value == false && pageNo == 1) {
        isJournalCreated.value = res?.items.isNotEmpty ?? false;
      }
      return res?.items ?? [];
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } finally {
      AppGlobals.isLoading(false);
    }
    return [];
  }

  Future deleteJournalApi(String journalId, int index) async {
    try {
      await JournalServices.deleteJournal(journalId);
      onRefresh();
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    }
  }

  void onRefresh([DateTime? date]) {
    if (date != null) dateTime = date;
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
