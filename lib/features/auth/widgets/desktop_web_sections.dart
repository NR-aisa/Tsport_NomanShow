import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../core/session/demo_avatars.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// Elite Desktop Web Command Center Sections for JOMNITTAKU.
///
/// Fixes applied:
/// 1. Proportional Table Tennis Table (authentic 1.8:1 ratio, not an empty stretched slab).
/// 2. Clean, legible typography and menus (13-15px labels).
/// 3. In-Shell Tab Switching (Overview, 10 Courts Floorplan, League, Passes, IoT).
/// 4. Zero cognitive overload: each view shows only relevant, focused information.
class DesktopWebSections {
  DesktopWebSections._();

  // ============================================================
  // MASTER COMMAND CENTER ORCHESTRATOR WITH VIEW SWITCHING
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          height: constraints.maxHeight,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: _buildCurrentView(
              context,
              isDark,
              activeTab: activeTab,
              onWalkInTap: onWalkInTap,
              onPassTap: onPassTap,
              onTvTap: onTvTap,
              onTabChanged: onTabChanged,
              onChallengeTap: onChallengeTap,
              onXpTap: onXpTap,
            ),
          ),
        );
      },
    );
  }

  static Widget _buildCurrentView(
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
    switch (activeTab) {
      case 'radar':
        return buildDedicatedRadarView(context, isDark, onPassTap: onPassTap);
      case 'league':
        return buildDedicatedLeagueView(context, isDark, onChallengeTap: onChallengeTap);
      case 'passes':
        return buildDedicatedPassesView(context, isDark, onWalkInTap: onWalkInTap, onPassTap: onPassTap);
      case 'iot':
        return buildDedicatedIotView(context, isDark);
      case 'command':
      default:
        return buildOverviewView(
          context,
          isDark,
          onWalkInTap: onWalkInTap,
          onPassTap: onPassTap,
          onTvTap: onTvTap,
          onTabChanged: onTabChanged,
        );
    }
  }

  // ============================================================
  // VIEW 1: ARENA OVERVIEW (CLEAN, FOCUSED, NO OVERLOAD)
  // ============================================================
  static Widget buildOverviewView(
    BuildContext context,
    bool isDark, {
    required VoidCallback onWalkInTap,
    required VoidCallback onPassTap,
    required VoidCallback onTvTap,
    required ValueChanged<String> onTabChanged,
  }) {
    return Column(
      key: const ValueKey('overview_view'),
      children: [
        // ROW 1: Hero Stage & Telemetry (Flex 55)
        Expanded(
          flex: 55,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // LEFT: Hero Stage + Proportional 3D Table HUD (Flex 60)
              Expanded(
                flex: 60,
                child: _buildHeroOverviewCard(
                  context,
                  isDark,
                  onWalkInTap: onWalkInTap,
                  onPassTap: onPassTap,
                ),
              ),
              const SizedBox(width: 16),
              // RIGHT: Arena Capacity Donut + Peak Traffic Sparkline (Flex 40)
              Expanded(
                flex: 40,
                child: _buildCapacityTelemetryCard(context, isDark),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ROW 2: Fast Access Cards (Flex 45)
        Expanded(
          flex: 45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // LEFT: 10 Courts Summary & Floorplan Launcher (Flex 60)
              Expanded(
                flex: 60,
                child: _buildCourtsQuickSummaryCard(
                  context,
                  isDark,
                  onFloorplanTap: () => onTabChanged('radar'),
                ),
              ),
              const SizedBox(width: 16),
              // RIGHT: Olympic Podium & Passes Shortcut (Flex 40)
              Expanded(
                flex: 40,
                child: _buildPodiumQuickCard(
                  context,
                  isDark,
                  onLeagueTap: () => onTabChanged('league'),
                  onPassTap: onPassTap,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // HERO OVERVIEW CARD WITH PROPORTIONATE TABLE TENNIS TABLE
  // ============================================================
  static Widget _buildHeroOverviewCard(
    BuildContext context,
    bool isDark, {
    required VoidCallback onWalkInTap,
    required VoidCallback onPassTap,
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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tagline Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.voltLime,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '3 DAMANSARA LEVEL 2 · 10 ITTF REGULATION COURTS',
                    style: AppTypography.ui(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.electricCrimson.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '● 2 MATCHES LIVE',
                  style: AppTypography.ui(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: AppColors.electricCrimson,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Main Headline & Action Buttons Row
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left text & CTAs
                Expanded(
                  flex: 55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'JUST PLAY TONIGHT.',
                        style: AppTypography.ui(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Malaysia's premier 24/7 autonomous, unmanned table tennis arena. Walk in anytime, scan your pass at the turnstile, and challenge live rivals.",
                        style: AppTypography.ui(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: onWalkInTap,
                              child: Container(
                                height: 42,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  gradient: AppColors.tobyCtaGradient,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.tobyCtaGlow.withValues(alpha: 0.35),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Walk In Tonight (RM17) →',
                                      style: AppTypography.ui(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: onPassTap,
                              child: Container(
                                height: 42,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: isDark ? Colors.white.withValues(alpha: 0.08) : AppColors.slate100,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isDark ? AppColors.darkObsidianBorder : AppColors.slate300,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.qr_code_rounded,
                                      size: 16,
                                      color: AppColors.voltLime,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Pass: KX8VQS',
                                      style: AppTypography.ui(
                                        fontSize: 12.5,
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

                const SizedBox(width: 20),

                // Right: PROPORTIONAL 3D TABLE TENNIS COURT (Compact & Balanced)
                Container(
                  width: 260,
                  height: 145,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF090F1C) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // Court Header
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
                                'TABLE 04 LIVE HUD',
                                style: AppTypography.ui(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? Colors.white70 : AppColors.slate900,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppColors.voltLime.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '14 - 11',
                              style: AppTypography.ui(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w900,
                                color: AppColors.voltLime,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // True 2:1 Proportional Court Surface
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.ittfTableBlue,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: AppColors.ittfTableBorder,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.ittfTableSurface.withValues(alpha: 0.25),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Center Net
                              Container(
                                height: 2,
                                color: AppColors.ittfCourtNet,
                              ),
                              // Player 1
                              const Positioned(
                                top: 6,
                                left: 8,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundImage: AssetImage(DemoAvatars.jason),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Jason (14)',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Match Ball
                              const Positioned(
                                top: 22,
                                right: 35,
                                child: CircleAvatar(
                                  radius: 3.5,
                                  backgroundColor: AppColors.pingPongOrange,
                                ),
                              ),
                              // Player 2
                              const Positioned(
                                bottom: 6,
                                right: 8,
                                child: Row(
                                  children: [
                                    Text(
                                      'Alman (11)',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.voltLime,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundImage: AssetImage(DemoAvatars.user),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'DHS 3-Star Match Ball · Active Rally: 9 hits',
                        style: AppTypography.ui(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w600,
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
    );
  }

  // ============================================================
  // CARD 2: CAPACITY & TELEMETRY (DONUT + SPARKLINE + IOT)
  // ============================================================
  static Widget _buildCapacityTelemetryCard(BuildContext context, bool isDark) {
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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Arena Capacity & Telemetry',
                style: AppTypography.ui(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.voltLime.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '6/10 FREE NOW',
                  style: AppTypography.ui(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w900,
                    color: AppColors.voltLime,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Visual meters row
          Expanded(
            child: Row(
              children: [
                // Donut Meter
                Container(
                  width: 110,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0E1626) : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
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
                                    fontSize: 12,
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '60% Available',
                        style: AppTypography.ui(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // 24h Traffic Curve Sparkline
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0E1626) : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
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
                              '24h Traffic Pattern',
                              style: AppTypography.ui(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'Peak: 8 - 11 PM',
                              style: AppTypography.ui(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.ittfTableBorder,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: CustomPaint(
                            size: Size.infinite,
                            painter: HourlyTrafficSparklinePainter(isDark: isDark),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Quiet', style: AppTypography.ui(fontSize: 8.5, color: AppColors.textMuted)),
                            Text('NOW: Moderate', style: AppTypography.ui(fontSize: 8.5, fontWeight: FontWeight.w800, color: AppColors.voltLime)),
                            Text('High', style: AppTypography.ui(fontSize: 8.5, color: AppColors.textMuted)),
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

          // Environment Strip
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('💡 480 Lux ITTF Lighting', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
              Text('🌡 23°C Climate Controlled', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
              Text('📷 Edge AI Camera Online 🟢', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.voltLime)),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARD 3: 10 COURTS QUICK SUMMARY (WITH DIRECT FLOORPLAN LAUNCHER)
  // ============================================================
  static Widget _buildCourtsQuickSummaryCard(
    BuildContext context,
    bool isDark, {
    required VoidCallback onFloorplanTap,
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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.table_restaurant_rounded,
                    size: 18,
                    color: AppColors.voltLime,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '10 Courts Radar & Floorplan',
                    style: AppTypography.ui(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onFloorplanTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.voltLime.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.voltLime.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      'View 10 Courts Floorplan →',
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: AppColors.voltLime,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 5 Court Highlights row
          Expanded(
            child: Row(
              children: [
                _buildCourtMiniTile('T01', 'Jason T.', 'In Play', false, isDark),
                const SizedBox(width: 8),
                _buildCourtMiniTile('T02', 'Sara K.', 'In Play', false, isDark),
                const SizedBox(width: 8),
                _buildCourtMiniTile('T03', 'Available', 'Free Now', true, isDark),
                const SizedBox(width: 8),
                _buildCourtMiniTile('T04', 'Jason v Alman', '14-11 Live', false, isDark, isMatch: true),
                const SizedBox(width: 8),
                _buildCourtMiniTile('T05', 'Available', 'Free Now', true, isDark),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Happy Hour Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                      size: 15,
                      color: AppColors.radiantGold,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'HAPPY HOUR: 50% OFF · All tables 50 sen/hr for members',
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.radiantGold : AppColors.goldDeep,
                      ),
                    ),
                  ],
                ),
                Text(
                  '18m : 45s Left',
                  style: AppTypography.ui(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                    color: isDark ? AppColors.radiantGold : AppColors.goldDeep,
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
  // CARD 4: PODIUM & PASSES QUICK CARD
  // ============================================================
  static Widget _buildPodiumQuickCard(
    BuildContext context,
    bool isDark, {
    required VoidCallback onLeagueTap,
    required VoidCallback onPassTap,
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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.emoji_events_rounded,
                    size: 17,
                    color: AppColors.radiantGold,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Arena League Podium',
                    style: AppTypography.ui(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onLeagueTap,
                  child: Text(
                    'View League →',
                    style: AppTypography.ui(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ittfTableBorder,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Top 3 Leaders
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildPodiumPill(
                    rank: 2,
                    name: 'Sara K.',
                    xp: '1,480 XP',
                    avatar: DemoAvatars.sara,
                    color: AppColors.rankSilver,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildPodiumPill(
                    rank: 1,
                    name: 'Daniel L.',
                    xp: '1,620 XP',
                    avatar: DemoAvatars.daniel,
                    color: AppColors.rankGold,
                    isDark: isDark,
                    isChampion: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildPodiumPill(
                    rank: 3,
                    name: 'Mei R.',
                    xp: '1,395 XP',
                    avatar: DemoAvatars.mei,
                    color: AppColors.rankBronze,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Rates & Passes Footer Strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF090F1C) : const Color(0xFFF1F5F9),
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
                    Text('Walk-In: ', style: AppTypography.ui(fontSize: 11, color: AppColors.textSecondary)),
                    Text('RM17', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                    const SizedBox(width: 8),
                    Text('· Member: ', style: AppTypography.ui(fontSize: 11, color: AppColors.textSecondary)),
                    Text('90 sen/day', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.voltLime)),
                  ],
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: onPassTap,
                    child: Text(
                      'Door Pass: KX8VQS 🔑',
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.voltLime,
                      ),
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
  // VIEW 2: DEDICATED 10-COURT FLOORPLAN (FULL-SCREEN, SPACIOUS)
  // ============================================================
  static Widget buildDedicatedRadarView(
    BuildContext context,
    bool isDark, {
    required VoidCallback onPassTap,
  }) {
    final courts = [
      {'id': 'T01', 'status': 'busy', 'player': 'Jason T.', 'time': '18m left', 'type': 'DHS Rainbow ITTF'},
      {'id': 'T02', 'status': 'busy', 'player': 'Sara K.', 'time': '12m left', 'type': 'DHS Rainbow ITTF'},
      {'id': 'T03', 'status': 'free', 'player': 'Available', 'time': 'Free Now', 'type': 'Stiga Showdown'},
      {'id': 'T04', 'status': 'match', 'player': 'Jason v Alman', 'time': '14-11 Live', 'type': 'Stadium Centre Court'},
      {'id': 'T05', 'status': 'free', 'player': 'Available', 'time': 'Free Now', 'type': 'Stiga Showdown'},
      {'id': 'T06', 'status': 'free', 'player': 'Available', 'time': 'Free Now', 'type': 'Butterfly Centrefold'},
      {'id': 'T07', 'status': 'free', 'player': 'Available', 'time': 'Free Now', 'type': 'Butterfly Centrefold'},
      {'id': 'T08', 'status': 'free', 'player': 'Available', 'time': 'Free Now', 'type': 'Nittaku Premium 25'},
      {'id': 'T09', 'status': 'reserved', 'player': 'League Cup Res', 'time': '9:00 PM', 'type': 'Nittaku Premium 25'},
      {'id': 'T10', 'status': 'free', 'player': 'Available', 'time': 'Free Now', 'type': 'Practice Court'},
    ];

    return Container(
      key: const ValueKey('radar_view'),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkObsidianCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '10 Courts Arena Floorplan & Live Telemetry',
                    style: AppTypography.ui(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '3 Damansara Level 2 · 10 ITTF Tournament Courts · Tap any table to unlock or view camera feed',
                    style: AppTypography.ui(
                      fontSize: 12,
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
                  '6 OF 10 COURTS FREE NOW',
                  style: AppTypography.ui(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: AppColors.voltLime,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 2x5 Grid of full court cards
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.45,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                final court = courts[index];
                final isFree = court['status'] == 'free';
                final isMatch = court['status'] == 'match';

                return Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0E1626) : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isMatch
                          ? AppColors.electricCrimson
                          : (isDark ? AppColors.darkObsidianBorder : AppColors.slate200),
                      width: isMatch ? 1.5 : 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
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
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isFree
                                  ? AppColors.voltLime.withValues(alpha: 0.15)
                                  : AppColors.electricCrimson.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              isFree ? 'FREE' : 'IN PLAY',
                              style: AppTypography.ui(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: isFree ? AppColors.voltLime : AppColors.electricCrimson,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        court['player']!,
                        style: AppTypography.ui(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        court['type']!,
                        style: AppTypography.ui(
                          fontSize: 10,
                          color: AppColors.textMuted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            court['time']!,
                            style: AppTypography.ui(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: isFree ? AppColors.voltLime : AppColors.ittfTableBorder,
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: onPassTap,
                              child: Text(
                                isFree ? 'Play →' : 'Watch',
                                style: AppTypography.ui(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.voltLime,
                                ),
                              ),
                            ),
                          ),
                        ],
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
  // VIEW 3: DEDICATED OLYMPIC LEAGUE VIEW
  // ============================================================
  static Widget buildDedicatedLeagueView(
    BuildContext context,
    bool isDark, {
    required VoidCallback onChallengeTap,
  }) {
    return Container(
      key: const ValueKey('league_view'),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkObsidianCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Arena League Standings & Olympic Podium',
                style: AppTypography.ui(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onChallengeTap,
                  child: Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: AppColors.tobyCtaGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Post 1v1 Challenge Match →',
                      style: AppTypography.ui(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Top 3 Podium
          Row(
            children: [
              Expanded(
                child: _buildPodiumAthleteBig(
                  rank: 2,
                  name: 'Sara K.',
                  xp: '1,480 XP',
                  avatarAsset: DemoAvatars.sara,
                  color: AppColors.rankSilver,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildPodiumAthleteBig(
                  rank: 1,
                  name: 'Daniel L. (Champion)',
                  xp: '1,620 XP',
                  avatarAsset: DemoAvatars.daniel,
                  color: AppColors.rankGold,
                  isDark: isDark,
                  isChampion: true,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildPodiumAthleteBig(
                  rank: 3,
                  name: 'Mei R.',
                  xp: '1,395 XP',
                  avatarAsset: DemoAvatars.mei,
                  color: AppColors.rankBronze,
                  isDark: isDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // User Standing Callout
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0E1626) : const Color(0xFFF1F5F9),
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
                    const CircleAvatar(
                      radius: 14,
                      backgroundImage: AssetImage(DemoAvatars.user),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Alman R. (YOU) · Current Rank: #4 · 1,240 XP',
                      style: AppTypography.ui(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Text(
                  '155 XP to reach #3 Podium',
                  style: AppTypography.ui(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.voltLime,
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
  // VIEW 4: DEDICATED PASSES & RATES VIEW
  // ============================================================
  static Widget buildDedicatedPassesView(
    BuildContext context,
    bool isDark, {
    required VoidCallback onWalkInTap,
    required VoidCallback onPassTap,
  }) {
    return Container(
      key: const ValueKey('passes_view'),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkObsidianCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Arena Passes & Membership Rates',
            style: AppTypography.ui(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Transparent 24/7 access at Level 2, 3 Damansara Mall. Scan DuitNow QR for instant optical turnstile unlock.',
            style: AppTypography.ui(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              children: [
                // Walk-in Pass
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0E1626) : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Walk-In Guest Pass', style: AppTypography.ui(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textSecondary)),
                        Text('RM17', style: AppTypography.ui(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                        Text('• Single session access\n• Free tournament DHS balls\n• AI match tracking', style: AppTypography.ui(fontSize: 12, color: AppColors.textSecondary, height: 1.6)),
                        ElevatedButton(
                          onPressed: onWalkInTap,
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.voltLime),
                          child: Text('Get Walk-In Pass →', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Monthly Unlimited
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF14243D) : const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.voltLime, width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Unlimited Member Pass', style: AppTypography.ui(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.voltLime)),
                            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppColors.voltLime, borderRadius: BorderRadius.circular(4)), child: const Text('BEST VALUE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.black))),
                          ],
                        ),
                        Text('90 sen / day', style: AppTypography.ui(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.voltLime)),
                        Text('• RM90 / month billing\n• Save RM16.10 every visit\n• 50% Happy Hour off\n• 24/7 unrestricted turnstile access', style: AppTypography.ui(fontSize: 12, color: AppColors.textPrimary, height: 1.6)),
                        ElevatedButton(
                          onPressed: onPassTap,
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.voltLime),
                          child: Text('Join Member Pass (RM90) →', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.black)),
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

  // ============================================================
  // VIEW 5: DEDICATED VENUE IOT TELEMETRY VIEW
  // ============================================================
  static Widget buildDedicatedIotView(BuildContext context, bool isDark) {
    return Container(
      key: const ValueKey('iot_view'),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkObsidianCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hardware Telemetry & Venue IoT Sensors',
            style: AppTypography.ui(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Live telemetry from 3 Damansara Mall Level 2 arena facility controllers.',
            style: AppTypography.ui(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildIotCard('Lighting Controller', '480 Lux ITTF', 'Philips Hue Pro', true, isDark),
                _buildIotCard('Climate Control', '23.0°C AC', 'Daikin VRV System', true, isDark),
                _buildIotCard('Edge AI Cameras', '10 of 10 Online', 'Overhead Tracking', true, isDark),
                _buildIotCard('Optical Turnstiles', 'Ready to Scan', 'DuitNow Fast Gate', true, isDark),
                _buildIotCard('Match Ball Status', 'DHS 3-Star 40+', 'Dispenser Full', true, isDark),
                _buildIotCard('WiFi Mesh Network', '5GHz Ultra-Low Latency', 'Arena Hotspot', true, isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MINI HELPERS
  // ============================================================
  static Widget _buildCourtMiniTile(String id, String player, String time, bool isFree, bool isDark, {bool isMatch = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0E1626) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isMatch ? AppColors.electricCrimson : (isDark ? AppColors.darkObsidianBorder : AppColors.slate200),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(id, style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isFree ? AppColors.voltLime : AppColors.electricCrimson,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            Text(player, style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: isFree ? AppColors.voltLime : AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
            Text(time, style: AppTypography.ui(fontSize: 8.5, color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }

  static Widget _buildPodiumPill({required int rank, required String name, required String xp, required String avatar, required Color color, required bool isDark, bool isChampion = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0E1626) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isChampion ? AppColors.radiantGold.withValues(alpha: 0.5) : (isDark ? AppColors.darkObsidianBorder : AppColors.slate200),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(radius: 12, backgroundImage: AssetImage(avatar)),
          const SizedBox(height: 4),
          Text(name, style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(xp, style: AppTypography.ui(fontSize: 8.5, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }

  static Widget _buildPodiumAthleteBig({required int rank, required String name, required String xp, required String avatarAsset, required Color color, required bool isDark, bool isChampion = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0E1626) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4), width: isChampion ? 2 : 1),
      ),
      child: Column(
        children: [
          CircleAvatar(radius: 24, backgroundImage: AssetImage(avatarAsset)),
          const SizedBox(height: 10),
          Text(name, style: AppTypography.ui(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(xp, style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
    );
  }

  static Widget _buildIotCard(String title, String val, String sub, bool isOnline, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0E1626) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? AppColors.darkObsidianBorder : AppColors.slate200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTypography.ui(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
              Container(width: 8, height: 8, decoration: BoxDecoration(color: isOnline ? AppColors.voltLime : AppColors.electricCrimson, shape: BoxShape.circle)),
            ],
          ),
          Text(val, style: AppTypography.ui(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.voltLime)),
          Text(sub, style: AppTypography.ui(fontSize: 11, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

// ============================================================
// CUSTOM PAINTER: OCCUPANCY DONUT METER
// ============================================================
class OccupancyDonutPainter extends CustomPainter {
  final int freeCount;
  final int totalCount;
  final bool isDark;

  OccupancyDonutPainter({required this.freeCount, required this.totalCount, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;
    const strokeWidth = 6.5;

    final trackPaint = Paint()
      ..color = isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, trackPaint);

    final sweepAngle = 2 * math.pi * (freeCount / totalCount);
    final valuePaint = Paint()
      ..color = AppColors.voltLime
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -math.pi / 2, sweepAngle, false, valuePaint);
  }

  @override
  bool shouldRepaint(covariant OccupancyDonutPainter oldDelegate) => oldDelegate.freeCount != freeCount || oldDelegate.isDark != isDark;
}

// ============================================================
// CUSTOM PAINTER: 24H HOURLY TRAFFIC SPARKLINE
// ============================================================
class HourlyTrafficSparklinePainter extends CustomPainter {
  final bool isDark;

  HourlyTrafficSparklinePainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
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

    final strokePaint = Paint()
      ..color = AppColors.ittfTableBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, strokePaint);

    final peakX = 6 * stepX;
    final peakY = size.height - (points[6] * size.height * 0.85);
    canvas.drawCircle(Offset(peakX, peakY), 3.5, Paint()..color = AppColors.voltLime);
  }

  @override
  bool shouldRepaint(covariant HourlyTrafficSparklinePainter oldDelegate) => oldDelegate.isDark != isDark;
}
