import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../core/session/demo_avatars.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// Elite 100vh Full-Screen Desktop Command Center Sections for JOMNITTAKU.
///
/// Designed to eliminate text collisions, honor 10 tournament courts,
/// and provide high-density SaaS command center aesthetics:
///  - 2-Row Master Bento Grid (60/40 Split)
///  - Card 1: Arena Hero Stage & Table 04 Live Match HUD
///  - Card 2: Arena Telemetry (Donut Occupancy Meter + 24h Traffic Sparkline + IoT)
///  - Card 3: Live 10-Court Architectural Radar Matrix (2x5 Grid)
///  - Card 4: Olympic League Podium & Rates / Passes Comparison
///  - Bottom Action Strip: Tactile Quick Access Hub
class DesktopWebSections {
  DesktopWebSections._();

  // ============================================================
  // MASTER COMMAND CENTER ORCHESTRATOR
  // ============================================================
  static Widget buildFullScreenCommandCenter(
    BuildContext context,
    bool isDark, {
    required VoidCallback onWalkInTap,
    required VoidCallback onPassTap,
    required VoidCallback onTvTap,
    required VoidCallback onRadarTap,
    required VoidCallback onLeaderboardTap,
    required VoidCallback onChallengeTap,
    required VoidCallback onXpTap,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Enforce smooth viewport scaling
        final isCompactHeight = constraints.maxHeight < 820;

        return Container(
          width: double.infinity,
          height: constraints.maxHeight,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: isCompactHeight ? 8 : 12,
          ),
          child: Column(
            children: [
              // ----------------------------------------------------
              // ROW 1: HERO & TELEMETRY (Flex 52)
              // ----------------------------------------------------
              Expanded(
                flex: 52,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // LEFT: HERO STAGE & LIVE MATCH HUD (Flex 58)
                    Expanded(
                      flex: 58,
                      child: buildArenaHeroStageCard(
                        context,
                        isDark,
                        onWalkInTap: onWalkInTap,
                        onPassTap: onPassTap,
                        onTvTap: onTvTap,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // RIGHT: VENUE TELEMETRY, DONUT & SPARKLINE (Flex 42)
                    Expanded(
                      flex: 42,
                      child: buildVenueTelemetryCard(context, isDark),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ----------------------------------------------------
              // ROW 2: 10-COURT RADAR & PODIUM / RATES (Flex 48)
              // ----------------------------------------------------
              Expanded(
                flex: 48,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // LEFT: 10-COURT ARCHITECTURAL RADAR MATRIX (Flex 58)
                    Expanded(
                      flex: 58,
                      child: buildTenCourtRadarMatrixCard(
                        context,
                        isDark,
                        onRadarTap: onRadarTap,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // RIGHT: OLYMPIC PODIUM & PASSES (Flex 42)
                    Expanded(
                      flex: 42,
                      child: buildPodiumAndRatesCard(
                        context,
                        isDark,
                        onPassTap: onPassTap,
                        onLeaderboardTap: onLeaderboardTap,
                        onChallengeTap: onChallengeTap,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ----------------------------------------------------
              // BOTTOM QUICK ACTION STRIP (40px)
              // ----------------------------------------------------
              buildBottomActionStrip(
                context,
                isDark,
                onPassTap: onPassTap,
                onRadarTap: onRadarTap,
                onLeaderboardTap: onLeaderboardTap,
                onChallengeTap: onChallengeTap,
                onXpTap: onXpTap,
                onTvTap: onTvTap,
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // CARD 1: ARENA HERO STAGE & TABLE 04 LIVE MATCH HUD
  // ============================================================
  static Widget buildArenaHeroStageCard(
    BuildContext context,
    bool isDark, {
    required VoidCallback onWalkInTap,
    required VoidCallback onPassTap,
    required VoidCallback onTvTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF162544), Color(0xFF0F1A2E)],
              )
            : const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFFFFF), Color(0xFFF9F5EE)],
              ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Venue Metadata & Live Signal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    '3 DAMANSARA LEVEL 2 · 10 ITTF COURTS',
                    style: AppTypography.ui(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.electricCrimson.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.electricCrimson.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppColors.electricCrimson,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'AI SCORING ONLINE',
                      style: AppTypography.ui(
                        fontSize: 8.5,
                        fontWeight: FontWeight.w900,
                        color: AppColors.electricCrimson,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Main Headline & Subtitle
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'JUST PLAY TONIGHT.',
                      style: AppTypography.ui(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Malaysia's premier 24/7 autonomous, AI-tracked arena. Scan in & play.",
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Compact Primary Action
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onWalkInTap,
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      gradient: AppColors.tobyCtaGradient,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.tobyCtaGlow.withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Walk In & Play (RM17)',
                          style: AppTypography.ui(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Live Court Visualizer 3D HUD (Table 04)
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF090F1C) : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // HUD Sub-Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.electricCrimson,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'TABLE 04 · LIVE MATCH HUD',
                            style: AppTypography.ui(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white70 : AppColors.slate900,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.voltLime.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Score: 14 - 11 · Game 3',
                          style: AppTypography.ui(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.voltLime,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Court Representation with Net & Players
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.ittfTableBlue,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.ittfTableBorder,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.ittfTableSurface.withValues(alpha: 0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Court Center Net Line
                          Container(
                            height: 3,
                            color: AppColors.ittfCourtNet,
                          ),
                          // Net Mesh Posts
                          Positioned(
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 6,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                Container(
                                  width: 6,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Player 1 (Top Court Half)
                          Positioned(
                            top: 8,
                            left: 12,
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 10,
                                  backgroundImage: AssetImage(DemoAvatars.jason),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Jason T. (14)',
                                    style: AppTypography.ui(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 3-Star Match Ball in Rally
                          const Positioned(
                            top: 24,
                            right: 50,
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor: AppColors.pingPongOrange,
                            ),
                          ),

                          // Player 2 (Bottom Court Half)
                          Positioned(
                            bottom: 8,
                            right: 12,
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.voltLime.withValues(alpha: 0.85),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Alman R. (11)',
                                    style: AppTypography.ui(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const CircleAvatar(
                                  radius: 10,
                                  backgroundImage: AssetImage(DemoAvatars.user),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // HUD Telemetry Strip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '● DHS 3-Star Match Ball · Active Rally: 9 hits',
                        style: AppTypography.ui(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.slate400 : AppColors.slate600,
                        ),
                      ),
                      Text(
                        'Lighting: 480 Lux ITTF · AI Camera Online 🟢',
                        style: AppTypography.ui(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.slate400 : AppColors.slate600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARD 2: CAPACITY & VENUE TELEMETRY (DONUT + SPARKLINE + IOT)
  // ============================================================
  static Widget buildVenueTelemetryCard(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF162544), Color(0xFF101B30)],
              )
            : const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFFFFF), Color(0xFFF9F5EE)],
              ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Arena Capacity & Telemetry',
                style: AppTypography.ui(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.voltLime.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'LIVE HARDWARE',
                  style: AppTypography.ui(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w900,
                    color: AppColors.voltLime,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Visual Telemetry Row: Donut Meter (Left) + Sparkline (Right)
          Expanded(
            child: Row(
              children: [
                // Occupancy Donut Meter
                Container(
                  width: 110,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0E1626) : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: CustomPaint(
                          painter: OccupancyDonutPainter(
                            freeCount: 6,
                            totalCount: 10,
                            isDark: isDark,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '6/10',
                                  style: AppTypography.ui(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.voltLime,
                                  ),
                                ),
                                Text(
                                  'FREE',
                                  style: AppTypography.ui(
                                    fontSize: 7.5,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textSecondary,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '60% Available',
                        style: AppTypography.ui(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // 24h Hourly Traffic Curve Sparkline
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0E1626) : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '24h Traffic Curve',
                              style: AppTypography.ui(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppColors.ittfTableSurface.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Peak: 8 - 11 PM',
                                style: AppTypography.ui(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.ittfTableBorder,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Custom Sparkline
                        Expanded(
                          child: CustomPaint(
                            size: Size.infinite,
                            painter: HourlyTrafficSparklinePainter(isDark: isDark),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '00:00 (Quiet)',
                              style: AppTypography.ui(
                                fontSize: 8,
                                color: AppColors.textMuted,
                              ),
                            ),
                            Text(
                              'NOW (Moderate)',
                              style: AppTypography.ui(
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                                color: AppColors.voltLime,
                              ),
                            ),
                            Text(
                              '23:00 (High)',
                              style: AppTypography.ui(
                                fontSize: 8,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Venue Conditions Micro-Tiles (IoT Grid)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0A1120) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIotMicroTile(
                  icon: Icons.lightbulb_rounded,
                  label: 'Lighting',
                  value: '480 Lux ITTF',
                  isGood: true,
                  isDark: isDark,
                ),
                _buildIotMicroTile(
                  icon: Icons.thermostat_rounded,
                  label: 'Climate',
                  value: '23°C AC',
                  isGood: true,
                  isDark: isDark,
                ),
                _buildIotMicroTile(
                  icon: Icons.videocam_rounded,
                  label: 'AI Camera',
                  value: 'Edge Online',
                  isGood: true,
                  isDark: isDark,
                ),
                _buildIotMicroTile(
                  icon: Icons.sports_tennis_rounded,
                  label: 'Match Ball',
                  value: 'DHS 3-Star',
                  isGood: true,
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARD 3: 10-COURT ARCHITECTURAL RADAR MATRIX (2x5 GRID)
  // ============================================================
  static Widget buildTenCourtRadarMatrixCard(
    BuildContext context,
    bool isDark, {
    required VoidCallback onRadarTap,
  }) {
    // 10 Courts Data Setup
    final courts = [
      {'id': 'T01', 'status': 'busy', 'player': 'Jason T.', 'time': '18m left'},
      {'id': 'T02', 'status': 'busy', 'player': 'Sara K.', 'time': '12m left'},
      {'id': 'T03', 'status': 'free', 'player': 'Available', 'time': 'Free Now'},
      {'id': 'T04', 'status': 'match', 'player': 'Jason v Alman', 'time': '14-11 Live'},
      {'id': 'T05', 'status': 'free', 'player': 'Available', 'time': 'Free Now'},
      {'id': 'T06', 'status': 'free', 'player': 'Available', 'time': 'Free Now'},
      {'id': 'T07', 'status': 'free', 'player': 'Available', 'time': 'Free Now'},
      {'id': 'T08', 'status': 'free', 'player': 'Available', 'time': 'Free Now'},
      {'id': 'T09', 'status': 'reserved', 'player': 'League Cup', 'time': 'Res 9:00 PM'},
      {'id': 'T10', 'status': 'free', 'player': 'Available', 'time': 'Free Now'},
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF162544), Color(0xFF0F1A2E)],
              )
            : const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFFFFF), Color(0xFFF9F5EE)],
              ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.table_restaurant_rounded,
                    size: 16,
                    color: AppColors.voltLime,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '10-Court Live Architectural Radar',
                    style: AppTypography.ui(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onRadarTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.voltLime.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.voltLime.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      '6 of 10 Free →',
                      style: AppTypography.ui(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: AppColors.voltLime,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 2x5 Court Grid Matrix
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.85,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                final court = courts[index];
                final status = court['status'];
                final isFree = status == 'free';
                final isMatch = status == 'match';
                final isReserved = status == 'reserved';

                Color statusColor = AppColors.voltLime;
                if (isMatch) statusColor = AppColors.electricCrimson;
                if (isReserved) statusColor = AppColors.amethystPurple;
                if (status == 'busy') statusColor = AppColors.pingPongOrange;

                return Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0E1626) : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isMatch
                          ? AppColors.electricCrimson.withValues(alpha: 0.6)
                          : (isDark ? AppColors.darkObsidianBorder : AppColors.slate200),
                      width: isMatch ? 1.5 : 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            court['id']!,
                            style: AppTypography.ui(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        court['player']!,
                        style: AppTypography.ui(
                          fontSize: 9.5,
                          fontWeight: isFree ? FontWeight.w800 : FontWeight.w600,
                          color: isFree ? AppColors.voltLime : AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        court['time']!,
                        style: AppTypography.ui(
                          fontSize: 8,
                          color: AppColors.textMuted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Happy Hour Promotion Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              gradient: isDark
                  ? const LinearGradient(
                      colors: [Color(0xFF2E1C0C), Color(0xFF1E1308)],
                    )
                  : const LinearGradient(
                      colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
                    ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.radiantGold.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.flash_on_rounded,
                      size: 14,
                      color: AppColors.radiantGold,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'HAPPY HOUR: 50% OFF (All tables 50 sen/hr for members)',
                      style: AppTypography.ui(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.radiantGold : AppColors.goldDeep,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.radiantGold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '18m : 45s Left',
                    style: AppTypography.ui(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: isDark ? AppColors.radiantGold : AppColors.goldDeep,
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

  // ============================================================
  // CARD 4: OLYMPIC LEAGUE PODIUM & RATES / PASSES
  // ============================================================
  static Widget buildPodiumAndRatesCard(
    BuildContext context,
    bool isDark, {
    required VoidCallback onPassTap,
    required VoidCallback onLeaderboardTap,
    required VoidCallback onChallengeTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF162544), Color(0xFF101B30)],
              )
            : const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFFFFF), Color(0xFFF9F5EE)],
              ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP HALF: OLYMPIC PODIUM LEADERS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.emoji_events_rounded,
                    size: 15,
                    color: AppColors.radiantGold,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Arena League Podium',
                    style: AppTypography.ui(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onLeaderboardTap,
                  child: Text(
                    'View Full Standings →',
                    style: AppTypography.ui(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ittfTableBorder,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Top 3 Podium Athletes Row
          Row(
            children: [
              // #2 Silver: Sara K.
              Expanded(
                child: _buildPodiumAthletePill(
                  rank: 2,
                  name: 'Sara K.',
                  xp: '1,480 XP',
                  avatarAsset: DemoAvatars.sara,
                  rankColor: AppColors.rankSilver,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 6),
              // #1 Gold: Daniel L.
              Expanded(
                child: _buildPodiumAthletePill(
                  rank: 1,
                  name: 'Daniel L.',
                  xp: '1,620 XP',
                  avatarAsset: DemoAvatars.daniel,
                  rankColor: AppColors.rankGold,
                  isDark: isDark,
                  isChampion: true,
                ),
              ),
              const SizedBox(width: 6),
              // #3 Bronze: Mei R.
              Expanded(
                child: _buildPodiumAthletePill(
                  rank: 3,
                  name: 'Mei R.',
                  xp: '1,395 XP',
                  avatarAsset: DemoAvatars.mei,
                  rankColor: AppColors.rankBronze,
                  isDark: isDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // User Rank Callout Pill (#4 Alman)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0E1626) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 9,
                      backgroundImage: AssetImage(DemoAvatars.user),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Alman R. (YOU): #4 · 1,240 XP',
                      style: AppTypography.ui(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Text(
                  '155 XP to #3 Podium',
                  style: AppTypography.ui(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.voltLime,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // BOTTOM HALF: ACCESS RATES & PASS COMPARISON
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF090F1C) : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Walk-In Pass',
                          style: AppTypography.ui(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          'RM17 / visit',
                          style: AppTypography.ui(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 26,
                      color: isDark ? AppColors.slate600 : AppColors.slate300,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Unlimited Member',
                          style: AppTypography.ui(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.voltLime,
                          ),
                        ),
                        Text(
                          '90 sen / day (RM90/mo)',
                          style: AppTypography.ui(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            color: AppColors.voltLime,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Instant savings badge + Door Pass trigger
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.voltLime.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '🔥 Member saves RM16.10 every single visit',
                          style: AppTypography.ui(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.voltLime,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onPassTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isDark ? AppColors.darkObsidianBorder : AppColors.slate300,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.qr_code_rounded,
                                size: 12,
                                color: AppColors.voltLime,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Pass: KX8VQS',
                                style: AppTypography.ui(
                                  fontSize: 10,
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
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM QUICK ACTION STRIP (40px)
  // ============================================================
  static Widget buildBottomActionStrip(
    BuildContext context,
    bool isDark, {
    required VoidCallback onPassTap,
    required VoidCallback onRadarTap,
    required VoidCallback onLeaderboardTap,
    required VoidCallback onChallengeTap,
    required VoidCallback onXpTap,
    required VoidCallback onTvTap,
  }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkObsidianElevated : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildBottomActionPill(
                icon: Icons.flash_on_rounded,
                label: 'Borrow XP (+200 Loan)',
                color: AppColors.radiantGold,
                onTap: onXpTap,
                isDark: isDark,
              ),
              const SizedBox(width: 8),
              _buildBottomActionPill(
                icon: Icons.search_rounded,
                label: 'Radar Ping Nearby',
                color: AppColors.voltLime,
                onTap: onRadarTap,
                isDark: isDark,
              ),
              const SizedBox(width: 8),
              _buildBottomActionPill(
                icon: Icons.sports_mma_rounded,
                label: '1v1 Match Pot (RM200)',
                color: AppColors.electricCrimson,
                onTap: onChallengeTap,
                isDark: isDark,
              ),
              const SizedBox(width: 8),
              _buildBottomActionPill(
                icon: Icons.door_front_door_rounded,
                label: 'Door Pass QR (KX8VQS)',
                color: AppColors.ittfTableBorder,
                onTap: onPassTap,
                isDark: isDark,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '3 Damansara Mall Level 2 · Open 24/7',
                style: AppTypography.ui(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HELPER WIDGETS
  // ============================================================
  static Widget _buildIotMicroTile({
    required IconData icon,
    required String label,
    required String value,
    required bool isGood,
    required bool isDark,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 13,
          color: isGood ? AppColors.voltLime : AppColors.electricCrimson,
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTypography.ui(
                fontSize: 8,
                color: AppColors.textMuted,
              ),
            ),
            Text(
              value,
              style: AppTypography.ui(
                fontSize: 9.5,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget _buildPodiumAthletePill({
    required int rank,
    required String name,
    required String xp,
    required String avatarAsset,
    required Color rankColor,
    required bool isDark,
    bool isChampion = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: isChampion
            ? (isDark ? const Color(0xFF221A06) : const Color(0xFFFFFBEB))
            : (isDark ? const Color(0xFF0E1626) : const Color(0xFFF8FAFC)),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isChampion
              ? AppColors.radiantGold.withValues(alpha: 0.5)
              : (isDark ? AppColors.darkObsidianBorder : AppColors.slate200),
        ),
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage(avatarAsset),
              ),
              Positioned(
                bottom: -3,
                right: -3,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: rankColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$rank',
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: AppTypography.ui(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            xp,
            style: AppTypography.ui(
              fontSize: 8.5,
              fontWeight: FontWeight.w700,
              color: rankColor,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildBottomActionPill({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: isDark ? 0.12 : 0.08),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: color.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: color),
              const SizedBox(width: 5),
              Text(
                label,
                style: AppTypography.ui(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppColors.slate900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CUSTOM PAINTER: OCCUPANCY DONUT METER (60% FREE)
// ============================================================
class OccupancyDonutPainter extends CustomPainter {
  final int freeCount;
  final int totalCount;
  final bool isDark;

  OccupancyDonutPainter({
    required this.freeCount,
    required this.totalCount,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;
    const strokeWidth = 7.0;

    // Track Paint
    final trackPaint = Paint()
      ..color = isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, trackPaint);

    // Free Segment (VoltLime)
    final sweepAngle = 2 * math.pi * (freeCount / totalCount);
    final valuePaint = Paint()
      ..color = AppColors.voltLime
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant OccupancyDonutPainter oldDelegate) {
    return oldDelegate.freeCount != freeCount || oldDelegate.isDark != isDark;
  }
}

// ============================================================
// CUSTOM PAINTER: 24H HOURLY TRAFFIC SPARKLINE
// ============================================================
class HourlyTrafficSparklinePainter extends CustomPainter {
  final bool isDark;

  HourlyTrafficSparklinePainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    // 8 normalized traffic sample points (00:00, 04:00, 08:00, 12:00, 16:00, 19:00, 21:00, 23:00)
    final points = [0.15, 0.05, 0.20, 0.45, 0.60, 0.90, 0.95, 0.70];

    final path = Path();
    final fillPath = Path();

    final stepX = size.width / (points.length - 1);

    for (int i = 0; i < points.length; i++) {
      final x = i * stepX;
      final y = size.height - (points[i] * size.height * 0.85);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        final prevX = (i - 1) * stepX;
        final prevY = size.height - (points[i - 1] * size.height * 0.85);
        final cX = (prevX + x) / 2;
        path.cubicTo(cX, prevY, cX, y, x, y);
        fillPath.cubicTo(cX, prevY, cX, y, x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    // Fill gradient
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.ittfTableSurface.withValues(alpha: isDark ? 0.35 : 0.20),
          AppColors.ittfTableSurface.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    // Stroke line
    final strokePaint = Paint()
      ..color = AppColors.ittfTableBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, strokePaint);

    // Peak dot highlight at 21:00 (index 6)
    final peakX = 6 * stepX;
    final peakY = size.height - (points[6] * size.height * 0.85);
    final dotPaint = Paint()..color = AppColors.voltLime;
    canvas.drawCircle(Offset(peakX, peakY), 3.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant HourlyTrafficSparklinePainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
