// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespData _$RespDataFromJson(Map<String, dynamic> json) => RespData(
      status: json['Status'] as String?,
      error: json['Error'] as String?,
    );

Map<String, dynamic> _$RespDataToJson(RespData instance) => <String, dynamic>{
      'Status': instance.status,
      'Error': instance.error,
    };
