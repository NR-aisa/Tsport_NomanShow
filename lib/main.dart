import 'package:flutter/material.dart';

import 'core/session/app_session.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_theme_controller.dart';
import 'core/theme/app_typography.dart';
import 'core/theme/viewport_controller.dart';
import 'features/auth/screens/splash_screen.dart';
import 'features/display/screens/display_leaderboard_screen.dart';
import 'shared/widgets/arena_widgets.dart';

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
  bool _isControlsCollapsed = false;

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
              backgroundColor: isDark ? const Color(0xFF090B10) : const Color(0xFFE2E8F0),
              body: Stack(
                children: [
                  // Main Presentation Surface
                  Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      constraints: BoxConstraints(
                        maxWidth: _viewportMode == 3
                            ? double.infinity
                            : (_viewportMode == 2
                                ? double.infinity
                                : (_viewportMode == 1 ? 820 : 440)),
                        maxHeight: (_viewportMode == 3 || _viewportMode == 2)
                            ? double.infinity
                            : (_viewportMode == 1 ? 1040 : 900),
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: (_viewportMode == 2 || _viewportMode == 3) ? 0 : 16,
                        horizontal: (_viewportMode == 2 || _viewportMode == 3) ? 0 : (_viewportMode == 1 ? 20 : 10),
                      ),
                      decoration: BoxDecoration(
                        color: (_viewportMode == 2 || _viewportMode == 3)
                            ? (_viewportMode == 3
                                ? const Color(0xFF0C0E15)
                                : (isDark ? const Color(0xFF090B10) : const Color(0xFFF8FAFC)))
                            : AppColors.canvasBg,
                        borderRadius: BorderRadius.circular(
                          (_viewportMode == 2 || _viewportMode == 3)
                              ? 0
                              : (_viewportMode == 1 ? 24 : 44),
                        ),
                        boxShadow: (_viewportMode == 2 || _viewportMode == 3)
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: isDark ? 0.55 : 0.25),
                                  blurRadius: 36,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          (_viewportMode == 2 || _viewportMode == 3)
                              ? 0
                              : (_viewportMode == 1 ? 24 : 44),
                        ),
                        child: child ?? const SizedBox(),
                      ),
                    ),
                  ),

                  // Floating Presentation Switcher Bar (Top Right, Collapsible)
                  Positioned(
                    top: 14,
                    right: 20,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                      child: _isControlsCollapsed
                          ? SoftHoverButton(
                              key: const ValueKey('collapsed_controls'),
                              onTap: () => setState(() => _isControlsCollapsed = false),
                              builder: (context, isHovered) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 160),
                                  curve: Curves.easeOutCubic,
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: isHovered
                                        ? const Color(0xFF282F45).withValues(alpha: 0.98)
                                        : const Color(0xFF1A1D2B).withValues(alpha: 0.95),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isHovered
                                          ? Colors.white.withValues(alpha: 0.30)
                                          : Colors.white.withValues(alpha: 0.15),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: isHovered ? 0.60 : 0.45),
                                        blurRadius: isHovered ? 18 : 14,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.tune_rounded, size: 14, color: Color(0xFFFF5C38)),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Controls',
                                        style: AppTypography.ui(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(Icons.arrow_back_ios_new_rounded, size: 11, color: Colors.white70),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Container(
                              key: const ValueKey('expanded_controls'),
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1D2B).withValues(alpha: 0.95),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.12),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.45),
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
                                  // Subtle Vertical Divider
                                  Container(
                                    height: 16,
                                    width: 1,
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    color: isDark
                                        ? Colors.white.withValues(alpha: 0.15)
                                        : AppColors.slate300,
                                  ),
                                  // High-Visibility Light / Dark Theme Toggle
                                  _buildThemeTogglePill(isDark: isDark),
                                  const SizedBox(width: 4),
                                  // Collapse arrow button
                                  SoftHoverButton(
                                    onTap: () => setState(() => _isControlsCollapsed = true),
                                    builder: (context, isHovered) {
                                      return AnimatedContainer(
                                        duration: const Duration(milliseconds: 160),
                                        curve: Curves.easeOutCubic,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: isHovered
                                              ? Colors.white.withValues(alpha: 0.20)
                                              : Colors.white.withValues(alpha: 0.08),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 11,
                                          color: Colors.white70,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
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

  Widget _buildThemeTogglePill({required bool isDark}) {
    return SoftHoverButton(
      onTap: () => AppThemeController.toggleTheme(),
      builder: (context, isHovered) {
        final normalBg = isDark ? const Color(0xFF262A3C) : const Color(0xFF2C3246);
        final hoverBg = isDark ? const Color(0xFF383E58) : const Color(0xFF3E4660);
        final normalBorder = isDark
            ? const Color(0xFFFFA533).withValues(alpha: 0.4)
            : const Color(0xFFFF9A3C).withValues(alpha: 0.5);
        final hoverBorder = isDark
            ? const Color(0xFFFFA533).withValues(alpha: 0.8)
            : const Color(0xFFFF9A3C).withValues(alpha: 0.85);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
          decoration: BoxDecoration(
            color: isHovered ? hoverBg : normalBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovered ? hoverBorder : normalBorder,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                size: 13,
                color: isDark ? const Color(0xFFFFA533) : const Color(0xFFFF9A3C),
              ),
              const SizedBox(width: 4),
              Text(
                isDark ? 'Dark' : 'Light',
                style: AppTypography.ui(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
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
    return SoftHoverButton(
      onTap: onTap,
      builder: (context, isHovered) {
        final unselectedBg = isHovered ? Colors.white.withValues(alpha: 0.12) : Colors.transparent;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFFF4B72) // Luxury Coral Rose
                : unselectedBg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 13,
                color: isSelected || isHovered ? Colors.white : Colors.white70,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: AppTypography.ui(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: isSelected || isHovered ? Colors.white : Colors.white70,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
