import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
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

  const JomnittakuNavBar({
    super.key,
    this.activeIndex = 0,
    this.onTabSelected,
  });

  void _handleTabTap(BuildContext context, int index) {
    if (onTabSelected != null) {
      onTabSelected!(index);
      return;
    }

    if (index == activeIndex) {
      return;
    }

    switch (index) {
      case 0:
        AppNavigator.toHome(context);
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
    final isDark = AppColors.isDark;

    // Phase 8 (Fluent pass): true acrylic — a blurred, translucent dock.
    // The shadow lives on the outer shell; the clip + backdrop filter
    // soften whatever scrolls behind the bar.
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.55 : 0.08),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
          if (isDark)
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.12),
              offset: const Offset(0, 1),
              blurRadius: 0,
            ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.62)
                  : Colors.white.withValues(alpha: 0.78), // Acrylic tint
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: isDark ? Colors.white.withValues(alpha: 0.10) : AppColors.lightBorder,
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
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    final isSelected = activeIndex == index;
    final isDark = AppColors.isDark;
    // ONE active colour for every tab: the primary emerald.
    const activeColor = AppColors.voltLime;

    return GestureDetector(
      onTap: () => _handleTabTap(context, index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 46 : 40,
            height: isSelected ? 46 : 40,
            decoration: BoxDecoration(
              color: isSelected
                  ? activeColor
                  : (isDark ? Colors.white.withValues(alpha: 0.05) : AppColors.lightCanvasBg),
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.3)
                    : (isDark ? Colors.white.withValues(alpha: 0.06) : AppColors.lightBorder),
                width: 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              icon,
              size: isSelected ? 21 : 18,
              color: isSelected
                  ? (isDark ? AppColors.darkObsidianBase : Colors.white)
                  : (isDark ? Colors.white.withValues(alpha: 0.65) : AppColors.slate500),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: AppTypography.ui(
              fontSize: 9,
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
              color: isSelected
                  ? activeColor
                  : (isDark ? Colors.white.withValues(alpha: 0.55) : AppColors.slate500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterPlayItem(BuildContext context, int index) {
    final isSelected = activeIndex == index;
    final isDark = AppColors.isDark;

    return GestureDetector(
      onTap: () => _handleTabTap(context, index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // The primary action wears the primary colour — emerald,
              // not the old always-blue gradient.
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.voltLime,
                  AppColors.btnGreenBorder,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.voltLime.withValues(alpha: isDark ? 0.45 : 0.30),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.25),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.sports_mma_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Play',
            style: AppTypography.ui(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: AppColors.voltLime,
            ),
          ),
        ],
      ),
    );
  }
}
