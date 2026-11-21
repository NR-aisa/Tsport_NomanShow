import 'dart:ui';
import 'package:flutter/material.dart';

import '../../core/navigation/app_navigator.dart';
import '../../core/session/app_session.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../features/display/screens/display_leaderboard_screen.dart';

/// Elite Broadcast-Grade Desktop Web Header Navbar.
///
/// Designed for desktop viewports (>= 900px).
/// Replaces the mobile hamburger bar with a full-fledged SaaS/Sports venue header:
///  - Brand & live venue status indicator
///  - Direct in-page section jump links (Arena, Radar, Podium, Pricing, IoT)
///  - 55" Stadium TV launch button
///  - Player XP & Rank status badge
///  - Door Pass quick launcher (KX8VQS)
///  - Dark / Light mode toggle
///  - User profile avatar & status
class DesktopWebHeader extends StatelessWidget {
  final VoidCallback? onArenaTap;
  final VoidCallback? onRadarTap;
  final VoidCallback? onLeaderboardTap;
  final VoidCallback? onPricingTap;
  final VoidCallback? onIotTap;
  final String activeSection;

  const DesktopWebHeader({
    super.key,
    this.onArenaTap,
    this.onRadarTap,
    this.onLeaderboardTap,
    this.onPricingTap,
    this.onIotTap,
    this.activeSection = 'arena',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkObsidianCard.withValues(alpha: 0.88)
                : Colors.white.withValues(alpha: 0.92),
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
                onTap: onArenaTap ?? () => AppNavigator.toHomeAndClear(context),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Circular JOMNITTAKU Crest
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
                                      'LIVE ARENA',
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
                            '3 Damansara · 10 Tables · 24/7 Autonomous Venue',
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

              const SizedBox(width: 32),

              // ==========================================
              // DESKTOP NAVIGATION LINKS (CENTER)
              // ==========================================
              Expanded(
                child: Row(
                  children: [
                    _buildNavLink(
                      title: 'Arena Command',
                      icon: Icons.dashboard_rounded,
                      isActive: activeSection == 'arena',
                      onTap: onArenaTap,
                    ),
                    const SizedBox(width: 6),
                    _buildNavLink(
                      title: 'Live Radar',
                      icon: Icons.radar_rounded,
                      isActive: activeSection == 'radar',
                      onTap: onRadarTap,
                    ),
                    const SizedBox(width: 6),
                    _buildNavLink(
                      title: 'Leaderboard Podium',
                      icon: Icons.emoji_events_rounded,
                      isActive: activeSection == 'leaderboard',
                      onTap: onLeaderboardTap,
                    ),
                    const SizedBox(width: 6),
                    _buildNavLink(
                      title: 'Membership & Rates',
                      icon: Icons.local_activity_rounded,
                      isActive: activeSection == 'pricing',
                      onTap: onPricingTap,
                    ),
                    const SizedBox(width: 6),
                    _buildNavLink(
                      title: 'Venue IoT',
                      icon: Icons.sensors_rounded,
                      isActive: activeSection == 'iot',
                      onTap: onIotTap,
                    ),
                    const SizedBox(width: 6),
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
                          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
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

              // ==========================================
              // PLAYER TELEMETRY & ACTIONS (RIGHT)
              // ==========================================
              // Live Player XP Capsule
              GestureDetector(
                onTap: () => AppNavigator.toXpStore(context),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.paddleBlack : AppColors.lightCanvasBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.radiantGold.withValues(alpha: 0.4),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.radiantGold.withValues(alpha: 0.15),
                          blurRadius: 8,
                        ),
                      ],
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
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: AppColors.radiantGold.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '#4',
                            style: AppTypography.ui(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: AppColors.radiantGold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Instant Door Pass Button (KX8VQS)
              GestureDetector(
                onTap: () => AppNavigator.toPass(context),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: AppColors.voltLime.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.voltLime.withValues(alpha: 0.45),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.voltLime.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.qr_code_scanner_rounded,
                          size: 15,
                          color: AppColors.voltLime,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Door Pass: KX8VQS',
                          style: AppTypography.ui(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: isDark ? AppColors.voltLime : AppColors.textPrimary,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // User Profile Avatar Chip
              GestureDetector(
                onTap: () => AppNavigator.toProfile(context),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.obsidianCard : AppColors.lightCanvasBg,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate300,
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                AppSession.avatarAsset,
                                width: 32,
                                height: 32,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 9,
                                height: 9,
                                decoration: BoxDecoration(
                                  color: AppColors.voltLime,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.canvasBg,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppSession.displayName.isEmpty ? 'Alman R.' : AppSession.displayName,
                              style: AppTypography.ui(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'Member · Lvl 12',
                              style: AppTypography.ui(
                                fontSize: 9.5,
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
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
                size: 15,
                color: isActive
                    ? AppColors.textPrimary
                    : (isDark ? AppColors.slate400 : AppColors.slate600),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: AppTypography.ui(
                  fontSize: 12.5,
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
