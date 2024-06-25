class ImageModel {
  ImageModel({required this.imageURL});

  String imageURL = "";
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      imageURL: json['url'] ?? '',
    );
  }
}
