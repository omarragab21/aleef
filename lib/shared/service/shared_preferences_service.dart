import 'package:shared_preferences/shared_preferences.dart';

/// A service class that handles all shared preferences operations.
/// This class provides methods to save, retrieve, and delete data from shared preferences.
abstract final class SharedPreferencesService {
  const SharedPreferencesService._();

  static SharedPreferences? _prefs;

  /// Initializes the shared preferences instance.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Saves a string value to shared preferences.
  static Future<bool> setString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  /// Saves a boolean value to shared preferences.
  static Future<bool> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  /// Saves an integer value to shared preferences.
  static Future<bool> setInt(String key, int value) async {
    return await _prefs?.setInt(key, value) ?? false;
  }

  /// Saves a double value to shared preferences.
  static Future<bool> setDouble(String key, double value) async {
    return await _prefs?.setDouble(key, value) ?? false;
  }

  /// Saves a list of strings to shared preferences.
  static Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs?.setStringList(key, value) ?? false;
  }

  /// Retrieves a string value from shared preferences.
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// Retrieves a boolean value from shared preferences.
  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  /// Retrieves an integer value from shared preferences.
  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// Retrieves a double value from shared preferences.
  static double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  /// Retrieves a list of strings from shared preferences.
  static List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  /// Checks if a key exists in shared preferences.
  static bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  /// Removes a value from shared preferences.
  static Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  /// Clears all data from shared preferences.
  static Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }

  /// Returns all keys in shared preferences.
  static Set<String> getKeys() {
    return _prefs?.getKeys() ?? {};
  }

  /// Reloads the shared preferences instance.
  static Future<void> reload() async {
    await _prefs?.reload();
  }
}
