import 'package:json_annotation/json_annotation.dart';
import 'package:jwt_decode/jwt_decode.dart';

part 'auth_data.g.dart';

@JsonSerializable()
class AuthData {
  @JsonKey(name: 'Token')
  final String raw;

  AuthData(this.raw);

  String get token => "Bearer $raw";
  
  int get userId => Jwt.parseJwt(token)["id"] as int;
  String get username => Jwt.parseJwt(token)["username"] as String;
  int get type => Jwt.parseJwt(token)["type"] as int;

  factory AuthData.fromJson(Map<String, dynamic> json) => _$AuthDataFromJson(json);
  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}