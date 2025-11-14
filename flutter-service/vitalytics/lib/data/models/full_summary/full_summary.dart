import 'package:freezed_annotation/freezed_annotation.dart';

part 'full_summary.freezed.dart';
part 'full_summary.g.dart';

@freezed
abstract class FullSummary with _$FullSummary {
  const factory FullSummary({
    required String last_analysis_date,
    required List<String> disease_history,
    required String current_status,
    required Map<String, dynamic> recommendations_snapshot,
  }) = _FullSummary;

  factory FullSummary.fromJson(Map<String, dynamic> json) =>
      _$FullSummaryFromJson(json);
}
