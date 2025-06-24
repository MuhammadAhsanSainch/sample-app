import 'dart:io';

import 'package:path_to_water/utilities/app_exports.dart';

class Helper {
  /// Return device based dimension
  static double getNormDim(double androidDimension, double iOSDimension) {
    if (Platform.isAndroid) {
      return androidDimension;
    } else {
      return iOSDimension;
    }
  }

  static Future<TimeOfDay?> pickTime(BuildContext context, [TimeOfDay? initialTime]) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (context, child) {
        return Theme(
          data:
              AppGlobals.isDarkMode.value
                  ? ThemeData.dark().copyWith(
                    colorScheme: ColorScheme.dark(primary: AppColors.primary),
                  )
                  : ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(primary: AppColors.primary),
                  ),
          child: child!,
        );
      },
    );
  }

  static Future<DateTime> pickDate(
      BuildContext context, {
        bool isFilterDialog = false,
        DateTime? lastDate,
      }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: lastDate ?? DateTime(2101),
      confirmText: 'Ok',
      cancelText:  'Cancel',
      builder: (context, child) {
        return Theme(
          data:
          AppGlobals.isDarkMode.value
              ? ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(primary: AppColors.primary),
          )
              : ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != DateTime.now()) {
      return picked;
    }
    return DateTime.now();
  }
}
