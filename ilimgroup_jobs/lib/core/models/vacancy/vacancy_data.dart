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
  final String body;
  final int? author;
  final List<int> tags;
  final int category;
  final int views;

  factory VacancyData.fromJson(Map<String, dynamic> json) =>
      _$VacancyDataFromJson(json);

  VacancyData(
      {this.id,
      this.createAt,
      this.upgradeAt,
      this.deleteAt,
      required this.published,
      required this.title,
      required this.body,
      this.author,
      required this.tags,
      required this.category,
      this.views = 0});
  Map<String, dynamic> toJson() => _$VacancyDataToJson(this);

  VacancyData copyWith(
          {int? id,
          DateTime? createAt,
          DateTime? upgradeAt,
          DateTime? deleteAt,
          bool? published,
          String? title,
          String? body,
          int? author,
          List<int>? tags,
          int? category}) =>
      VacancyData(
          id: id ?? this.id,
          createAt: createAt ?? this.createAt,
          upgradeAt: upgradeAt ?? this.upgradeAt,
          deleteAt: deleteAt ?? this.deleteAt,
          published: published ?? this.published,
          title: title ?? this.title,
          body: body ?? this.body,
          author: author ?? this.author,
          tags: tags ?? this.tags,
          category: category ?? this.category,
          views: views);
}
