import 'package:flutter/material.dart';

import '../../core/theme/app_typography.dart';

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
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: luxuryCanvasBg,
      child: Row(
        children: [
          // ==========================================
          // SEARCH INPUT BAR (PILL-SHAPED)
          // ==========================================
          Container(
            width: 340,
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

          const SizedBox(width: 14),

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

          // Quick Public Website Switcher Pill
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => onTabChanged?.call('landing'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF222533),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.public_rounded,
                      size: 13,
                      color: Color(0xFF60A5FA),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Public Website',
                      style: AppTypography.ui(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Spacer(),

          // Buffer for the top-right floating switcher bar
          const SizedBox(width: 420),
        ],
      ),
    );
  }
}
