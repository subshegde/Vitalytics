class ProgressImagesModel {
  final List<ProgressImageItem> images;

  ProgressImagesModel({required this.images});

  factory ProgressImagesModel.fromJson(Map<String, dynamic> json) {
    return ProgressImagesModel(
      images: (json["images"] as List? ?? [])
          .map((item) => ProgressImageItem.fromJson(item))
          .toList(),
    );
  }
}

class ProgressImageItem {
  final String base64Image;
  final double confidenceScore;

  ProgressImageItem({
    required this.base64Image,
    required this.confidenceScore,
  });

  factory ProgressImageItem.fromJson(Map<String, dynamic> json) {
    return ProgressImageItem(
      base64Image: json["image"] ?? "",
      confidenceScore: (json["confidence_score"] ?? 0).toDouble(),
    );
  }
}
