import 'package:wolt/models/coordinate.dart';

///A class that contains immutable values used in
///the application. For example the list of coordinates, endpoints, constant colors,
///fonts, etc.
class Constants {
  static const baseURL = "https://restaurant-api.wolt.com/v1/pages/restaurants";

  static List<Coordinate> coordinates = [
    Coordinate(60.170187, 24.930599),
    Coordinate(60.169418, 24.931618),
    Coordinate(60.169818, 24.932906),
    Coordinate(60.170005, 24.935105),
    Coordinate(60.169108, 24.936210),
    Coordinate(60.168355, 24.934869),
    Coordinate(60.167560, 24.932562),
    Coordinate(60.168254, 24.931532),
    Coordinate(60.169012, 24.930341),
    Coordinate(60.170085, 24.929569),
  ];

  static const String favoriteFalse = "assets/svg/favorite_false.svg";
  static const String favoriteTrue = "assets/svg/favorite_true.svg";

  static const String appBarText = "Find your favorite place to eat!";
}
