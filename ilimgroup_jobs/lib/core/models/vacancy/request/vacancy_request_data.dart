import 'package:json_annotation/json_annotation.dart';

part 'vacancy_request_data.g.dart';

@JsonSerializable()
class VacancyRequestData {
  final int? id;
  @JsonKey(name: 'create_at')
  final DateTime? createAt;
  @JsonKey(name: 'upgrade_at')
  final DateTime? upgradeAt;
  @JsonKey(name: 'delete_at')
  final DateTime? deleteAt;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'vacancy_id')
  final int vacancyId;
  final int status;

  VacancyRequestData(
      {this.id,
      this.createAt,
      this.upgradeAt,
      this.deleteAt,
      required this.userId,
      required this.vacancyId,
      required this.status});

  factory VacancyRequestData.fromJson(Map<String, dynamic> json) =>
      _$VacancyRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$VacancyRequestDataToJson(this);
}
