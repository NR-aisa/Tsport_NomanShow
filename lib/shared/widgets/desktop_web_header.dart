import 'dart:ui';
import 'package:flutter/material.dart';

import '../../core/navigation/app_navigator.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_controller.dart';
import '../../core/theme/app_typography.dart';
import '../../features/display/screens/display_leaderboard_screen.dart';

/// Elite Commercial Desktop Web Header Navbar.
///
/// Designed for true commercial desktop website browsing (>= 800px):
///  - Brand crest & live venue status indicator (3 Damansara · 6/10 Free)
///  - Direct in-page anchor scroll navigation:
///    * Overview
///    * How It Works
///    * 10 Courts Floorplan
///    * Rates & Passes
///    * Arena League
///    * Location & Specs
///  - Direct 55" Stadium TV launcher button
///  - Dark / Light mode toggle
///  - High-converting primary CTA: Walk In Tonight (RM17) →
class DesktopWebHeader extends StatelessWidget {
  final VoidCallback? onHomeTap;
  final VoidCallback? onHowItWorksTap;
  final VoidCallback? onFloorplanTap;
  final VoidCallback? onPricingTap;
  final VoidCallback? onLeaderboardTap;
  final VoidCallback? onLocationTap;
  final VoidCallback? onWalkInTap;
  final VoidCallback? onPassTap;
  final String activeSection;

  const DesktopWebHeader({
    super.key,
    this.onHomeTap,
    this.onHowItWorksTap,
    this.onFloorplanTap,
    this.onPricingTap,
    this.onLeaderboardTap,
    this.onLocationTap,
    this.onWalkInTap,
    this.onPassTap,
    this.activeSection = 'home',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 66,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkObsidianCard.withValues(alpha: 0.92)
                : Colors.white.withValues(alpha: 0.95),
            border: Border(
              bottom: BorderSide(
                color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate200,
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.05),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // ==========================================
              // BRAND & ARENA VENUE STATUS (LEFT)
              // ==========================================
              GestureDetector(
                onTap: onHomeTap,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Circular JOMNITTAKU Crest
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.ittfTableBorder.withValues(alpha: 0.6),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.ittfTableSurface.withValues(alpha: 0.25),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/company_logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'JOMNITTAKU',
                                style: AppTypography.ui(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.textPrimary,
                                  letterSpacing: 1.4,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.voltLime.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: AppColors.voltLime.withValues(alpha: 0.4),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: AppColors.voltLime,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '6/10 FREE',
                                      style: AppTypography.ui(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.voltLime,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 1),
                          Text(
                            '3 Damansara · 24/7 Autonomous Arena',
                            style: AppTypography.ui(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 28),

              // ==========================================
              // COMMERCIAL NAVIGATION ANCHOR LINKS (CENTER)
              // ==========================================
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildNavLink(
                        title: 'Overview',
                        icon: Icons.sports_tennis_rounded,
                        isActive: activeSection == 'home',
                        onTap: onHomeTap,
                      ),
                      const SizedBox(width: 4),
                      _buildNavLink(
                        title: 'How It Works',
                        icon: Icons.auto_awesome_rounded,
                        isActive: activeSection == 'how-it-works',
                        onTap: onHowItWorksTap,
                      ),
                      const SizedBox(width: 4),
                      _buildNavLink(
                        title: '10 Courts Floorplan',
                        icon: Icons.grid_view_rounded,
                        isActive: activeSection == 'floorplan',
                        onTap: onFloorplanTap,
                      ),
                      const SizedBox(width: 4),
                      _buildNavLink(
                        title: 'Rates & Passes',
                        icon: Icons.local_activity_rounded,
                        isActive: activeSection == 'pricing',
                        onTap: onPricingTap,
                      ),
                      const SizedBox(width: 4),
                      _buildNavLink(
                        title: 'Arena League',
                        icon: Icons.emoji_events_rounded,
                        isActive: activeSection == 'leaderboard',
                        onTap: onLeaderboardTap,
                      ),
                      const SizedBox(width: 4),
                      _buildNavLink(
                        title: 'Location & Amenities',
                        icon: Icons.place_rounded,
                        isActive: activeSection == 'location',
                        onTap: onLocationTap,
                      ),
                      const SizedBox(width: 8),
                      // Direct 55" Stadium TV Link
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const DisplayLeaderboardScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.ittfTableSurface.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.ittfTableBorder.withValues(alpha: 0.45),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.tv_rounded,
                                  size: 14,
                                  color: AppColors.ittfTableBorder,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '55" TV Feed',
                                  style: AppTypography.ui(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.ittfTableBorder,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // ==========================================
              // ACTIONS & THEME TOGGLE (RIGHT)
              // ==========================================
              // Theme Switcher: Dark / Light
              GestureDetector(
                onTap: () => AppThemeController.toggleTheme(),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF162032) : AppColors.lightCanvasBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? Colors.white.withValues(alpha: 0.12) : AppColors.slate300,
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
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : AppColors.slate900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Quick Door Pass
              GestureDetector(
                onTap: onPassTap ?? () => AppNavigator.toPass(context),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withValues(alpha: 0.05) : AppColors.slate100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark ? Colors.white.withValues(alpha: 0.12) : AppColors.slate300,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.qr_code_rounded,
                          size: 14,
                          color: isDark ? Colors.white70 : AppColors.slate600,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Pass: KX8VQS',
                          style: AppTypography.ui(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white70 : AppColors.slate600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // High-Converting Primary CTA: Walk In Tonight (RM17) →
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onWalkInTap,
                  child: Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.voltLime,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.voltLime.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Walk In Tonight (RM17) →',
                      style: AppTypography.ui(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavLink({
    required String title,
    required IconData icon,
    required bool isActive,
    required VoidCallback? onTap,
  }) {
    final isDark = AppColors.isDark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
            color: isActive
                ? (isDark
                    ? AppColors.darkObsidianCardLight
                    : AppColors.slate200)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isActive
                ? Border.all(
                    color: isDark ? AppColors.border : AppColors.slate300,
                    width: 1,
                  )
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 14,
                color: isActive
                    ? AppColors.textPrimary
                    : (isDark ? AppColors.slate400 : AppColors.slate600),
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: AppTypography.ui(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                  color: isActive
                      ? AppColors.textPrimary
                      : (isDark ? AppColors.slate400 : AppColors.slate600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
