import 'package:wolt/models/image_model.dart';
import 'package:wolt/models/venue_model.dart';

class ItemModel {
  final VenueModel venue;
  final ImageModel image;

  ItemModel({required this.venue, required this.image});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> venueJson = json['venue'] ?? {};
    final VenueModel venue = VenueModel.fromJson(venueJson);
    final Map<String, dynamic> imageJson = json['image'] ?? {};
    final ImageModel image = ImageModel.fromJson(imageJson);
    return ItemModel(venue: venue, image: image);
  }
}
