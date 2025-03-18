import 'dart:convert';

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

  /// Set a List of Strings
  static Future<bool> setStringList(String key, List<String> value) {
    return preferencesInstance!.setStringList(key, value);
  }

  /// Get a list String
  static List<String>? getStringList(String key) {
    return preferencesInstance!.getStringList(key);
  }

  /// Remove an item from the list stored
  static Future<bool> removeEntireItem(String key) {
    return preferencesInstance!.remove(key);
  }

  /// Remove an item from the list
  static Future<bool> removeListItem(String key, String item) async {
    List<String>? currentList = preferencesInstance?.getStringList(key);
    if (currentList != null && currentList.contains(item)) {
      currentList.remove(item);
      return await preferencesInstance!.setStringList(key, currentList);
    }
    return Future.value(false);
  }

  // Remove a product from a list of cart items
  static Future<bool> removeCartListItem(String key, String itemId) async {
    // Retrieve the list of cart items (stored as JSON strings)
    List<String>? currentList = preferencesInstance?.getStringList(key);

    // If the list exists
    if (currentList != null) {
      // Decode the JSON strings into maps
      List<Map<String, dynamic>> decodedList = currentList
          .map((itemJson) => Map<String, dynamic>.from(jsonDecode(itemJson)))
          .toList();

      // Find the item and remove it by matching productId
      decodedList.removeWhere((item) => item['productId'] == itemId);

      // Convert the updated list back to JSON strings
      List<String> updatedList = decodedList
          .map((item) => jsonEncode(item))
          .toList();

      // Save the updated list back to SharedPreferences
      return await preferencesInstance!.setStringList(key, updatedList);
    }

    // Return false if the list doesn't exist or the item isn't found
    return Future.value(false);
  }

  /// Add a product ID to a dynamic list (allowing duplicates)
  static Future<void> addProductToList(String key, String productId) async {
    // Retrieve the current list of product IDs for the given key
    List<String>? currentList = preferencesInstance!.getStringList(key);

    // If no list is found, initialize an empty list
    currentList ??= [];

    // Simply add the product ID to the list (duplicates allowed)
    currentList.add(productId);

    // Save the updated list back to SharedPreferences
    await preferencesInstance!.setStringList(key, currentList);
  }

  // Add a product to the list in SharedPreferences
  static Future<void> addCartProductToList(String key, String productId,
      String size, String caratBy, String colorBy) async {
    // Retrieve the current list of products for the given key
    List<String>? currentList = preferencesInstance!.getStringList(key);

    // If no list is found, initialize an empty list
    currentList ??= [];

    // Create a new product map
    Map<String, String> product = {
      "productId": productId,
      "size": size,
      "caratBy": caratBy,
      "colorBy": colorBy,
    };

    // Convert the product map to a JSON string
    String productJson = jsonEncode(product);

    // Add the product JSON string to the list
    currentList.add(productJson);

    // Save the updated list back to SharedPreferences
    await preferencesInstance!.setStringList(key, currentList);
  }
}
