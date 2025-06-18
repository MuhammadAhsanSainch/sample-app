import 'package:path_to_water/utilities/app_exports.dart';

enum ReminderType {
  once("Only Once"),
  repeat("Every Time");

  final String name;
  const ReminderType(this.name);

  @override
  String toString() => name;
}

class CreateReminderScreenController extends GetxController {
  final TextEditingController reminderTitleController = TextEditingController();
  final TextEditingController selectedDateController = TextEditingController();
  final TextEditingController selectedTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  RxBool isRepeat = false.obs;

  RxInt currentTabIndex = 0.obs;

  ReminderType selectedReminderType = ReminderType.once;

  onReminderTypeSelect(ReminderType? reminderType) {
    selectedReminderType = reminderType ?? ReminderType.once;
    update(['type']);
  }
}
