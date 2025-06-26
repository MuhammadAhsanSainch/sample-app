import 'package:hijri/hijri_calendar.dart';
import 'package:path_to_water/api_core/custom_exception_handler.dart';
import 'package:path_to_water/api_services/journal_service.dart';
import 'package:path_to_water/models/journal_model.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/widgets/custom_dialog.dart';

class CreateJournalScreenController extends GetxController {
  final TextEditingController journalTitleController = TextEditingController();
  final TextEditingController selectedDateController = TextEditingController();
  final TextEditingController selectedTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  HijriCalendar? selectedHijriDate;
  TimeOfDay? selectedTime;

  setDetails(JournalDetail? journalDetail) {
    selectedDate = journalDetail?.date ?? DateTime.now();
    selectedHijriDate = HijriCalendar.fromDate(selectedDate ?? DateTime.now());
    journalTitleController.text = journalDetail?.title ?? "";
    selectedDateController.text =
        "${journalDetail?.date.toFormatDateTime(format: "dd MMM, yyyy")}/ ${selectedHijriDate?.hDay ?? ""} ${selectedHijriDate?.longMonthName ?? ""} ${selectedHijriDate?.hYear ?? ""}";
    selectedTimeController.text = journalDetail?.time ?? "";
    descriptionController.text = journalDetail?.description ?? "";
  }

  createJournal({bool isEditing = false, JournalDetail? journalDetail}) async {
    try {
      AppGlobals.isLoading(true);
      Map<String, dynamic> data = {
        "title": journalTitleController.text,
        "date": selectedDate.toFormatDateTime(format: "yyyy-MM-dd"),
        "time": selectedTimeController.text,
        "description": descriptionController.text,
        if (isEditing) "id": journalDetail?.id,
      };

      final res =
          isEditing
              ? await JournalServices.editJournal(data, journalDetail?.id ?? "")
              : await JournalServices.createJournal(data);
      if (res != null) {
        Get.dialog(
          barrierDismissible: false,
          CustomDialog(
            message:
                isEditing
                    ? "Your journal entry has been successfully updated."
                    : "Your journal entry has been successfully created.",
            imageIcon: AppConstants.celebrationIcon,
            title: isEditing ? "Journal Updated" : "Journal Created",
            btnText: "Close",
            showCloseIcon: false,
            onButtonTap: () {
              Get.back();
              Get.back(result: true);
            },
          ),
        );
      }
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } catch (e) {
      log(e.toString());
    } finally {
      AppGlobals.isLoading(false);
    }
  }
}
