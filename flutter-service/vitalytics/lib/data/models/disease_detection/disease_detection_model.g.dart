// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disease_detection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiseaseDetectionModel _$DiseaseDetectionModelFromJson(
  Map<String, dynamic> json,
) => _DiseaseDetectionModel(
  detected_disease: json['detected_disease'] as String,
  confidence_score: (json['confidence_score'] as num).toDouble(),
  description: json['description'] as String,
  precautionary_steps: (json['precautionary_steps'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$DiseaseDetectionModelToJson(
  _DiseaseDetectionModel instance,
) => <String, dynamic>{
  'detected_disease': instance.detected_disease,
  'confidence_score': instance.confidence_score,
  'description': instance.description,
  'precautionary_steps': instance.precautionary_steps,
};
