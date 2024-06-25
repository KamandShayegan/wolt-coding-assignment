class VenueModel {
  final String id;
  final String name;
  final String shortDescription;
  bool isFavorite;

  VenueModel(
      {required this.id,
      required this.name,
      required this.shortDescription,
      this.isFavorite = false});

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      shortDescription: json['short_description'] ?? '',
    );
  }
}
