import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';

class StorageService {
  static StorageService? _instance;
  static StorageService get instance => _instance ??= StorageService._();

  StorageService._();

  SharedPreferences? _prefs;

  /// Initialize storage service
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save string value
  Future<bool> setString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  /// Get string value
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// Save object as JSON
  Future<bool> setObject(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    return await setString(key, jsonString);
  }

  /// Get object from JSON
  Map<String, dynamic>? getObject(String key) {
    final jsonString = getString(key);
    if (jsonString != null) {
      try {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Save boolean value
  Future<bool> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  /// Get boolean value
  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  /// Remove value
  Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  /// Clear all values
  Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }

  /// Check if key exists
  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  // Auth specific methods
  Future<bool> saveUserData(Map<String, dynamic> userData) async {
    return await setObject(AppConfig.userDataKey, userData);
  }

  Map<String, dynamic>? getUserData() {
    return getObject(AppConfig.userDataKey);
  }

  Future<bool> clearUserData() async {
    return await remove(AppConfig.userDataKey);
  }
}
