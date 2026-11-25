import 'package:flutter/material.dart';

import '../../core/theme/app_typography.dart';
import 'arena_widgets.dart';

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
  final bool isDark;

  const DesktopWebHeader({
    super.key,
    this.activeTab = 'command',
    this.onTabChanged,
    this.onTvTap,
    this.onXpTap,
    this.onProfileTap,
    this.isDark = true,
  });

  @override
  Widget build(BuildContext context) {
    final headerBg = isDark ? const Color(0xFF090B10) : Colors.white;
    final borderColor = isDark ? const Color(0x0EFFFFFF) : const Color(0xFFE2E8F0);
    final searchBg = isDark ? const Color(0xFF12151F) : const Color(0xFFF1F5F9);
    final searchBorder = isDark ? const Color(0x0EFFFFFF) : const Color(0xFFE2E8F0);
    final textMuted = isDark ? const Color(0xFF7E869B) : const Color(0xFF64748B);
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);

    final telemetryBg = isDark ? const Color(0x1800D8A5) : const Color(0xFFE6F9F4);
    final telemetryBorder = isDark ? const Color(0x3300D8A5) : const Color(0xFF99E6D3);
    final telemetryColor = isDark ? const Color(0xFF00D8A5) : const Color(0xFF0D9488);

    final chipBg = isDark ? const Color(0xFF12151F) : const Color(0xFFF8FAFC);
    final chipBorder = isDark ? const Color(0x0EFFFFFF) : const Color(0xFFE2E8F0);

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: headerBg,
        border: Border(
          bottom: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // ==========================================
          // SEARCH INPUT BAR (PILL-SHAPED)
          // ==========================================
          Container(
            width: 260,
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: searchBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: searchBorder,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  size: 16,
                  color: textMuted,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Search player, court (T01-T10), or live match...',
                    style: AppTypography.ui(
                      fontSize: 12,
                      color: textMuted,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          // ==========================================
          // VENUE TELEMETRY PILL (6/10 FREE)
          // ==========================================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: telemetryBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: telemetryBorder,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: telemetryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '6 OF 10 COURTS FREE',
                  style: AppTypography.ui(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: telemetryColor,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          // Quick Public Website Switcher Pill
          SoftHoverButton(
            onTap: () => onTabChanged?.call('landing'),
            builder: (context, isHovered) {
              final hoverBg = isDark ? const Color(0xFF1E2436) : const Color(0xFFE2E8F0);
              final hoverBorder = isDark ? Colors.white.withValues(alpha: 0.22) : const Color(0xFFCBD5E1);

              return AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isHovered ? hoverBg : chipBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isHovered ? hoverBorder : chipBorder,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.public_rounded,
                      size: 13,
                      color: Color(0xFF3B82F6),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Public Website',
                      style: AppTypography.ui(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const Spacer(),

          // Buffer for the top-right floating switcher bar
          const SizedBox(width: 420),
        ],
      ),
    );
  }
}
