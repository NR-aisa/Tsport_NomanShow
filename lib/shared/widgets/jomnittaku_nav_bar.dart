import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/navigation/app_navigator.dart';

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

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xE6111724) : Colors.white.withValues(alpha: 0.95), // Frosted glass
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.10) : const Color(0xFFE2E8F0),
          width: 1.0,
        ),
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
      child: SafeArea(
        top: false,
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context, 0, Icons.home_rounded, AppColors.voltLime),
            _buildNavItem(context, 1, Icons.emoji_events_rounded, AppColors.radiantGold),
            _buildCenterSparkleItem(context, 2),
            _buildNavItem(context, 3, Icons.table_restaurant_rounded, AppColors.hyperCyan),
            _buildNavItem(context, 4, Icons.alt_route_rounded, AppColors.amethystPurple),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, Color activeColor) {
    final isSelected = activeIndex == index;
    final isDark = AppColors.isDark;

    return GestureDetector(
      onTap: () => _handleTabTap(context, index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isSelected ? 48 : 42,
        height: isSelected ? 48 : 42,
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor
              : (isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF1F5F9)),
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.3)
                : (isDark ? Colors.white.withValues(alpha: 0.06) : const Color(0xFFE2E8F0)),
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
          size: isSelected ? 22 : 19,
          color: isSelected
              ? (isDark ? const Color(0xFF070A0F) : Colors.white)
              : (isDark ? Colors.white.withValues(alpha: 0.65) : const Color(0xFF64748B)),
        ),
      ),
    );
  }

  Widget _buildCenterSparkleItem(BuildContext context, int index) {
    final isSelected = activeIndex == index;
    final isDark = AppColors.isDark;

    return GestureDetector(
      onTap: () => _handleTabTap(context, index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3B82F6),
              Color(0xFF1D4ED8),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2563EB).withValues(alpha: isDark ? 0.45 : 0.30),
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
    );
  }
}
