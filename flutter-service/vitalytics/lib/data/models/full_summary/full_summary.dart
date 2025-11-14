class FullSummary {
  String? analysisDate;
  String? overallStatus;
  KeyMetrics? keyMetrics;
  List<Sections>? sections;

  FullSummary(
      {this.analysisDate, this.overallStatus, this.keyMetrics, this.sections});

  FullSummary.fromJson(Map<String, dynamic> json) {
    analysisDate = json['analysis_date'];
    overallStatus = json['overall_status'];
    keyMetrics = json['key_metrics'] != null
        ? new KeyMetrics.fromJson(json['key_metrics'])
        : null;
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['analysis_date'] = this.analysisDate;
    data['overall_status'] = this.overallStatus;
    if (this.keyMetrics != null) {
      data['key_metrics'] = this.keyMetrics!.toJson();
    }
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KeyMetrics {
  double? dietScore;
  String? progressionTrend;

  KeyMetrics({this.dietScore, this.progressionTrend});

  KeyMetrics.fromJson(Map<String, dynamic> json) {
    dietScore = json['diet_score'];
    progressionTrend = json['progression_trend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diet_score'] = this.dietScore;
    data['progression_trend'] = this.progressionTrend;
    return data;
  }
}

class Sections {
  String? sectionTitle;
  String? briefSummary;
  String? recommendation;

  Sections({this.sectionTitle, this.briefSummary, this.recommendation});

  Sections.fromJson(Map<String, dynamic> json) {
    sectionTitle = json['section_title'];
    briefSummary = json['brief_summary'];
    recommendation = json['recommendation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section_title'] = this.sectionTitle;
    data['brief_summary'] = this.briefSummary;
    data['recommendation'] = this.recommendation;
    return data;
  }
}