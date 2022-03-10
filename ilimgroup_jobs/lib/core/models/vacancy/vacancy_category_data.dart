import 'package:json_annotation/json_annotation.dart';

part 'vacancy_category_data.g.dart';

@JsonSerializable()
class VacancyCategoryData {
  final int? id;
  @JsonKey(name: 'create_at')
  final DateTime? createAt;
  @JsonKey(name: 'upgrade_at')
  final DateTime? upgradeAt;
  @JsonKey(name: 'delete_at')
  final DateTime? deleteAt;
  final String category;
  final String description;

  VacancyCategoryData(
      {this.id,
      this.createAt,
      this.upgradeAt,
      this.deleteAt,
      required this.category,
      required this.description});

  factory VacancyCategoryData.fromJson(Map<String, dynamic> json) =>
      _$VacancyCategoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$VacancyCategoryDataToJson(this);
}
