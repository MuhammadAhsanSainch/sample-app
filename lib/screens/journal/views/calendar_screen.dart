import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

// To launch the calendar
void showDualCalendarSheet(
  BuildContext context, {
  DateTime? initialDate,
  DateTime? selectedDate,
  Function(DateTime)? onDateSelected,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Important for content that might overflow
    backgroundColor: Colors.transparent, // Sheet itself is transparent
    builder: (builderContext) {
      return DualCalendarView(
        initialDisplayMonth: initialDate ?? DateTime.now(),
        selectedDate: selectedDate,
        onDateSelected: onDateSelected,
      );
    },
  );
}

class DualCalendarView extends StatefulWidget {
  final DateTime initialDisplayMonth;
  final DateTime? selectedDate;
  final Function(DateTime)? onDateSelected;

  const DualCalendarView({
    Key? key,
    required this.initialDisplayMonth,
    this.selectedDate,
    this.onDateSelected,
  }) : super(key: key);

  @override
  _DualCalendarViewState createState() => _DualCalendarViewState();
}

class _DualCalendarViewState extends State<DualCalendarView> {
  late DateTime _displayedMonth;
  DateTime? _selectedDate;
  final DateTime _today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  // Custom day abbreviations as per the image
  final List<String> _dayAbbreviations = ['M', 'T', 'W', 'T', 'D', 'S', 'S'];
  final Color _darkBgColor = const Color(0xFF2C2C2E); // Slightly lighter than pure black
  final Color _greenAccentColor = const Color(0xFF34C759);
  final Color _headerTextColor = Colors.white;
  final Color _dayNumberColor = Colors.white.withOpacity(0.9);
  final Color _otherMonthDayNumberColor = Colors.white.withOpacity(0.4);
  final Color _dayHeaderColor = Colors.white.withOpacity(0.6);

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

  Future<void> _pickMonthYear() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _displayedMonth,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.year,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: _greenAccentColor,
              onPrimary: Colors.black,
              surface: _darkBgColor,
              onSurface: _headerTextColor,
            ),
            dialogBackgroundColor: _darkBgColor,
          ),
          child: child!,
        );
      },
    );

    if (picked != null &&
        (picked.year != _displayedMonth.year || picked.month != _displayedMonth.month)) {
      setState(() {
        _displayedMonth = DateTime(picked.year, picked.month, 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _darkBgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildDayOfWeekHeaders(),
          const SizedBox(height: 8),
          _buildCalendarGrid(),
          const SizedBox(height: 16), // For bottom padding/safe area
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InkWell(
            onTap: _pickMonthYear,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  children: [
                    Text(
                      _getHijriMonthYearString(_displayedMonth),
                      style: TextStyle(fontSize: 14, color: _headerTextColor.withOpacity(0.8)),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_drop_down, color: _greenAccentColor, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: const Icon(Icons.close, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildDayOfWeekHeaders() {
    return Row(
      children:
          _dayAbbreviations.map((dayAbbr) {
            // Highlight today's day of week header
            // Note: This highlights the column, not just the specific day's letter.
            // For this design, let's find which day of week _today is.
            // DateTime.monday = 1, ... DateTime.sunday = 7.
            // Our _dayAbbreviations list is 0-indexed for Monday.
            bool isTodayDayOfWeek = false;
            if (_today.month == _displayedMonth.month && _today.year == _displayedMonth.year) {
              int todayIndex = _today.weekday - 1; // 0 for Monday, ... 6 for Sunday
              int currentAbbrIndex = _dayAbbreviations.indexOf(dayAbbr);
              // This logic for highlighting 'W' needs to check if today is Wednesday.
              // A simpler way is to check if the current abbreviation corresponds to today's day.
              // For example, if today is Wednesday, the 'W' should be highlighted.
              String todayAbbr = _dayAbbreviations[_today.weekday - 1];
              if (dayAbbr == todayAbbr) {
                isTodayDayOfWeek = true;
              }
            }

            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: isTodayDayOfWeek ? _greenAccentColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  dayAbbr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isTodayDayOfWeek ? _darkBgColor : _dayHeaderColor,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildCalendarGrid() {
    List<DateTime> days = [];
    DateTime firstDayOfGrid = _displayedMonth.subtract(Duration(days: _displayedMonth.weekday - 1));

    for (int i = 0; i < 42; i++) {
      // 6 weeks
      days.add(firstDayOfGrid.add(Duration(days: i)));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.9, // Adjust for cell height
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

        return _buildDayCell(date, isCurrentMonth, isToday, isSelected);
      },
    );
  }

  Widget _buildDayCell(DateTime date, bool isCurrentMonth, bool isToday, bool isSelected) {
    HijriCalendar hijriDate = HijriCalendar.fromDate(date);

    BoxDecoration decoration = BoxDecoration(
      shape: BoxShape.circle,
      color: isToday ? Colors.white : Colors.transparent,
      border: isSelected && !isToday ? Border.all(color: _greenAccentColor, width: 1.5) : null,
    );

    // Specific highlight for selected Hijri day (17) as in image
    // This example is specific and might need adjustment for general use.
    // For April 14, 2025, Hijri is Ramadan 17, 1446 (not 1418).
    // Let's assume the (17) highlight in image means "if this Hijri day is special"
    bool specialHijriHighlight = false;
    if (date.year == 2025 && date.month == 4 && date.day == 14 && hijriDate.hDay == 17) {
      // This is specific to the example date. In real app, this would be dynamic.
      // The image seems to show a green circle on the Hijri day number itself for some dates.
      // For now, we focus on Gregorian selection and today.
    }

    return GestureDetector(
      onTap: () {
        if (isCurrentMonth) {
          // Only allow selecting days in the current month
          setState(() {
            _selectedDate = date;
          });
          widget.onDateSelected?.call(date);
          // Optionally close: Navigator.pop(context);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(1), // Spacing between cells
        alignment: Alignment.center,
        decoration: decoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.day.toString(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                color:
                    isToday
                        ? _darkBgColor
                        : (isCurrentMonth ? _dayNumberColor : _otherMonthDayNumberColor),
              ),
            ),
            if (isCurrentMonth) // Only show Hijri for current month days
              Text(
                '(${hijriDate.hDay})',
                style: TextStyle(
                  fontSize: 10,
                  color: _greenAccentColor.withOpacity(isCurrentMonth ? 1.0 : 0.5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// --- Example Usage: Add this to a page to test ---
class CalendarTestPage extends StatefulWidget {
  @override
  _CalendarTestPageState createState() => _CalendarTestPageState();
}

class _CalendarTestPageState extends State<CalendarTestPage> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dual Calendar Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Example: April 2025, with 14th selected
                DateTime initial = DateTime(2025, 4, 1);
                DateTime preSelected = DateTime(2025, 4, 14);

                showDualCalendarSheet(
                  context,
                  initialDate: initial, // Set this to April 2025
                  selectedDate: _selectedDate ?? preSelected,
                  onDateSelected: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                    print("Selected Gregorian Date: $date");
                    HijriCalendar hijri = HijriCalendar.fromDate(date);
                    print(
                      "Selected Hijri Date: ${hijri.hDay} ${hijri.getLongMonthName()} ${hijri.hYear}",
                    );
                    Navigator.pop(context); // Close sheet after selection
                  },
                );
              },
              child: Text("Show Dual Calendar"),
            ),
            if (_selectedDate != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Last Selected: ${DateFormat.yMMMMd().format(_selectedDate!)}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
