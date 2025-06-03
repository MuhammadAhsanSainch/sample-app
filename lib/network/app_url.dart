import '/network/api_service.dart';
import 'package:dio/dio.dart' as dio;

class AppUrl {
  static const String baseUrl = 'https://chaps-api.futurbyte.ae/api';
  static const String mediaUrl =
      'https://chapsandco.s3.ap-south-1.amazonaws.com/';
  static ApiService apiService = ApiService(dio.Dio(), AppUrl.baseUrl);
  static const String loginApi = "login";
}
