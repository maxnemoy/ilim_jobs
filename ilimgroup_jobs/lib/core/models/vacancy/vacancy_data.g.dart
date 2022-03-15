// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacancy_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VacancyData _$VacancyDataFromJson(Map<String, dynamic> json) => VacancyData(
      id: json['id'] as int?,
      createAt: json['create_at'] == null
          ? null
          : DateTime.parse(json['create_at'] as String),
      upgradeAt: json['upgrade_at'] == null
          ? null
          : DateTime.parse(json['upgrade_at'] as String),
      deleteAt: json['delete_at'] == null
          ? null
          : DateTime.parse(json['delete_at'] as String),
      published: json['published'] as bool,
      title: json['title'] as String,
      description: json['description'] as String,
      responsibilities: json['responsibilities'] as String,
      requirements: json['requirements'] as String,
      terms: json['terms'] as String,
      author: json['author'] as int?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as int).toList(),
      category: json['category'] as int,
      contacts: (json['contacts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$VacancyDataToJson(VacancyData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'create_at': instance.createAt?.toIso8601String(),
      'upgrade_at': instance.upgradeAt?.toIso8601String(),
      'delete_at': instance.deleteAt?.toIso8601String(),
      'published': instance.published,
      'title': instance.title,
      'description': instance.description,
      'responsibilities': instance.responsibilities,
      'requirements': instance.requirements,
      'terms': instance.terms,
      'author': instance.author,
      'tags': instance.tags,
      'category': instance.category,
      'contacts': instance.contacts,
    };
