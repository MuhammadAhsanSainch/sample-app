import 'package:json_annotation/json_annotation.dart';

part 'general_map_response.g.dart';

@JsonSerializable()
class GeneralMapResponse {

  @JsonKey(name: 'message')
  late final dynamic message;

  @JsonKey(name: 'status')
  late final bool status;

  @JsonKey(name: 'code')
  late final String code;

  @JsonKey(name: 'data')
  late final Map<String,dynamic>? data;

  GeneralMapResponse(this.data, {required this.message,required this.status, required this.code});

  factory GeneralMapResponse.fromJson(Map<String, dynamic> json) => _$GeneralMapResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralMapResponseToJson(this);

}