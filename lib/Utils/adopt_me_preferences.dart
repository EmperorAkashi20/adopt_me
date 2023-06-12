import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

final adoptMePref = AdoptMePreferences._();

class AdoptMePreferences {
  AdoptMePreferences._();

  late SharedPreferences _preferences;

  ///Initializes the [_preferences], to be called in main before using any preferences
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// bool.
  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  /// Saves a boolean [value] to persistent storage in the background.
  Future<bool> setBool(String key, bool value) {
    log('setBool $key: $value', name: 'ARRE_PREFERENCES');
    return _preferences.setBool(key, value);
  }
}

abstract class PrefKey {
  static const THEME_STATUS = "THEMESTATUS";
}
