import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../splash/data/repositories/splash_repository_impl.dart';

final themeProvider = StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeController(prefs);
});

class ThemeController extends StateNotifier<ThemeMode> {
  final SharedPreferences _prefs;
  static const _themeKey = 'app_theme_mode';

  ThemeController(this._prefs) : super(_loadThemeMode(_prefs));

  static ThemeMode _loadThemeMode(SharedPreferences prefs) {
    final savedMode = prefs.getString(_themeKey);
    if (savedMode == 'light') return ThemeMode.light;
    if (savedMode == 'dark') return ThemeMode.dark;
    return ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    String saveValue = 'system';
    if (mode == ThemeMode.light) saveValue = 'light';
    if (mode == ThemeMode.dark) saveValue = 'dark';
    await _prefs.setString(_themeKey, saveValue);
  }
}
