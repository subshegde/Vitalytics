class NutritionRequest {
  final String name;
  final String diseaseType;
  final String query;

  NutritionRequest({
    required this.name,
    required this.diseaseType,
    required this.query,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "disease_type": diseaseType,
        "query": query,
      };
}
