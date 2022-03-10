// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostData _$PostDataFromJson(Map<String, dynamic> json) => PostData(
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
      body: json['body'] as String,
      cover: json['cover'] as String,
      assets:
          (json['assets'] as List<dynamic>).map((e) => e as String).toList(),
      type: json['type'] as int,
    );

Map<String, dynamic> _$PostDataToJson(PostData instance) => <String, dynamic>{
      'id': instance.id,
      'create_at': instance.createAt?.toIso8601String(),
      'upgrade_at': instance.upgradeAt?.toIso8601String(),
      'delete_at': instance.deleteAt?.toIso8601String(),
      'published': instance.published,
      'title': instance.title,
      'body': instance.body,
      'cover': instance.cover,
      'assets': instance.assets,
      'type': instance.type,
    };
