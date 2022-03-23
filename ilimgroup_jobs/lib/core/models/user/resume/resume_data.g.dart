// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResumeData _$ResumeDataFromJson(Map<String, dynamic> json) => ResumeData(
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
      userId: json['user_id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      city: json['city'] as String?,
      citizenship: json['citizenship'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      gender: json['gender'] as String?,
      education: (json['education'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      works:
          (json['works'] as List<dynamic>?)?.map((e) => e as String).toList(),
      resumeLink: json['resume_link'] as String?,
      assets:
          (json['assets'] as List<dynamic>?)?.map((e) => e as String).toList(),
      about: json['about'] as String?,
    );

Map<String, dynamic> _$ResumeDataToJson(ResumeData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'create_at': instance.createAt?.toIso8601String(),
      'upgrade_at': instance.upgradeAt?.toIso8601String(),
      'delete_at': instance.deleteAt?.toIso8601String(),
      'user_id': instance.userId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'city': instance.city,
      'citizenship': instance.citizenship,
      'birthday': dateTimeUTCToJson(instance.birthday),
      'gender': instance.gender,
      'education': instance.education,
      'categories': instance.categories,
      'works': instance.works,
      'resume_link': instance.resumeLink,
      'assets': instance.assets,
      'about': instance.about,
    };
