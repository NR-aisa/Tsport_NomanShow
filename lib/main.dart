import 'package:flutter/material.dart';

import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_theme_controller.dart';
import 'features/auth/screens/entry_gate_screen.dart';
import 'features/display/screens/display_leaderboard_screen.dart';
import 'core/theme/app_typography.dart';

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
  int _viewportMode = 2; // 0 = Mobile (440px), 1 = Tab (820px), 2 = Desktop Web (Full bleed), 3 = 55" TV (1440px)

  void openTvDisplay() {
    setState(() => _viewportMode = 3);
    _navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => const DisplayLeaderboardScreen()),
    );
  }

  void openWebDisplay() {
    setState(() => _viewportMode = 2);
    if (_navigatorKey.currentState?.canPop() == true) {
      _navigatorKey.currentState?.pop();
    }
  }

  void openTabDisplay() {
    setState(() => _viewportMode = 1);
    if (_navigatorKey.currentState?.canPop() == true) {
      _navigatorKey.currentState?.pop();
    }
  }

  void openMobileFlow() {
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
          title: 'JOMNITTAKU — No Man Show',
          debugShowCheckedModeBanner: false,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          home: const EntryGateScreen(),
          builder: (context, child) {
            final screenWidth = MediaQuery.of(context).size.width;
            final isDesktop = screenWidth > 600;

            if (!isDesktop) {
              return child ?? const SizedBox();
            }

            return Scaffold(
              backgroundColor: isDark ? AppColors.darkObsidianBase : AppColors.lightBorder,
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
                        color: AppColors.canvasBg,
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
                        border: _viewportMode == 2
                            ? null
                            : Border.all(
                                color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate300,
                                width: _viewportMode == 3 ? 3 : (_viewportMode == 1 ? 6 : 8),
                              ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          _viewportMode == 2
                              ? 0
                              : (_viewportMode == 3 ? 16 : (_viewportMode == 1 ? 18 : 36)),
                        ),
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
                        color: isDark ? AppColors.darkObsidianElevated : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? Colors.white.withValues(alpha: 0.12) : AppColors.slate300,
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
                                color: isDark ? AppColors.paddleBlack : AppColors.lightCanvasBg,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isDark ? Colors.white.withValues(alpha: 0.08) : AppColors.lightBorder,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                                    size: 13,
                                    color: isDark ? AppColors.radiantGold : AppColors.pingPongOrange,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    isDark ? 'Dark' : 'Light',
                                    style: AppTypography.ui(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: isDark ? Colors.white : AppColors.slate900,
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
                                color: _viewportMode == 0 ? AppColors.ittfTableSurface : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.phone_iphone_rounded,
                                    size: 13,
                                    color: _viewportMode == 0
                                        ? Colors.white
                                        : (isDark ? Colors.white60 : AppColors.slate500),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Mobile',
                                    style: AppTypography.ui(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: _viewportMode == 0
                                          ? Colors.white
                                          : (isDark ? Colors.white60 : AppColors.slate500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),

                          // Tablet / Tab View (iPad 820px)
                          GestureDetector(
                            onTap: openTabDisplay,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: _viewportMode == 1 ? AppColors.ittfTableSurface : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.tablet_mac_rounded,
                                    size: 13,
                                    color: _viewportMode == 1
                                        ? Colors.white
                                        : (isDark ? Colors.white60 : AppColors.slate500),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Tab',
                                    style: AppTypography.ui(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: _viewportMode == 1
                                          ? Colors.white
                                          : (isDark ? Colors.white60 : AppColors.slate500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),

                          // Desktop Web View (Full-bleed responsive website)
                          GestureDetector(
                            onTap: openWebDisplay,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: _viewportMode == 2 ? AppColors.ittfTableSurface : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.laptop_chromebook_rounded,
                                    size: 13,
                                    color: _viewportMode == 2
                                        ? Colors.white
                                        : (isDark ? Colors.white60 : AppColors.slate500),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Web',
                                    style: AppTypography.ui(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: _viewportMode == 2
                                          ? Colors.white
                                          : (isDark ? Colors.white60 : AppColors.slate500),
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
                                color: _viewportMode == 3 ? AppColors.ittfTableSurface : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.tv_rounded,
                                    size: 13,
                                    color: _viewportMode == 3
                                        ? Colors.white
                                        : (isDark ? Colors.white60 : AppColors.slate500),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '55" TV',
                                    style: AppTypography.ui(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: _viewportMode == 3
                                          ? Colors.white
                                          : (isDark ? Colors.white60 : AppColors.slate500),
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
