import 'package:device_calendar/device_calendar.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:path_to_water/screens/calendar/controller/calendar_controller.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  CalendarController get controller => Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppGlobals.isDarkMode.value ? AppColors.dark : AppColors.white100,
      child: Stack(
        children: [
          CustomImageView(
            imagePath:
                AppGlobals.isDarkMode.value
                    ? AppConstants.createJournalBgDarkImage
                    : AppConstants.createJournalBgImage,
            height: 150.h,
            fit: BoxFit.contain,
          ),
          ListView(
            physics: ClampingScrollPhysics(),
            children: [
              75.verticalSpace,
              DualCalendarView(
                initialDisplayMonth: controller.selectedDate ?? DateTime.now(),
                selectedDate: controller.selectedDate,
                onDateSelected: (date) {
                  controller.selectedDate = date;
                },
                controller: controller,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DualCalendarView extends StatefulWidget {
  final DateTime initialDisplayMonth;
  final DateTime? selectedDate;
  final Function(DateTime)? onDateSelected;
  final CalendarController controller;

  const DualCalendarView({
    super.key,
    required this.initialDisplayMonth,
    this.selectedDate,
    this.onDateSelected,
    required this.controller,
  });

  @override
  _DualCalendarViewState createState() => _DualCalendarViewState();
}

class _DualCalendarViewState extends State<DualCalendarView> {
  late DateTime _displayedMonth;
  DateTime? _selectedDate;
  final DateTime _today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  // Custom day abbreviations as per the image
  final List<String> _dayAbbreviations = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  Color get _darkBgColor => AppGlobals.isDarkMode.value ? AppColors.dark : AppColors.white100;
  Color get _greenAccentColor => AppColors.primary;
  Color get _headerTextColor => AppColors.textPrimary;
  Color get _dayNumberColor => AppColors.textPrimary;
  Color get _otherMonthDayNumberColor => AppColors.grey500;
  Color get _dayHeaderColor => AppColors.primary;

  @override
  void initState() {
    super.initState();
    _displayedMonth = DateTime(
      widget.initialDisplayMonth.year,
      widget.initialDisplayMonth.month,
      1,
    );
    _selectedDate = widget.selectedDate;
    HijriCalendar.setLocal('en'); // For English Hijri month names
  }

  String _getHijriMonthYearString(DateTime gregorianMonth) {
    final firstDayGregorian = DateTime(gregorianMonth.year, gregorianMonth.month, 1);
    final lastDayGregorian = DateTime(gregorianMonth.year, gregorianMonth.month + 1, 0);

    final hijriStartDate = HijriCalendar.fromDate(firstDayGregorian);
    final hijriEndDate = HijriCalendar.fromDate(lastDayGregorian);

    String startHijriName = hijriStartDate.getLongMonthName();
    String endHijriName = hijriEndDate.getLongMonthName();
    String startHijriYear = hijriStartDate.hYear.toString();
    String endHijriYear = hijriEndDate.hYear.toString();

    if (startHijriName == endHijriName && startHijriYear == endHijriYear) {
      return "$startHijriName $startHijriYear";
    } else if (startHijriYear == endHijriYear) {
      return "$startHijriName – $endHijriName $startHijriYear";
    } else {
      // Spans across Hijri years
      return "$startHijriName $startHijriYear – $endHijriName $endHijriYear";
    }
  }

  Future<void> _nextMonth() async {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 1);
      widget.controller.retrieveCalendarEvent(_displayedMonth);
    });
  }

  Future<void> _previousMonth() async {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month - 1, 1);
      widget.controller.retrieveCalendarEvent(_displayedMonth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: _darkBgColor),
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildDayOfWeekHeaders(),
          _buildCalendarGrid(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(_displayedMonth),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _headerTextColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => _previousMonth(),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.arrow_back_ios, color: AppColors.primary, size: 16.h),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.72,

                    child: CustomText(
                      _getHijriMonthYearString(_displayedMonth),
                      textAlign: TextAlign.center,
                      fontSize: 14,
                      color: _headerTextColor.withAlpha(200),
                    ),
                  ),
                  InkWell(
                    onTap: () => _nextMonth(),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 16.h),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayOfWeekHeaders() {
    return Row(
      children:
          _dayAbbreviations.map((dayAbbr) {
            return Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: AppColors.greenStrokeColor.withAlpha(120), width: 0.2),
                ),
                child: CustomText(
                  dayAbbr,
                  textAlign: TextAlign.center,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _dayHeaderColor,
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildCalendarGrid() {
    List<DateTime> days = [];
    DateTime firstDayOfGrid = _displayedMonth.subtract(Duration(days: _displayedMonth.weekday - 1));
    int length = 35;
    if (_displayedMonth.weekday > 5) {
      length = 42;
    }

    for (int i = 0; i < length; i++) {
      days.add(firstDayOfGrid.add(Duration(days: i)));
    }

    return GetBuilder(
      init: widget.controller,
      id: "calendarEvents",
      builder: (_) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.7, // Adjust for cell height
          ),
          itemCount: days.length,
          itemBuilder: (context, index) {
            DateTime date = days[index];
            bool isCurrentMonth = date.month == _displayedMonth.month;
            bool isToday =
                date.year == _today.year && date.month == _today.month && date.day == _today.day;
            bool isSelected =
                _selectedDate != null &&
                date.year == _selectedDate!.year &&
                date.month == _selectedDate!.month &&
                date.day == _selectedDate!.day;
            List<Event> events = widget.controller.events[date] ?? [];
            return _buildDayCell(date, isCurrentMonth, isToday, isSelected, events);
          },
        );
      },
    );
  }

  Widget _buildDayCell(
    DateTime date,
    bool isCurrentMonth,
    bool isToday,
    bool isSelected,
    List<Event> events,
  ) {
    HijriCalendar hijriDate = HijriCalendar.fromDate(date);

    BoxDecoration decoration = BoxDecoration(
      border: Border.all(color: AppColors.greenStrokeColor.withAlpha(120), width: 0.2),
      color: Colors.transparent,
    );

    return GestureDetector(
      onTap: () {
        if (isCurrentMonth) {
          setState(() {
            _selectedDate = date;
          });
        }
      },
      child: Container(
        // alignment: Alignment.center,
        decoration: decoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.r),
              child: Container(
                padding: isToday ? const EdgeInsets.all(6) : null,
                decoration:
                    isToday
                        ? BoxDecoration(shape: BoxShape.circle, color: AppColors.surface)
                        : null,
                child: CustomText(
                  date.day.toString(),
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color:
                      isToday
                          ? AppColors.scaffoldBackground
                          : (isCurrentMonth ? _dayNumberColor : _otherMonthDayNumberColor),
                ),
              ),
            ),
            Visibility(
              visible: events.isNotEmpty,
              child: Tooltip(
                message: events.firstOrNull?.title ?? "",
                child: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.r),
                    border: Border.all(color: AppColors.primary.withAlpha(155), width: 0.5),
                    color: AppColors.primary.withAlpha(50),
                  ),
                  child: CustomText(
                    events.firstOrNull?.title ?? "",
                    maxLine: 2,
                    fontSize: 9,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.r),

                  child: CustomText(
                    '(${hijriDate.hDay})',

                    fontSize: 11,
                    color: (isCurrentMonth ? _greenAccentColor : _greenAccentColor.withAlpha(150)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
