import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static bool _isInstanceInitialized = false;
  static bool _isPreferenceInitialized = false;
  static late SharedPreferenceService _instance;
  static late SharedPreferences _preferences;

  static Future<SharedPreferenceService> getInstance() async {
    if (!_isInstanceInitialized) {
      _isInstanceInitialized = true;
      _instance = SharedPreferenceService();
    }

    if (!_isPreferenceInitialized) {
      _isPreferenceInitialized = true;
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  dynamic getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  void saveToDisk(String key, String value) {
    _preferences.setString(key, value);
  }

  void removeFromDisk(String key) {
    _preferences.remove(key);
  }
}
