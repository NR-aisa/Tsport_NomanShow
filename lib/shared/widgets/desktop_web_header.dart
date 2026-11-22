import 'package:flutter/material.dart';

import '../../core/session/demo_avatars.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_controller.dart';
import '../../core/theme/app_typography.dart';
import '../../features/display/screens/display_leaderboard_screen.dart';

/// Elite Luxury Top Search & Profile Bar for JOMNITTAKU Desktop.
///
/// Designed after the latest luxury fintech dashboard:
/// - Pill-shaped search bar
/// - Live venue telemetry indicator (`● 6/10 Free`)
/// - 55" Stadium TV link
/// - Authenticated user profile chip (`Alman R.`)
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

  static const Color luxuryCanvasBg = Color(0xFF161720);
  static const Color luxuryCardBg = Color(0xFF222533);
  static const Color luxuryCoralRose = Color(0xFFFF4B72);
  static const Color luxuryVoltEmerald = Color(0xFF10B981);
  static const Color luxuryMutedText = Color(0xFF8A8E9E);

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark;

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: luxuryCanvasBg,
      child: Row(
        children: [
          // ==========================================
          // SEARCH INPUT BAR (PILL-SHAPED)
          // ==========================================
          Expanded(
            flex: 48,
            child: Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: luxuryCardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.05),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search_rounded,
                    size: 16,
                    color: luxuryMutedText,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Search player, court (T01-T10), or live match...',
                      style: AppTypography.ui(
                        fontSize: 12,
                        color: luxuryMutedText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(flex: 12),

          // ==========================================
          // VENUE TELEMETRY PILL (6/10 FREE)
          // ==========================================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: luxuryVoltEmerald.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: luxuryVoltEmerald.withValues(alpha: 0.35),
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
                    color: luxuryVoltEmerald,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '6 OF 10 COURTS FREE',
                  style: AppTypography.ui(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: luxuryVoltEmerald,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          // ==========================================
          // 55" TV FEED BUTTON
          // ==========================================
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
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: luxuryCardBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.tv_rounded,
                      size: 14,
                      color: Color(0xFF60A5FA),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '55" Stadium TV',
                      style: AppTypography.ui(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF60A5FA),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // ==========================================
          // THEME TOGGLE (DARK / LIGHT)
          // ==========================================
          GestureDetector(
            onTap: () => AppThemeController.toggleTheme(),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 9),
                decoration: BoxDecoration(
                  color: luxuryCardBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      size: 14,
                      color: isDark ? const Color(0xFFFFA533) : const Color(0xFFFF7A00),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      isDark ? 'Dark' : 'Light',
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // ==========================================
          // USER PROFILE CHIP (ALMAN R.)
          // ==========================================
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onProfileTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage(DemoAvatars.user),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Alman R.',
                    style: AppTypography.ui(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 16,
                    color: luxuryMutedText,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
