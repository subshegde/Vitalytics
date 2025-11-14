class ProgressSummaryModel {
  final String analysisDate;
  final String overallChange;
  final List<MetricTrackModel> metricsTracked;
  final String visualNotes;

  ProgressSummaryModel({
    required this.analysisDate,
    required this.overallChange,
    required this.metricsTracked,
    required this.visualNotes,
  });

  factory ProgressSummaryModel.fromJson(Map<String, dynamic> json) {
    return ProgressSummaryModel(
      analysisDate: json['analysis_date'] ?? '',
      overallChange: json['overall_change'] ?? '',
      metricsTracked: (json['metrics_tracked'] as List<dynamic>? ?? [])
          .map((e) => MetricTrackModel.fromJson(e))
          .toList(),
      visualNotes: json['visual_notes'] ?? '',
    );
  }
}

class MetricTrackModel {
  final String metricName;
  final String changeDescription;
  final double confidenceScore;

  MetricTrackModel({
    required this.metricName,
    required this.changeDescription,
    required this.confidenceScore,
  });

  factory MetricTrackModel.fromJson(Map<String, dynamic> json) {
    return MetricTrackModel(
      metricName: json['metric_name'] ?? '',
      changeDescription: json['change_description'] ?? '',
      confidenceScore: json['confidence_score'] ?? 0,
    );
  }
}