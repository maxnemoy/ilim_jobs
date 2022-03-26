// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacancy_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VacancyRequestData _$VacancyRequestDataFromJson(Map<String, dynamic> json) =>
    VacancyRequestData(
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
      userId: json['user_id'] as int,
      vacancyId: json['vacancy_id'] as int,
      status: json['status'] as int,
    );

Map<String, dynamic> _$VacancyRequestDataToJson(VacancyRequestData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'create_at': instance.createAt?.toIso8601String(),
      'upgrade_at': instance.upgradeAt?.toIso8601String(),
      'delete_at': instance.deleteAt?.toIso8601String(),
      'user_id': instance.userId,
      'vacancy_id': instance.vacancyId,
      'status': instance.status,
    };
