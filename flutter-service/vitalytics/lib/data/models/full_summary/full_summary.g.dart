// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FullSummary _$FullSummaryFromJson(Map<String, dynamic> json) => _FullSummary(
  last_analysis_date: json['last_analysis_date'] as String,
  disease_history: (json['disease_history'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  current_status: json['current_status'] as String,
  recommendations_snapshot:
      json['recommendations_snapshot'] as Map<String, dynamic>,
);

Map<String, dynamic> _$FullSummaryToJson(_FullSummary instance) =>
    <String, dynamic>{
      'last_analysis_date': instance.last_analysis_date,
      'disease_history': instance.disease_history,
      'current_status': instance.current_status,
      'recommendations_snapshot': instance.recommendations_snapshot,
    };
