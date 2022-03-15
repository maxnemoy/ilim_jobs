import 'package:json_annotation/json_annotation.dart';

part 'tmp_category.g.dart';


@JsonSerializable()
class TmpVacancy {
  final String title;
  final String description;
  final String responsibilities;
  final String requirements;
  final String terms;
  final List<String> contacts;

  factory TmpVacancy.fromJson(Map<String, dynamic> json) =>
      _$TmpVacancyFromJson(json);

  TmpVacancy(
      {required this.title,
      required this.description,
      required this.responsibilities,
      required this.requirements,
      required this.terms,
      required this.contacts,});
  Map<String, dynamic> toJson() => _$TmpVacancyToJson(this);
}

@JsonSerializable()
class TmpData {
  final List<String> categories;
  final List<String> tags;
  final List<TmpVacancy> vacancies;

  TmpData({
      required this.tags, 
      required this.categories, 
      required this.vacancies});

  factory TmpData.fromJson(Map<String, dynamic> json) =>
      _$TmpDataFromJson(json);

  Map<String, dynamic> toJson() => _$TmpDataToJson(this);
}
