// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmp_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmpVacancy _$TmpVacancyFromJson(Map<String, dynamic> json) => TmpVacancy(
      title: json['title'] as String,
      description: json['description'] as String,
      responsibilities: json['responsibilities'] as String,
      requirements: json['requirements'] as String,
      terms: json['terms'] as String,
      contacts:
          (json['contacts'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TmpVacancyToJson(TmpVacancy instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'responsibilities': instance.responsibilities,
      'requirements': instance.requirements,
      'terms': instance.terms,
      'contacts': instance.contacts,
    };

TmpData _$TmpDataFromJson(Map<String, dynamic> json) => TmpData(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      vacancies: (json['vacancies'] as List<dynamic>)
          .map((e) => TmpVacancy.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TmpDataToJson(TmpData instance) => <String, dynamic>{
      'categories': instance.categories,
      'vacancies': instance.vacancies,
    };
