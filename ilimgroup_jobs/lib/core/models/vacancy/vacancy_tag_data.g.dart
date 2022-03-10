// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacancy_tag_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VacancyTagData _$VacancyTagDataFromJson(Map<String, dynamic> json) =>
    VacancyTagData(
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
      tag: json['tag'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$VacancyTagDataToJson(VacancyTagData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'create_at': instance.createAt?.toIso8601String(),
      'upgrade_at': instance.upgradeAt?.toIso8601String(),
      'delete_at': instance.deleteAt?.toIso8601String(),
      'tag': instance.tag,
      'description': instance.description,
    };
