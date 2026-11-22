import 'dart:ui';
import 'package:flutter/material.dart';

import '../../core/session/demo_avatars.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_controller.dart';
import '../../core/theme/app_typography.dart';
import '../../features/display/screens/display_leaderboard_screen.dart';

/// Elite 62px-Height Commercial Desktop Web Header.
///
/// Designed with comfortable, legible proportions:
/// - Brand Crest & 3 Damansara Live Badge
/// - Clear, readable tab buttons (13.5px text + 16px icons)
/// - Interactive XP Wallet Pill (`1,240 XP #4`)
/// - Theme Switcher (Dark / Light)
/// - User Profile Chip (`Alman R.`)
/// - 55" TV Feed Launcher
class DesktopWebHeader extends StatelessWidget {
  final String activeTab;
  final ValueChanged<String>? onTabChanged;
  final VoidCallback? onTvTap;
  final VoidCallback? onXpTap;
  final VoidCallback? onProfileTap;

  const DesktopWebHeader({
    super.key,
    this.activeTab = 'command',
    this.onTabChanged,
    this.onTvTap,
    this.onXpTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 62,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkObsidianCard.withValues(alpha: 0.94)
                : Colors.white.withValues(alpha: 0.96),
            border: Border(
              bottom: BorderSide(
                color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate200,
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.30 : 0.04),
                blurRadius: 14,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // ==========================================
              // BRAND & VENUE STATUS (LEFT)
              // ==========================================
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => onTabChanged?.call('command'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.ittfTableBorder.withValues(alpha: 0.6),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.ittfTableSurface.withValues(alpha: 0.25),
                              blurRadius: 8,
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
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
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
                                    const SizedBox(width: 5),
                                    Text(
                                      '6/10 FREE',
                                      style: AppTypography.ui(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.voltLime,
                                        letterSpacing: 0.6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '3 Damansara Level 2 · 24/7 Autonomous Arena',
                            style: AppTypography.ui(
                              fontSize: 10.5,
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
              // PROMINENT NAVIGATION TABS (CENTER)
              // ==========================================
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildTabButton(
                        id: 'command',
                        label: 'Arena Overview',
                        icon: Icons.dashboard_rounded,
                        isActive: activeTab == 'command',
                        isDark: isDark,
                      ),
                      const SizedBox(width: 6),
                      _buildTabButton(
                        id: 'radar',
                        label: '10 Courts Floorplan',
                        icon: Icons.table_restaurant_rounded,
                        isActive: activeTab == 'radar',
                        isDark: isDark,
                      ),
                      const SizedBox(width: 6),
                      _buildTabButton(
                        id: 'league',
                        label: 'Olympic League',
                        icon: Icons.emoji_events_rounded,
                        isActive: activeTab == 'league',
                        isDark: isDark,
                      ),
                      const SizedBox(width: 6),
                      _buildTabButton(
                        id: 'passes',
                        label: 'Rates & Passes',
                        icon: Icons.confirmation_number_rounded,
                        isActive: activeTab == 'passes',
                        isDark: isDark,
                      ),
                      const SizedBox(width: 6),
                      _buildTabButton(
                        id: 'iot',
                        label: 'Venue Telemetry',
                        icon: Icons.sensors_rounded,
                        isActive: activeTab == 'iot',
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // ==========================================
              // ACTION & USER TOOLS (RIGHT)
              // ==========================================
              // 55" TV Feed Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onTvTap ??
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const DisplayLeaderboardScreen(),
                          ),
                        );
                      },
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.ittfTableSurface.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.ittfTableBorder.withValues(alpha: 0.40),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.tv_rounded,
                          size: 15,
                          color: AppColors.ittfTableBorder,
                        ),
                        const SizedBox(width: 6),
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

              const SizedBox(width: 10),

              // XP Wallet Pill (1,240 XP #4)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onXpTap,
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF221A06) : const Color(0xFFFFFBEB),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.radiantGold.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.stars_rounded,
                          size: 15,
                          color: AppColors.radiantGold,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '1,240 XP',
                          style: AppTypography.ui(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: isDark ? AppColors.radiantGold : AppColors.goldDeep,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: AppColors.radiantGold.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '#4',
                            style: AppTypography.ui(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w900,
                              color: isDark ? AppColors.radiantGold : AppColors.goldDeep,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Dark / Light Toggle
              GestureDetector(
                onTap: () => AppThemeController.toggleTheme(),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF162032) : AppColors.lightCanvasBg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark ? Colors.white.withValues(alpha: 0.12) : AppColors.slate300,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                          size: 14,
                          color: isDark ? AppColors.radiantGold : AppColors.pingPongOrange,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          isDark ? 'Dark' : 'Light',
                          style: AppTypography.ui(
                            fontSize: 12,
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

              // User Profile Chip
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onProfileTap,
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.only(left: 4, right: 10),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withValues(alpha: 0.06) : AppColors.slate100,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isDark ? Colors.white.withValues(alpha: 0.10) : AppColors.slate300,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          radius: 13,
                          backgroundImage: AssetImage(DemoAvatars.user),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          'Alman R.',
                          style: AppTypography.ui(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
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
    );
  }

  Widget _buildTabButton({
    required String id,
    required String label,
    required IconData icon,
    required bool isActive,
    required bool isDark,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTabChanged?.call(id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: isActive
                ? (isDark ? AppColors.darkObsidianCardLight : AppColors.slate200)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isActive
                ? Border.all(
                    color: isDark ? AppColors.voltLime.withValues(alpha: 0.5) : AppColors.slate300,
                    width: 1.2,
                  )
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isActive
                    ? AppColors.voltLime
                    : (isDark ? AppColors.slate400 : AppColors.slate600),
              ),
              const SizedBox(width: 7),
              Text(
                label,
                style: AppTypography.ui(
                  fontSize: 13.5,
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
