import 'package:flutter/material.dart';

import '../../../core/session/demo_avatars.dart';
import '../../../core/theme/app_typography.dart';

/// Elite Luxury Desktop Web Command Center Sections for JOMNITTAKU.
///
/// Faithfully modeled after the reference fintech/gaming dashboard:
/// - 3 Top Micro-Metric Cards (Availability, Centre Court HUD, League XP) with subtle waves
/// - 10-Court Live Architectural Activity Table with horizontal rows and filter tabs
/// - Stacked Arena Passes Card Widget (Tangerine Orange Apple-Card style) + Quick Functions
/// - Quick Challenge Sparring Rivals Avatar Strip
class DesktopWebSections {
  DesktopWebSections._();

  // Color tokens matching the reference luxury palette
  static const Color luxuryCanvasBg = Color(0xFF161720);
  static const Color luxuryCardBg = Color(0xFF20222F);
  static const Color luxuryCardBgElevated = Color(0xFF262938);
  static const Color luxuryCoralRose = Color(0xFFFF4B72);
  static const Color luxuryTangerineGold = Color(0xFFFFA533);
  static const Color luxuryVoltEmerald = Color(0xFF10B981);
  static const Color luxuryElectricBlue = Color(0xFF3B82F6);
  static const Color luxuryAmethystPurple = Color(0xFF8B5CF6);
  static const Color luxuryMutedText = Color(0xFF8A8E9E);
  static const Color luxuryBorderSubtle = Color(0x0AFFFFFF);

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
          // 1. TOP ROW: 3 MICRO-METRIC CARDS (BALANCES ROW)
          // ====================================================
          SizedBox(
            height: 110,
            child: Row(
              children: [
                // CARD 1: VENUE AVAILABILITY
                Expanded(
                  child: _buildMetricCard(
                    title: 'VENUE AVAILABILITY',
                    value: '6 of 10 Free',
                    badge: '↑ 2 freed up this hour',
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
                  child: _buildStackedPassesAndFunctions(
                    context,
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
  // TOP MICRO-METRIC CARD BUILDER
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Stack(
        children: [
          // Bottom subtle wave painter
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 32,
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
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: luxuryMutedText,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      badge,
                      style: AppTypography.ui(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: badgeColor,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                value,
                style: AppTypography.ui(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.3,
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
  // 10 COURTS LIVE ACTIVITY TABLE (HORIZONTAL ROWS)
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
      padding: const EdgeInsets.all(18),
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
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: luxuryVoltEmerald.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '6 FREE',
                      style: AppTypography.ui(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w900,
                        color: luxuryVoltEmerald,
                      ),
                    ),
                  ),
                ],
              ),
              // Filter pills
              Row(
                children: [
                  _buildFilterPill('All (10)', true),
                  const SizedBox(width: 6),
                  _buildFilterPill('Free (6)', false),
                  const SizedBox(width: 6),
                  _buildFilterPill('In Play (3)', false),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Table Column Titles
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: luxuryCardBgElevated.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 65,
                  child: Text('COURT', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: luxuryMutedText)),
                ),
                SizedBox(
                  width: 140,
                  child: Text('SPECIFICATION', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: luxuryMutedText)),
                ),
                Expanded(
                  flex: 40,
                  child: Text('OCCUPANT / MATCH', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: luxuryMutedText)),
                ),
                SizedBox(
                  width: 110,
                  child: Text('STATUS', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: luxuryMutedText)),
                ),
                SizedBox(
                  width: 80,
                  child: Text('ACTION', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: luxuryMutedText)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // Horizontal Court Rows (Scrollable list inside table container)
          Expanded(
            child: ListView.separated(
              itemCount: courts.length,
              separatorBuilder: (context, index) => const SizedBox(height: 4),
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
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: index.isEven ? luxuryCardBgElevated : const Color(0xFF222433),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      // Court ID
                      SizedBox(
                        width: 65,
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              court['id'] as String,
                              style: AppTypography.ui(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Specification
                      SizedBox(
                        width: 140,
                        child: Text(
                          court['type'] as String,
                          style: AppTypography.ui(
                            fontSize: 11,
                            color: luxuryMutedText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Occupant
                      Expanded(
                        flex: 40,
                        child: Row(
                          children: [
                            if (court['avatar'] != null)
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundImage: AssetImage(court['avatar'] as String),
                                ),
                              ),
                            Expanded(
                              child: Text(
                                court['player'] as String,
                                style: AppTypography.ui(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: isFree ? luxuryVoltEmerald : Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Status Pill
                      SizedBox(
                        width: 110,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                statusLabel,
                                style: AppTypography.ui(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w800,
                                  color: statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Action
                      SizedBox(
                        width: 80,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: isFree ? onPassTap : onChallengeTap,
                            child: Text(
                              isFree ? 'Play →' : 'Watch',
                              style: AppTypography.ui(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                                color: isFree ? luxuryVoltEmerald : const Color(0xFF60A5FA),
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
  // STACKED ARENA PASSES & QUICK FUNCTIONS
  // ============================================================
  static Widget _buildStackedPassesAndFunctions(
    BuildContext context, {
    required VoidCallback onPassTap,
    required VoidCallback onWalkInTap,
    required VoidCallback onXpTap,
    required VoidCallback onChallengeTap,
  }) {
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
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Arena Passes & Membership',
            style: AppTypography.ui(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          // STACKED CREDIT-CARD WIDGET (TANGERINE GOLD FRONT)
          Center(
            child: SizedBox(
              width: 270,
              height: 135,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Back Card 2 (Purple)
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 230,
                      height: 110,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7C3AED),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  // Back Card 1 (Electric Blue)
                  Positioned(
                    top: 8,
                    child: Container(
                      width: 250,
                      height: 115,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  // Front Card (Tangerine Orange Apple-Card Style)
                  Positioned(
                    top: 16,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onPassTap,
                        child: Container(
                          width: 270,
                          height: 125,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFFA533), Color(0xFFFF7A00)],
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF7A00).withValues(alpha: 0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.sports_tennis_rounded,
                                        size: 16,
                                        color: Colors.black87,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        'JOMNITTAKU PASS',
                                        style: AppTypography.ui(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black87,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.contactless_rounded,
                                    size: 16,
                                    color: Colors.black87,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '90 sen / day',
                                    style: AppTypography.ui(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'KX8VQS',
                                      style: AppTypography.ui(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Alman Rahman · 24/7 Unlimited',
                                style: AppTypography.ui(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          // QUICK ARENA FUNCTIONS LIST
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickActionRow(
                  icon: Icons.flash_on_rounded,
                  label: 'Borrow XP (+200 Loan)',
                  color: luxuryTangerineGold,
                  onTap: onXpTap,
                ),
                _buildQuickActionRow(
                  icon: Icons.search_rounded,
                  label: 'Radar Ping Nearby Players',
                  color: luxuryVoltEmerald,
                  onTap: onChallengeTap,
                ),
                _buildQuickActionRow(
                  icon: Icons.sports_mma_rounded,
                  label: '1v1 Match Pot (RM200 Pot)',
                  color: luxuryCoralRose,
                  onTap: onChallengeTap,
                ),
                _buildQuickActionRow(
                  icon: Icons.door_front_door_rounded,
                  label: 'Instant Turnstile QR Code',
                  color: const Color(0xFF60A5FA),
                  onTap: onPassTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
              fontSize: 12,
              fontWeight: FontWeight.w800,
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
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: luxuryCoralRose,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Horizontal avatar row
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: rivals.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final rival = rivals[index];
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: onChallengeTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: luxuryCardBgElevated,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundImage: AssetImage(rival['avatar']!),
                          ),
                          const SizedBox(width: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                rival['name']!,
                                style: AppTypography.ui(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                rival['level']!,
                                style: AppTypography.ui(
                                  fontSize: 9,
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
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? luxuryCoralRose.withValues(alpha: 0.2) : luxuryCardBgElevated,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isActive ? luxuryCoralRose : Colors.transparent,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppTypography.ui(
          fontSize: 10.5,
          fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
          color: isActive ? luxuryCoralRose : luxuryMutedText,
        ),
      ),
    );
  }

  static Widget _buildQuickActionRow({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: luxuryCardBgElevated,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.ui(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 10, color: luxuryMutedText),
            ],
          ),
        ),
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
