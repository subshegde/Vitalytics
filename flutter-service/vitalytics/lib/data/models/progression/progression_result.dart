import 'package:freezed_annotation/freezed_annotation.dart';

part 'progression_result.freezed.dart';
part 'progression_result.g.dart';

@freezed
abstract
class ProgressionResult with _$ProgressionResult {
  const factory ProgressionResult({
    required String analysis_date,
    required String status,
    required String change_description,
    required String suggested_adjustment,
  }) = _ProgressionResult;

  factory ProgressionResult.fromJson(Map<String, dynamic> json) =>
      _$ProgressionResultFromJson(json);
}
