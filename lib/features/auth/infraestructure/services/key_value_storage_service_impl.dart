// ignore_for_file: type_literal_in_constant_pattern

import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getPreferences();

    switch (T) {
      case String:
        return prefs.getString(key) as T?;

      case int:
        return prefs.getInt(key) as T?;

      default:
        throw Exception('Type $T not supported');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getPreferences();

    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getPreferences();

    switch (T) {
      case String:
        prefs.setString(key, value as String);
        break;
      case int:
        prefs.setInt(key, value as int);
        break;
      default:
        throw Exception('Type $T not supported');
    }
  }
}
