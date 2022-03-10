import 'package:json_annotation/json_annotation.dart';

part 'auth_data.g.dart';

@JsonSerializable()
class AuthData {
  @JsonKey(name: 'Token')
  final String raw;

  AuthData(this.raw);

  String get token => "Bearer $raw";

  factory AuthData.fromJson(Map<String, dynamic> json) => _$AuthDataFromJson(json);
  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}