import 'package:json_annotation/json_annotation.dart';

part 'post_type_data.g.dart';

@JsonSerializable()
class PostTypeData {
  final int? id;
  @JsonKey(name: 'create_at')
  final DateTime? createAt;
  @JsonKey(name: 'upgrade_at')
  final DateTime? upgradeAt;
  @JsonKey(name: 'delete_at')
  final DateTime? deleteAt;
  final String type;
  final String description;

  factory PostTypeData.fromJson(Map<String, dynamic> json) =>
      _$PostTypeDataFromJson(json);

  PostTypeData(
      {this.id,
      this.createAt,
      this.upgradeAt,
      this.deleteAt,
      required this.type,
      required this.description});
  Map<String, dynamic> toJson() => _$PostTypeDataToJson(this);
}
