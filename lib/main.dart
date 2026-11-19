import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_theme_controller.dart';
import 'features/auth/screens/splash_screen.dart';
import 'features/display/screens/display_leaderboard_screen.dart';

void main() {
  runApp(const JomnittakuApp());
}

class JomnittakuApp extends StatefulWidget {
  const JomnittakuApp({super.key});

  @override
  State<JomnittakuApp> createState() => _JomnittakuAppState();
}

class _JomnittakuAppState extends State<JomnittakuApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  bool _isWidescreenTv = false;

  void openTvDisplay() {
    setState(() => _isWidescreenTv = true);
    _navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => const DisplayLeaderboardScreen()),
    );
  }

  void openMobileFlow() {
    setState(() => _isWidescreenTv = false);
    _navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SplashScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppThemeController.isDarkMode,
      builder: (context, isDark, _) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          title: 'JOMNITTAKU — No Man Show',
          debugShowCheckedModeBanner: false,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          home: const SplashScreen(),
          builder: (context, child) {
            final screenWidth = MediaQuery.of(context).size.width;
            final isDesktop = screenWidth > 600;

            if (!isDesktop) {
              return child ?? const SizedBox();
            }

            return Scaffold(
              backgroundColor: isDark ? const Color(0xFF070D18) : const Color(0xFFE2E8F0),
              body: Stack(
                children: [
                  // Main Presentation Surface
                  Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      constraints: BoxConstraints(
                        maxWidth: _isWidescreenTv ? 1440 : 440,
                        maxHeight: _isWidescreenTv ? double.infinity : 900,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: _isWidescreenTv ? 0 : 20,
                        horizontal: _isWidescreenTv ? 24 : 0,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.canvasBg,
                        borderRadius: BorderRadius.circular(_isWidescreenTv ? 20 : 44),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: isDark ? 0.55 : 0.15),
                            blurRadius: 36,
                            offset: const Offset(0, 16),
                          ),
                        ],
                        border: Border.all(
                          color: isDark ? const Color(0xFF1E2D4A) : const Color(0xFFCBD5E1),
                          width: _isWidescreenTv ? 3 : 8,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(_isWidescreenTv ? 16 : 36),
                        child: child,
                      ),
                    ),
                  ),

                  // Minimal Top-Right Device Viewport & Theme Switcher (Production)
                  Positioned(
                    top: 14,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF111D33) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark ? Colors.white.withValues(alpha: 0.12) : const Color(0xFFCBD5E1),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Theme Switcher: Dark / Light
                          GestureDetector(
                            onTap: () => AppThemeController.toggleTheme(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isDark ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                                    size: 13,
                                    color: isDark ? const Color(0xFFF59E0B) : const Color(0xFFD97706),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    isDark ? 'Dark' : 'Light',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),

                          // Mobile Phone View
                          GestureDetector(
                            onTap: openMobileFlow,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: !_isWidescreenTv ? const Color(0xFF2563EB) : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.phone_iphone_rounded,
                                    size: 13,
                                    color: !_isWidescreenTv
                                        ? Colors.white
                                        : (isDark ? Colors.white60 : const Color(0xFF64748B)),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Mobile',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: !_isWidescreenTv
                                          ? Colors.white
                                          : (isDark ? Colors.white60 : const Color(0xFF64748B)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),

                          // 55" Venue TV Arena View
                          GestureDetector(
                            onTap: openTvDisplay,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: _isWidescreenTv ? const Color(0xFF2563EB) : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.tv_rounded,
                                    size: 13,
                                    color: _isWidescreenTv
                                        ? Colors.white
                                        : (isDark ? Colors.white60 : const Color(0xFF64748B)),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '55" TV',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: _isWidescreenTv
                                          ? Colors.white
                                          : (isDark ? Colors.white60 : const Color(0xFF64748B)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
