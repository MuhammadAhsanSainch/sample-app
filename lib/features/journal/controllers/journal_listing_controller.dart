import 'package:hijri/hijri_calendar.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class JournalListingController extends GetxController with GetSingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();

  DateTime focusedMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  ); // For month/year display

  String get focusedHijriMonthText {
    final firstDayGregorian = DateTime(focusedMonth.year, focusedMonth.month, focusedMonth.day);

    final hijriStartDate = HijriCalendar.fromDate(firstDayGregorian);

    String startHijriName = hijriStartDate.getLongMonthName();
    String startHijriYear = hijriStartDate.hYear.toString();

    return "$startHijriName $startHijriYear";
  }

  bool isEnglishCalendar = true;
  List<DateTime> visibleDates = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    focusedMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    generateVisibleDates(selectedDate);
  }

  void onDateSelected(DateTime date) {
    selectedDate = date;
    if (focusedMonth.month != selectedDate.month || focusedMonth.year != selectedDate.year) {
      focusedMonth = DateTime(selectedDate.year, selectedDate.month, 1);
      update(["calendar"]);
    }
    update();
  }

  void generateVisibleDates(DateTime centerDate) {
    visibleDates.clear();
    // Show 3 days before, centerDate, and 3 days after (total 7 days)
    // Adjust this range as needed
    for (int i = -180; i < 360; i++) {
      // Show a wider range for better scrolling
      visibleDates.add(DateTime(centerDate.year, centerDate.month, i));
    }
  }

  void scrollToSelectedDate(InfiniteScrollController scrollController) {
    // Scroll to selected date after layout
    // _scrollToSelectedDate(animate: false);
    if (scrollController.hasClients) {
      int selectedIndex = visibleDates.indexOf(
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
      );
      if (selectedIndex != -1) {
        scrollController.animateToItem(
          selectedIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}
