import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  static const String key = "theme_mode";

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      // Ideally we would access SchedulerBinding.instance.window.platformBrightness
      // But for the switch state, simpler to default to false or try to detect system.
      // However, usually manual toggle overrides system.
      // Let's just say if it's strictly dark, return true.
      return _themeMode == ThemeMode.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  void toggleTheme(bool isDark) async {
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
