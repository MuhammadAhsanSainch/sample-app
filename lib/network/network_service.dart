import 'dart:developer';

import 'response/general_list_response.dart';
import 'response/general_map_response.dart';

import '../../utilities/app_globals.dart';

class NetworkService {
  static Future<Map<String, dynamic>> handleApiCall<T>(
    apiCall, {
    String? errorMessagePrefix,
    void Function(T response)? onSuccess,
  }) async {
    Map<String, dynamic> results = {};
    try {
      AppGlobals.isLoading(true);
      final T response = await apiCall;
      AppGlobals.isLoading(false);

      bool status = false;
      String code = "Unknown";
      dynamic message;
      dynamic data;

      if (response is GeneralMapResponse) {
        status = response.status;
        code = response.code;
        message = response.message;
        data = response.data;
      } else if (response is GeneralListResponse) {
        status = response.status == true;
        code = response.code;
        message = response.message;
        data = response.data;
      } else {
        throw Exception("Unsupported response type: ${response.runtimeType}");
      }

      if (status) {
        if (onSuccess != null) {
          onSuccess(response);
        }
      } else {
        log("[FAILURE] ($errorMessagePrefix) code: $code");
        log("[FAILURE] ($errorMessagePrefix) message: $message");
        AppGlobals.showAlertDialog(heading: code, message: message);
      }

      results = {
        "status": status,
        "code": code,
        "message": message,
        "data": data,
      };
    } catch (e) {
      final errorMessage =
          'An error "${e.toString()}" occurred while trying to "$errorMessagePrefix". Please try again later.';
      AppGlobals.showAlertDialog(message: errorMessage);
      log("[EXCEPTION] ($errorMessagePrefix): ${e.toString()}");
      results = {"status": false, "message": e.toString(), "data": {}};
    } finally {
      AppGlobals.isLoading(false);
    }

    return results;
  }
}
