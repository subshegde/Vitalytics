// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NutritionResult _$NutritionResultFromJson(Map<String, dynamic> json) =>
    _NutritionResult(
      name: json['name'] as String,
      type: json['type'] as String,
      disease_type: json['disease_type'] as String,
      query: json['query'] as String,
    );

Map<String, dynamic> _$NutritionResultToJson(_NutritionResult instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'disease_type': instance.disease_type,
      'query': instance.query,
    };
