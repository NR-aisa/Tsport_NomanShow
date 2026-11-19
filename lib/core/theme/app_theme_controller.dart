import 'package:flutter/material.dart';

/// Global controller managing the application's ThemeMode (Dark / Light).
class AppThemeController {
  AppThemeController._();

  static final ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

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

/// A reactive widget builder that automatically rebuilds whenever the global
/// AppThemeController.isDarkMode changes.
class ThemeScope extends StatelessWidget {
  final Widget Function(BuildContext context, bool isDark) builder;

  const ThemeScope({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppThemeController.isDarkMode,
      builder: (context, isDark, _) => builder(context, isDark),
    );
  }
}
