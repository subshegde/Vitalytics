// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DietSummaryResponse _$DietSummaryResponseFromJson(Map<String, dynamic> json) =>
    _DietSummaryResponse(
      title: json['title'] as String,
      summary_text: json['summary_text'] as String,
      suggested_meals: (json['suggested_meals'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$DietSummaryResponseToJson(
  _DietSummaryResponse instance,
) => <String, dynamic>{
  'title': instance.title,
  'summary_text': instance.summary_text,
  'suggested_meals': instance.suggested_meals,
};
