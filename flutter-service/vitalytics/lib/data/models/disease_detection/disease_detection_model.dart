import 'package:freezed_annotation/freezed_annotation.dart';

part 'disease_detection_model.freezed.dart';
part 'disease_detection_model.g.dart';

@freezed
abstract class DiseaseDetectionModel with _$DiseaseDetectionModel {
  const factory DiseaseDetectionModel({
    required String detected_disease,
    required double confidence_score,
    required String description,
    required List<String> precautionary_steps,
  }) = _DiseaseDetectionModel;

  factory DiseaseDetectionModel.fromJson(Map<String, dynamic> json) =>
      _$DiseaseDetectionModelFromJson(json);
}
