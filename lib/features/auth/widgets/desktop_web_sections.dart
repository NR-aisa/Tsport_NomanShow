import 'package:flutter/material.dart';

import '../../../core/navigation/app_navigator.dart';
import '../../../core/session/app_session.dart';
import '../../../core/session/demo_avatars.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../display/screens/display_leaderboard_screen.dart';

/// Elite Commercial Desktop Web Sections for JOMNITTAKU:
///  - Section 1: Athletic Widescreen "JUST PLAY TONIGHT" Hero Stage & 3D Court Visualizer
///  - Section 2: "How No Man Show Works" (The 4-Step Unmanned Autonomous Experience)
///  - Section 3: Live 10-Court Architectural Floorplan & Venue Telemetry (2x5 Grid)
///  - Section 4: Transparent Membership & Passes Matrix (3 Columns, Zero Collision)
///  - Section 5: Live Arena Leaderboard Showcase & Top-3 Olympic Podium
///  - Section 6: Venue Specifications, Amenities & IoT Hardware Telemetry
///  - Section 7: Professional Corporate Website Footer
class DesktopWebSections {
  DesktopWebSections._();

  // ============================================================
  // SECTION 1: ATHLETIC WIDESCREEN HERO STAGE & 3D COURT
  // ============================================================
  static Widget buildHeroJustPlaySection(
    BuildContext context,
    bool isDark, {
    required VoidCallback onWalkInTap,
    required VoidCallback onPassTap,
    required VoidCallback onTvTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ----------------------------------------------------
          // LEFT: BRAND HERO & ATHLETIC CTAS (Flex 58)
          // ----------------------------------------------------
          Expanded(
            flex: 58,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Tag: Venue Arena & Live Status
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
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.voltLime.withValues(alpha: 0.15) : AppColors.lightCanvasBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isDark ? AppColors.voltLime.withValues(alpha: 0.35) : AppColors.slate300,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '6 OF 10 FREE',
                        style: AppTypography.ui(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: isDark ? AppColors.voltLime : AppColors.btnGreenBorder,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Brand Headline with Circular Crest
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.ittfTableBorder.withValues(alpha: 0.6),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.ittfTableSurface.withValues(alpha: 0.25),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/company_logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AUTONOMOUS 24/7',
                          style: AppTypography.ui(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textPrimary,
                            letterSpacing: -0.5,
                            height: 1.05,
                          ),
                        ),
                        Text(
                          'TABLE TENNIS ARENA',
                          style: AppTypography.ui(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: isDark ? AppColors.voltLime : AppColors.ittfTableSurface,
                            letterSpacing: -0.5,
                            height: 1.05,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Subtitle
                Text(
                  'Malaysia’s premier autonomous, 24/7 AI-tracked table tennis arena. Walk in anytime, scan your digital pass at the turnstile, and challenge live rivals on 10 ITTF tournament courts.',
                  style: AppTypography.ui(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 22),

                // Action Buttons Row (Side-by-side, NOT stretched)
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Primary CTA
                    TactileButton.volt(
                      text: 'Walk In & Play Tonight (RM17) →',
                      isFullWidth: false,
                      height: 48,
                      onPressed: onWalkInTap,
                    ),

                    // Door Pass Button
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onPassTap,
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF162032) : AppColors.lightCanvasBg,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.ittfTableBorder.withValues(alpha: 0.6),
                              width: 1.2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.qr_code_scanner_rounded, size: 16, color: AppColors.ittfTableBorder),
                              const SizedBox(width: 8),
                              Text(
                                'Door Pass (KX8VQS)',
                                style: AppTypography.ui(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? Colors.white : AppColors.ittfTableBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 55" TV Feed Button
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onTvTap,
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E3A8A).withValues(alpha: 0.3) : const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.ittfTableBorder.withValues(alpha: 0.5),
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.tv_rounded, size: 16, color: AppColors.ittfTableBorder),
                              const SizedBox(width: 6),
                              Text(
                                '55" Stadium TV',
                                style: AppTypography.ui(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? Colors.white : AppColors.ittfTableBorder,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Live Status Capsule
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black.withValues(alpha: 0.3) : AppColors.lightCanvasDeep,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDark ? Colors.white.withValues(alpha: 0.08) : AppColors.slate200,
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
                      const SizedBox(width: 8),
                      Text(
                        'LIVE • 2 matches active · 6 tables free · AI Scoring Online 🟢',
                        style: AppTypography.ui(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 32),

          // ----------------------------------------------------
          // RIGHT: PROPORTIONAL 3D TABLE TENNIS COURT STAGE (Flex 42)
          // ----------------------------------------------------
          Expanded(
            flex: 42,
            child: _buildProportional3dCourtStage(context, isDark),
          ),
        ],
      ),
    );
  }

  static Widget _buildProportional3dCourtStage(BuildContext context, bool isDark) {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF142036), const Color(0xFF0C1422)]
              : [const Color(0xFFE2E8F0), const Color(0xFFF1F5F9)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.ittfTableBorder.withValues(alpha: 0.4) : AppColors.slate300,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top HUD Strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.black.withValues(alpha: 0.25) : Colors.white.withValues(alpha: 0.8),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
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
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.paddleRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      'TABLE 04 · LIVE MATCH HUD',
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
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

          // Center Table Tennis Court Canvas
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Table Top Perspective (Championship Blue)
                  Container(
                    width: double.infinity,
                    height: 125,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF1E40AF)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Center White Divider Line
                        Container(width: 1.5, color: Colors.white.withValues(alpha: 0.8)),

                        // Center Mesh Net
                        Container(
                          height: 5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),

                        // Ping Pong Ball
                        Positioned(
                          left: 80,
                          top: 34,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: AppColors.pingPongOrange,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.pingPongOrange.withValues(alpha: 0.8),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Player 1 Badge (Left - Jason T.)
                  Positioned(
                    left: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A).withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white24, width: 0.8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipOval(
                            child: Image.asset(DemoAvatars.jason, width: 18, height: 18, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Jason (14)',
                            style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Player 2 Badge (Right - Alman R. / YOU)
                  Positioned(
                    right: 6,
                    bottom: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A).withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.voltLime.withValues(alpha: 0.6), width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipOval(
                            child: Image.asset(AppSession.avatarAsset, width: 18, height: 18, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Alman (11)',
                            style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.voltLime),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Court Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? Colors.black.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(13)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '● DHS 3-Star Match Ball · Active Rally: 9 hits',
                  style: AppTypography.ui(fontSize: 10, color: AppColors.textSecondary),
                ),
                Text(
                  'Lighting: 480 Lux ITTF · AI Edge Camera Online 🟢',
                  style: AppTypography.ui(fontSize: 10, color: AppColors.voltLime),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 2: HOW NO MAN SHOW WORKS (4-STEP UNMANNED FLOW)
  // ============================================================
  static Widget buildHowItWorksSection(BuildContext context, bool isDark) {
    final steps = [
      {
        'step': '01',
        'title': 'Buy Pass Online',
        'badge': 'INSTANT DUITNOW QR',
        'badgeColor': AppColors.voltLime,
        'icon': Icons.qr_code_2_rounded,
        'description':
            'Purchase a RM17 Walk-In Pass or join as an Unlimited Member (RM90/mo · ~90 sen/day) via DuitNow QR or Card on your phone.',
      },
      {
        'step': '02',
        'title': 'Scan Turnstile Gate',
        'badge': '24/7 OPTICAL GATE',
        'badgeColor': AppColors.ittfTableBorder,
        'icon': Icons.sensor_door_rounded,
        'description':
            'Hold your dynamic encrypted QR code to the entrance optical reader. High-speed turnstiles unlock in under 0.3s.',
      },
      {
        'step': '03',
        'title': 'Smart Court Lighting',
        'badge': '500 LUX ITTF SPEC',
        'badgeColor': AppColors.radiantGold,
        'icon': Icons.lightbulb_rounded,
        'description':
            'Step onto your assigned court. Philips Hue automated lighting illuminates to 500 Lux ITTF tournament standard.',
      },
      {
        'step': '04',
        'title': 'AI Overhead Tracking',
        'badge': 'AUTO SCORE BROADCAST',
        'badgeColor': AppColors.pingPongOrange,
        'icon': Icons.videocam_rounded,
        'description':
            'Play uninterrupted. Overhead computer vision cameras track ball hits, rallies, and auto-sync live match scores to the 55" Stadium TV.',
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header Tag
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
                const Icon(Icons.auto_awesome_rounded, size: 13, color: AppColors.voltLime),
                const SizedBox(width: 5),
                Text(
                  'THE NO MAN SHOW CONCEPT · 100% UNMANNED',
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
            'How Autonomous Table Tennis Works',
            style: AppTypography.ui(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Zero front-desk queues. Zero manual booking delays. Arrive anytime, tap your phone, and play under tournament conditions.',
            style: AppTypography.ui(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 24),

          // 4-Card Horizontal Flow
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: steps.map((s) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.obsidianCard : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate200,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                          blurRadius: 14,
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
                              s['step'] as String,
                              style: AppTypography.ui(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: isDark ? Colors.white38 : AppColors.slate400,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: (s['badgeColor'] as Color).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                s['icon'] as IconData,
                                size: 20,
                                color: s['badgeColor'] as Color,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: (s['badgeColor'] as Color).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            s['badge'] as String,
                            style: AppTypography.ui(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w900,
                              color: s['badgeColor'] as Color,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          s['title'] as String,
                          style: AppTypography.ui(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          s['description'] as String,
                          style: AppTypography.ui(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 3: LIVE 10-COURT ARCHITECTURAL FLOORPLAN
  // ============================================================
  static Widget buildTenTableFloorplan(BuildContext context, bool isDark) {
    final tables = [
      {'id': '01', 'player': 'Alman R. vs Jason', 'lux': '480 Lux', 'isFree': false, 'time': '18m', 'status': 'Match in Progress'},
      {'id': '02', 'player': 'Sara K. vs Nurul', 'lux': '500 Lux', 'isFree': false, 'time': '24m', 'status': 'Match in Progress'},
      {'id': '03', 'player': 'Ready to Play', 'lux': '500 Lux', 'isFree': true, 'time': 'Ready', 'status': 'Available'},
      {'id': '04', 'player': 'Tournament T4', 'lux': '480 Lux', 'isFree': false, 'time': '12m', 'status': 'Match in Progress'},
      {'id': '05', 'player': 'Ready to Play', 'lux': '500 Lux', 'isFree': true, 'time': 'Ready', 'status': 'Available'},
      {'id': '06', 'player': 'Ready to Play', 'lux': '500 Lux', 'isFree': true, 'time': 'Ready', 'status': 'Available'},
      {'id': '07', 'player': 'Daniel L. vs Mel', 'lux': '500 Lux', 'isFree': false, 'time': '32m', 'status': 'Match in Progress'},
      {'id': '08', 'player': 'Ready to Play', 'lux': '500 Lux', 'isFree': true, 'time': 'Ready', 'status': 'Available'},
      {'id': '09', 'player': 'Ready to Play', 'lux': '500 Lux', 'isFree': true, 'time': 'Ready', 'status': 'Available'},
      {'id': '10', 'player': 'Ready to Play', 'lux': '500 Lux', 'isFree': true, 'time': 'Ready', 'status': 'Available'},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header Tag & Live Stats
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
                        const Icon(Icons.grid_view_rounded, size: 13, color: AppColors.ittfTableBorder),
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
                  const SizedBox(height: 10),
                  Text(
                    'Live Venue Radar & Architectural Floorplan',
                    style: AppTypography.ui(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
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

          const SizedBox(height: 24),

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
              const SizedBox(height: 12),
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

          const SizedBox(height: 16),

          // Telemetry Status Strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F172A) : AppColors.slate100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate200,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.ac_unit_rounded, size: 14, color: AppColors.ittfTableBorder),
                    const SizedBox(width: 6),
                    Text(
                      'HVAC Climate: 22.4°C · Humidity: 52% RH',
                      style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, size: 14, color: AppColors.voltLime),
                    const SizedBox(width: 6),
                    Text(
                      'Enlio Competition Rubber Flooring · 10 Tables Sanctioned',
                      style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.voltLime),
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

  static Widget _buildTableRadarCard(BuildContext context, Map<String, dynamic> t, bool isDark) {
    final bool isFree = t['isFree'] as bool;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => AppNavigator.toTables(context),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.obsidianCard : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isFree
                  ? AppColors.voltLime.withValues(alpha: 0.35)
                  : AppColors.paddleRed.withValues(alpha: 0.35),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: isFree
                    ? AppColors.voltLime.withValues(alpha: 0.08)
                    : AppColors.paddleRed.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 3),
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
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: isFree ? AppColors.voltLime : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t['lux'] as String,
                    style: AppTypography.ui(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: isFree
                          ? AppColors.voltLime.withValues(alpha: 0.15)
                          : AppColors.paddleRed.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isFree ? 'AVAILABLE' : (t['time'] as String),
                      style: AppTypography.ui(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: isFree ? AppColors.voltLime : AppColors.paddleRed,
                      ),
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
  // SECTION 4: MEMBERSHIP TIERS & PASS COMPARISON MATRIX
  // ============================================================
  static Widget buildPricingSection(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header Tag
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
                  period: 'per single visit',
                  description: 'Perfect for tonight’s session. Instant entry via digital door QR.',
                  features: const [
                    'Instant turnstile QR access',
                    'Access to all 10 ITTF tables',
                    'Computer vision scoreboard tracking',
                    'Free DHS 3-star match balls',
                  ],
                  missingFeatures: const [
                    'Free equipment rental',
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
                  period: 'per month (~90 sen / day)',
                  description: 'Save RM16.10 every single visit! Unmanned 24/7 access for regular rivals.',
                  features: const [
                    'Unlimited 24/7 autonomous entry',
                    'FREE DHS paddle & ball rentals',
                    '50% Happy Hour table discount (50 sen/hr)',
                    'Official PJ Arena League entry',
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
                  period: 'per year (Save RM230)',
                  description: 'For dedicated tournament contenders and serious club competitors.',
                  features: const [
                    'All Monthly Unlimited benefits',
                    'Personalized smart locker at 3 Damansara',
                    'Official JOMNITTAKU match jersey',
                    'Free entry to monthly cash tournaments',
                    '5 complimentary guest passes/month',
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
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  period,
                  style: AppTypography.ui(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
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

          const SizedBox(height: 16),
          Divider(color: isDark ? Colors.white12 : AppColors.slate200, height: 1),
          const SizedBox(height: 16),

          // Included Features
          ...features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_rounded, size: 15, color: AppColors.voltLime),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        f,
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

          // Missing Features
          ...missingFeatures.map((mf) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.remove_circle_outline_rounded,
                        size: 15, color: isDark ? Colors.white30 : AppColors.slate400),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        mf,
                        style: AppTypography.ui(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white38 : AppColors.slate400,
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          const SizedBox(height: 16),

          // CTA Button
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(
                  color: isFeatured
                      ? AppColors.voltLime
                      : (isDark ? AppColors.darkObsidianCardLight : AppColors.slate100),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isFeatured
                        ? AppColors.voltLime
                        : (isDark ? AppColors.border : AppColors.slate300),
                    width: 1,
                  ),
                  boxShadow: isFeatured
                      ? [
                          BoxShadow(
                            color: AppColors.voltLime.withValues(alpha: 0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          )
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  buttonText,
                  style: AppTypography.ui(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: isFeatured ? Colors.black : AppColors.textPrimary,
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
  // SECTION 5: LIVE LEADERBOARD SHOWCASE & PODIUM
  // ============================================================
  static Widget buildLeaderboardShowcase(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header Tag & TV Stream Button
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
                        tag: '🔥 7W Streak',
                        avatarAsset: DemoAvatars.daniel,
                        avatarSize: 80,
                        ringColor: AppColors.radiantGold,
                        medallion: '👑',
                        pedestalHeight: 145,
                        pedestalGradient: [
                          const Color(0xFF854D0E),
                          const Color(0xFF451A03),
                        ],
                        pedestalBorderColor: AppColors.radiantGold,
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
                        tag: '⚔️ 2W Streak',
                        avatarAsset: DemoAvatars.mei,
                        avatarSize: 64,
                        ringColor: const Color(0xFFCD7F32),
                        medallion: '🥉',
                        pedestalHeight: 90,
                        pedestalGradient: [
                          isDark ? const Color(0xFF271A0C) : const Color(0xFFFED7AA),
                          isDark ? const Color(0xFF140D06) : const Color(0xFFFDBA74),
                        ],
                        pedestalBorderColor: const Color(0xFFCD7F32),
                        isCenter: false,
                        isDark: isDark,
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
  // SECTION 6: VENUE LOCATION, AMENITIES & IOT TELEMETRY
  // ============================================================
  static Widget buildLocationAmenitiesSection(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header Tag
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
                const Icon(Icons.place_rounded, size: 13, color: AppColors.ittfTableBorder),
                const SizedBox(width: 5),
                Text(
                  '3 DAMANSARA LEVEL 2 · 24/7 AUTONOMOUS ARENA',
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
            'Venue Specifications, Amenities & Location',
            style: AppTypography.ui(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Level 2, 3 Damansara Mall, Jalan SS 20/27, Petaling Jaya · Open 24 Hours / 7 Days a Week, 365 Days a Year.',
            style: AppTypography.ui(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 24),

          // 3 Venue Specification Cards
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card 1: Location & Access
              Expanded(
                child: _buildAmenityCard(
                  isDark: isDark,
                  icon: Icons.map_rounded,
                  iconColor: AppColors.pingPongOrange,
                  title: 'Prime PJ Location & Parking',
                  subtitle: 'Level 2, 3 Damansara Mall',
                  description:
                      'Direct elevator access from Zone B basement parking. Dedicated Grab drop-off at Main Entrance. 10 minutes from TTDI, Damansara Uptown & SS2.',
                ),
              ),
              const SizedBox(width: 16),

              // Card 2: 24/7 Autonomous Entry
              Expanded(
                child: _buildAmenityCard(
                  isDark: isDark,
                  icon: Icons.lock_clock_rounded,
                  iconColor: AppColors.voltLime,
                  title: '24/7/365 Unmanned Access',
                  subtitle: 'Play at 2 AM or Mid-day',
                  description:
                      'Complete freedom without reception queues. Optical turnstiles unlock in 0.3s with your dynamic encrypted QR code on your mobile phone.',
                ),
              ),
              const SizedBox(width: 16),

              // Card 3: Premium Facilities
              Expanded(
                child: _buildAmenityCard(
                  isDark: isDark,
                  icon: Icons.shower_rounded,
                  iconColor: AppColors.ittfTableBorder,
                  title: 'Central Aircon & Hot Showers',
                  subtitle: 'Climate Controlled at 22.4°C',
                  description:
                      'Commercial central air conditioning, hot water private showers, changing rooms, digital lockers, and automated DHS tournament ball dispensers.',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 4 Hardware IoT Telemetry Tiles
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
                  description: 'Automated motion sensors illuminate court zones when players step onto the floor.',
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
                  status: 'Speed Gates Online',
                  statusColor: AppColors.voltLime,
                  description: 'Cloud access controller syncs dynamic pass credentials to optical barriers.',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildIotTile(
                  isDark: isDark,
                  icon: Icons.thermostat_rounded,
                  iconColor: AppColors.pingPongOrange,
                  title: 'Indoor Climate & RH',
                  metric: '22.4°C · 52% RH',
                  status: 'Chilled Air Active',
                  statusColor: AppColors.voltLime,
                  description: 'Commercial central HVAC keeps playing courts cool and prevents rubber paddle moisture.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Alias for backward compatibility
  static Widget buildIotSection(BuildContext context, bool isDark) =>
      buildLocationAmenitiesSection(context, isDark);

  static Widget _buildAmenityCard({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.obsidianCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 22, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.ui(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTypography.ui(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: iconColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: AppTypography.ui(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              height: 1.45,
            ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.obsidianCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.darkObsidianCardLight : AppColors.slate200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 18, color: iconColor),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: AppTypography.ui(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            metric,
            style: AppTypography.ui(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: AppTypography.ui(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.ui(
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 7: PROFESSIONAL CORPORATE WEBSITE FOOTER
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
          constraints: const BoxConstraints(maxWidth: 1380),
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
                              width: 36,
                              height: 36,
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
                        _buildFooterLink('Arena Overview', () => AppNavigator.toHomeAndClear(context)),
                        _buildFooterLink('10 Courts Floorplan', () => AppNavigator.toTables(context)),
                        _buildFooterLink('Weekly Leaderboard', () => AppNavigator.toLeaderboard(context)),
                        _buildFooterLink('Rates & Passes', () => AppNavigator.toPlan(context)),
                        _buildFooterLink('55" Stadium TV Feed', () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const DisplayLeaderboardScreen()),
                          );
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(width: 24),

                  // Col 3: Memberships
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MEMBERSHIPS',
                          style: AppTypography.ui(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _buildFooterLink('Walk-In Pass (RM17)', () => AppNavigator.toPlan(context)),
                        _buildFooterLink('Monthly Unlimited (RM90)', () => AppNavigator.toPlan(context)),
                        _buildFooterLink('Elite VIP Annual', () => AppNavigator.toPlan(context)),
                        _buildFooterLink('Digital Door Pass', () => AppNavigator.toPass(context)),
                      ],
                    ),
                  ),

                  const SizedBox(width: 24),

                  // Col 4: Legal & Standards
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LEGAL & SAFETY',
                          style: AppTypography.ui(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _buildFooterLink('Venue Safety Rules', null),
                        _buildFooterLink('PDPA Privacy Notice', null),
                        _buildFooterLink('Terms of Service', null),
                        _buildFooterLink('ITTF Standard Spec', null),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),
              Divider(color: isDark ? Colors.white12 : AppColors.slate300, height: 1),
              const SizedBox(height: 20),

              // Bottom Credits & Copyright
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© 2026 JOMNITTAKU Sdn Bhd. All rights reserved.',
                    style: AppTypography.ui(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.voltLime,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '100% Autonomous 24/7 Facility · 3 Damansara Level 2',
                        style: AppTypography.ui(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.voltLime,
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
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
