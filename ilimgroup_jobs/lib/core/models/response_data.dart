import 'package:json_annotation/json_annotation.dart';

part 'response_data.g.dart';

@JsonSerializable()
class RespData {
  @JsonKey(name: 'Status')
  final String? status;
  @JsonKey(name: 'Error')
  final String? error;
  @JsonKey(name: 'Path')
  final String? path;

  factory RespData.fromJson(Map<String, dynamic> json) => _$RespDataFromJson(json);

  RespData({this.status, this.error, this.path});
  Map<String, dynamic> toJson() => _$RespDataToJson(this);
}