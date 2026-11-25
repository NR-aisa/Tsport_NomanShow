import 'package:flutter/material.dart';

import '../../../core/session/demo_avatars.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/arena_widgets.dart';
import '../../display/screens/display_leaderboard_screen.dart';

/// Elite Luxury Desktop Web Command Center Sections for JOMNITTAKU.
///
/// Features:
/// - High-contrast, large, eye-catching typography (13-26px, w800-w900)
/// - Spacious 58px table rows with high-legibility specification text
/// - Vibrant status pills with glowing backgrounds and borders
/// - Tactile action pill buttons ([Play Now →] and [Watch HUD])
/// - Eye-catching top metric cards with bold numbers
class DesktopWebSections {
  DesktopWebSections._();

  // Luxury high-contrast palette
  static const Color luxuryCanvasBg = Color(0xFF07080B);
  static const Color luxuryCardBg = Color(0xFF0D101A);
  static const Color luxuryCardBgElevated = Color(0xFF131724);
  static const Color luxuryCoralRose = Color(0xFFFF5C38);
  static const Color luxuryTangerineGold = Color(0xFFFF9900);
  static const Color luxuryVoltEmerald = Color(0xFF00F59B);
  static const Color luxuryElectricBlue = Color(0xFF38BDF8);
  static const Color luxuryAmethystPurple = Color(0xFFA855F7);
  static const Color luxuryTextPrimary = Colors.white;
  static const Color luxuryTextSecondary = Color(0xFFCBD5E1);
  static const Color luxuryTextMuted = Color(0xFF7E869B);
  static const Color luxuryBorderSubtle = Color(0x18FFFFFF);

