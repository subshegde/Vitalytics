// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progression_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProgressionResult _$ProgressionResultFromJson(Map<String, dynamic> json) =>
    _ProgressionResult(
      analysis_date: json['analysis_date'] as String,
      status: json['status'] as String,
      change_description: json['change_description'] as String,
      suggested_adjustment: json['suggested_adjustment'] as String,
    );

Map<String, dynamic> _$ProgressionResultToJson(_ProgressionResult instance) =>
    <String, dynamic>{
      'analysis_date': instance.analysis_date,
      'status': instance.status,
      'change_description': instance.change_description,
      'suggested_adjustment': instance.suggested_adjustment,
    };
