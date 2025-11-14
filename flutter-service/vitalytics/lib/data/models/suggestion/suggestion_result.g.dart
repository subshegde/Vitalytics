// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestion_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SuggestionResult _$SuggestionResultFromJson(Map<String, dynamic> json) =>
    _SuggestionResult(
      suggestion_type: json['suggestion_type'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$SuggestionResultToJson(_SuggestionResult instance) =>
    <String, dynamic>{
      'suggestion_type': instance.suggestion_type,
      'items': instance.items,
    };
