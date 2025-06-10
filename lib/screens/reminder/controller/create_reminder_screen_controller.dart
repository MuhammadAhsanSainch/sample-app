import 'package:path_to_water/utilities/app_exports.dart';

class CreateReminderScreenController extends GetxController {
  final TextEditingController reminderTitleController = TextEditingController();
  final TextEditingController selectedDateController = TextEditingController();
  final TextEditingController selectedTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
}
