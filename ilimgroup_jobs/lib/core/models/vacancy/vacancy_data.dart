import 'package:json_annotation/json_annotation.dart';

part 'vacancy_data.g.dart';

@JsonSerializable()
class VacancyData {
  final int? id;
  @JsonKey(name: 'create_at')
  final DateTime? createAt;
  @JsonKey(name: 'upgrade_at')
  final DateTime? upgradeAt;
  @JsonKey(name: 'delete_at')
  final DateTime? deleteAt;
  final bool published;
  final String title;
  final String responsibilities;
  final String requirements;
  final String terms;
  final int? author;
  final List<String> tags;
  final int category;

  factory VacancyData.fromJson(Map<String, dynamic> json) =>
      _$VacancyDataFromJson(json);

  VacancyData(
      {this.id,
      this.createAt,
      this.upgradeAt,
      this.deleteAt,
      required this.published,
      required this.title,
      required this.responsibilities,
      required this.requirements,
      required this.terms,
      this.author,
      required this.tags,
      required this.category});
  Map<String, dynamic> toJson() => _$VacancyDataToJson(this);
}
