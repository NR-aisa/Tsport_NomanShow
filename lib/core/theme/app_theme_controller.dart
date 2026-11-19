import 'package:flutter/material.dart';

/// Global controller managing the application's ThemeMode (Dark / Light).
class AppThemeController {
  AppThemeController._();

  static final ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(true);

  static bool get isDark => isDarkMode.value;

  static void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  static void setDarkMode(bool dark) {
    if (isDarkMode.value != dark) {
      isDarkMode.value = dark;
    }
  }
}
