class DietRequest {
  final String userId;
  final String diseaseType;
  final String query;

  DietRequest({
    required this.userId,
    required this.diseaseType,
    required this.query,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "disease_type": diseaseType,
      "query": query,
    };
  }
}
