import 'package:flutter/material.dart';

import 'core/session/app_session.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_theme_controller.dart';
import 'features/auth/screens/splash_screen.dart';

void main() {
  AppSession.signInMember();
  runApp(const JomnittakuApp());
}

class JomnittakuApp extends StatelessWidget {
  const JomnittakuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppThemeController.isDarkMode,
      builder: (context, isDark, _) {
        return MaterialApp(
          title: 'JOMNITTAKU — 24/7 Autonomous Table Tennis Arena',
          debugShowCheckedModeBanner: false,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          home: const SplashScreen(),
          builder: (context, child) {
            return child ?? const SizedBox();
          },
        );
      },
    );
  }
}
