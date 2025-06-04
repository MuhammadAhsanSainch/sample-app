import 'package:dio/dio.dart';
import '/utilities/app_exports.dart' hide Response;

class Logging extends Interceptor {
  String endpoint = "";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    endpoint = options.path;
    log('Authorization: Bearer ${UserPreferences.authToken}');
    log('REQUEST TYPE: ${options.method}');
    log('REQUEST: ${AppUrl.baseUrl}${options.path}');
    log('BODY: ${options.data}');
    log('PARAMETERS: ${options.queryParameters}');
    if (options.path != '/login' &&
        options.path != '/send-otp' &&
        options.path != '/verify-otp' &&
        options.path != '/reset-password') {
      options.headers.addEntries(
          [MapEntry("Authorization", 'Bearer ${UserPreferences.authToken}')]);
    }
    if (options.path == '/update-profile' || options.path == "/upload") {
      options.contentType = 'multipart/form-data';
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE: ${response.toString()}');
    if (response.data['message'] == 'User Is Not Logged In') {
      AppGlobals.isLoading(false);
      _tokenExpiredDialog(AppGlobals.appNavigationKey.currentContext!);
      return;
    } else if (response.data['status'] == false ||
        (response.data['status'] == false && response.data['data'] == null)) {
      AppGlobals.isLoading(false);
      AppGlobals.showAlertDialog(
          heading: response.data['code'] == 'BAD_REQUEST' || response.data['code'] == 'NOT_FOUND'
              ? 'Error'
              : response.data['code'],
          message: response.data['message'].toString());
      return;
    } else {
      return super.onResponse(response, handler);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppGlobals.isLoading(false);
    log('🔥 AN ERROR CAUGHT WHILE TRYING TO HIT: ${AppUrl.baseUrl}${err.requestOptions.path}');
    log('⚠️ ERROR TYPE: ${err.type}');
    log('🚨 ERROR: ${err.error}');
    log('📄 ERROR MESSAGE: ${err.message}');

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        AppGlobals.showAlertDialog(
            message:
                'Connection timed out. Please check your internet connection.');
        break;
      case DioExceptionType.sendTimeout:
        AppGlobals.showAlertDialog(
            message: 'Request timed out while sending data to the server.');
        break;
      case DioExceptionType.receiveTimeout:
        AppGlobals.showAlertDialog(
            message:
                'Response timed out while receiving data from the server.');
        break;
      case DioExceptionType.badResponse:
        _handleBadResponse(err.response?.statusCode, err.response?.data);
        break;
      case DioExceptionType.cancel:
        log('❌ Request was cancelled.');
        break;
      case DioExceptionType.connectionError:
        AppGlobals.showAlertDialog(
            message:
                'Failed to connect to the server. Please check your internet connection.');
        break;
      case DioExceptionType.badCertificate:
        AppGlobals.showAlertDialog(message: 'Bad SSL certificate.');
        break;
      case DioExceptionType.unknown:
        AppGlobals.showAlertDialog(message: 'An unexpected error occurred.');
        break;
    }

    // handler.next(err); // Continue with the error handling
  }

  void _handleBadResponse(int? statusCode, dynamic responseData) {
    log('🚫 Bad Response - Status Code: $statusCode, Data: $responseData');
    switch (statusCode) {
      case 400:
        AppGlobals.showAlertDialog(
            message:
                'Bad Request: The server could not understand the request.');
        break;
      case 401:
        AppGlobals.showAlertDialog(
            message:
                'Unauthorized: Authentication is required and has failed or has not yet been provided.');
        // You might want to trigger a logout or token refresh here
        break;
      case 403:
        AppGlobals.showAlertDialog(
            message:
                'Forbidden: The client does not have access rights to the content.');
        break;
      case 404:
        AppGlobals.showAlertDialog(
            message:
                'Not Found: The server could not find the requested resource.');
        break;
      case 408:
        AppGlobals.showAlertDialog(
            message:
                'Request Timeout: The server timed out waiting for the request.');
        break;
      case 429:
        AppGlobals.showAlertDialog(
            message:
                'Too Many Requests: The user has sent too many requests in a given amount of time.');
        break;
      case 500:
        AppGlobals.showAlertDialog(
            heading: 'SERVER_ERROR',
            message:
                'Internal Server Error: Something went wrong on the server.');
        break;
      case 502:
        AppGlobals.showAlertDialog(
            heading: 'SERVER_ERROR',
            message:
                'Bad Gateway: The server received an invalid response from an upstream server.');
        break;
      case 503:
        AppGlobals.showAlertDialog(
            heading: 'SERVER_ERROR',
            message:
                'Service Unavailable: The server is currently unavailable (overloaded or down).');
        break;
      case 504:
        AppGlobals.showAlertDialog(
            heading: 'SERVER_ERROR',
            message:
                'Gateway Timeout: The server did not receive a timely response from an upstream server.');
        break;
      case 101: // You had this specifically, so I'm keeping it
        AppGlobals.showAlertDialog(message: 'Network Is Unreachable');
        break;
      default:
        AppGlobals.showAlertDialog(
            message: 'An error occurred with status code: $statusCode');
        break;
    }

    // You can also inspect the responseData for more specific error messages from the backend
    if (responseData != null) {
      log('⚠️ Response Data: $responseData');
      // You might want to parse responseData (if it's JSON) and show specific messages
      // Example:
      // if (responseData is Map<String, dynamic> && responseData.containsKey('message')) {
      //   AppGlobals.showAlertDialog(message: responseData['message']);
      // }
    }
  }

  void _tokenExpiredDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User Must Tap Button
      builder: (BuildContext context) {
        return PopScope<Object?>(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (didPop) {
              return;
            }
            final bool shouldPop = await _showBackDialog(context) ?? false;
            if (context.mounted && shouldPop) {
              Navigator.pop(context);
            }
          },
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                "Authentication Expired".toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    fontStyle: FontStyle.normal),
              ),
            ),
            titlePadding: const EdgeInsets.all(0),
            content: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Ohh Sorry!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Your Authentication Has Been Expired. Please Login Again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            alignment: Alignment.center,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomRoundedButton(
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();

                      /// Remove All Screens And Get Back To Login Screen
                    },
                    text: 'Okay',
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<bool?> _showBackDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Are you sure you want to leave this page?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Never Mind'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }
}
