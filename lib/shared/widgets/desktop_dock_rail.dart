import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Elite 56px-wide Icon Navigation Dock Rail for JOMNITTAKU Desktop Web.
///
/// Anchored on the left edge of the 100vh Command Center:
/// - Icon-only navigation with active voltLime indicator
/// - Tooltip hover labels
/// - Bottom-pinned settings/venue info
class DesktopDockRail extends StatelessWidget {
  final String activeItem;
  final ValueChanged<String> onItemTap;

  const DesktopDockRail({
    super.key,
    required this.activeItem,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark;

    return Container(
      width: 56,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkObsidianElevated : Colors.white,
        border: Border(
          right: BorderSide(
            color: isDark ? AppColors.obsidianBorder : AppColors.slate200,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Nav items
          _buildDockItem(
            id: 'command',
            icon: Icons.dashboard_rounded,
            label: 'Arena Command',
            isDark: isDark,
          ),
          _buildDockItem(
            id: 'radar',
            icon: Icons.table_restaurant_rounded,
            label: '10 Courts Radar',
            isDark: isDark,
          ),
          _buildDockItem(
            id: 'league',
            icon: Icons.emoji_events_rounded,
            label: 'Olympic Podium & League',
            isDark: isDark,
          ),
          _buildDockItem(
            id: 'challenge',
            icon: Icons.sports_mma_rounded,
            label: '1v1 Matchmaking',
            isDark: isDark,
          ),
          _buildDockItem(
            id: 'passes',
            icon: Icons.confirmation_number_rounded,
            label: 'Passes & Membership',
            isDark: isDark,
          ),
          _buildDockItem(
            id: 'iot',
            icon: Icons.sensors_rounded,
            label: 'Venue IoT Sensors',
            isDark: isDark,
          ),
          _buildDockItem(
            id: 'tv',
            icon: Icons.tv_rounded,
            label: '55" Arena TV Broadcast',
            isDark: isDark,
          ),

          const Spacer(),

          // Bottom pinned: Settings / Venue Info
          _buildDockItem(
            id: 'settings',
            icon: Icons.settings_rounded,
            label: 'Venue Settings & PDPA',
            isDark: isDark,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildDockItem({
    required String id,
    required IconData icon,
    required String label,
    required bool isDark,
  }) {
    final isActive = activeItem == id;

    return Tooltip(
      message: label,
      preferBelow: false,
      textStyle: AppTypography.ui(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: AppColors.slate900,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => onItemTap(id),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 56,
          height: 48,
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Active left indicator bar
              if (isActive)
                Positioned(
                  left: 0,
                  top: 8,
                  bottom: 8,
                  width: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.voltLime,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.voltLime.withValues(alpha: 0.5),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),

              // Icon container with active background highlight
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: isActive
                      ? (isDark
                          ? AppColors.voltLime.withValues(alpha: 0.12)
                          : AppColors.voltLime.withValues(alpha: 0.15))
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 20,
                    color: isActive
                        ? AppColors.voltLime
                        : (isDark ? AppColors.slate400 : AppColors.slate500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
