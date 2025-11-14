import 'package:freezed_annotation/freezed_annotation.dart';

part 'diet_summary.freezed.dart';
part 'diet_summary.g.dart';

@freezed
abstract class DietSummaryResponse with _$DietSummaryResponse {
  const factory DietSummaryResponse({
    required String title,
    required String summary_text,
    required List<Map<String, dynamic>> suggested_meals,
  }) = _DietSummaryResponse;

  factory DietSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$DietSummaryResponseFromJson(json);
}
