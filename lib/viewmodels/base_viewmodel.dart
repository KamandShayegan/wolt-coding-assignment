import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wolt/constants/constants.dart';
import 'package:wolt/constants/enums.dart';
import 'package:wolt/models/coordinate.dart';
import 'package:wolt/models/section_model.dart';
import 'package:wolt/services/api_service.dart';
import 'package:wolt/services/local_storage_service.dart';
import 'package:wolt/services/looper.dart';

class BaseViewmodel extends ChangeNotifier {
  ///Takes care of state management of the application
  ///State management includes: taking care of
  ///local storage handling, calling API, changing coordinates,
  ///handling favorites, and the API state

  final Dio _dio;
  final LoopingService _loopingService;
  BaseViewmodel(this._dio, this._loopingService) {
    _initialize();
  }

  Future<void> _initialize() async {
    await _storage.initializeStorage();
    await initializeFavorites();
  }

  List<SectionModel>? _sections;

  List<SectionModel>? get sections => _sections;

  Future<List<SectionModel>> fetchSections(Coordinate coordinate) async {
    print("fetch lat: ${coordinate.lat} lon: ${coordinate.lon}");
    return await ApiService(this, _dio).getRestaurant(coordinate);
  }

  Future<void> startCoordinateLooping() async {
    /*Gets the coordinate list and duration, and starts
    traversing through the list*/
    await _loopingService.startLooping<Coordinate>(
      Constants.coordinates,
      const Duration(seconds: 10),
      (Coordinate coordinate) async {
        _sections = await fetchSections(coordinate);
        notifyListeners();
      },
    );
  }

  stopLooping() {
    //Stops the traverser - not practically used
    _loopingService.stopLooping();
    _state = ApiState.idle;
    notifyListeners();
  }

  Coordinate? _coordinate;

  void setCoordinate(Coordinate newCoordinate) {
    _coordinate = newCoordinate;
    ChangeNotifier();
  }

  Coordinate? getCoordinate() => _coordinate;

  final LocalStorageService _storage = LocalStorageService();

  List<String> _favorites = []; //faster to work with than shared preferences

  List<String> getFavorites() => _favorites;

  void toggleFavorite(String id) async {
    //setFavorite and update storage
    if (_favorites.contains(id)) {
      _favorites.remove(id);
      _storage.deleteID(id);
    } else {
      _favorites.add(id);
      _storage.addID(id);
    }
    notifyListeners();
  }

  bool isFavorite(String id) {
    if (_favorites.contains(id)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> initializeFavorites() async {
    //take the favorites list from the storage
    _favorites = await _storage.getIDs();
    notifyListeners();
  }

  ApiState _state = ApiState.initial;

  ApiState get state => _state;

  void setAPIState(ApiState newState) {
    if (_state != newState) {
      _state = newState;
      notifyListeners();
    }
  }
}
