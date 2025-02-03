import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  static SharedPreferences? preferencesInstance;
  String token = "token";
  static init() async {
    preferencesInstance ??= await SharedPreferences.getInstance();
  }

  /// Set string data
  static Future<bool> setString(String key, String value) {
    return preferencesInstance!.setString(key, value);
  }

  /// Get string data
  static String? getString(String key) {
    return preferencesInstance!.getString(key) ?? " ";
  }

  /// Remove string data
  static Future<bool> removeString(String key) {
    return preferencesInstance!.remove(key);
  }

  /// Set true false data
  static Future<bool> setBoolValue(String key, bool value) {
    return preferencesInstance!.setBool(key, value);
  }

  /// Get true false data
  static bool? getBoolValue(String key) {
    return preferencesInstance?.getBool(key);
  }

  /// Set int value
  static Future<bool> setIntValue(String key, int value) {
    return preferencesInstance!.setInt(key, value);
  }

  /// Get int value
  static int? getIntValue(String key) {
    return preferencesInstance!.getInt(key);
  }
}
