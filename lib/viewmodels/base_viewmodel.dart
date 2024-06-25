import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wolt/constants/constants.dart';
import 'package:wolt/models/coordinate.dart';
import 'package:wolt/models/section_model.dart';
import 'package:wolt/services/api_service.dart';
import 'package:wolt/services/local_storage_service.dart';
import 'package:wolt/services/looper.dart';
// import 'package:provider/provider.dart';

class BaseViewmodel extends ChangeNotifier {
  BaseViewmodel() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _storage.initializeStorage();
    await initializeFavorites();
  }

  final LoopingService _loopingService = LoopingService();

  List<SectionModel>? _sections;

  List<SectionModel>? getSections() => _sections;

  Future<List<SectionModel>> fetchSections(Coordinate coordinate) async {
    print("fetch lat: ${coordinate.lat} lon: ${coordinate.lon}");
    return await ApiService().getRestaurant(coordinate);
  }

  Future<void> startCoordinateLooping() async {
    await _loopingService.startLooping<Coordinate>(
      Constants.coordinates,
      const Duration(seconds: 12),
      (Coordinate coordinate) async {
        _sections = await fetchSections(coordinate);
        notifyListeners();
      },
    );
  }

  Coordinate? _coordinate;

  setCoordinate(Coordinate newCoordinate) {
    _coordinate = newCoordinate;
    ChangeNotifier();
  }

  Coordinate? getCoordinate() => _coordinate;

  final LocalStorageService _storage = LocalStorageService();

  List<String> _favorites = [];

  List<String> getFavorites() => _favorites;

  void toggleFavorite(String id) {
    //setFavorite
    if (!_favorites.contains(id)) {
      _favorites.add(id);
    } else {
      _favorites.remove(id);
    }
    notifyListeners();
  }

  Future<void> initializeFavorites() async {
    _favorites = await _storage.getIDs();
    notifyListeners();
  }
}
