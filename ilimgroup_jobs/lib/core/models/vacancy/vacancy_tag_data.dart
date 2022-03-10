import 'package:json_annotation/json_annotation.dart';

part 'vacancy_tag_data.g.dart';

@JsonSerializable()
class VacancyTagData {
  final int? id;
  @JsonKey(name: 'create_at')
  final DateTime? createAt;
  @JsonKey(name: 'upgrade_at')
  final DateTime? upgradeAt;
  @JsonKey(name: 'delete_at')
  final DateTime? deleteAt;
  final String tag;
  final String description;

  VacancyTagData(
      {this.id,
      this.createAt,
      this.upgradeAt,
      this.deleteAt,
      required this.tag,
      required this.description});

  factory VacancyTagData.fromJson(Map<String, dynamic> json) =>
      _$VacancyTagDataFromJson(json);
  Map<String, dynamic> toJson() => _$VacancyTagDataToJson(this);
}