  // ============================================================
  // MASTER COMMAND CENTER ORCHESTRATOR
  // ============================================================
  static Widget buildFullScreenCommandCenter(
    BuildContext context,
    bool isDark, {
    required String activeTab,
    required VoidCallback onWalkInTap,
    required VoidCallback onPassTap,
    required VoidCallback onTvTap,
    required ValueChanged<String> onTabChanged,
    required VoidCallback onChallengeTap,
    required VoidCallback onXpTap,
  }) {
    final canvasBg = isDark ? const Color(0xFF090B10) : const Color(0xFFF8FAFC);

    return Container(
      color: canvasBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ====================================================
          // 1. TOP ROW: 3 BOLD, EYE-CATCHING METRIC CARDS
          // ====================================================
          SizedBox(
            height: 120,
            child: Row(
              children: [
                // CARD 1: VENUE AVAILABILITY
                Expanded(
                  child: _buildMetricCard(
                    title: 'VENUE AVAILABILITY',
                    value: '6 of 10 Free',
                    badge: '↑ 2 tables freed up',
                    badgeColor: isDark ? const Color(0xFF00D8A5) : const Color(0xFF0D9488),
                    waveColor: isDark ? const Color(0xFF00D8A5) : const Color(0xFF0D9488),
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 14),
                // CARD 2: CENTRE COURT HUD (T04)
                Expanded(
                  child: _buildMetricCard(
                    title: 'CENTRE COURT HUD (T04)',
                    value: 'Jason 14 - 11 Alman',
                    badge: '● Active Rally: 9 hits · Game 3',
                    badgeColor: const Color(0xFF38BDF8),
                    waveColor: const Color(0xFF38BDF8),
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 14),
                // CARD 3: LEAGUE PROGRESSION
                Expanded(
                  child: _buildMetricCard(
                    title: 'LEAGUE PROGRESSION',
                    value: '1,240 XP (#4 Rank)',
                    badge: '↑ 155 XP to reach Top 3',
                    badgeColor: isDark ? const Color(0xFFF59E0B) : const Color(0xFFD97706),
                    waveColor: isDark ? const Color(0xFFF59E0B) : const Color(0xFFD97706),
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ====================================================
          // 2. MIDDLE AREA: 10 COURTS TABLE + STACKED CARDS
          // ====================================================
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // LEFT: 10 COURTS LIVE ACTIVITY TABLE (Flex 65)
                Expanded(
                  flex: 65,
                  child: _buildTenCourtActivityTable(
                    context,
                    isDark: isDark,
                    onPassTap: onPassTap,
                    onChallengeTap: onChallengeTap,
                  ),
                ),
                const SizedBox(width: 16),
                // RIGHT: STACKED ARENA PASSES & QUICK FUNCTIONS (Flex 35)
                Expanded(
                  flex: 35,
                  child: InteractiveArenaPassDeck(
                    isDark: isDark,
                    onPassTap: onPassTap,
                    onWalkInTap: onWalkInTap,
                    onXpTap: onXpTap,
                    onChallengeTap: onChallengeTap,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ====================================================
          // 3. BOTTOM ROW: QUICK CHALLENGE SPARRING RIVALS
          // ====================================================
          _buildQuickSparringRivalsRow(
            context,
            isDark: isDark,
            onChallengeTap: onChallengeTap,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TOP BOLD MICRO-METRIC CARD BUILDER
  // ============================================================
  static Widget _buildMetricCard({
    required String title,
    required String value,
    required String badge,
    required Color badgeColor,
    required Color waveColor,
    required bool isDark,
  }) {
    final cardBg = isDark ? const Color(0xFF12151F) : Colors.white;
    final borderColor = isDark ? const Color(0x0EFFFFFF) : const Color(0xFFE2E8F0);
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);
    final textMuted = isDark ? const Color(0xFF8A99AD) : const Color(0xFF64748B);

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Stack(
        children: [
          // Bottom subtle wave painter (clean opacity, zero neon halo)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 38,
            child: Opacity(
              opacity: isDark ? 0.40 : 0.25,
              child: CustomPaint(
                painter: _MetricWavePainter(waveColor: waveColor),
              ),
            ),
          ),
          // Text content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTypography.ui(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: textMuted,
                        letterSpacing: 0.8,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: isDark ? 0.15 : 0.10),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: badgeColor.withValues(alpha: isDark ? 0.35 : 0.25),
                      ),
                    ),
                    child: Text(
                      badge,
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: badgeColor,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                value,
                style: AppTypography.ui(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 10 COURTS LIVE ACTIVITY TABLE (SPACIOUS 58PX ROWS, EYE-CATCHING)
  // ============================================================
  static Widget _buildTenCourtActivityTable(
    BuildContext context, {
    required bool isDark,
    required VoidCallback onPassTap,
    required VoidCallback onChallengeTap,
  }) {
    final courts = [
      {'id': 'T01', 'type': 'DHS Rainbow ITTF', 'player': 'Jason T. (Lvl 14)', 'avatar': DemoAvatars.jason, 'time': '18m in match', 'status': 'busy'},
      {'id': 'T02', 'type': 'DHS Rainbow ITTF', 'player': 'Sara K. (Lvl 18)', 'avatar': DemoAvatars.sara, 'time': '12m in match', 'status': 'busy'},
      {'id': 'T03', 'type': 'Stiga Showdown 25', 'player': 'Court Free & Ready', 'avatar': null, 'time': 'Free Now', 'status': 'free'},
      {'id': 'T04', 'type': 'Stadium Centre Court', 'player': 'Jason v Alman (14-11)', 'avatar': DemoAvatars.user, 'time': 'Live Match HUD', 'status': 'match'},
      {'id': 'T05', 'type': 'Stiga Showdown 25', 'player': 'Court Free & Ready', 'avatar': null, 'time': 'Free Now', 'status': 'free'},
      {'id': 'T06', 'type': 'Butterfly Centrefold', 'player': 'Court Free & Ready', 'avatar': null, 'time': 'Free Now', 'status': 'free'},
      {'id': 'T07', 'type': 'Butterfly Centrefold', 'player': 'Court Free & Ready', 'avatar': null, 'time': 'Free Now', 'status': 'free'},
      {'id': 'T08', 'type': 'Nittaku Premium 25', 'player': 'Court Free & Ready', 'avatar': null, 'time': 'Free Now', 'status': 'free'},
      {'id': 'T09', 'type': 'Nittaku Premium 25', 'player': 'League Cup Tournament', 'avatar': DemoAvatars.champion, 'time': 'Res 9:00 PM', 'status': 'reserved'},
      {'id': 'T10', 'type': 'Practice Court DHS', 'player': 'Court Free & Ready', 'avatar': null, 'time': 'Free Now', 'status': 'free'},
    ];

    final cardBg = isDark ? const Color(0xFF12151F) : Colors.white;
    final borderColor = isDark ? const Color(0x0EFFFFFF) : const Color(0xFFE2E8F0);
    final tableHeaderBg = isDark ? const Color(0xFF161A26) : const Color(0xFFF1F5F9);
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);
    final textMuted = isDark ? const Color(0xFF8A99AD) : const Color(0xFF64748B);

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.04),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '10 Courts Live Architectural Activity',
                    style: AppTypography.ui(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (isDark ? const Color(0xFF00D8A5) : const Color(0xFF0D9488)).withValues(alpha: isDark ? 0.18 : 0.10),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: (isDark ? const Color(0xFF00D8A5) : const Color(0xFF0D9488)).withValues(alpha: isDark ? 0.40 : 0.25),
                        width: 1.2,
                      ),
                    ),
                    child: Text(
                      '6 FREE NOW',
                      style: AppTypography.ui(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w900,
                        color: isDark ? const Color(0xFF00D8A5) : const Color(0xFF0D9488),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              // Filter pills
              Row(
                children: [
                  _buildFilterPill('All (10)', true, isDark),
                  const SizedBox(width: 8),
                  _buildFilterPill('Free (6)', false, isDark),
                  const SizedBox(width: 8),
                  _buildFilterPill('In Play (3)', false, isDark),
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Table Column Titles
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: tableHeaderBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text('COURT', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: textMuted, letterSpacing: 0.8)),
                ),
                SizedBox(
                  width: 165,
                  child: Text('SPECIFICATION', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: textMuted, letterSpacing: 0.8)),
                ),
                Expanded(
                  flex: 38,
                  child: Text('OCCUPANT / MATCH', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: textMuted, letterSpacing: 0.8)),
                ),
                SizedBox(
                  width: 125,
                  child: Text('STATUS', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: textMuted, letterSpacing: 0.8)),
                ),
                SizedBox(
                  width: 110,
                  child: Text('ACTION', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: textMuted, letterSpacing: 0.8)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Horizontal Court Rows (Spacious 56px rows with tactical precision)
          Expanded(
            child: ListView.separated(
              itemCount: courts.length,
              separatorBuilder: (context, index) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                final court = courts[index];
                final status = court['status'];
                final isFree = status == 'free';
                final isMatch = status == 'match';
                final isReserved = status == 'reserved';

                Color statusColor = isDark ? const Color(0xFF00D8A5) : const Color(0xFF0D9488);
                String statusLabel = 'AVAILABLE';
                if (status == 'busy') {
                  statusColor = isDark ? const Color(0xFFF59E0B) : const Color(0xFFD97706);
                  statusLabel = 'IN PLAY';
                } else if (isMatch) {
                  statusColor = isDark ? const Color(0xFFFF4655) : const Color(0xFFE11D48);
                  statusLabel = 'LIVE MATCH';
                } else if (isReserved) {
                  statusColor = isDark ? const Color(0xFF8B5CF6) : const Color(0xFF7C3AED);
                  statusLabel = 'RESERVED';
                }

                final rowBg = isMatch
                    ? (isDark ? const Color(0xFF1B1218) : const Color(0xFFFFF1F2))
                    : (index.isEven
                        ? (isDark ? const Color(0xFF101320) : Colors.white)
                        : (isDark ? const Color(0xFF0C0E16) : const Color(0xFFF8FAFC)));

                final rowBorder = isMatch
                    ? (isDark ? const Color(0x55FF4655) : const Color(0x55E11D48))
                    : borderColor;

                return Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: rowBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: rowBorder,
                      width: isMatch ? 1.2 : 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Court ID with solid dot (NO neon blur)
                      SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              court['id'] as String,
                              style: AppTypography.ui(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Specification (Bold & High Contrast)
                      SizedBox(
                        width: 165,
                        child: Text(
                          court['type'] as String,
                          style: AppTypography.ui(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Occupant (Large avatars, bold names)
                      Expanded(
                        flex: 38,
                        child: Row(
                          children: [
                            if (court['avatar'] != null)
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundImage: AssetImage(court['avatar'] as String),
                                ),
                              ),
                            Expanded(
                              child: Text(
                                court['player'] as String,
                                style: AppTypography.ui(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: isFree
                                      ? (isDark ? const Color(0xFF00D8A5) : const Color(0xFF0D9488))
                                      : textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Status Pill (Rich & Prominent)
                      SizedBox(
                        width: 125,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: isDark ? 0.16 : 0.10),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: statusColor.withValues(alpha: isDark ? 0.40 : 0.25),
                                  width: 1.2,
                                ),
                              ),
                              child: Text(
                                '● $statusLabel',
                                style: AppTypography.ui(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w900,
                                  color: statusColor,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Action Button (Tactile Obsidian / Platinum / Crimson with Soft Satisfying Hover)
                      SizedBox(
                        width: 110,
                        child: SoftHoverButton(
                          onTap: isFree ? onPassTap : onChallengeTap,
                          builder: (context, isHovered) {
                            if (isFree) {
                              final normalBg = isDark ? Colors.white : const Color(0xFF0F172A);
                              final hoverBg = isDark ? const Color(0xFFE2E8F0) : const Color(0xFF1E293B);
                              final hoverBorder = isDark ? Colors.white.withValues(alpha: 0.35) : const Color(0xFF334155);

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 160),
                                curve: Curves.easeOutCubic,
                                height: 34,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: isHovered ? hoverBg : normalBg,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isHovered ? hoverBorder : Colors.transparent,
                                    width: 1.2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: isHovered ? (isDark ? 0.35 : 0.20) : (isDark ? 0.20 : 0.10)),
                                      blurRadius: isHovered ? 12 : 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Play Now',
                                      style: AppTypography.ui(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                        color: isDark ? const Color(0xFF090B10) : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 13,
                                      color: isDark ? const Color(0xFF090B10) : Colors.white,
                                    ),
                                  ],
                                ),
                              );
                            } else if (isMatch) {
                              final normalBg = isDark ? const Color(0xFF240E14) : const Color(0xFFFFE4E6);
                              final hoverBg = isDark ? const Color(0xFF3B1621) : const Color(0xFFFECDD3);
                              final normalBorder = isDark
                                  ? const Color(0xFFFF4655).withValues(alpha: 0.5)
                                  : const Color(0xFFE11D48).withValues(alpha: 0.4);
                              final hoverBorder = isDark
                                  ? const Color(0xFFFF4655).withValues(alpha: 0.85)
                                  : const Color(0xFFE11D48).withValues(alpha: 0.75);

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 160),
                                curve: Curves.easeOutCubic,
                                height: 34,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: isHovered ? hoverBg : normalBg,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isHovered ? hoverBorder : normalBorder,
                                    width: 1.2,
                                  ),
                                  boxShadow: isHovered
                                      ? [
                                          BoxShadow(
                                            color: const Color(0xFFFF4655).withValues(alpha: 0.25),
                                            blurRadius: 10,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: isDark ? const Color(0xFFFF4655) : const Color(0xFFE11D48),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Live HUD',
                                      style: AppTypography.ui(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                        color: isDark ? const Color(0xFFFDA4AF) : const Color(0xFFBE123C),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.sensors_rounded,
                                      size: 13,
                                      color: isDark ? const Color(0xFFFDA4AF) : const Color(0xFFBE123C),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              final normalBg = isDark ? const Color(0xFF141824) : const Color(0xFFF1F5F9);
                              final hoverBg = isDark ? const Color(0xFF22293C) : const Color(0xFFE2E8F0);
                              final normalBorder = isDark ? const Color(0x1AFFFFFF) : const Color(0xFFCBD5E1);
                              final hoverBorder = isDark ? const Color(0x44FFFFFF) : const Color(0xFF94A3B8);
                              final hoverText = isDark ? Colors.white : const Color(0xFF0F172A);
                              final normalText = isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155);

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 160),
                                curve: Curves.easeOutCubic,
                                height: 34,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: isHovered ? hoverBg : normalBg,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isHovered ? hoverBorder : normalBorder,
                                    width: 1.2,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Watch HUD',
                                      style: AppTypography.ui(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: isHovered ? hoverText : normalText,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.visibility_rounded,
                                      size: 13,
                                      color: isHovered ? hoverText : normalText,
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STACKED ARENA PASSES & QUICK FUNCTIONS (Interactive Deck)
  // ============================================================
  // See InteractiveArenaPassDeck widget defined below.

  // ============================================================
  // QUICK CHALLENGE SPARRING RIVALS ROW (CIRCULAR AVATARS)
  // ============================================================
  static Widget _buildQuickSparringRivalsRow(
    BuildContext context, {
    required bool isDark,
    required VoidCallback onChallengeTap,
  }) {
    final rivals = [
      {'name': 'Jason T.', 'level': 'Lvl 14', 'avatar': DemoAvatars.jason},
      {'name': 'Sara K.', 'level': 'Lvl 18', 'avatar': DemoAvatars.sara},
      {'name': 'Nurul P.', 'level': 'Lvl 11', 'avatar': DemoAvatars.nurul},
      {'name': 'Daniel L.', 'level': 'Lvl 22', 'avatar': DemoAvatars.daniel},
      {'name': 'Mei R.', 'level': 'Lvl 19', 'avatar': DemoAvatars.mei},
      {'name': 'Rajan M.', 'level': 'Lvl 16', 'avatar': DemoAvatars.rajan},
    ];

    final cardBg = isDark ? const Color(0xFF12151F) : Colors.white;
    final cardBgElevated = isDark ? const Color(0xFF181D2A) : const Color(0xFFF8FAFC);
    final borderColor = isDark ? const Color(0x0EFFFFFF) : const Color(0xFFE2E8F0);
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);
    final levelColor = isDark ? const Color(0xFF00D8A5) : const Color(0xFF0D9488);
    final crimsonAccent = isDark ? const Color(0xFFFF4655) : const Color(0xFFE11D48);

    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'Quick Challenge Rivals',
            style: AppTypography.ui(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: textPrimary,
            ),
          ),
          const SizedBox(width: 16),
          // Crimson Add Button (Soft Glow Hover, Zero Layout Shift)
          SoftHoverButton(
            onTap: onChallengeTap,
            builder: (context, isHovered) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                curve: Curves.easeOutCubic,
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isHovered ? const Color(0xFFFF5C7A) : crimsonAccent,
                  shape: BoxShape.circle,
                  boxShadow: isHovered
                      ? [
                          BoxShadow(
                            color: crimsonAccent.withValues(alpha: 0.45),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: const Icon(
                  Icons.add_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              );
            },
          ),
          const SizedBox(width: 14),
          // Horizontal avatar row
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: rivals.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final rival = rivals[index];
                return SoftHoverButton(
                  onTap: onChallengeTap,
                  builder: (context, isHovered) {
                    final hoverBg = isDark ? const Color(0xFF222A3C) : const Color(0xFFF1F5F9);
                    final hoverBorder = isDark ? Colors.white.withValues(alpha: 0.25) : const Color(0xFFCBD5E1);

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isHovered ? hoverBg : cardBgElevated,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: isHovered ? hoverBorder : borderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundImage: AssetImage(rival['avatar']!),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                rival['name']!,
                                style: AppTypography.ui(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textPrimary,
                                ),
                              ),
                              Text(
                                rival['level']!,
                                style: AppTypography.ui(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: levelColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HELPER WIDGETS
  // ============================================================
  static Widget _buildFilterPill(String label, bool isActive, bool isDark, [VoidCallback? onTap]) {
    final activeBg = isDark ? const Color(0x18FF4655) : const Color(0xFFF1F5F9);
    final activeBorder = isDark ? const Color(0x55FF4655) : const Color(0xFFCBD5E1);
    final activeText = isDark ? const Color(0xFFFF4655) : const Color(0xFF0F172A);

    final inactiveBg = isDark ? const Color(0xFF161A26) : const Color(0xFFF8FAFC);
    final hoverInactiveBg = isDark ? const Color(0xFF22293C) : const Color(0xFFF1F5F9);
    final hoverInactiveBorder = isDark ? Colors.white.withValues(alpha: 0.20) : const Color(0xFFCBD5E1);
    final inactiveText = isDark ? const Color(0xFF8A99AD) : const Color(0xFF64748B);
    final hoverInactiveText = isDark ? Colors.white : const Color(0xFF0F172A);

    return SoftHoverButton(
      onTap: onTap,
      builder: (context, isHovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: isActive
                ? activeBg
                : (isHovered ? hoverInactiveBg : inactiveBg),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive
                  ? activeBorder
                  : (isHovered ? hoverInactiveBorder : Colors.transparent),
              width: 1.2,
            ),
          ),
          child: Text(
            label,
            style: AppTypography.ui(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w900 : FontWeight.w700,
              color: isActive
                  ? activeText
                  : (isHovered ? hoverInactiveText : inactiveText),
            ),
          ),
        );
      },
    );
  }

  static Widget buildRadarFloorplanSection(
    BuildContext context,
    bool isDark, {
    required VoidCallback onBackToCommand,
    required VoidCallback onPassTap,
    required VoidCallback onChallengeTap,
  }) {
    return _DesktopRadarFloorplanView(
      isDark: isDark,
      onBackToCommand: onBackToCommand,
      onPassTap: onPassTap,
      onChallengeTap: onChallengeTap,
    );
  }

  static Widget buildLeagueSection(
    BuildContext context,
    bool isDark, {
    required VoidCallback onBackToCommand,
    required VoidCallback onChallengeTap,
  }) {
    return _DesktopLeagueView(
      isDark: isDark,
      onBackToCommand: onBackToCommand,
      onChallengeTap: onChallengeTap,
    );
  }

  static Widget buildPassesSection(
    BuildContext context,
    bool isDark, {
    required VoidCallback onBackToCommand,
  }) {
    return _DesktopPassesView(
      isDark: isDark,
      onBackToCommand: onBackToCommand,
    );
  }

  static Widget buildTelemetrySection(
    BuildContext context,
    bool isDark, {
    required VoidCallback onBackToCommand,
  }) {
    return _DesktopTelemetryView(
      isDark: isDark,
      onBackToCommand: onBackToCommand,
    );
  }

  static Widget buildTvSection(
    BuildContext context,
    bool isDark, {
    required VoidCallback onBackToCommand,
  }) {
    final canvasBg = isDark ? const Color(0xFF090B10) : const Color(0xFFF8FAFC);
    final cardBg = isDark ? const Color(0xFF12151F) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);

    return Container(
      color: canvasBg,
      child: Column(
        children: [
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: cardBg,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SoftHoverButton(
                  onTap: onBackToCommand,
                  builder: (context, isHovered) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isHovered
                            ? (isDark ? Colors.white.withValues(alpha: 0.10) : const Color(0xFFE2E8F0))
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_rounded,
                            size: 16,
                            color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textPrimary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Back to Dashboard',
                            style: AppTypography.ui(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textPrimary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Text(
                  '55" Centre Court Broadcast Feed (1080p 60FPS)',
                  style: AppTypography.ui(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: DisplayLeaderboardScreen()),
        ],
      ),
    );
  }
}

// ============================================================
// METRIC WAVE PAINTER (SUBTLE SMOOTH BASE WAVE)
// ============================================================
class _MetricWavePainter extends CustomPainter {
  final Color waveColor;

  _MetricWavePainter({required this.waveColor});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.2,
      size.width * 0.5,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.8,
      size.width,
      size.height * 0.3,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          waveColor.withValues(alpha: 0.25),
          waveColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, fillPaint);

    final linePaint = Paint()
      ..color = waveColor.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final strokePath = Path();
    strokePath.moveTo(0, size.height * 0.7);
    strokePath.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.2,
      size.width * 0.5,
      size.height * 0.5,
    );
    strokePath.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.8,
      size.width,
      size.height * 0.3,
    );

    canvas.drawPath(strokePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant _MetricWavePainter oldDelegate) => oldDelegate.waveColor != waveColor;
}

// ============================================================
// INTERACTIVE ARENA PASS DECK (ANIMATED 3D STACK & RICH MATRIX)
// ============================================================
class InteractiveArenaPassDeck extends StatefulWidget {
  final VoidCallback onPassTap;
  final VoidCallback onWalkInTap;
  final VoidCallback onXpTap;
  final VoidCallback onChallengeTap;
  final bool isDark;

  const InteractiveArenaPassDeck({
    super.key,
    required this.onPassTap,
    required this.onWalkInTap,
    required this.onXpTap,
    required this.onChallengeTap,
    this.isDark = true,
  });

  @override
  State<InteractiveArenaPassDeck> createState() => _InteractiveArenaPassDeckState();
}

class _InteractiveArenaPassDeckState extends State<InteractiveArenaPassDeck> {
  int _activeCardIndex = 0;

  List<Map<String, dynamic>> _getPasses(bool isDark) {
    if (isDark) {
      return [
        {
          'title': 'JOMNITTAKU VIP PASS',
          'highlight': '90 sen / day',
          'subtitle': 'Alman Rahman · 24/7 Unlimited Access',
          'code': 'KX8VQS',
          'badge': 'VIP PASS',
          'colors': [const Color(0xFF1C202C), const Color(0xFF10131E)],
          'accent': const Color(0xFFFF4655),
          'icon': Icons.sports_tennis_rounded,
          'isDarkText': false,
        },
        {
          'title': 'OLYMPIC LEAGUE PRO',
          'highlight': '1,240 XP · Rank #4',
          'subtitle': 'Damansara Master · Zero Table Fees',
          'code': 'PRO-042',
          'badge': 'PRO LEAGUE',
          'colors': [const Color(0xFF1A1828), const Color(0xFF0F0E1C)],
          'accent': const Color(0xFF8B5CF6),
          'icon': Icons.military_tech_rounded,
          'isDarkText': false,
        },
        {
          'title': 'SMART RFID WALLET',
          'highlight': 'RM 150.00 Balance',
          'subtitle': 'Autonomous Ball Dispenser & Robot Active',
          'code': 'RFID-7701',
          'badge': 'RFID SMART',
          'colors': [const Color(0xFF0F1E20), const Color(0xFF081214)],
          'accent': const Color(0xFF00D8A5),
          'icon': Icons.contactless_rounded,
          'isDarkText': false,
        },
        {
          'title': 'NIGHT OWL PASS',
          'highlight': '12 AM – 6 AM',
          'subtitle': '50% OFF All Tables · Free Energy Drink',
          'code': 'NIGHT-50',
          'badge': 'MIDNIGHT',
          'colors': [const Color(0xFF26121D), const Color(0xFF14080E)],
          'accent': const Color(0xFFFF4655),
          'icon': Icons.nightlight_round,
          'isDarkText': false,
        },
      ];
    } else {
      return [
        {
          'title': 'JOMNITTAKU VIP PASS',
          'highlight': '90 sen / day',
          'subtitle': 'Alman Rahman · 24/7 Unlimited Access',
          'code': 'KX8VQS',
          'badge': 'VIP PASS',
          'colors': [Colors.white, const Color(0xFFF8FAFC)],
          'accent': const Color(0xFF0F172A),
          'icon': Icons.sports_tennis_rounded,
          'isDarkText': true,
        },
        {
          'title': 'OLYMPIC LEAGUE PRO',
          'highlight': '1,240 XP · Rank #4',
          'subtitle': 'Damansara Master · Zero Table Fees',
          'code': 'PRO-042',
          'badge': 'PRO LEAGUE',
          'colors': [Colors.white, const Color(0xFFFAF5FF)],
          'accent': const Color(0xFF6B21A8),
          'icon': Icons.military_tech_rounded,
          'isDarkText': true,
        },
        {
          'title': 'SMART RFID WALLET',
          'highlight': 'RM 150.00 Balance',
          'subtitle': 'Autonomous Ball Dispenser & Robot Active',
          'code': 'RFID-7701',
          'badge': 'RFID SMART',
          'colors': [Colors.white, const Color(0xFFF0FDFA)],
          'accent': const Color(0xFF0D9488),
          'icon': Icons.contactless_rounded,
          'isDarkText': true,
        },
        {
          'title': 'NIGHT OWL PASS',
          'highlight': '12 AM – 6 AM',
          'subtitle': '50% OFF All Tables · Free Energy Drink',
          'code': 'NIGHT-50',
          'badge': 'MIDNIGHT',
          'colors': [Colors.white, const Color(0xFFFFF1F2)],
          'accent': const Color(0xFFBE123C),
          'icon': Icons.nightlight_round,
          'isDarkText': true,
        },
      ];
    }
  }

  void _nextCard(int length) {
    setState(() {
      _activeCardIndex = (_activeCardIndex + 1) % length;
    });
  }

  void _selectCard(int index) {
    setState(() {
      _activeCardIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final passes = _getPasses(isDark);
    final cardBg = isDark ? const Color(0xFF12151F) : Colors.white;
    final borderColor = isDark ? const Color(0x0EFFFFFF) : const Color(0xFFE2E8F0);
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);
    final textSecondary = isDark ? const Color(0xFF8A99AD) : const Color(0xFF64748B);
    final elevatedBg = isDark ? const Color(0xFF161A26) : const Color(0xFFF8FAFC);

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.04),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with Interactive Swap Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Arena Passes & Membership',
                style: AppTypography.ui(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
              SoftHoverButton(
                onTap: () => _nextCard(passes.length),
                builder: (context, isHovered) {
                  final normalBg = isDark ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFF1F5F9);
                  final hoverBg = isDark ? Colors.white.withValues(alpha: 0.16) : const Color(0xFFE2E8F0);
                  final normalBorder = isDark ? Colors.white.withValues(alpha: 0.12) : const Color(0xFFE2E8F0);
                  final hoverBorder = isDark ? Colors.white.withValues(alpha: 0.28) : const Color(0xFFCBD5E1);

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isHovered ? hoverBg : normalBg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isHovered ? hoverBorder : normalBorder),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.swap_horiz_rounded,
                          size: 14,
                          color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Swap Pass (${_activeCardIndex + 1}/4)',
                          style: AppTypography.ui(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 3D Animated Card Stack
          Center(
            child: SizedBox(
              width: 310,
              height: 154,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _nextCard(passes.length),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: _buildAnimatedCardStack(passes, isDark),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Interactive Selector Pills
          Center(
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              alignment: WrapAlignment.center,
              children: List.generate(passes.length, (idx) {
                final isCurrent = idx == _activeCardIndex;
                final card = passes[idx];
                final accent = card['accent'] as Color;
                return SoftHoverButton(
                  onTap: () => _selectCard(idx),
                  builder: (context, isHovered) {
                    final hoverUnselectedBg = isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : const Color(0xFFE2E8F0);
                    final hoverUnselectedBorder = isDark
                        ? Colors.white.withValues(alpha: 0.22)
                        : const Color(0xFFCBD5E1);

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? accent.withValues(alpha: isDark ? 0.22 : 0.12)
                            : (isHovered
                                ? hoverUnselectedBg
                                : (isDark ? Colors.transparent : const Color(0xFFF1F5F9))),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isCurrent
                              ? accent
                              : (isHovered ? hoverUnselectedBorder : borderColor),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            card['icon'] as IconData,
                            size: 11,
                            color: isCurrent
                                ? accent
                                : (isHovered
                                    ? (isDark ? Colors.white : const Color(0xFF0F172A))
                                    : textSecondary),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            card['badge'] as String,
                            style: AppTypography.ui(
                              fontSize: 10.5,
                              fontWeight: isCurrent ? FontWeight.w900 : FontWeight.w700,
                              color: isCurrent
                                  ? textPrimary
                                  : (isHovered
                                      ? (isDark ? Colors.white : const Color(0xFF0F172A))
                                      : textSecondary),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ),

          const SizedBox(height: 14),

          // 2x2 TACTILE ACTION MATRIX (Replaces the lonely 4 thin lines!)
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildActionTile(
                          icon: Icons.door_front_door_rounded,
                          title: 'Walk In Tonight',
                          sub: 'RM17 Single Pass',
                          color: const Color(0xFFFF4655),
                          onTap: widget.onWalkInTap,
                          isDark: isDark,
                          elevatedBg: elevatedBg,
                          borderColor: borderColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildActionTile(
                          icon: Icons.radar_rounded,
                          title: 'Radar Ping',
                          sub: '14 Rivals Nearby',
                          color: const Color(0xFF38BDF8),
                          onTap: widget.onChallengeTap,
                          isDark: isDark,
                          elevatedBg: elevatedBg,
                          borderColor: borderColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildActionTile(
                          icon: Icons.emoji_events_rounded,
                          title: '1v1 Match Pot',
                          sub: 'RM200 Pot Active',
                          color: const Color(0xFFF59E0B),
                          onTap: widget.onChallengeTap,
                          isDark: isDark,
                          elevatedBg: elevatedBg,
                          borderColor: borderColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildActionTile(
                          icon: Icons.qr_code_2_rounded,
                          title: 'Optical QR Code',
                          sub: 'Scan Turnstile Gate',
                          color: const Color(0xFF00D8A5),
                          onTap: widget.onPassTap,
                          isDark: isDark,
                          elevatedBg: elevatedBg,
                          borderColor: borderColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Venue Telemetry Bar
                Container(
                  height: 34,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: elevatedBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTelemetryChip(Icons.ac_unit_rounded, '23°C AC', isDark),
                      _buildTelemetryChip(Icons.lightbulb_rounded, '480 Lux ITTF', isDark),
                      _buildTelemetryChip(Icons.sensors_rounded, 'Edge AI 60fps', isDark),
                      _buildTelemetryChip(Icons.lock_clock_rounded, '24/7 Gate', isDark),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAnimatedCardStack(List<Map<String, dynamic>> passes, bool isDark) {
    final indices = List.generate(passes.length, (i) => i);
    indices.sort((a, b) {
      int depthA = (a - _activeCardIndex + passes.length) % passes.length;
      int depthB = (b - _activeCardIndex + passes.length) % passes.length;
      return depthB.compareTo(depthA);
    });

    return indices.map((i) {
      int depth = (i - _activeCardIndex + passes.length) % passes.length;
      final card = passes[i];
      final colors = card['colors'] as List<Color>;
      final isDarkText = card['isDarkText'] as bool;
      final textColor = isDarkText ? const Color(0xFF0F172A) : Colors.white;
      final subColor = isDarkText ? const Color(0xFF475569) : const Color(0xFFCBD5E1);

      double top = 0;
      double width = 310;
      double height = 135;
      double scale = 1.0;
      double opacity = 1.0;

      if (depth == 0) {
        top = 18;
        width = 310;
        height = 135;
        scale = 1.0;
        opacity = 1.0;
      } else if (depth == 1) {
        top = 9;
        width = 285;
        height = 130;
        scale = 0.94;
        opacity = 0.85;
      } else if (depth == 2) {
        top = 0;
        width = 260;
        height = 125;
        scale = 0.88;
        opacity = 0.65;
      } else {
        top = -10;
        width = 235;
        height = 120;
        scale = 0.80;
        opacity = 0.0;
      }

      final accent = card['accent'] as Color? ?? Colors.white;

      return AnimatedPositioned(
        key: ValueKey('card_$i'),
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutBack,
        top: top,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutBack,
          scale: scale,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: opacity,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark
                      ? (depth == 0 ? accent.withValues(alpha: 0.45) : Colors.white.withValues(alpha: 0.10))
                      : (depth == 0 ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8F0)),
                  width: depth == 0 ? 1.4 : 1.0,
                ),
                boxShadow: depth == 0
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : null,
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(card['icon'] as IconData, size: 18, color: textColor),
                          const SizedBox(width: 6),
                          Text(
                            card['title'] as String,
                            style: AppTypography.ui(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: textColor,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.contactless_rounded, size: 18, color: textColor),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        card['highlight'] as String,
                        style: AppTypography.ui(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: textColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: isDarkText ? const Color(0xFFF1F5F9) : Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: isDarkText ? const Color(0xFFE2E8F0) : Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          card['code'] as String,
                          style: AppTypography.ui(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    card['subtitle'] as String,
                    style: AppTypography.ui(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: subColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String sub,
    required Color color,
    required VoidCallback onTap,
    required bool isDark,
    required Color elevatedBg,
    required Color borderColor,
  }) {
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);
    final textMuted = isDark ? const Color(0xFF8A99AD) : const Color(0xFF64748B);

    return SoftHoverButton(
      onTap: onTap,
      builder: (context, isHovered) {
        final hoverBg = isDark ? const Color(0xFF1F263A) : const Color(0xFFF1F5F9);
        final hoverBorder = isDark ? color.withValues(alpha: 0.40) : color.withValues(alpha: 0.35);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isHovered ? hoverBg : elevatedBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isHovered ? hoverBorder : borderColor),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.14),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: isHovered ? (isDark ? 0.28 : 0.16) : (isDark ? 0.16 : 0.08)),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: color.withValues(alpha: isHovered ? (isDark ? 0.55 : 0.35) : (isDark ? 0.30 : 0.18)),
                  ),
                ),
                child: Icon(icon, size: 16, color: color),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppTypography.ui(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w900,
                        color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      sub,
                      style: AppTypography.ui(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: textMuted,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 10,
                color: isHovered ? color : textMuted,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTelemetryChip(IconData icon, String label, bool isDark) {
    final emerald = isDark ? const Color(0xFF00D8A5) : const Color(0xFF0D9488);
    final textMuted = isDark ? const Color(0xFF8A99AD) : const Color(0xFF64748B);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: emerald),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTypography.ui(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            color: textMuted,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// 1. DESKTOP 10 COURTS RADAR & ARENA FLOORPLAN VIEW
// ============================================================
class _DesktopRadarFloorplanView extends StatefulWidget {
  final VoidCallback onBackToCommand;
  final VoidCallback onPassTap;
  final VoidCallback onChallengeTap;
  final bool isDark;

  const _DesktopRadarFloorplanView({
    required this.onBackToCommand,
    required this.onPassTap,
    required this.onChallengeTap,
    this.isDark = true,
  });

  @override
  State<_DesktopRadarFloorplanView> createState() => _DesktopRadarFloorplanViewState();
}

class _DesktopRadarFloorplanViewState extends State<_DesktopRadarFloorplanView> {
  String _selectedCourt = 'T04';
  int _filterIndex = 0; // 0: All, 1: Free, 2: In Play

  final List<Map<String, dynamic>> _courts = [
    {'id': 'T01', 'type': 'DHS Rainbow ITTF', 'player': 'Jason T. (Lvl 14)', 'avatar': DemoAvatars.jason, 'time': '18m in match', 'status': 'busy'},
    {'id': 'T02', 'type': 'DHS Rainbow ITTF', 'player': 'Sara K. (Lvl 18)', 'avatar': DemoAvatars.sara, 'time': '12m in match', 'status': 'busy'},
    {'id': 'T03', 'type': 'Stiga Showdown 25', 'player': 'Court Free & Ready', 'avatar': null, 'time': 'Free Now', 'status': 'free'},
    {'id': 'T04', 'type': 'Stadium Centre Court', 'player': 'Jason v Alman (14-11)', 'avatar': DemoAvatars.user, 'time': 'Live Match HUD', 'status': 'match'},
    {'id': 'T05', 'type': 'Stiga Showdown 25', 'player': 'Court Free & Ready', 'avatar': null, 'time': 'Free Now', 'status': 'free'},
    {'id': 'T06', 'type': 'Butterfly Centrefold', 'player': 'Court Free & Ready', 'avatar': null, 'time': 'Free Now', 'status': 'free'},
    {'id': 'T07', 'type': 'Butterfly Centrefold', 'player': 'Court Free & Ready', 'avatar': null, 'time': 'Free Now', 'status': 'free'},
    {'id': 'T08', 'type': 'Nittaku Premium 25', 'player': 'Court Free & Ready', 'avatar': null, 'time': 'Free Now', 'status': 'free'},
    {'id': 'T09', 'type': 'Nittaku Premium 25', 'player': 'League Cup Tournament', 'avatar': DemoAvatars.champion, 'time': 'Res 9:00 PM', 'status': 'reserved'},
    {'id': 'T10', 'type': 'Practice Court DHS', 'player': 'Court Free & Ready', 'avatar': null, 'time': 'Free Now', 'status': 'free'},
  ];

  Map<String, dynamic> get _activeCourt =>
      _courts.firstWhere((c) => c['id'] == _selectedCourt, orElse: () => _courts[3]);

  @override
  Widget build(BuildContext context) {
    final active = _activeCourt;
    final isFree = active['status'] == 'free';
    final isMatch = active['status'] == 'match';
    final isDark = widget.isDark;
    final canvasBg = isDark ? const Color(0xFF090B10) : const Color(0xFFF8FAFC);
    final cardBg = isDark ? const Color(0xFF12151F) : Colors.white;
    final borderColor = isDark ? const Color(0x0EFFFFFF) : const Color(0xFFE2E8F0);
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);

    return Container(
      color: canvasBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Navigation Bar (Back to Dashboard + Header)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SoftHoverButton(
                    onTap: widget.onBackToCommand,
                    builder: (context, isHovered) {
                      final hoverBg = isDark ? const Color(0xFF1C2234) : const Color(0xFFE2E8F0);
                      final hoverBorder = isDark ? Colors.white.withValues(alpha: 0.22) : const Color(0xFFCBD5E1);

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        curve: Curves.easeOutCubic,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isHovered ? hoverBg : cardBg,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: isHovered ? hoverBorder : borderColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_back_rounded,
                              size: 14,
                              color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textPrimary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Back to Dashboard',
                              style: AppTypography.ui(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textPrimary,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 14),
                  Text(
                    '10 Courts Interactive Arena Floorplan',
                    style: AppTypography.ui(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: DesktopWebSections.luxuryVoltEmerald.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: DesktopWebSections.luxuryVoltEmerald.withValues(alpha: 0.5),
                        width: 1.2,
                      ),
                    ),
                    child: Text(
                      '● 6 OF 10 FREE',
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: DesktopWebSections.luxuryVoltEmerald,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              // Filter pills
              Row(
                children: [
                  _buildFloorplanFilter('All (10)', _filterIndex == 0, () => setState(() => _filterIndex = 0)),
                  const SizedBox(width: 8),
                  _buildFloorplanFilter('Free (6)', _filterIndex == 1, () => setState(() => _filterIndex = 1)),
                  const SizedBox(width: 8),
                  _buildFloorplanFilter('In Play (3)', _filterIndex == 2, () => setState(() => _filterIndex = 2)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Main Canvas: Left 10-Court Floorplan Matrix + Right Spotlight Card
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left 10-Court Grid (Flex 65)
                Expanded(
                  flex: 65,
                  child: Container(
                    decoration: BoxDecoration(
                      color: DesktopWebSections.luxuryCardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: DesktopWebSections.luxuryBorderSubtle),
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'VENUE FLOORPLAN (LEVEL 2, 3 DAMANSARA MALL)',
                          style: AppTypography.ui(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF94A3B8),
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.88,
                            ),
                            itemCount: _courts.length,
                            itemBuilder: (context, index) {
                              final court = _courts[index];
                              final isSelected = court['id'] == _selectedCourt;
                              final status = court['status'] as String;
                              final courtIsFree = status == 'free';
                              final courtIsMatch = status == 'match';

                              Color statusCol = DesktopWebSections.luxuryVoltEmerald;
                              String statusTxt = 'FREE NOW';
                              if (status == 'busy') {
                                statusCol = DesktopWebSections.luxuryTangerineGold;
                                statusTxt = 'IN PLAY';
                              } else if (courtIsMatch) {
                                statusCol = DesktopWebSections.luxuryCoralRose;
                                statusTxt = 'LIVE MATCH';
                              } else if (status == 'reserved') {
                                statusCol = DesktopWebSections.luxuryAmethystPurple;
                                statusTxt = 'RESERVED';
                              }

                              return MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => setState(() => _selectedCourt = court['id'] as String),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF2C3044)
                                          : DesktopWebSections.luxuryCardBgElevated,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? DesktopWebSections.luxuryCoralRose
                                            : Colors.white.withValues(alpha: 0.05),
                                        width: isSelected ? 2.0 : 1.0,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: DesktopWebSections.luxuryCoralRose.withValues(alpha: 0.3),
                                                blurRadius: 12,
                                                offset: const Offset(0, 3),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Mini ITTF Table 3D Surface
                                        Container(
                                          width: 48,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: courtIsFree
                                                  ? [const Color(0xFF1E3A8A), const Color(0xFF2563EB)]
                                                  : [const Color(0xFF334155), const Color(0xFF1E293B)],
                                            ),
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(
                                              color: Colors.white.withValues(alpha: 0.5),
                                              width: 1,
                                            ),
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(width: 1.5, color: Colors.white.withValues(alpha: 0.8)),
                                              if (!courtIsFree)
                                                Positioned(
                                                  left: 8,
                                                  child: Container(
                                                    width: 5,
                                                    height: 5,
                                                    decoration: const BoxDecoration(
                                                      color: DesktopWebSections.luxuryCoralRose,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          court['id'] as String,
                                          style: AppTypography.ui(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          court['type'] as String,
                                          style: AppTypography.ui(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF94A3B8),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: statusCol.withValues(alpha: 0.18),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            statusTxt,
                                            style: AppTypography.ui(
                                              fontSize: 9.5,
                                              fontWeight: FontWeight.w900,
                                              color: statusCol,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Right Court Spotlight Card (Flex 35)
                Expanded(
                  flex: 35,
                  child: Container(
                    decoration: BoxDecoration(
                      color: DesktopWebSections.luxuryCardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: DesktopWebSections.luxuryBorderSubtle),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 18,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${active['id']} SPOTLIGHT',
                              style: AppTypography.ui(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: (isFree ? DesktopWebSections.luxuryVoltEmerald : DesktopWebSections.luxuryCoralRose).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                isFree ? 'AVAILABLE' : (isMatch ? 'LIVE MATCH' : 'IN PLAY'),
                                style: AppTypography.ui(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  color: isFree ? DesktopWebSections.luxuryVoltEmerald : DesktopWebSections.luxuryCoralRose,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          active['type'] as String,
                          style: AppTypography.ui(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFBAC0D4),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Occupant / Match Status Box
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: DesktopWebSections.luxuryCardBgElevated,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CURRENT OCCUPANT / SESSION',
                                style: AppTypography.ui(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF94A3B8),
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  if (active['avatar'] != null)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundImage: AssetImage(active['avatar'] as String),
                                      ),
                                    ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          active['player'] as String,
                                          style: AppTypography.ui(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          active['time'] as String,
                                          style: AppTypography.ui(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w700,
                                            color: DesktopWebSections.luxuryVoltEmerald,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Telemetry sensors for this court
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: DesktopWebSections.luxuryCardBgElevated,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              _buildSensorRow(Icons.ac_unit_rounded, 'Court Climate', '23.0°C Optimal'),
                              const Divider(height: 16, color: Color(0x14FFFFFF)),
                              _buildSensorRow(Icons.lightbulb_rounded, 'ITTF Arena Lighting', '480 Lux Flicker-Free'),
                              const Divider(height: 16, color: Color(0x14FFFFFF)),
                              _buildSensorRow(Icons.videocam_rounded, 'Edge AI Camera Sensor', 'Active 60 FPS Ball Track'),
                            ],
                          ),
                        ),

                        const Spacer(),

                        // Action button
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: isFree ? widget.onPassTap : widget.onChallengeTap,
                            child: Container(
                              width: double.infinity,
                              height: 44,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: isFree
                                      ? [const Color(0xFF10B981), const Color(0xFF059669)]
                                      : [const Color(0xFFFF4B72), const Color(0xFFE11D48)],
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: (isFree ? const Color(0xFF10B981) : const Color(0xFFFF4B72)).withValues(alpha: 0.35),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(isFree ? Icons.door_front_door_rounded : Icons.sensors_rounded, size: 16, color: Colors.white),
                                  const SizedBox(width: 8),
                                  Text(
                                    isFree ? 'Check In to ${active['id']} (RM17) →' : 'Watch Live Match HUD →',
                                    style: AppTypography.ui(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloorplanFilter(String label, bool isActive, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: isActive ? DesktopWebSections.luxuryCoralRose.withValues(alpha: 0.2) : DesktopWebSections.luxuryCardBgElevated,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? DesktopWebSections.luxuryCoralRose : Colors.transparent,
              width: 1.2,
            ),
          ),
          child: Text(
            label,
            style: AppTypography.ui(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w900 : FontWeight.w700,
              color: isActive ? DesktopWebSections.luxuryCoralRose : DesktopWebSections.luxuryTextSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSensorRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: DesktopWebSections.luxuryVoltEmerald),
            const SizedBox(width: 8),
            Text(label, style: AppTypography.ui(fontSize: 12, color: const Color(0xFFBAC0D4))),
          ],
        ),
        Text(value, style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white)),
      ],
    );
  }
}

// ============================================================
// 2. DESKTOP OLYMPIC LEAGUE & LEADERBOARD VIEW
// ============================================================
class _DesktopLeagueView extends StatelessWidget {
  final VoidCallback onBackToCommand;
  final VoidCallback onChallengeTap;
  final bool isDark;

  const _DesktopLeagueView({
    required this.onBackToCommand,
    required this.onChallengeTap,
    this.isDark = true,
  });

  @override
  Widget build(BuildContext context) {
    final standings = [
      {'rank': '#1', 'name': 'Daniel L.', 'xp': '1,620 XP', 'winRate': '88%', 'avatar': DemoAvatars.daniel, 'badge': 'CHAMPION'},
      {'rank': '#2', 'name': 'Sara K.', 'xp': '1,460 XP', 'winRate': '82%', 'avatar': DemoAvatars.sara, 'badge': 'MASTER'},
      {'rank': '#3', 'name': 'Mei R.', 'xp': '1,395 XP', 'winRate': '79%', 'avatar': DemoAvatars.mei, 'badge': 'MASTER'},
      {'rank': '#4', 'name': 'Alman R. (You)', 'xp': '1,240 XP', 'winRate': '76%', 'avatar': DemoAvatars.user, 'badge': 'PRO'},
      {'rank': '#5', 'name': 'Jason T.', 'xp': '1,190 XP', 'winRate': '71%', 'avatar': DemoAvatars.jason, 'badge': 'PRO'},
      {'rank': '#6', 'name': 'Rajan M.', 'xp': '1,110 XP', 'winRate': '68%', 'avatar': DemoAvatars.rajan, 'badge': 'CONTENDER'},
      {'rank': '#7', 'name': 'Nurul P.', 'xp': '1,050 XP', 'winRate': '65%', 'avatar': DemoAvatars.nurul, 'badge': 'CONTENDER'},
    ];

    final canvasBg = isDark ? const Color(0xFF090B10) : const Color(0xFFF8FAFC);
    final cardBg = isDark ? const Color(0xFF12151F) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);

    return Container(
      color: canvasBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              SoftHoverButton(
                onTap: onBackToCommand,
                builder: (context, isHovered) {
                  final hoverBg = isDark ? const Color(0xFF1C2234) : const Color(0xFFE2E8F0);
                  final hoverBorder = isDark ? Colors.white.withValues(alpha: 0.22) : const Color(0xFFCBD5E1);

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isHovered ? hoverBg : cardBg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isHovered
                            ? hoverBorder
                            : (isDark ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFE2E8F0)),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_rounded,
                          size: 14,
                          color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textPrimary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Back to Dashboard',
                          style: AppTypography.ui(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textPrimary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: 14),
              Text(
                'Olympic League & Damansara Standings',
                style: AppTypography.ui(fontSize: 18, fontWeight: FontWeight.w900, color: textPrimary),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Podium Top 3 Cards
          SizedBox(
            height: 110,
            child: Row(
              children: [
                Expanded(
                  child: _buildPodiumCard(
                    rank: '1ST PLACE',
                    name: 'Daniel L.',
                    xp: '1,620 XP',
                    avatar: DemoAvatars.daniel,
                    color: DesktopWebSections.luxuryTangerineGold,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildPodiumCard(
                    rank: '2ND PLACE',
                    name: 'Sara K.',
                    xp: '1,460 XP',
                    avatar: DemoAvatars.sara,
                    color: const Color(0xFFCBD5E1),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildPodiumCard(
                    rank: '3RD PLACE',
                    name: 'Mei R.',
                    xp: '1,395 XP',
                    avatar: DemoAvatars.mei,
                    color: const Color(0xFFCD7F32),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Full Standings Table
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: DesktopWebSections.luxuryCardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: DesktopWebSections.luxuryBorderSubtle),
              ),
              padding: const EdgeInsets.all(18),
              child: ListView.separated(
                itemCount: standings.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final s = standings[index];
                  final isUser = s['name']!.contains('(You)');

                  return Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isUser ? DesktopWebSections.luxuryCoralRose.withValues(alpha: 0.12) : DesktopWebSections.luxuryCardBgElevated,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isUser ? DesktopWebSections.luxuryCoralRose.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.04),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 45,
                          child: Text(
                            s['rank']!,
                            style: AppTypography.ui(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: isUser ? DesktopWebSections.luxuryCoralRose : Colors.white,
                            ),
                          ),
                        ),
                        CircleAvatar(radius: 14, backgroundImage: AssetImage(s['avatar']!)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            s['name']!,
                            style: AppTypography.ui(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'Win Rate: ${s['winRate']}',
                          style: AppTypography.ui(fontSize: 12, color: const Color(0xFFBAC0D4)),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: DesktopWebSections.luxuryTangerineGold.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            s['xp']!,
                            style: AppTypography.ui(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: DesktopWebSections.luxuryTangerineGold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: onChallengeTap,
                            child: Container(
                              height: 32,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: DesktopWebSections.luxuryElectricBlue.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: DesktopWebSections.luxuryElectricBlue.withValues(alpha: 0.5)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Challenge Rival →',
                                style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w900, color: const Color(0xFF60A5FA)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumCard({
    required String rank,
    required String name,
    required String xp,
    required String avatar,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: DesktopWebSections.luxuryCardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundImage: AssetImage(avatar)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(rank, style: AppTypography.ui(fontSize: 10.5, fontWeight: FontWeight.w900, color: color, letterSpacing: 0.8)),
              Text(name, style: AppTypography.ui(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white)),
              Text(xp, style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 3. DESKTOP ARENA PASSES & MEMBERSHIP PLANS VIEW
// ============================================================
class _DesktopPassesView extends StatelessWidget {
  final VoidCallback onBackToCommand;
  final bool isDark;

  const _DesktopPassesView({
    required this.onBackToCommand,
    this.isDark = true,
  });

  @override
  Widget build(BuildContext context) {
    final canvasBg = isDark ? const Color(0xFF090B10) : const Color(0xFFF8FAFC);
    final cardBg = isDark ? const Color(0xFF12151F) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);

    return Container(
      color: canvasBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SoftHoverButton(
                onTap: onBackToCommand,
                builder: (context, isHovered) {
                  final hoverBg = isDark ? const Color(0xFF1C2234) : const Color(0xFFE2E8F0);
                  final hoverBorder = isDark ? Colors.white.withValues(alpha: 0.22) : const Color(0xFFCBD5E1);

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isHovered ? hoverBg : cardBg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isHovered
                            ? hoverBorder
                            : (isDark ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFE2E8F0)),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_rounded,
                          size: 14,
                          color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textPrimary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Back to Dashboard',
                          style: AppTypography.ui(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textPrimary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: 14),
              Text(
                'Arena Passes & 24/7 Autonomous Membership',
                style: AppTypography.ui(fontSize: 18, fontWeight: FontWeight.w900, color: textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _buildPassProductCard(
                    title: 'JOMNITTAKU VIP PASS',
                    price: '90 sen / day',
                    sub: 'Billed monthly (RM27) · Unlimited 24/7 Arena Access',
                    colors: isDark
                        ? [const Color(0xFF1C202C), const Color(0xFF121520)]
                        : [Colors.white, const Color(0xFFF8FAFC)],
                    accentColor: isDark ? const Color(0xFFFF4655) : const Color(0xFF0F172A),
                    code: 'KX8VQS',
                    badge: 'MOST POPULAR',
                    features: ['All 10 ITTF Tables Unlimited', 'Smart Turnstile Door Unlock', 'Daily Quest +200 XP', 'Zero Wait Time'],
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPassProductCard(
                    title: 'OLYMPIC LEAGUE PRO',
                    price: 'Tier 1 Master',
                    sub: 'Earned at 1,200+ XP or RM45/mo Pro Tier',
                    colors: isDark
                        ? [const Color(0xFF1B192A), const Color(0xFF100E1C)]
                        : [Colors.white, const Color(0xFFFAF5FF)],
                    accentColor: isDark ? const Color(0xFF8B5CF6) : const Color(0xFF6B21A8),
                    code: 'PRO-042',
                    badge: 'PRO LEAGUE',
                    features: ['Free Tournament Entry', 'Centre Court T04 Priority', 'Coach AI Match Analytics', 'Exclusive Rival Challenges'],
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPassProductCard(
                    title: 'SMART RFID WALLET',
                    price: 'RM 150.00 Balance',
                    sub: 'Preloaded autonomous token wallet',
                    colors: isDark
                        ? [const Color(0xFF0F1E20), const Color(0xFF081214)]
                        : [Colors.white, const Color(0xFFF0FDFA)],
                    accentColor: isDark ? const Color(0xFF00D8A5) : const Color(0xFF0D9488),
                    code: 'RFID-7701',
                    badge: 'INSTANT TAP',
                    features: ['Instant Physical NFC Gate Card', 'Automatic Ball Dispenser', 'Robot Trainer Dispenser', 'Auto Reload Option'],
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassProductCard({
    required String title,
    required String price,
    required String sub,
    required List<Color> colors,
    required Color accentColor,
    required String code,
    required String badge,
    required List<String> features,
    required bool isDark,
  }) {
    final cardBg = isDark ? const Color(0xFF12151F) : Colors.white;
    final borderColor = isDark ? const Color(0x0EFFFFFF) : const Color(0xFFE2E8F0);
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);
    final textMuted = isDark ? const Color(0xFF8A99AD) : const Color(0xFF64748B);

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? accentColor.withValues(alpha: 0.35) : borderColor,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.04),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: isDark ? 0.18 : 0.10),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: accentColor.withValues(alpha: isDark ? 0.35 : 0.20),
              ),
            ),
            child: Text(
              badge,
              style: AppTypography.ui(fontSize: 10.5, fontWeight: FontWeight.w900, color: accentColor),
            ),
          ),
          const SizedBox(height: 12),
          Text(title, style: AppTypography.ui(fontSize: 16, fontWeight: FontWeight.w900, color: textPrimary)),
          const SizedBox(height: 4),
          Text(price, style: AppTypography.ui(fontSize: 22, fontWeight: FontWeight.w900, color: accentColor)),
          Text(sub, style: AppTypography.ui(fontSize: 11, color: textMuted)),
          const SizedBox(height: 18),
          Divider(color: borderColor),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_rounded, size: 14, color: accentColor),
                    const SizedBox(width: 8),
                    Expanded(child: Text(f, style: AppTypography.ui(fontSize: 12, color: textPrimary))),
                  ],
                ),
              )).toList(),
            ),
          ),
          SoftHoverButton(
            onTap: () {},
            builder: (context, isHovered) {
              final isPopular = badge == 'MOST POPULAR';
              final normalBg = isPopular
                  ? (isDark ? Colors.white : const Color(0xFF0F172A))
                  : (isDark ? const Color(0xFF161A26) : const Color(0xFFF1F5F9));
              final hoverBg = isPopular
                  ? (isDark ? const Color(0xFFE2E8F0) : const Color(0xFF1E293B))
                  : (isDark ? const Color(0xFF22293C) : const Color(0xFFE2E8F0));
              final normalBorder = isPopular
                  ? (isDark ? Colors.white : const Color(0xFF0F172A))
                  : (isDark ? const Color(0x1AFFFFFF) : const Color(0xFFCBD5E1));
              final hoverBorder = isPopular
                  ? (isDark ? Colors.white : const Color(0xFF334155))
                  : (isDark ? const Color(0x44FFFFFF) : const Color(0xFF94A3B8));

              return AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                curve: Curves.easeOutCubic,
                width: double.infinity,
                height: 42,
                decoration: BoxDecoration(
                  color: isHovered ? hoverBg : normalBg,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: isHovered ? hoverBorder : normalBorder,
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Select Pass →',
                  style: AppTypography.ui(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: isPopular
                        ? (isDark ? const Color(0xFF090B10) : Colors.white)
                        : (isDark ? Colors.white : const Color(0xFF0F172A)),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 4. DESKTOP 24/7 SMART ARENA LIVE HUB (ZENITH & TYMEWISE CLEAN DESIGN)
// ============================================================
class _DesktopTelemetryView extends StatelessWidget {
  final VoidCallback onBackToCommand;
  final bool isDark;

  const _DesktopTelemetryView({
    required this.onBackToCommand,
    this.isDark = true,
  });

  @override
  Widget build(BuildContext context) {
    final canvasBg = isDark ? const Color(0xFF090B10) : const Color(0xFFF8FAFC);
    final cardBg = isDark ? const Color(0xFF111420) : Colors.white;
    final cardBorder = isDark ? Colors.white.withValues(alpha: 0.07) : const Color(0xFFE2E8F0);
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);
    final textSecondary = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final textMuted = isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);
    const voltEmerald = Color(0xFF10B981);
    const electricBlue = Color(0xFF38BDF8);
    const coralRose = Color(0xFFFF5C38);
    const amberGold = Color(0xFFF59E0B);

    return Container(
      color: canvasBg,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1320),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. TOP HEADER BAR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SoftHoverButton(
                          onTap: onBackToCommand,
                          builder: (context, isHovered) {
                            final hoverBg = isDark ? const Color(0xFF1C2234) : const Color(0xFFF1F5F9);
                            final hoverBorder = isDark ? Colors.white.withValues(alpha: 0.20) : const Color(0xFFCBD5E1);

                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 160),
                              curve: Curves.easeOutCubic,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: isHovered ? hoverBg : cardBg,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: isHovered ? hoverBorder : cardBorder),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_back_rounded,
                                    size: 14,
                                    color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textPrimary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Back to Dashboard',
                                    style: AppTypography.ui(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                      color: isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '24/7 Autonomous Smart Arena Live Hub',
                          style: AppTypography.ui(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: textPrimary,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: voltEmerald.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: voltEmerald.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: voltEmerald,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '24/7 UNMANNED ARENA ACTIVE',
                                style: AppTypography.ui(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: voltEmerald,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '3 Damansara Mall Level 2 • Self-Service Venue',
                      style: AppTypography.ui(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 2. FOUR ZENITH-STYLE CALM METRICS (TOP ROW)
                Row(
                  children: [
                    Expanded(
                      child: _buildZenithMetricCard(
                        cardBg: cardBg,
                        cardBorder: cardBorder,
                        title: 'TABLE AVAILABILITY',
                        value: '6 / 10 Free',
                        subtitle: '4 active matches • 0 queue',
                        badgeText: 'Walk-ins Ready',
                        badgeColor: voltEmerald,
                        icon: Icons.sports_tennis_rounded,
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildZenithMetricCard(
                        cardBg: cardBg,
                        cardBorder: cardBorder,
                        title: 'CLIMATE & LIGHTING',
                        value: '23.0°C / 480 Lux',
                        subtitle: 'Dual inverters • 5000K',
                        badgeText: 'ITTF Certified',
                        badgeColor: electricBlue,
                        icon: Icons.thermostat_rounded,
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildZenithMetricCard(
                        cardBg: cardBg,
                        cardBorder: cardBorder,
                        title: 'UNMANNED TURNSTILES',
                        value: 'Gates 1 & 2 Online',
                        subtitle: '0.3s QR • Anti-tailgating',
                        badgeText: 'Fail-Open Ready',
                        badgeColor: voltEmerald,
                        icon: Icons.qr_code_scanner_rounded,
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildZenithMetricCard(
                        cardBg: cardBg,
                        cardBorder: cardBorder,
                        title: 'BALL DISPENSERS',
                        value: '240 Balls Ready',
                        subtitle: 'DHS 3-Star • T08 & T10 armed',
                        badgeText: '100% Stocked',
                        badgeColor: amberGold,
                        icon: Icons.all_inclusive_rounded,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 3. MIDDLE HERO: 24-HOUR ARENA ACTIVITY & OCCUPANCY FORECAST (TYMEWISE HOURLY BAR CHART)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: cardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month_outlined, size: 16, color: coralRose),
                                  const SizedBox(width: 8),
                                  Text(
                                    '24-Hour Arena Crowd Pattern & Best Time To Play',
                                    style: AppTypography.ui(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Real-time telemetry and predictive hourly wait times for walk-in players',
                                style: AppTypography.ui(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: textSecondary,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: voltEmerald.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: voltEmerald.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: voltEmerald,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'NOW: 11:20 AM • 6 OF 10 TABLES FREE',
                                  style: AppTypography.ui(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: voltEmerald,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Tymewise Vertical Hourly Bar Chart
                      _buildCrowdPatternChart(isDark: isDark),
                      const SizedBox(height: 20),

                      // Schedule Phase Tags Row (Clean Saas Badges)
                      Row(
                        children: [
                          Expanded(
                            child: _buildScheduleTag(
                              timeRange: '12 AM – 8 AM',
                              title: 'MIDNIGHT CHILL',
                              subtitle: 'Happy Hour 50% Off Pass',
                              color: coralRose,
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildScheduleTag(
                              timeRange: '8 AM – 4 PM',
                              title: 'DAY OPEN PLAY',
                              subtitle: 'Solo Robot Practice • Free Tables',
                              color: electricBlue,
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildScheduleTag(
                              timeRange: '4 PM – 8 PM',
                              title: 'AFTER-WORK MATCHES',
                              subtitle: 'Casual 1v1 Sparring & Groups',
                              color: voltEmerald,
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildScheduleTag(
                              timeRange: '8 PM – 11 PM',
                              title: 'PEAK RUSH HOUR',
                              subtitle: 'Olympic League Matches',
                              color: amberGold,
                              isDark: isDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 4. BOTTOM 50/50 SPLIT: AUTONOMOUS HARDWARE & LIVE CHECK-IN FEED
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT COLUMN: AUTONOMOUS HARDWARE SUBSYSTEMS
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: cardBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.memory_rounded, size: 16, color: electricBlue),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Autonomous Subsystems',
                                      style: AppTypography.ui(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: voltEmerald.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '100% HEALTHY',
                                    style: AppTypography.ui(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: voltEmerald,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            _buildHardwareRow(
                              title: 'Turnstile Gates (1 & 2)',
                              desc: 'Optical QR reader • Anti-tailgating active',
                              statusText: 'GATE 1 & 2 ONLINE',
                              statusColor: voltEmerald,
                              isDark: isDark,
                            ),
                            const SizedBox(height: 8),
                            _buildHardwareRow(
                              title: 'Optical Radar & AI Cameras',
                              desc: '60 FPS smash velocity • Ball trajectory model',
                              statusText: 'ACTIVE ON T04',
                              statusColor: electricBlue,
                              isDark: isDark,
                            ),
                            const SizedBox(height: 8),
                            _buildHardwareRow(
                              title: 'Robot Ball Feeders',
                              desc: 'Courts T08 & T10 • DHS 3-Star automated cycle',
                              statusText: 'ARMED & READY',
                              statusColor: amberGold,
                              isDark: isDark,
                            ),
                            const SizedBox(height: 8),
                            _buildHardwareRow(
                              title: 'Climate & Neutral Lighting',
                              desc: 'Dual inverter chillers • Shadowless 5000K white',
                              statusText: '23.0°C / 480 LUX',
                              statusColor: textPrimary,
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // RIGHT COLUMN: LIVE ARENA CHECK-IN & MATCH ACTIVITY FEED
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: cardBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.history_rounded, size: 16, color: voltEmerald),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Live Arena Check-In Feed',
                                      style: AppTypography.ui(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'REAL-TIME SYNC',
                                  style: AppTypography.ui(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: textMuted,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            _buildFeedRow(
                              avatar: 'JT',
                              name: 'Jason T. (Lvl 14)',
                              action: 'Unlocked Gate 1 Turnstile via Dynamic QR',
                              timeAgo: '2m ago',
                              accentColor: voltEmerald,
                              isDark: isDark,
                            ),
                            const SizedBox(height: 8),
                            _buildFeedRow(
                              avatar: '04',
                              name: 'Court T04 Match Active',
                              action: 'Jason T. vs Alman R. (Game 3 • 14 - 11)',
                              timeAgo: '5m ago',
                              accentColor: electricBlue,
                              isDark: isDark,
                            ),
                            const SizedBox(height: 8),
                            _buildFeedRow(
                              avatar: 'SK',
                              name: 'Sara K. (Lvl 18)',
                              action: 'Dispensed 10 Balls at Robot Trainer T08',
                              timeAgo: '12m ago',
                              accentColor: amberGold,
                              isDark: isDark,
                            ),
                            const SizedBox(height: 8),
                            _buildFeedRow(
                              avatar: 'AI',
                              name: 'Tournament Court T01',
                              action: 'Optical Radar calibration completed (60 FPS)',
                              timeAgo: '19m ago',
                              accentColor: textSecondary,
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper: Zenith-style Calm Metric Card
  Widget _buildZenithMetricCard({
    required Color cardBg,
    required Color cardBorder,
    required String title,
    required String value,
    required String subtitle,
    required String badgeText,
    required Color badgeColor,
    required IconData icon,
    required bool isDark,
  }) {
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);
    final textSecondary = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.ui(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: textSecondary,
                  letterSpacing: 0.6,
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: isDark ? 0.12 : 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 14, color: badgeColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTypography.ui(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: textPrimary,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.ui(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: textSecondary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badgeText,
                  style: AppTypography.ui(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper: Tymewise 24-Hour Crowd Pattern Hourly Bar Chart
  Widget _buildCrowdPatternChart({required bool isDark}) {
    final textMuted = isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);
    final regularBarBg = isDark ? const Color(0xFF1E2638) : const Color(0xFFE2E8F0);
    const emerald = Color(0xFF10B981);
    const coral = Color(0xFFFF5C38);
    const blue = Color(0xFF38BDF8);

    final slots = [
      {'hour': '12A', 'pct': 0.12, 'isNow': false, 'color': regularBarBg},
      {'hour': '2A', 'pct': 0.06, 'isNow': false, 'color': regularBarBg},
      {'hour': '4A', 'pct': 0.04, 'isNow': false, 'color': regularBarBg},
      {'hour': '6A', 'pct': 0.10, 'isNow': false, 'color': regularBarBg},
      {'hour': '8A', 'pct': 0.28, 'isNow': false, 'color': blue.withValues(alpha: 0.6)},
      {'hour': '10A', 'pct': 0.38, 'isNow': false, 'color': blue.withValues(alpha: 0.7)},
      {'hour': 'NOW', 'pct': 0.40, 'isNow': true, 'color': emerald},
      {'hour': '12P', 'pct': 0.52, 'isNow': false, 'color': blue.withValues(alpha: 0.7)},
      {'hour': '2P', 'pct': 0.48, 'isNow': false, 'color': blue.withValues(alpha: 0.7)},
      {'hour': '4P', 'pct': 0.65, 'isNow': false, 'color': coral.withValues(alpha: 0.7)},
      {'hour': '6P', 'pct': 0.88, 'isNow': false, 'color': coral},
      {'hour': '8P', 'pct': 0.95, 'isNow': false, 'color': coral},
      {'hour': '10P', 'pct': 0.45, 'isNow': false, 'color': regularBarBg},
    ];

    return SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: slots.map((slot) {
          final isNow = slot['isNow'] as bool;
          final pct = slot['pct'] as double;
          final hour = slot['hour'] as String;
          final barColor = slot['color'] as Color;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isNow)
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: emerald,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '11:20',
                        style: AppTypography.ui(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: pct.clamp(0.08, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: barColor,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                            border: isNow ? Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1.5) : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    hour,
                    style: AppTypography.ui(
                      fontSize: 10,
                      fontWeight: isNow ? FontWeight.w800 : FontWeight.w600,
                      color: isNow ? emerald : textMuted,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Helper: Schedule Phase Tag
  Widget _buildScheduleTag({
    required String timeRange,
    required String title,
    required String subtitle,
    required Color color,
    required bool isDark,
  }) {
    final bg = isDark ? color.withValues(alpha: 0.08) : color.withValues(alpha: 0.05);
    final border = isDark ? color.withValues(alpha: 0.25) : color.withValues(alpha: 0.2);
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);

    return SoftHoverButton(
      onTap: () {},
      builder: (context, isHovered) {
        final hoverBg = isDark ? color.withValues(alpha: 0.16) : color.withValues(alpha: 0.12);
        final hoverBorder = isDark ? color.withValues(alpha: 0.50) : color.withValues(alpha: 0.40);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isHovered ? hoverBg : bg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isHovered ? hoverBorder : border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    timeRange,
                    style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: color),
                  ),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: AppTypography.ui(fontSize: 11.5, fontWeight: FontWeight.w800, color: textPrimary),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w500, color: color),
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper: Hardware Row
  Widget _buildHardwareRow({
    required String title,
    required String desc,
    required String statusText,
    required Color statusColor,
    required bool isDark,
  }) {
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);
    final textSecondary = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final rowBg = isDark ? const Color(0xFF151926) : const Color(0xFFF1F5F9);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: rowBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: textPrimary),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: AppTypography.ui(fontSize: 10.5, fontWeight: FontWeight.w500, color: textSecondary),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: statusColor.withValues(alpha: 0.25)),
            ),
            child: Text(
              statusText,
              style: AppTypography.ui(fontSize: 9.5, fontWeight: FontWeight.w800, color: statusColor),
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Live Check-In / Activity Feed Row
  Widget _buildFeedRow({
    required String avatar,
    required String name,
    required String action,
    required String timeAgo,
    required Color accentColor,
    required bool isDark,
  }) {
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);
    final textSecondary = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final rowBg = isDark ? const Color(0xFF151926) : const Color(0xFFF1F5F9);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: rowBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: isDark ? 0.2 : 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Text(
              avatar,
              style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: accentColor),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: textPrimary),
                ),
                Text(
                  action,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.ui(fontSize: 10.5, fontWeight: FontWeight.w500, color: textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            timeAgo,
            style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: accentColor),
          ),
        ],
      ),
    );
  }
}
