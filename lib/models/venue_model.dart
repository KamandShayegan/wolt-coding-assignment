class VenueModel {
  final String id;
  final String name;
  final String shortDescription;

  VenueModel(
      {required this.id, required this.name, required this.shortDescription});

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      shortDescription: json['short_description'] ?? '',
    );
  }
}
