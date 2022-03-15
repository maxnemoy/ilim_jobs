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
  final String description;
  final String responsibilities;
  final String requirements;
  final String terms;
  final int? author;
  final List<int> tags;
  final int category;
  final List<String>? contacts;

  factory VacancyData.fromJson(Map<String, dynamic> json) =>
      _$VacancyDataFromJson(json);

  VacancyData(
      {this.id,
      this.createAt,
      this.upgradeAt,
      this.deleteAt,
      required this.published,
      required this.title,
      required this.description,
      required this.responsibilities,
      required this.requirements,
      required this.terms,
      this.author,
      required this.tags,
      required this.category,
      this.contacts});
  Map<String, dynamic> toJson() => _$VacancyDataToJson(this);

  VacancyData copyWith(
          {int? id,
          DateTime? createAt,
          DateTime? upgradeAt,
          DateTime? deleteAt,
          bool? published,
          String? title,
          String? description,
          String? responsibilities,
          String? requirements,
          String? terms,
          int? author,
          List<int>? tags,
          int? category,
          List<String>? contacts}) =>
      VacancyData(
          id: id ?? this.id,
          createAt: createAt ?? this.createAt,
          upgradeAt: upgradeAt ?? this.upgradeAt,
          deleteAt: deleteAt ?? this.deleteAt,
          published: published ?? this.published,
          title: title ?? this.title,
          description: description ?? this.description,
          responsibilities: responsibilities ?? this.responsibilities,
          requirements: requirements ?? this.requirements,
          terms: terms ?? this.terms,
          author: author ?? this.author,
          tags: tags ?? this.tags,
          category: category ?? this.category,
          contacts: contacts ?? this.contacts);
}
