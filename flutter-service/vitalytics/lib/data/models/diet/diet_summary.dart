class DietModel {
  String? summaryText;
  MacroBreakdown? macroBreakdown;
  List<String>? recommendations;

  DietModel({this.summaryText, this.macroBreakdown, this.recommendations});

  DietModel.fromJson(Map<String, dynamic> json) {
    summaryText = json['summary_text'];
    macroBreakdown = json['macro_breakdown'] != null
        ? new MacroBreakdown.fromJson(json['macro_breakdown'])
        : null;
    recommendations = json['recommendations'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['summary_text'] = this.summaryText;
    if (this.macroBreakdown != null) {
      data['macro_breakdown'] = this.macroBreakdown!.toJson();
    }
    data['recommendations'] = this.recommendations;
    return data;
  }
}

class MacroBreakdown {
  int? carbs;
  int? protein;
  int? fats;

  MacroBreakdown({this.carbs, this.protein, this.fats});

  MacroBreakdown.fromJson(Map<String, dynamic> json) {
    carbs = json['carbs'];
    protein = json['protein'];
    fats = json['fats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carbs'] = this.carbs;
    data['protein'] = this.protein;
    data['fats'] = this.fats;
    return data;
  }
}