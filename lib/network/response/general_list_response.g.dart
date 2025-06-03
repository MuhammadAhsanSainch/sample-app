// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralListResponse _$GeneralListResponseFromJson(Map<String, dynamic> json) =>
    GeneralListResponse(
      json['data'] as List<dynamic>?,
      message: json['message'],
      status: json['status'],
      code: json['code'] as String,
    );

Map<String, dynamic> _$GeneralListResponseToJson(
  GeneralListResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'status': instance.status,
  'code': instance.code,
  'data': instance.data,
};
