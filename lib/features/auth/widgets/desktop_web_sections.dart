import 'package:flutter/material.dart';

import '../../../core/session/demo_avatars.dart';
import '../../../core/theme/app_typography.dart';
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
  static const Color luxuryCanvasBg = Color(0xFF161720);
  static const Color luxuryCardBg = Color(0xFF20222F);
  static const Color luxuryCardBgElevated = Color(0xFF262938);
  static const Color luxuryCoralRose = Color(0xFFFF4B72);
  static const Color luxuryTangerineGold = Color(0xFFFFA533);
  static const Color luxuryVoltEmerald = Color(0xFF10B981);
  static const Color luxuryElectricBlue = Color(0xFF3B82F6);
  static const Color luxuryAmethystPurple = Color(0xFF8B5CF6);
  static const Color luxuryTextPrimary = Colors.white;
  static const Color luxuryTextSecondary = Color(0xFFBAC0D4);
  static const Color luxuryTextMuted = Color(0xFF9095AA);
  static const Color luxuryBorderSubtle = Color(0x14FFFFFF);

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
    return Container(
      color: luxuryCanvasBg,
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
                    badgeColor: luxuryVoltEmerald,
                    waveColor: luxuryVoltEmerald,
                  ),
                ),
                const SizedBox(width: 14),
                // CARD 2: CENTRE COURT HUD (T04)
                Expanded(
                  child: _buildMetricCard(
                    title: 'CENTRE COURT HUD (T04)',
                    value: 'Jason 14 - 11 Alman',
                    badge: '● Active Rally: 9 hits · Game 3',
                    badgeColor: luxuryElectricBlue,
                    waveColor: luxuryElectricBlue,
                  ),
                ),
                const SizedBox(width: 14),
                // CARD 3: LEAGUE PROGRESSION
                Expanded(
                  child: _buildMetricCard(
                    title: 'LEAGUE PROGRESSION',
                    value: '1,240 XP (#4 Rank)',
                    badge: '↑ 155 XP to reach Top 3',
                    badgeColor: luxuryTangerineGold,
                    waveColor: luxuryTangerineGold,
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
                    onPassTap: onPassTap,
                    onChallengeTap: onChallengeTap,
                  ),
                ),
                const SizedBox(width: 16),
                // RIGHT: STACKED ARENA PASSES & QUICK FUNCTIONS (Flex 35)
                Expanded(
                  flex: 35,
                  child: InteractiveArenaPassDeck(
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
  }) {
    return Container(
      decoration: BoxDecoration(
        color: luxuryCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: luxuryBorderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Stack(
        children: [
          // Bottom subtle wave painter
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 38,
            child: CustomPaint(
              painter: _MetricWavePainter(waveColor: waveColor),
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
                  Text(
                    title,
                    style: AppTypography.ui(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF94A3B8),
                      letterSpacing: 1.0,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: badgeColor.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      badge,
                      style: AppTypography.ui(
                        fontSize: 11.5,
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
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
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

    return Container(
      decoration: BoxDecoration(
        color: luxuryCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: luxuryBorderSubtle),
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
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: luxuryVoltEmerald.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: luxuryVoltEmerald.withValues(alpha: 0.5),
                        width: 1.2,
                      ),
                    ),
                    child: Text(
                      '6 FREE NOW',
                      style: AppTypography.ui(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w900,
                        color: luxuryVoltEmerald,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              // Filter pills
              Row(
                children: [
                  _buildFilterPill('All (10)', true),
                  const SizedBox(width: 8),
                  _buildFilterPill('Free (6)', false),
                  const SizedBox(width: 8),
                  _buildFilterPill('In Play (3)', false),
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Table Column Titles
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: luxuryCardBgElevated.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text('COURT', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: const Color(0xFF94A3B8), letterSpacing: 0.8)),
                ),
                SizedBox(
                  width: 165,
                  child: Text('SPECIFICATION', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: const Color(0xFF94A3B8), letterSpacing: 0.8)),
                ),
                Expanded(
                  flex: 38,
                  child: Text('OCCUPANT / MATCH', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: const Color(0xFF94A3B8), letterSpacing: 0.8)),
                ),
                SizedBox(
                  width: 125,
                  child: Text('STATUS', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: const Color(0xFF94A3B8), letterSpacing: 0.8)),
                ),
                SizedBox(
                  width: 110,
                  child: Text('ACTION', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: const Color(0xFF94A3B8), letterSpacing: 0.8)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Horizontal Court Rows (Spacious 56px rows with high contrast)
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

                Color statusColor = luxuryVoltEmerald;
                String statusLabel = 'FREE NOW';
                if (status == 'busy') {
                  statusColor = luxuryTangerineGold;
                  statusLabel = 'IN PLAY';
                } else if (isMatch) {
                  statusColor = luxuryCoralRose;
                  statusLabel = 'LIVE MATCH';
                } else if (isReserved) {
                  statusColor = luxuryAmethystPurple;
                  statusLabel = 'RESERVED';
                }

                return Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: index.isEven ? luxuryCardBgElevated : const Color(0xFF232535),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isMatch ? luxuryCoralRose.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.04),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Court ID with larger neon dot
                      SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            Container(
                              width: 9,
                              height: 9,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: statusColor.withValues(alpha: 0.6),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              court['id'] as String,
                              style: AppTypography.ui(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
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
                            color: const Color(0xFFE2E8F0),
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
                                  color: isFree ? luxuryVoltEmerald : Colors.white,
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
                                color: statusColor.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: statusColor.withValues(alpha: 0.5),
                                  width: 1.2,
                                ),
                              ),
                              child: Text(
                                '● $statusLabel',
                                style: AppTypography.ui(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  color: statusColor,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Action Button (Real Tactile Button!)
                      SizedBox(
                        width: 110,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: isFree ? onPassTap : onChallengeTap,
                            child: isFree
                                ? Container(
                                    height: 34,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF10B981), Color(0xFF059669)],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF10B981).withValues(alpha: 0.35),
                                          blurRadius: 8,
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
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(Icons.arrow_forward_rounded, size: 13, color: Colors.white),
                                      ],
                                    ),
                                  )
                                : isMatch
                                    ? Container(
                                        height: 34,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [Color(0xFFFF4B72), Color(0xFFE11D48)],
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFFF4B72).withValues(alpha: 0.35),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Live HUD',
                                              style: AppTypography.ui(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            const Icon(Icons.sensors_rounded, size: 14, color: Colors.white),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        height: 34,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: luxuryElectricBlue.withValues(alpha: 0.18),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: luxuryElectricBlue.withValues(alpha: 0.6),
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
                                                fontWeight: FontWeight.w900,
                                                color: const Color(0xFF60A5FA),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            const Icon(Icons.visibility_rounded, size: 13, color: Color(0xFF60A5FA)),
                                          ],
                                        ),
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

    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: luxuryCardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: luxuryBorderSubtle),
      ),
      child: Row(
        children: [
          Text(
            'Quick Challenge Rivals',
            style: AppTypography.ui(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          // Pink Add Button
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onChallengeTap,
              child: Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: luxuryCoralRose,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_rounded,
                  size: 22,
                  color: Colors.white,
                ),
              ),
            ),
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
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: onChallengeTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: luxuryCardBgElevated,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
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
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                rival['level']!,
                                style: AppTypography.ui(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: luxuryVoltEmerald,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
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
    );
  }

  // ============================================================
  // HELPER WIDGETS
  // ============================================================
  static Widget _buildFilterPill(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? luxuryCoralRose.withValues(alpha: 0.2) : luxuryCardBgElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? luxuryCoralRose : Colors.transparent,
          width: 1.2,
        ),
      ),
      child: Text(
        label,
        style: AppTypography.ui(
          fontSize: 12,
          fontWeight: isActive ? FontWeight.w900 : FontWeight.w700,
          color: isActive ? luxuryCoralRose : luxuryTextSecondary,
        ),
      ),
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
      onBackToCommand: onBackToCommand,
    );
  }

  static Widget buildTelemetrySection(
    BuildContext context,
    bool isDark, {
    required VoidCallback onBackToCommand,
  }) {
    return _DesktopTelemetryView(
      onBackToCommand: onBackToCommand,
    );
  }

  static Widget buildTvSection(
    BuildContext context, {
    required VoidCallback onBackToCommand,
  }) {
    return Container(
      color: luxuryCanvasBg,
      child: Column(
        children: [
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: luxuryCardBg,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: onBackToCommand,
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_rounded, size: 16, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          'Back to Dashboard',
                          style: AppTypography.ui(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '55" STADIUM TV FEED · 3 DAMANSARA LEVEL 2',
                  style: AppTypography.ui(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: luxuryCoralRose,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: DisplayLeaderboardScreen(),
          ),
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

  const InteractiveArenaPassDeck({
    super.key,
    required this.onPassTap,
    required this.onWalkInTap,
    required this.onXpTap,
    required this.onChallengeTap,
  });

  @override
  State<InteractiveArenaPassDeck> createState() => _InteractiveArenaPassDeckState();
}

class _InteractiveArenaPassDeckState extends State<InteractiveArenaPassDeck> {
  int _activeCardIndex = 0;

  final List<Map<String, dynamic>> _passes = [
    {
      'title': 'JOMNITTAKU PASS',
      'highlight': '90 sen / day',
      'subtitle': 'Alman Rahman · 24/7 Unlimited Access',
      'code': 'KX8VQS',
      'badge': 'VIP PASS',
      'colors': [const Color(0xFFFFA533), const Color(0xFFFF7A00)],
      'shadow': const Color(0xFFFF7A00),
      'icon': Icons.sports_tennis_rounded,
      'isDarkText': true,
    },
    {
      'title': 'OLYMPIC LEAGUE PRO',
      'highlight': '1,240 XP · Rank #4',
      'subtitle': 'Damansara Master · Zero Table Fees',
      'code': 'PRO-042',
      'badge': 'PRO LEAGUE',
      'colors': [const Color(0xFF8B5CF6), const Color(0xFF6366F1)],
      'shadow': const Color(0xFF8B5CF6),
      'icon': Icons.military_tech_rounded,
      'isDarkText': false,
    },
    {
      'title': 'SMART RFID WALLET',
      'highlight': 'RM 150.00 Balance',
      'subtitle': 'Autonomous Ball Dispenser & Robot Active',
      'code': 'RFID-7701',
      'badge': 'RFID SMART',
      'colors': [const Color(0xFF06B6D4), const Color(0xFF10B981)],
      'shadow': const Color(0xFF10B981),
      'icon': Icons.contactless_rounded,
      'isDarkText': false,
    },
    {
      'title': 'NIGHT OWL PASS',
      'highlight': '12 AM – 6 AM',
      'subtitle': '50% OFF All Tables · Free Energy Drink',
      'code': 'NIGHT-50',
      'badge': 'MIDNIGHT',
      'colors': [const Color(0xFFFF4B72), const Color(0xFFE11D48)],
      'shadow': const Color(0xFFFF4B72),
      'icon': Icons.nightlight_round,
      'isDarkText': false,
    },
  ];

  void _nextCard() {
    setState(() {
      _activeCardIndex = (_activeCardIndex + 1) % _passes.length;
    });
  }

  void _selectCard(int index) {
    setState(() {
      _activeCardIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  color: Colors.white,
                  letterSpacing: -0.2,
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _nextCard,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.swap_horiz_rounded, size: 14, color: Color(0xFFBAC0D4)),
                        const SizedBox(width: 4),
                        Text(
                          'Swap Pass (${_activeCardIndex + 1}/4)',
                          style: AppTypography.ui(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFBAC0D4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                  onTap: _nextCard,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: _buildAnimatedCardStack(),
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
              children: List.generate(_passes.length, (idx) {
                final isCurrent = idx == _activeCardIndex;
                final card = _passes[idx];
                final color = (card['colors'] as List<Color>).first;
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _selectCard(idx),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: isCurrent ? color.withValues(alpha: 0.22) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isCurrent ? color : Colors.white.withValues(alpha: 0.1),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(card['icon'] as IconData, size: 11, color: isCurrent ? color : const Color(0xFF8A8E9E)),
                          const SizedBox(width: 4),
                          Text(
                            card['badge'] as String,
                            style: AppTypography.ui(
                              fontSize: 10.5,
                              fontWeight: isCurrent ? FontWeight.w900 : FontWeight.w700,
                              color: isCurrent ? Colors.white : const Color(0xFF8A8E9E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                          color: DesktopWebSections.luxuryCoralRose,
                          onTap: widget.onWalkInTap,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildActionTile(
                          icon: Icons.radar_rounded,
                          title: 'Radar Ping',
                          sub: '14 Rivals Nearby',
                          color: DesktopWebSections.luxuryElectricBlue,
                          onTap: widget.onChallengeTap,
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
                          color: DesktopWebSections.luxuryTangerineGold,
                          onTap: widget.onChallengeTap,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildActionTile(
                          icon: Icons.qr_code_2_rounded,
                          title: 'Optical QR Code',
                          sub: 'Scan Turnstile Gate',
                          color: DesktopWebSections.luxuryVoltEmerald,
                          onTap: widget.onPassTap,
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
                    color: DesktopWebSections.luxuryCardBgElevated,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTelemetryChip(Icons.ac_unit_rounded, '23°C AC'),
                      _buildTelemetryChip(Icons.lightbulb_rounded, '480 Lux ITTF'),
                      _buildTelemetryChip(Icons.sensors_rounded, 'Edge AI 60fps'),
                      _buildTelemetryChip(Icons.lock_clock_rounded, '24/7 Gate'),
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

  List<Widget> _buildAnimatedCardStack() {
    final indices = List.generate(_passes.length, (i) => i);
    indices.sort((a, b) {
      int depthA = (a - _activeCardIndex + _passes.length) % _passes.length;
      int depthB = (b - _activeCardIndex + _passes.length) % _passes.length;
      return depthB.compareTo(depthA);
    });

    return indices.map((i) {
      int depth = (i - _activeCardIndex + _passes.length) % _passes.length;
      final card = _passes[i];
      final colors = card['colors'] as List<Color>;
      final shadowColor = card['shadow'] as Color;
      final isDarkText = card['isDarkText'] as bool;
      final textColor = isDarkText ? Colors.black : Colors.white;
      final subColor = isDarkText ? Colors.black87 : Colors.white70;

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
                boxShadow: depth == 0
                    ? [
                        BoxShadow(
                          color: shadowColor.withValues(alpha: 0.4),
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
                          color: isDarkText ? Colors.black26 : Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(5),
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
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: DesktopWebSections.luxuryCardBgElevated,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 17, color: color),
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
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      sub,
                      style: AppTypography.ui(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF94A3B8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 10, color: Color(0xFF64748B)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTelemetryChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: DesktopWebSections.luxuryVoltEmerald),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTypography.ui(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFBAC0D4),
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

  const _DesktopRadarFloorplanView({
    required this.onBackToCommand,
    required this.onPassTap,
    required this.onChallengeTap,
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

    return Container(
      color: DesktopWebSections.luxuryCanvasBg,
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
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: widget.onBackToCommand,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: DesktopWebSections.luxuryCardBg,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.arrow_back_rounded, size: 14, color: Colors.white),
                            const SizedBox(width: 6),
                            Text(
                              'Back to Dashboard',
                              style: AppTypography.ui(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    '10 Courts Interactive Arena Floorplan',
                    style: AppTypography.ui(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
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

  const _DesktopLeagueView({
    required this.onBackToCommand,
    required this.onChallengeTap,
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

    return Container(
      color: DesktopWebSections.luxuryCanvasBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onBackToCommand,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: DesktopWebSections.luxuryCardBg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back_rounded, size: 14, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          'Back to Dashboard',
                          style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Text(
                'Olympic League & Damansara Standings',
                style: AppTypography.ui(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white),
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

  const _DesktopPassesView({required this.onBackToCommand});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesktopWebSections.luxuryCanvasBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onBackToCommand,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: DesktopWebSections.luxuryCardBg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back_rounded, size: 14, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          'Back to Dashboard',
                          style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Text(
                'Arena Passes & 24/7 Autonomous Membership',
                style: AppTypography.ui(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white),
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
                    colors: [const Color(0xFFFFA533), const Color(0xFFFF7A00)],
                    code: 'KX8VQS',
                    badge: 'MOST POPULAR',
                    features: ['All 10 ITTF Tables Unlimited', 'Smart Turnstile Door Unlock', 'Daily Quest +200 XP', 'Zero Wait Time'],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPassProductCard(
                    title: 'OLYMPIC LEAGUE PRO',
                    price: 'Tier 1 Master',
                    sub: 'Earned at 1,200+ XP or RM45/mo Pro Tier',
                    colors: [const Color(0xFF8B5CF6), const Color(0xFF6366F1)],
                    code: 'PRO-042',
                    badge: 'PRO LEAGUE',
                    features: ['Free Tournament Entry', 'Centre Court T04 Priority', 'Coach AI Match Analytics', 'Exclusive Rival Challenges'],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPassProductCard(
                    title: 'SMART RFID WALLET',
                    price: 'RM 150.00 Balance',
                    sub: 'Preloaded autonomous token wallet',
                    colors: [const Color(0xFF06B6D4), const Color(0xFF10B981)],
                    code: 'RFID-7701',
                    badge: 'INSTANT TAP',
                    features: ['Instant Physical NFC Gate Card', 'Automatic Ball Dispenser', 'Robot Trainer Dispenser', 'Auto Reload Option'],
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
    required String code,
    required String badge,
    required List<String> features,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: DesktopWebSections.luxuryCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.first.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: colors.first.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              badge,
              style: AppTypography.ui(fontSize: 10.5, fontWeight: FontWeight.w900, color: colors.first),
            ),
          ),
          const SizedBox(height: 12),
          Text(title, style: AppTypography.ui(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white)),
          const SizedBox(height: 4),
          Text(price, style: AppTypography.ui(fontSize: 22, fontWeight: FontWeight.w900, color: colors.first)),
          Text(sub, style: AppTypography.ui(fontSize: 11, color: const Color(0xFFBAC0D4))),
          const SizedBox(height: 18),
          const Divider(color: Color(0x14FFFFFF)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_rounded, size: 14, color: colors.first),
                    const SizedBox(width: 8),
                    Expanded(child: Text(f, style: AppTypography.ui(fontSize: 12, color: Colors.white))),
                  ],
                ),
              )).toList(),
            ),
          ),
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              'Select Pass →',
              style: AppTypography.ui(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 4. DESKTOP VENUE TELEMETRY & IOT SENSOR HUB VIEW
// ============================================================
class _DesktopTelemetryView extends StatelessWidget {
  final VoidCallback onBackToCommand;

  const _DesktopTelemetryView({required this.onBackToCommand});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesktopWebSections.luxuryCanvasBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onBackToCommand,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: DesktopWebSections.luxuryCardBg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back_rounded, size: 14, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          'Back to Dashboard',
                          style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Text(
                'Smart Venue 24/7 Telemetry & IoT Sensor Hub',
                style: AppTypography.ui(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.8,
              children: [
                _buildTelemetryBento(
                  icon: Icons.ac_unit_rounded,
                  title: 'HVAC CLIMATE CONTROL',
                  metric: '23.0°C / 54% Humidity',
                  status: 'OPTIMAL · AUTO BALANCED',
                  color: DesktopWebSections.luxuryVoltEmerald,
                  desc: 'Dual split inverter chillers maintaining ITTF tournament standard humidity and ambient temperature 24/7.',
                ),
                _buildTelemetryBento(
                  icon: Icons.lightbulb_rounded,
                  title: 'ARENA ITTF LIGHTING',
                  metric: '480 Lux LED Units',
                  status: '5000K NEUTRAL WHITE',
                  color: DesktopWebSections.luxuryTangerineGold,
                  desc: 'Glare-free anti-stroboscopic lighting focused on table play areas with zero flicker for high-speed camera tracking.',
                ),
                _buildTelemetryBento(
                  icon: Icons.videocam_rounded,
                  title: 'EDGE AI OPTICAL CAMERAS',
                  metric: '10 Cameras · 60 FPS',
                  status: 'TRACKING ACTIVE',
                  color: DesktopWebSections.luxuryCoralRose,
                  desc: 'Overhead optical tracking cameras recording ball velocity, rally counts, edge hits, and tournament scores.',
                ),
                _buildTelemetryBento(
                  icon: Icons.door_sliding_rounded,
                  title: 'UNMANNED TURNSTILE GATE',
                  metric: 'Optical QR & RFID',
                  status: 'GATE 1 & 2 ONLINE',
                  color: DesktopWebSections.luxuryElectricBlue,
                  desc: '0.3-second response turnstiles with anti-tailgating sensors and live fire safety fail-open integration.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryBento({
    required IconData icon,
    required String title,
    required String metric,
    required String status,
    required Color color,
    required String desc,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: DesktopWebSections.luxuryCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: color),
                  const SizedBox(width: 8),
                  Text(title, style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.8)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(status, style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w900, color: color)),
              ),
            ],
          ),
          Text(metric, style: AppTypography.ui(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white)),
          Text(desc, style: AppTypography.ui(fontSize: 11.5, color: const Color(0xFFBAC0D4))),
        ],
      ),
    );
  }
}
