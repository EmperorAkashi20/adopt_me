import 'dart:developer';

import 'package:adopt_me/Utils/adopt_me_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkThemeProvider = ChangeNotifierProvider((ref) => DarkThemeProvider());

class DarkThemeProvider with ChangeNotifier {
  bool? _darkTheme = false;

  bool get darkTheme => _darkTheme!;

  _init() {
    getCurrentAppTheme();
  }

  DarkThemeProvider() {
    _init();
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    adoptMePref.setBool(PrefKey.THEME_STATUS, value);
    notifyListeners();
  }

  void getCurrentAppTheme() {
    _darkTheme = adoptMePref.getBool(PrefKey.THEME_STATUS)!;
    log(_darkTheme.toString());
  }
}
