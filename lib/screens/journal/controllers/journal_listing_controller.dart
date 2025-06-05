import 'package:hijri/hijri_calendar.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class JournalListingController extends GetxController with GetSingleTickerProviderStateMixin {
  DateTime focusedMonth = DateTime.now(); // For month/year display
  DateTime selectedDate = DateTime.now(); // For month/year display
  String get focusedHijriMonthText =>
      "${HijriCalendar.fromDate(focusedMonth).getLongMonthName()}, ${HijriCalendar.fromDate(focusedMonth).hYear}";

  bool isEnglishCalendar = true;
  List<DateTime> visibleDates = [];
  // ScrollController calendarScrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  final InfiniteScrollController infiniteScrollController = InfiniteScrollController();

  @override
  void onInit() {
    super.onInit();
    focusedMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    generateVisibleDates(selectedDate);
  }

  @override
  void onReady() {
    super.onReady();

    // Scroll to selected date after layout
    // _scrollToSelectedDate(animate: false);
    int selectedIndex = visibleDates.indexOf(
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
    );
    if (selectedIndex != -1) {
      infiniteScrollController.animateToItem(
        selectedIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onDateSelected(DateTime date) {
    selectedDate = date;
    if (selectedDate.month != focusedMonth.month || selectedDate.year != focusedMonth.year) {
      focusedMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    }
    // It's good practice to regenerate visible dates if the logic depends on selectedDate heavily,
    // though for a simple sliding window, it might not be strictly necessary on every selection.
    // _generateVisibleDates(selectedDate);
    // _filterEntriesForSelectedDate();

    update();
  }

  void generateVisibleDates(DateTime centerDate) {
    visibleDates.clear();
    // Show 3 days before, centerDate, and 3 days after (total 7 days)
    // Adjust this range as needed
    for (int i = 1; i < DateTime(centerDate.year, centerDate.month, 0).day; i++) {
      // Show a wider range for better scrolling
      visibleDates.add(DateTime(centerDate.year, centerDate.month, i));
    }
    // Ensure selectedDate is somewhat centered visually if it changes drastically
    // The _scrollToSelectedDate handles the precise centering.
  }

  // void _scrollToSelectedDate({bool animate = true}) {
  //   if (visibleDates.isEmpty) return;

  //   int selectedIndex = visibleDates.indexWhere(
  //     (date) =>
  //         date.year == selectedDate.year &&
  //         date.month == selectedDate.month &&
  //         date.day == selectedDate.day,
  //   );

  //   if (selectedIndex != -1 && infiniteScrollController.hasClients) {
  //     double itemWidth = 60.w + 30.w;
  //     double screenWidth = Get.width;
  //     double targetScrollOffset = (selectedIndex * itemWidth) - (screenWidth / 2);

  //     // Clamp the scroll offset
  //     targetScrollOffset = targetScrollOffset.clamp(
  //       infiniteScrollController.position.minScrollExtent,
  //       infiniteScrollController.position.maxScrollExtent,
  //     );

  //     if (animate) {
  //       infiniteScrollController.animateTo(
  //         targetScrollOffset,
  //         duration: Duration(milliseconds: 300),
  //         curve: Curves.easeInOut,
  //       );
  //     } else {
  //       infiniteScrollController.jumpTo(targetScrollOffset);
  //     }
  //   }
  // }
}
