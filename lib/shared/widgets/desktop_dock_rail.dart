import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Elite 68px-wide Icon + Label Navigation Dock Rail for JOMNITTAKU Desktop.
///
/// Designed with clear legibility (no tiny micro-icons):
/// - 22px crisp icons with compact 10px sub-labels
/// - Generous hover and active pill states
/// - Left voltLime accent border for active state
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
      width: 68,
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
          const SizedBox(height: 14),
          // Nav items with clear icons & labels
          _buildDockItem(
            id: 'command',
            icon: Icons.dashboard_rounded,
            label: 'Arena',
            isDark: isDark,
          ),
          const SizedBox(height: 6),
          _buildDockItem(
            id: 'radar',
            icon: Icons.table_restaurant_rounded,
            label: '10 Courts',
            isDark: isDark,
          ),
          const SizedBox(height: 6),
          _buildDockItem(
            id: 'league',
            icon: Icons.emoji_events_rounded,
            label: 'League',
            isDark: isDark,
          ),
          const SizedBox(height: 6),
          _buildDockItem(
            id: 'passes',
            icon: Icons.confirmation_number_rounded,
            label: 'Passes',
            isDark: isDark,
          ),
          const SizedBox(height: 6),
          _buildDockItem(
            id: 'iot',
            icon: Icons.sensors_rounded,
            label: 'Venue IoT',
            isDark: isDark,
          ),
          const SizedBox(height: 6),
          _buildDockItem(
            id: 'tv',
            icon: Icons.tv_rounded,
            label: '55" TV',
            isDark: isDark,
          ),

          const Spacer(),

          // Bottom pinned: Settings
          _buildDockItem(
            id: 'settings',
            icon: Icons.settings_rounded,
            label: 'Settings',
            isDark: isDark,
          ),
          const SizedBox(height: 14),
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
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
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
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 58,
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: isActive
                ? (isDark
                    ? AppColors.voltLime.withValues(alpha: 0.14)
                    : AppColors.voltLime.withValues(alpha: 0.16))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isActive
                ? Border.all(
                    color: AppColors.voltLime.withValues(alpha: 0.4),
                    width: 1,
                  )
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 22,
                color: isActive
                    ? AppColors.voltLime
                    : (isDark ? AppColors.slate400 : AppColors.slate600),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTypography.ui(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                  color: isActive
                      ? AppColors.textPrimary
                      : (isDark ? AppColors.slate400 : AppColors.slate600),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
