class NutritionModel {
  String? reportTitle;
  List<Nutritions>? nutritions;

  NutritionModel({this.reportTitle, this.nutritions});

  NutritionModel.fromJson(Map<String, dynamic> json) {
    reportTitle = json['report_title'];
    if (json['nutritions'] != null) {
      nutritions = <Nutritions>[];
      json['nutritions'].forEach((v) {
        nutritions!.add(new Nutritions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['report_title'] = this.reportTitle;
    if (this.nutritions != null) {
      data['nutritions'] = this.nutritions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nutritions {
  String? name;
  String? benefit;
  List<String>? sourceFoods;
  String? image;

  Nutritions({this.name, this.benefit, this.sourceFoods, this.image});

  Nutritions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    benefit = json['benefit'];
    image = json['image'];
    sourceFoods = json['source_foods'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['benefit'] = this.benefit;
    data['image'] = this.image;
    data['source_foods'] = this.sourceFoods;
    return data;
  }
}
