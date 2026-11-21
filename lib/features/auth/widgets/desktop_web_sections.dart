import 'package:flutter/material.dart';

import '../../../core/navigation/app_navigator.dart';
import '../../../core/session/app_session.dart';
import '../../../core/session/demo_avatars.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../display/screens/display_leaderboard_screen.dart';

/// Desktop Web Sections for JOMNITTAKU:
///  - Section 1: Widescreen Hero Broadcast Command Stage
///  - Section 1B: Architectural 10-Table Arena Floorplan Radar (2x5 Grid)
///  - Section 1C: Command Bento Modules (1v1, Path, Happy Hour, Rivals)
///  - Section 2: Live Leaderboard Showcase & Top-3 Podium
///  - Section 3: Membership Tiers & Pass Comparison Matrix
///  - Section 4: Autonomous Venue 24/7 IoT Facility Telemetry
///  - Section 5: Professional Desktop Website Footer
class DesktopWebSections {
  DesktopWebSections._();

  // ============================================================
  // SECTION 1: WIDESCREEN HERO BROADCAST COMMAND STAGE
  // ============================================================
  static Widget buildHeroBroadcastSection(
    BuildContext context,
    bool isDark, {
    required VoidCallback onWalkInTap,
    required VoidCallback onPassTap,
    required VoidCallback onTvTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ----------------------------------------------------
          // LEFT: CINEMATIC ARENA HEADLINE & ACTION BAR (Flex 6)
          // ----------------------------------------------------
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Venue location & autonomous status pill
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.voltLime.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: AppColors.voltLime.withValues(alpha: 0.35),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.voltLime,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '3 DAMANSARA LEVEL 2 · 10 TABLES · 24/7 AUTONOMOUS',
                        style: AppTypography.ui(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.voltLime,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Main Headline
                Text(
                  'AUTONOMOUS 24/7\nTABLE TENNIS ARENA',
                  style: AppTypography.ui(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                    letterSpacing: -1.2,
                    height: 1.05,
                  ),
                ),

                const SizedBox(height: 14),

                // Subtitle
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 540),
                  child: Text(
                    'Malaysia\'s first unmanned, AI-tracked table tennis venue. Walk in anytime, scan your digital pass at the turnstile, and challenge live rivals on 10 ITTF tournament courts.',
                    style: AppTypography.ui(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Dual Action CTA Button Group
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Primary: Walk In & Play
                    TactileButton.volt(
                      text: 'Walk In & Play Tonight (RM17) →',
                      onPressed: onWalkInTap,
                    ),

                    // Secondary: Door Pass
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onPassTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.darkObsidianCard : AppColors.lightCanvasBg,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.ittfTableBorder.withValues(alpha: 0.5),
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.qr_code_scanner_rounded, size: 16, color: AppColors.ittfTableBorder),
                              const SizedBox(width: 8),
                              Text(
                                'Door Pass: KX8VQS',
                                style: AppTypography.ui(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? AppColors.slate200 : AppColors.ittfTableBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Tertiary: 55" Stadium TV Feed
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onTvTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.ittfTableSurface.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.ittfTableBorder.withValues(alpha: 0.4),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.tv_rounded, size: 16, color: AppColors.ittfTableBorder),
                              const SizedBox(width: 6),
                              Text(
                                '55" Stadium TV',
                                style: AppTypography.ui(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.ittfTableBorder,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Live Telemetry Badges Strip
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _buildStatBadge(
                      icon: Icons.circle,
                      iconColor: AppColors.voltLime,
                      iconSize: 8,
                      label: '6 of 10 Tables Free',
                      isDark: isDark,
                    ),
                    _buildStatBadge(
                      icon: Icons.emoji_events_rounded,
                      iconColor: AppColors.radiantGold,
                      iconSize: 14,
                      label: '⭐ 1,240 XP · Rank #4',
                      isDark: isDark,
                    ),
                    _buildStatBadge(
                      icon: Icons.flash_on_rounded,
                      iconColor: AppColors.pingPongOrange,
                      iconSize: 14,
                      label: 'Happy Hour: 50 sen/hr (18m left)',
                      isDark: isDark,
                    ),
                    _buildStatBadge(
                      icon: Icons.sports_mma_rounded,
                      iconColor: AppColors.paddleRed,
                      iconSize: 14,
                      label: '1v1 Match Pot: RM200',
                      isDark: isDark,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 32),

          // ----------------------------------------------------
          // RIGHT: WIDESCREEN 3D LIVE MATCH ARENA VISUALIZER (Flex 5)
          // ----------------------------------------------------
          Expanded(
            flex: 5,
            child: _buildWidescreenMatchVisualizer(context, isDark),
          ),
        ],
      ),
    );
  }

  static Widget _buildStatBadge({
    required IconData icon,
    required Color iconColor,
    required double iconSize,
    required String label,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isDark ? AppColors.obsidianCard : AppColors.lightCanvasBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate300,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: iconColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.ui(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildWidescreenMatchVisualizer(BuildContext context, bool isDark) {
    return Container(
      height: 310,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF131D2E), const Color(0xFF0B111C)]
              : [const Color(0xFFE2E8F0), const Color(0xFFF8FAFC)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.ittfTableBorder.withValues(alpha: 0.4) : AppColors.slate300,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Match HUD
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? Colors.black.withValues(alpha: 0.25) : Colors.white.withValues(alpha: 0.8),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? Colors.white.withValues(alpha: 0.08) : AppColors.slate200,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.paddleRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'LIVE ARENA MATCH · TABLE 04 (COURT ALPHA)',
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.voltLime.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Score: 14 - 11 · Game 3',
                    style: AppTypography.ui(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.voltLime,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Center 3D Table Tennis Court
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Full Table Canvas
                  Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF172554)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.45),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Center White Division Line
                        Container(width: 2, color: Colors.white.withValues(alpha: 0.75)),

                        // Center Mesh Net
                        Container(
                          height: 6,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.35),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),

                        // Ball in play (Animated glowing ping pong ball)
                        Positioned(
                          left: 110,
                          top: 45,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: AppColors.pingPongOrange,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.pingPongOrange.withValues(alpha: 0.6),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Player 1 Card (Left - Jason T.)
                  Positioned(
                    left: 12,
                    top: 10,
                    child: _buildPlayerRallyPill(
                      avatar: DemoAvatars.jason,
                      name: 'Jason T.',
                      score: '14',
                      paddle: 'DHS Hurricane (Black)',
                      isServer: true,
                    ),
                  ),

                  // Player 2 Card (Right - Alman R. / YOU)
                  Positioned(
                    right: 12,
                    bottom: 10,
                    child: _buildPlayerRallyPill(
                      avatar: AppSession.avatarAsset,
                      name: 'Alman R. (YOU)',
                      score: '11',
                      paddle: 'Butterfly Tenergy (Red)',
                      isServer: false,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Telemetry Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.black.withValues(alpha: 0.25) : Colors.white.withValues(alpha: 0.6),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '● DHS D40+ 3-Star Ball · Rally: 9 hits',
                  style: AppTypography.ui(fontSize: 10.5, color: AppColors.textSecondary),
                ),
                Text(
                  'Lighting: 480 Lux ITTF · AI Scoring Camera: Online 🟢',
                  style: AppTypography.ui(fontSize: 10.5, color: AppColors.voltLime),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildPlayerRallyPill({
    required String avatar,
    required String name,
    required String score,
    required String paddle,
    required bool isServer,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isServer ? AppColors.voltLime : Colors.white30,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.asset(avatar, width: 24, height: 24, fit: BoxFit.cover),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: AppTypography.ui(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  if (isServer) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.sports_tennis_rounded, size: 11, color: AppColors.voltLime),
                  ],
                ],
              ),
              Text(
                paddle,
                style: AppTypography.ui(fontSize: 8.5, color: Colors.white60),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: isServer ? AppColors.voltLime : const Color(0xFF334155),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              score,
              style: AppTypography.ui(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: isServer ? const Color(0xFF0F172A) : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 1B: ARCHITECTURAL 10-TABLE ARENA FLOORPLAN RADAR (2x5 Grid)
  // ============================================================
  static Widget buildTenTableFloorplan(BuildContext context, bool isDark) {
    // 10 Tables dataset representing 3 Damansara Level 2
    final tables = [
      {'id': '01', 'status': 'IN MATCH', 'player': 'Alman R. vs Jason', 'time': '18m', 'free': false, 'lux': '480 Lux'},
      {'id': '02', 'status': 'IN MATCH', 'player': 'Sara K. vs Nurul', 'time': '24m', 'free': false, 'lux': '500 Lux'},
      {'id': '03', 'status': 'AVAILABLE', 'player': 'Ready to Play', 'time': '', 'free': true, 'lux': '500 Lux'},
      {'id': '04', 'status': 'IN MATCH', 'player': 'Tournament T4', 'time': '12m', 'free': false, 'lux': '480 Lux'},
      {'id': '05', 'status': 'AVAILABLE', 'player': 'Ready to Play', 'time': '', 'free': true, 'lux': '500 Lux'},
      {'id': '06', 'status': 'AVAILABLE', 'player': 'Ready to Play', 'time': '', 'free': true, 'lux': '500 Lux'},
      {'id': '07', 'status': 'IN MATCH', 'player': 'Daniel L. vs Mel', 'time': '32m', 'free': false, 'lux': '500 Lux'},
      {'id': '08', 'status': 'AVAILABLE', 'player': 'Ready to Play', 'time': '', 'free': true, 'lux': '500 Lux'},
      {'id': '09', 'status': 'AVAILABLE', 'player': 'Ready to Play', 'time': '', 'free': true, 'lux': '500 Lux'},
      {'id': '10', 'status': 'AVAILABLE', 'player': 'Ready to Play', 'time': '', 'free': true, 'lux': '500 Lux'},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.ittfTableBorder.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.ittfTableBorder.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.radar_rounded, size: 13, color: AppColors.ittfTableBorder),
                        const SizedBox(width: 5),
                        Text(
                          'VENUE TELEMETRY · 10 ITTF REGULATION COURTS',
                          style: AppTypography.ui(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ittfTableBorder,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Live Venue Radar & Architectural Floorplan',
                    style: AppTypography.ui(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Real-time table occupancy, active rally durations, and lighting lux across 3 Damansara Level 2.',
                    style: AppTypography.ui(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.voltLime.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.voltLime.withValues(alpha: 0.4)),
                ),
                child: Text(
                  '6 OF 10 TABLES FREE',
                  style: AppTypography.ui(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: AppColors.voltLime,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 10 Tables Grid (2 rows of 5 tables)
          Column(
            children: [
              // Row 1: Tables 01 to 05
              Row(
                children: tables.sublist(0, 5).map((t) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: _buildTableRadarCard(context, t, isDark),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 10),
              // Row 2: Tables 06 to 10
              Row(
                children: tables.sublist(5, 10).map((t) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: _buildTableRadarCard(context, t, isDark),
                  ),
                )).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildTableRadarCard(BuildContext context, Map<String, dynamic> t, bool isDark) {
    final isFree = t['free'] as bool;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => AppNavigator.toTables(context),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.obsidianCard : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isFree
                  ? (isDark ? AppColors.ittfTableBorder.withValues(alpha: 0.45) : AppColors.ittfTableBlue)
                  : (isDark ? AppColors.paddleRed.withValues(alpha: 0.4) : AppColors.slate300),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Table ${t['id']}',
                    style: AppTypography.ui(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isFree ? AppColors.voltLime : AppColors.paddleRed,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                t['player'] as String,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.ui(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isFree ? AppColors.voltLime : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t['lux'] as String,
                    style: AppTypography.ui(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    isFree ? 'AVAILABLE' : (t['time'] as String),
                    style: AppTypography.ui(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      color: isFree ? AppColors.voltLime : AppColors.paddleRed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 1C: COMMAND BENTO MODULES (4 Columns)
  // ============================================================
  static Widget buildBentoCommandGrid(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. 1v1 Arena Match Bounty
          Expanded(
            child: _buildBentoCard(
              context: context,
              isDark: isDark,
              icon: Icons.sports_mma_rounded,
              iconColor: AppColors.paddleRed,
              badge: 'BOUNTY: RM200',
              badgeColor: AppColors.paddleRed,
              title: '1v1 Match Bounty',
              description: 'Challenge active players in the venue to a live cash bounty match.',
              actionText: 'Enter Arena →',
              onTap: () => AppNavigator.toChallengeBoard(context),
            ),
          ),
          const SizedBox(width: 14),

          // 2. The Path Quests
          Expanded(
            child: _buildBentoCard(
              context: context,
              isDark: isDark,
              icon: Icons.alt_route_rounded,
              iconColor: AppColors.radiantGold,
              badge: 'QUEST ACTIVE',
              badgeColor: AppColors.radiantGold,
              title: 'The Path: Node 2',
              description: 'Win 5 rallies tonight to claim 150 bonus XP and upgrade your player card.',
              actionText: 'Claim Quest XP →',
              onTap: () => AppNavigator.toGamificationPath(context),
            ),
          ),
          const SizedBox(width: 14),

          // 3. Sunset Pass Happy Hour
          Expanded(
            child: _buildBentoCard(
              context: context,
              isDark: isDark,
              icon: Icons.flash_on_rounded,
              iconColor: AppColors.pingPongOrange,
              badge: '50% DISCOUNT',
              badgeColor: AppColors.pingPongOrange,
              title: 'Happy Hour Pass',
              description: 'All 10 tables are 50 sen/hour for members right now. 18m : 45s remaining.',
              actionText: 'View Rates →',
              onTap: () => AppNavigator.toPlan(context),
            ),
          ),
          const SizedBox(width: 14),

          // 4. Sparring Rivals Roster
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? AppColors.obsidianCard : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate200,
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sparring Rivals',
                        style: AppTypography.ui(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '4 Active',
                        style: AppTypography.ui(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppColors.voltLime,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildRivalMiniAvatar(DemoAvatars.jason, '3W'),
                      _buildRivalMiniAvatar(DemoAvatars.sara, '5W'),
                      _buildRivalMiniAvatar(DemoAvatars.nurul, '1W'),
                      _buildRivalMiniAvatar(DemoAvatars.daniel, '7W'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => AppNavigator.toChallengeAccepted(context),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        'Manage Rivals & Bounties →',
                        style: AppTypography.ui(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ittfTableBorder,
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
    );
  }

  static Widget _buildRivalMiniAvatar(String asset, String streak) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(child: Image.asset(asset, fit: BoxFit.cover)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: AppColors.radiantGold,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            streak,
            style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.black),
          ),
        ),
      ],
    );
  }

  static Widget _buildBentoCard({
    required BuildContext context,
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String badge,
    required Color badgeColor,
    required String title,
    required String description,
    required String actionText,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.obsidianCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate200,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
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
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTypography.ui(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: AppTypography.ui(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                actionText,
                style: AppTypography.ui(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.voltLime,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 2: LIVE ARENA LEADERBOARD SHOWCASE & PODIUM
  // ============================================================
  static Widget buildLeaderboardShowcase(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.radiantGold.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.radiantGold.withValues(alpha: 0.35),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.emoji_events_rounded, size: 13, color: AppColors.radiantGold),
                        const SizedBox(width: 5),
                        Text(
                          'PETALING JAYA ARENA · 55" STADIUM BROADCAST',
                          style: AppTypography.ui(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppColors.radiantGold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Live Arena Leaderboard & Top Rivals',
                    style: AppTypography.ui(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Real-time weekly XP rankings across 248 registered venue players. Updated every rally.',
                    style: AppTypography.ui(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Launch 55" TV Feed Button
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const DisplayLeaderboardScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.ittfTableSurface.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.ittfTableBorder.withValues(alpha: 0.5),
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.tv_rounded, size: 15, color: AppColors.ittfTableBorder),
                            const SizedBox(width: 6),
                            Text(
                              'Launch 55" Stadium TV Feed →',
                              style: AppTypography.ui(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: AppColors.ittfTableBorder,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Full Leaderboard Link
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => AppNavigator.toLeaderboard(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate200,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isDark ? AppColors.border : AppColors.slate300,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.format_list_numbered_rounded, size: 15, color: AppColors.textPrimary),
                            const SizedBox(width: 6),
                            Text(
                              'View All 248 Players',
                              style: AppTypography.ui(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Top 3 Olympic Podium Showcase
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? AppColors.obsidianCard : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate200,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.06),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // 3 Podium Columns (2nd Silver | 1st Gold | 3rd Bronze)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // #2 SILVER: SARA K.
                    Expanded(
                      child: _buildPodiumAthleteCard(
                        context: context,
                        rank: '2',
                        name: 'Sara K.',
                        xp: '1,480 XP',
                        tag: '⚡ 4W Streak',
                        avatarAsset: DemoAvatars.sara,
                        avatarSize: 64,
                        ringColor: AppColors.slate300,
                        medallion: '🥈',
                        pedestalHeight: 110,
                        pedestalGradient: [
                          isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                          isDark ? const Color(0xFF0F172A) : const Color(0xFFCBD5E1),
                        ],
                        pedestalBorderColor: AppColors.slate400,
                        isCenter: false,
                        isDark: isDark,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // #1 GOLD CHAMPION: DANIEL L.
                    Expanded(
                      child: _buildPodiumAthleteCard(
                        context: context,
                        rank: '1',
                        name: 'Daniel L.',
                        xp: '1,620 XP',
                        tag: '👑 CHAMPION',
                        avatarAsset: DemoAvatars.daniel,
                        avatarSize: 80,
                        ringColor: const Color(0xFFFFD700),
                        medallion: '👑',
                        pedestalHeight: 150,
                        pedestalGradient: [
                          isDark ? const Color(0xFF2C2210) : const Color(0xFFFEF3C7),
                          isDark ? const Color(0xFF171B26) : const Color(0xFFFDE68A),
                        ],
                        pedestalBorderColor: const Color(0xFFFFD700),
                        isCenter: true,
                        isDark: isDark,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // #3 BRONZE: MEL R.
                    Expanded(
                      child: _buildPodiumAthleteCard(
                        context: context,
                        rank: '3',
                        name: 'Mel R.',
                        xp: '1,395 XP',
                        tag: '🔥 3W Streak',
                        avatarAsset: DemoAvatars.mei,
                        avatarSize: 60,
                        ringColor: AppColors.rankBronze,
                        medallion: '🥉',
                        pedestalHeight: 90,
                        pedestalGradient: [
                          isDark ? const Color(0xFF2A1C14) : const Color(0xFFFFEDD5),
                          isDark ? const Color(0xFF121824) : const Color(0xFFFED7AA),
                        ],
                        pedestalBorderColor: AppColors.rankBronze,
                        isCenter: false,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Player Standings Bar (Alman R. - You)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.paddleBlack : AppColors.lightCanvasBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.ittfTableBorder.withValues(alpha: 0.5),
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.ittfTableBorder, width: 1.5),
                        ),
                        child: ClipOval(
                          child: Image.asset(AppSession.avatarAsset, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Alman Rahman (YOU)',
                                style: AppTypography.ui(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.ittfTableSurface.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'RANK #4',
                                  style: AppTypography.ui(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.ittfTableBorder,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '1,240 XP · ▲ +40 XP this week · Only 155 XP to reach Podium #3!',
                            style: AppTypography.ui(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Sparring Action Button
                      GestureDetector(
                        onTap: () => AppNavigator.toChallengeAccepted(context),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              color: AppColors.voltLime,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.flash_on_rounded, size: 14, color: AppColors.slate900),
                                const SizedBox(width: 5),
                                Text(
                                  'Challenge Podium →',
                                  style: AppTypography.ui(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.slate900,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildPodiumAthleteCard({
    required BuildContext context,
    required String rank,
    required String name,
    required String xp,
    required String tag,
    required String avatarAsset,
    required double avatarSize,
    required Color ringColor,
    required String medallion,
    required double pedestalHeight,
    required List<Color> pedestalGradient,
    required Color pedestalBorderColor,
    required bool isCenter,
    required bool isDark,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Medallion icon / crown
        Text(
          medallion,
          style: TextStyle(fontSize: isCenter ? 24 : 18),
        ),
        const SizedBox(height: 4),

        // Avatar with ring
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ringColor, width: isCenter ? 3 : 2),
            boxShadow: [
              BoxShadow(
                color: ringColor.withValues(alpha: isCenter ? 0.35 : 0.15),
                blurRadius: isCenter ? 18 : 10,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(avatarAsset, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),

        // Athlete Name
        Text(
          name,
          style: AppTypography.ui(
            fontSize: isCenter ? 15 : 13,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),

        // XP
        Text(
          xp,
          style: AppTypography.ui(
            fontSize: isCenter ? 13 : 11.5,
            fontWeight: FontWeight.w900,
            color: isCenter ? const Color(0xFFFFD700) : AppColors.textPrimary,
          ),
        ),

        // Tag / Streak
        Container(
          margin: const EdgeInsets.only(top: 4, bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: ringColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            tag,
            style: AppTypography.ui(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: ringColor,
            ),
          ),
        ),

        // Pedestal
        Container(
          width: double.infinity,
          height: pedestalHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: pedestalGradient,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            border: Border(
              top: BorderSide(color: pedestalBorderColor, width: 2),
              left: BorderSide(color: pedestalBorderColor.withValues(alpha: 0.3), width: 1),
              right: BorderSide(color: pedestalBorderColor.withValues(alpha: 0.3), width: 1),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            '#$rank',
            style: AppTypography.ui(
              fontSize: isCenter ? 34 : 26,
              fontWeight: FontWeight.w900,
              color: pedestalBorderColor.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SECTION 3: MEMBERSHIP TIERS & PASS COMPARISON MATRIX
  // ============================================================
  static Widget buildPricingSection(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.voltLime.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.voltLime.withValues(alpha: 0.35),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.local_activity_rounded, size: 13, color: AppColors.voltLime),
                const SizedBox(width: 5),
                Text(
                  'AUTOMATED ENTRY · ZERO QUEUES',
                  style: AppTypography.ui(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.voltLime,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Choose Your Arena Pass',
            style: AppTypography.ui(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Autonomous entry via QR or NFC pass. No hidden signup fees or annual lock-ins.',
            style: AppTypography.ui(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 24),

          // 3-Column Plan Grid
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PLAN 1: WALK-IN GUEST PASS
              Expanded(
                child: _buildPricingCard(
                  context: context,
                  isDark: isDark,
                  title: 'Walk-In Guest Pass',
                  badge: 'CASUAL MATCH',
                  badgeColor: AppColors.slate400,
                  price: 'RM 17',
                  period: 'per day',
                  description: 'Perfect for tonight’s session. Instant entry via digital door QR.',
                  features: const [
                    'Instant turnstile QR access',
                    'Access to all 10 ITTF tables',
                    'Computer vision scoreboard tracking',
                    'Guest match telemetry logging',
                  ],
                  missingFeatures: const [
                    'Equipment rental included',
                    '50% Happy Hour discount',
                    'Tournament priority booking',
                  ],
                  buttonText: 'Walk In Tonight (RM17) →',
                  isFeatured: false,
                  onTap: () => AppNavigator.toPlan(context),
                ),
              ),

              const SizedBox(width: 18),

              // PLAN 2: MONTHLY UNLIMITED (FEATURED - 90 SEN / DAY)
              Expanded(
                child: _buildPricingCard(
                  context: context,
                  isDark: isDark,
                  title: 'Monthly Unlimited',
                  badge: 'MOST POPULAR · 90 SEN / DAY',
                  badgeColor: AppColors.voltLime,
                  price: 'RM 90',
                  period: 'per month',
                  description: 'Save RM16.10 every single visit! Unmanned 24/7 access for regular rivals.',
                  features: const [
                    'Unlimited 24/7 autonomous entry',
                    'FREE DHS paddle & ball rentals',
                    '50% Happy Hour table discount (50 sen/hr)',
                    'XP multipliers & cash match bounties',
                    '1v1 sparring priority matchmaking',
                    'Door Pass sync (KX8VQS)',
                  ],
                  missingFeatures: const [],
                  buttonText: 'Get Monthly Pass (RM90) →',
                  isFeatured: true,
                  onTap: () => AppNavigator.toPlan(context),
                ),
              ),

              const SizedBox(width: 18),

              // PLAN 3: ELITE ANNUAL & LEAGUE PASS
              Expanded(
                child: _buildPricingCard(
                  context: context,
                  isDark: isDark,
                  title: 'Elite VIP Annual',
                  badge: 'COMPETITIVE CLUB',
                  badgeColor: AppColors.radiantGold,
                  price: 'RM 850',
                  period: 'per year',
                  description: 'For dedicated tournament contenders and serious club competitors.',
                  features: const [
                    'All Monthly Unlimited benefits',
                    'Personalized smart locker at 3 Damansara',
                    'Official JOMNITTAKU team match jersey',
                    'Free entry to monthly cash tournaments',
                    '5 complimentary guest day passes/month',
                    'AI match highlight video reels',
                  ],
                  missingFeatures: const [],
                  buttonText: 'Join Elite Annual →',
                  isFeatured: false,
                  onTap: () => AppNavigator.toPlan(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildPricingCard({
    required BuildContext context,
    required bool isDark,
    required String title,
    required String badge,
    required Color badgeColor,
    required String price,
    required String period,
    required String description,
    required List<String> features,
    required List<String> missingFeatures,
    required String buttonText,
    required bool isFeatured,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: isDark
            ? (isFeatured ? AppColors.darkObsidianCardLight : AppColors.obsidianCard)
            : (isFeatured ? const Color(0xFFF0FDF4) : Colors.white),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isFeatured
              ? AppColors.voltLime
              : (isDark ? AppColors.darkObsidianCardLight : AppColors.slate200),
          width: isFeatured ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isFeatured
                ? AppColors.voltLime.withValues(alpha: 0.18)
                : Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: isFeatured ? 24 : 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: badgeColor.withValues(alpha: 0.4), width: 1),
            ),
            child: Text(
              badge,
              style: AppTypography.ui(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: badgeColor,
                letterSpacing: 0.6,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: AppTypography.ui(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                price,
                style: AppTypography.ui(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: isFeatured ? AppColors.voltLime : AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                period,
                style: AppTypography.ui(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            description,
            style: AppTypography.ui(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 18),
          Divider(color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate200, height: 1),
          const SizedBox(height: 16),

          // Feature list
          ...features.map((feat) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 15,
                      color: AppColors.voltLime,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feat,
                        style: AppTypography.ui(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          ...missingFeatures.map((feat) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.cancel_rounded,
                      size: 15,
                      color: isDark ? AppColors.slate600 : AppColors.slate400,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feat,
                        style: AppTypography.ui(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          const SizedBox(height: 18),

          // Plan Button
          if (isFeatured)
            TactileButton.volt(
              text: buttonText,
              onPressed: onTap,
            )
          else
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.paddleBlack : AppColors.slate100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDark ? AppColors.border : AppColors.slate300,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    buttonText,
                    style: AppTypography.ui(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 4: AUTONOMOUS VENUE 24/7 IOT FACILITY TELEMETRY
  // ============================================================
  static Widget buildIotSection(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.ittfTableBorder.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.ittfTableBorder.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.sensors_rounded, size: 13, color: AppColors.ittfTableBorder),
                const SizedBox(width: 5),
                Text(
                  '100% UNMANNED IOT FACILITY',
                  style: AppTypography.ui(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ittfTableBorder,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Autonomous Venue Systems Telemetry',
            style: AppTypography.ui(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Live hardware telemetry streams from 3 Damansara Level 2 venue sensors.',
            style: AppTypography.ui(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 24),

          // 4-Card Status Grid
          Row(
            children: [
              Expanded(
                child: _buildIotTile(
                  isDark: isDark,
                  icon: Icons.lightbulb_rounded,
                  iconColor: AppColors.radiantGold,
                  title: 'Smart Court Lighting',
                  metric: '500 Lux ITTF',
                  status: 'Active (480 Lux)',
                  statusColor: AppColors.voltLime,
                  description: 'Dynamic motion sensors illuminate court zones when players step onto the floor.',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildIotTile(
                  isDark: isDark,
                  icon: Icons.videocam_rounded,
                  iconColor: AppColors.ittfTableBorder,
                  title: 'AI Scorekeeping',
                  metric: '10 / 10 Tables',
                  status: 'All Cameras Live',
                  statusColor: AppColors.voltLime,
                  description: 'High-speed overhead computer vision cameras track ball spin, rally hits, and edge points.',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildIotTile(
                  isDark: isDark,
                  icon: Icons.door_sliding_rounded,
                  iconColor: AppColors.btnGreenBorder,
                  title: 'NFC Door Turnstiles',
                  metric: 'Sub-second Sync',
                  status: 'Door Pass Active',
                  statusColor: AppColors.voltLime,
                  description: 'Instant turnstile unlock via digital pass (KX8VQS) with automated visit registration.',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildIotTile(
                  isDark: isDark,
                  icon: Icons.ac_unit_rounded,
                  iconColor: const Color(0xFF67E8F9),
                  title: 'Climate & Friction',
                  metric: '22.4°C · 52% RH',
                  status: 'Optimal Bounce',
                  statusColor: AppColors.voltLime,
                  description: 'Calibrated temperature & humidity for DHS 3-star ball rubber friction and true bounce.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildIotTile({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String metric,
    required String status,
    required Color statusColor,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.obsidianCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate200,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: AppTypography.ui(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTypography.ui(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            metric,
            style: AppTypography.ui(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppTypography.ui(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textMuted,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 5: PROFESSIONAL DESKTOP WEBSITE FOOTER
  // ============================================================
  static Widget buildWebsiteFooter(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF090D16) : const Color(0xFFF1F5F9),
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate300,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1240),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Col 1: Brand & Venue
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/company_logo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'JOMNITTAKU',
                              style: AppTypography.ui(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textPrimary,
                                letterSpacing: 1.4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Malaysia’s First Autonomous 24/7 Table Tennis Venue. Walk in, tap in, and challenge rivals anytime with computer vision scoring.',
                          style: AppTypography.ui(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded, size: 14, color: AppColors.pingPongOrange),
                            const SizedBox(width: 5),
                            Text(
                              'Level 2, 3 Damansara Mall, Petaling Jaya',
                              style: AppTypography.ui(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.access_time_filled_rounded, size: 14, color: AppColors.voltLime),
                            const SizedBox(width: 5),
                            Text(
                              'Open 24 Hours · 365 Days a Year',
                              style: AppTypography.ui(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.voltLime,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 32),

                  // Col 2: Navigation Links
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ARENA NAVIGATION',
                          style: AppTypography.ui(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _buildFooterLink('Arena Command', () => AppNavigator.toHomeAndClear(context)),
                        _buildFooterLink('Live Table Radar', () => AppNavigator.toTables(context)),
                        _buildFooterLink('Weekly Leaderboard', () => AppNavigator.toLeaderboard(context)),
                        _buildFooterLink('1v1 Match Bounty', () => AppNavigator.toChallengeBoard(context)),
                        _buildFooterLink('55" Stadium TV Feed', () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const DisplayLeaderboardScreen()),
                          );
                        }),
                      ],
                    ),
                  ),

                  // Col 3: Rules & Equipment
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RULES & EQUIPMENT',
                          style: AppTypography.ui(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _buildFooterLink('ITTF Standard Tables', null),
                        _buildFooterLink('DHS 3-Star Match Balls', null),
                        _buildFooterLink('Carbon Blade Rentals', null),
                        _buildFooterLink('Venue Fair Play Policy', null),
                        _buildFooterLink('Door Pass Guide (KX8VQS)', () => AppNavigator.toPass(context)),
                      ],
                    ),
                  ),

                  // Col 4: Systems Status
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SYSTEM TELEMETRY',
                          style: AppTypography.ui(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.paddleBlack : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate300,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: const BoxDecoration(
                                      color: AppColors.voltLime,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'All 10 Table Nodes Online',
                                    style: AppTypography.ui(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.voltLime,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Engine: Flutter Web + TSports IoT Gateway v2.4.0',
                                style: AppTypography.ui(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Telemetry: 24/7 Autonomous Turnstile & Camera Link',
                                style: AppTypography.ui(
                                  fontSize: 10,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),
              Divider(color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate300, height: 1),
              const SizedBox(height: 20),

              // Bottom legal & copyright
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© 2026 JOMNITTAKU Sdn Bhd. All rights reserved. Malaysia’s Autonomous Sports Arena.',
                    style: AppTypography.ui(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Terms of Service  ·  Privacy Policy  ·  Venue Code',
                        style: AppTypography.ui(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildFooterLink(String label, VoidCallback? onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: MouseRegion(
        cursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            label,
            style: AppTypography.ui(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: onTap != null ? AppColors.textSecondary : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}
