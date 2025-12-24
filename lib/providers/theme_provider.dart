import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the application's theme mode (Light, Dark, System).
///
/// This provider handles:
/// - Persisting the user's theme preference using [SharedPreferences].
/// - Toggling between light and dark modes.
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  static const String key = "theme_mode";

  // -- Getters --
  ThemeMode get themeMode => _themeMode;

  /// Returns true if the current theme is effectively dark.
  /// Note: This logic assumes 'System' might default to light if not explicitly checked against platform brightness here,
  /// but `MaterialApp` handles system mode automatically. This is mostly for internal switch state.
  bool get isDarkMode {
    return _themeMode == ThemeMode.dark;
  }

  ThemeProvider() {
    _loadTheme();
  }

  // -- Actions --

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    _saveTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final String? themeString = prefs.getString(key);

    if (themeString != null) {
      if (themeString == 'ThemeMode.dark') {
        _themeMode = ThemeMode.dark;
      } else if (themeString == 'ThemeMode.light') {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.system;
      }
      notifyListeners();
    }
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, _themeMode.toString());
  }
}
