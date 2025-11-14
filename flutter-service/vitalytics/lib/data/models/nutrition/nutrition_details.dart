class NutritionDetailsModel {
  String? itemName;
  String? category;
  String? description;
  List<KeyNutrients>? keyNutrients;

  NutritionDetailsModel(
      {this.itemName, this.category, this.description, this.keyNutrients});

  NutritionDetailsModel.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    category = json['category'];
    description = json['description'];
    if (json['key_nutrients'] != null) {
      keyNutrients = <KeyNutrients>[];
      json['key_nutrients'].forEach((v) {
        keyNutrients!.add(new KeyNutrients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['category'] = this.category;
    data['description'] = this.description;
    if (this.keyNutrients != null) {
      data['key_nutrients'] =
          this.keyNutrients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KeyNutrients {
  String? nutrient;
  String? amount;

  KeyNutrients({this.nutrient, this.amount});

  KeyNutrients.fromJson(Map<String, dynamic> json) {
    nutrient = json['nutrient'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nutrient'] = this.nutrient;
    data['amount'] = this.amount;
    return data;
  }
}