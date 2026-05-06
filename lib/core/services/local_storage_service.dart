import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract interface class LocalStorageService {
  Future<String?> readString(String key);

  Future<void> writeString(String key, String value);

  Future<Map<String, dynamic>?> readJsonMap(String key);

  Future<void> writeJsonMap(String key, Map<String, dynamic> value);

  Future<void> remove(String key);
}

class SharedPreferencesLocalStorageService implements LocalStorageService {
  const SharedPreferencesLocalStorageService({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<String?> readString(String key) async {
    return sharedPreferences.getString(key);
  }

  @override
  Future<void> writeString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  @override
  Future<Map<String, dynamic>?> readJsonMap(String key) async {
    final rawValue = await readString(key);
    if (rawValue == null || rawValue.trim().isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(rawValue);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      await remove(key);
      return null;
    } on FormatException {
      await remove(key);
      return null;
    }
  }

  @override
  Future<void> writeJsonMap(String key, Map<String, dynamic> value) async {
    await writeString(key, jsonEncode(value));
  }

  @override
  Future<void> remove(String key) async {
    await sharedPreferences.remove(key);
  }
}
