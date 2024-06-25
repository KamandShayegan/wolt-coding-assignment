import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late SharedPreferences _sharedPref;

  static const String _listKey = 'IDs';

  Future initializeStorage() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  Future addID(String id) async {
    List<String> IDs = _sharedPref.getStringList(_listKey) ?? [];
    if (!_listKey.contains(id)) {
      IDs.add(id);
      await _sharedPref.setStringList(_listKey, IDs);
    }
  }

  Future<void> deleteID(String id) async {
    List<String> IDs = _sharedPref.getStringList(_listKey) ?? [];
    IDs.remove(id);
    await _sharedPref.setStringList(_listKey, IDs);
  }

  Future<List<String>> getIDs() async {
    List<String> ids = _sharedPref.getStringList(_listKey) ?? [];
    return ids;
  }
}
