import 'package:flutter/material.dart';
import 'light_mode.dart';
import 'dark_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkTheme;

  void setThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = _themeData == lightTheme ? _themeData = darkTheme : lightTheme;
    notifyListeners();
  }
}
