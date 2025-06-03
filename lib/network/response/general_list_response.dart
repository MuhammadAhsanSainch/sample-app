import 'package:json_annotation/json_annotation.dart';

part 'general_list_response.g.dart';

@JsonSerializable()
class GeneralListResponse {

  @JsonKey(name: 'message')
  late final dynamic message;

  @JsonKey(name: 'status')
  late final dynamic status;

  @JsonKey(name: 'code')
  late final String code;

  @JsonKey(name: 'data')
  late final List<dynamic>? data;

  GeneralListResponse(this.data, {required this.message,required this.status,required this.code});

  factory GeneralListResponse.fromJson(Map<String, dynamic> json) => _$GeneralListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralListResponseToJson(this);

}