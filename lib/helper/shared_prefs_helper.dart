import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  static String? getString(String key) {
    return _preferences.getString(key);
  }

  static Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  static Future<bool> clearData() async {
    return await _preferences.clear();
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static setSecuredString(String key, String value) async {
    const flutterSecureStorage = FlutterSecureStorage();

    await flutterSecureStorage.write(key: key, value: value);
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  static getSecuredString(String key) async {
    const flutterSecureStorage = FlutterSecureStorage();
    return await flutterSecureStorage.read(key: key) ?? '';
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static clearAllSecuredData() async {
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.deleteAll();
  }
}
