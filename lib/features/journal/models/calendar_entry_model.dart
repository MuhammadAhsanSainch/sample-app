
class CalendarEntry {
  final String id;
  final DateTime time; // Store as DateTime for sorting/filtering
  final String title;
  final String content;

  CalendarEntry({
    required this.id,
    required this.time,
    required this.title,
    required this.content,
  });
}