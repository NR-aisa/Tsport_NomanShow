import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/viewport_controller.dart';
import '../../core/navigation/app_navigator.dart';

/// Bottom navigation — Arena DS v1 (Phase 1).
///
/// Toby's law applied: one selected style, in the one primary colour, and
/// every item is labelled. Before this pass each tab lit up in a different
/// colour (green/amber/blue/purple) and nothing had a label, so two items
/// could look "active" at once and the centre button's icon actually
/// opened Match-Accept. The centre action is now honestly labelled "Play".
class JomnittakuNavBar extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int>? onTabSelected;
  final bool isRootTab;

  const JomnittakuNavBar({
    super.key,
    this.activeIndex = 0,
    this.onTabSelected,
    this.isRootTab = true,
  });

  void _handleTabTap(BuildContext context, int index) {
    if (onTabSelected != null) {
      onTabSelected!(index);
      return;
    }

    if (isRootTab && index == activeIndex) {
      return;
    }

    switch (index) {
      case 0:
        AppNavigator.toHomeAndClear(context);
        break;
      case 1:
        AppNavigator.toLeaderboard(context);
        break;
      case 2:
        AppNavigator.toChallengeAccepted(context);
        break;
      case 3:
        AppNavigator.toTables(context);
        break;
      case 4:
        AppNavigator.toGamificationPath(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ViewportController.isWeb) {
      return const SizedBox.shrink();
    }

    final isDark = AppColors.isDark;

    // Windows 11 Fluent Taskbar style: centered 12px squircle dock (max width 600px).
    return Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.45 : 0.08),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF090C14).withValues(alpha: 0.90)
                      : Colors.white.withValues(alpha: 0.90), // Fluent acrylic tint
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : AppColors.slate300.withValues(alpha: 0.6),
                    width: 1.0,
                  ),
                ),
                child: SafeArea(
              top: false,
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(context, 0, Icons.home_rounded, 'Home'),
                  _buildNavItem(context, 1, Icons.emoji_events_rounded, 'Ranks'),
                  _buildCenterPlayItem(context, 2),
                  _buildNavItem(context, 3, Icons.table_restaurant_rounded, 'Tables'),
                  _buildNavItem(context, 4, Icons.alt_route_rounded, 'Path'),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  ),
);
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    final isSelected = activeIndex == index;
    final isDark = AppColors.isDark;

    return GestureDetector(
      onTap: () => _handleTabTap(context, index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark ? Colors.white.withValues(alpha: 0.10) : AppColors.actionBlue.withValues(alpha: 0.12))
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6), // Windows 11 Fluent squircle
              ),
              child: Icon(
                icon,
                size: 20,
                color: isSelected
                    ? (isDark ? Colors.white : AppColors.actionBlue)
                    : (isDark ? Colors.white.withValues(alpha: 0.60) : AppColors.slate500),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTypography.ui(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: isSelected
                    ? (isDark ? Colors.white : AppColors.actionBlue)
                    : (isDark ? Colors.white.withValues(alpha: 0.55) : AppColors.slate500),
              ),
            ),
            const SizedBox(height: 2),
            // Active Indicator Pill
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: isSelected ? 16 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark ? const Color(0xFFFF5C38) : AppColors.actionBlue)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterPlayItem(BuildContext context, int index) {
    final isSelected = activeIndex == index;
    final isDark = AppColors.isDark;

    return GestureDetector(
      onTap: () => _handleTabTap(context, index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFF5C38), Color(0xFFFF3310)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF5C38).withValues(alpha: isDark ? 0.45 : 0.28),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.sports_tennis_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Play',
              style: AppTypography.ui(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: isSelected
                    ? (isDark ? Colors.white : AppColors.actionBlue)
                    : (isDark ? Colors.white.withValues(alpha: 0.55) : AppColors.slate500),
              ),
            ),
            const SizedBox(height: 2),
            // Active Indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: isSelected ? 16 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFF5C38) : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
