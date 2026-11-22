import 'package:flutter/material.dart';

import 'core/session/app_session.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_theme_controller.dart';
import 'core/theme/app_typography.dart';
import 'core/theme/viewport_controller.dart';
import 'features/auth/screens/splash_screen.dart';
import 'features/display/screens/display_leaderboard_screen.dart';

void main() {
  AppSession.signInMember();
  runApp(const JomnittakuApp());
}

class JomnittakuApp extends StatefulWidget {
  const JomnittakuApp({super.key});

  @override
  State<JomnittakuApp> createState() => _JomnittakuAppState();
}

class _JomnittakuAppState extends State<JomnittakuApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _viewportMode = 2; // 0 = Mobile (440px), 1 = Tab (820px), 2 = Desktop Web (Full bleed), 3 = 55" TV (1440px)

  @override
  void initState() {
    super.initState();
    _viewportMode = ViewportController.mode.value;
    ViewportController.mode.addListener(_onModeChanged);
  }

  @override
  void dispose() {
    ViewportController.mode.removeListener(_onModeChanged);
    super.dispose();
  }

  void _onModeChanged() {
    if (mounted && _viewportMode != ViewportController.mode.value) {
      setState(() => _viewportMode = ViewportController.mode.value);
    }
  }

  void openTvDisplay() {
    ViewportController.setMode(3);
    setState(() => _viewportMode = 3);
    _navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => const DisplayLeaderboardScreen()),
    );
  }

  void openWebDisplay() {
    ViewportController.setMode(2);
    setState(() => _viewportMode = 2);
    if (_navigatorKey.currentState?.canPop() == true) {
      _navigatorKey.currentState?.pop();
    }
  }

  void openTabDisplay() {
    ViewportController.setMode(1);
    setState(() => _viewportMode = 1);
    if (_navigatorKey.currentState?.canPop() == true) {
      _navigatorKey.currentState?.pop();
    }
  }

  void openMobileFlow() {
    ViewportController.setMode(0);
    setState(() => _viewportMode = 0);
    if (_navigatorKey.currentState?.canPop() == true) {
      _navigatorKey.currentState?.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppThemeController.isDarkMode,
      builder: (context, isDark, _) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          title: 'JOMNITTAKU — 24/7 Autonomous Table Tennis Arena',
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
              backgroundColor: isDark ? const Color(0xFF10121A) : AppColors.lightBorder,
              body: Stack(
                children: [
                  // Main Presentation Surface
                  Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      constraints: BoxConstraints(
                        maxWidth: _viewportMode == 3
                            ? 1440
                            : (_viewportMode == 2
                                ? double.infinity
                                : (_viewportMode == 1 ? 820 : 440)),
                        maxHeight: (_viewportMode == 3 || _viewportMode == 2)
                            ? double.infinity
                            : (_viewportMode == 1 ? 1040 : 900),
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: (_viewportMode == 2 || _viewportMode == 3) ? 0 : 16,
                        horizontal: _viewportMode == 2 ? 0 : (_viewportMode == 3 ? 24 : 10),
                      ),
                      decoration: BoxDecoration(
                        color: _viewportMode == 2 ? const Color(0xFF161720) : AppColors.canvasBg,
                        borderRadius: BorderRadius.circular(
                          _viewportMode == 2
                              ? 0
                              : (_viewportMode == 3 ? 20 : (_viewportMode == 1 ? 24 : 44)),
                        ),
                        boxShadow: _viewportMode == 2
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: isDark ? 0.55 : 0.15),
                                  blurRadius: 36,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          _viewportMode == 2
                              ? 0
                              : (_viewportMode == 3 ? 20 : (_viewportMode == 1 ? 24 : 44)),
                        ),
                        child: child ?? const SizedBox(),
                      ),
                    ),
                  ),

                  // Floating Presentation Switcher Bar (Top Right)
                  Positioned(
                    top: 14,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E2232).withValues(alpha: 0.92)
                            : Colors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isDark ? Colors.white.withValues(alpha: 0.12) : AppColors.slate300,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: isDark ? 0.40 : 0.10),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Mobile View
                          _buildModePill(
                            icon: Icons.phone_iphone_rounded,
                            label: 'Mobile',
                            isSelected: _viewportMode == 0,
                            onTap: openMobileFlow,
                            isDark: isDark,
                          ),
                          const SizedBox(width: 3),
                          // Tablet View
                          _buildModePill(
                            icon: Icons.tablet_mac_rounded,
                            label: 'Tab',
                            isSelected: _viewportMode == 1,
                            onTap: openTabDisplay,
                            isDark: isDark,
                          ),
                          const SizedBox(width: 3),
                          // Web View
                          _buildModePill(
                            icon: Icons.laptop_chromebook_rounded,
                            label: 'Web',
                            isSelected: _viewportMode == 2,
                            onTap: openWebDisplay,
                            isDark: isDark,
                          ),
                          const SizedBox(width: 3),
                          // 55" TV View
                          _buildModePill(
                            icon: Icons.tv_rounded,
                            label: '55" TV',
                            isSelected: _viewportMode == 3,
                            onTap: openTvDisplay,
                            isDark: isDark,
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

  Widget _buildModePill({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected
              ? (const Color(0xFFFF4B72)) // Luxury Coral Rose
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13,
              color: isSelected ? Colors.white : (isDark ? Colors.white60 : AppColors.slate500),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTypography.ui(
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                color: isSelected ? Colors.white : (isDark ? Colors.white60 : AppColors.slate500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
