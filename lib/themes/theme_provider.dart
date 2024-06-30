import 'package:flutter/material.dart';
import 'light_mode.dart';
import 'dark_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkTheme;

  void setThemeData({required bool isDarkMode}) {
    // _themeData = themeData;
    if (isDarkMode) {
      _themeData = darkTheme;
    } else {
      _themeData = lightTheme;
    }
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = _themeData == lightTheme ? _themeData = darkTheme : lightTheme;
    notifyListeners();
  }
}
