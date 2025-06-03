// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_map_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralMapResponse _$GeneralMapResponseFromJson(Map<String, dynamic> json) =>
    GeneralMapResponse(
      json['data'] as Map<String, dynamic>?,
      message: json['message'],
      status: json['status'] as bool,
      code: json['code'] as String,
    );

Map<String, dynamic> _$GeneralMapResponseToJson(GeneralMapResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
    };
