import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '/network/interceptor/logging_interceptor.dart';
import '/network/response/general_map_response.dart';
import 'app_url.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: AppUrl.baseUrl) // Enter Your API Base URL

abstract class ApiService {
  factory ApiService(Dio dio, baseUrl) {
    dio.options = BaseOptions(
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        /* If needed headers */
        headers: {'Content-Type': 'application/json'});

    dio.interceptors.add(Logging());
    return _ApiService(dio, baseUrl: AppUrl.baseUrl,errorLogger: null);
  }

  // APIs EndPoints Request Bodies without Token

  @POST(AppUrl.loginApi)
  Future<GeneralMapResponse> signIn(@Body() Map<String, dynamic> body);

  @POST('/auth/logout')
  Future<GeneralMapResponse> logout(@Body() Map<String, dynamic> body);

  @POST('/auth/send-otp')
  Future<GeneralMapResponse> sendOtp(@Body() Map<String, dynamic> body);

  @POST('/auth/verify-otp')
  Future<GeneralMapResponse> verifyOtp(@Body() Map<String, dynamic> body);

  @POST('/auth/reset-pin')
  Future<GeneralMapResponse> resetPassword(@Body() Map<String, dynamic> body);

  @POST('/media/upload')
  @MultiPart()
  Future<GeneralMapResponse> uploadMedia(@Body() FormData formData);

  // APIs EndPoints Request Bodies with Token
  @POST('/auth/update-password')
  Future<GeneralMapResponse> updatePassword(@Body() Map<String, dynamic> body);

}
