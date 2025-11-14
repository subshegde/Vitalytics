import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_result.freezed.dart';
part 'nutrition_result.g.dart';

@freezed
abstract class NutritionResult with _$NutritionResult {
  const factory NutritionResult({
    required String name,
    required String type,
    required String disease_type,
    required String query,
  }) = _NutritionResult;

  factory NutritionResult.fromJson(Map<String, dynamic> json) =>
      _$NutritionResultFromJson(json);
}
