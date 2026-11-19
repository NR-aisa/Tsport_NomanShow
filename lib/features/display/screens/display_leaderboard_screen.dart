import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class DisplayLeaderboardScreen extends StatefulWidget {
  const DisplayLeaderboardScreen({super.key});

  @override
  State<DisplayLeaderboardScreen> createState() => _DisplayLeaderboardScreenState();
}

class _DisplayLeaderboardScreenState extends State<DisplayLeaderboardScreen> {
  int _tvMode = 0; // 0 = TV Leaderboard, 1 = TV Kombat VS Screen

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 650;

        return Scaffold(
          backgroundColor: const Color(0xFF070A0F),
          body: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF070A0F),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // ==========================================
                  // TOP TV HEADER BAR (Responsive & Back Button)
                  // ==========================================
                  _buildTopHeaderBar(context, isMobile),

                  // TV Mode Content (Responsive)
                  Expanded(
                    child: _tvMode == 0
                        ? _buildTvLeaderboard(isMobile)
                        : _buildTvKombatCard(isMobile),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopHeaderBar(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 28, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1524),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // Back Button
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: Colors.white),
              onPressed: () => Navigator.maybePop(context),
              tooltip: 'Back',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
            const SizedBox(width: 8),

            // Official Company Logo
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/company_logo.png',
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Venue Title
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'JOMNITTAKU · 3 DAMANSARA',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  '55" STADIUM BROADCAST FEED',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF60A5FA),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),

            // Mode Switcher Chips
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color(0xFF16233B),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  _buildTvModeChip(0, 'LEADERBOARD'),
                  const SizedBox(width: 3),
                  _buildTvModeChip(1, '1v1 KOMBAT VS'),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Live Broadcast Beacon
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0F261C),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.5)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'LIVE',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTvModeChip(int mode, String label) {
    final isSelected = _tvMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _tvMode = mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 9,
            fontWeight: FontWeight.w900,
            color: isSelected ? Colors.white : Colors.white60,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TV MODE 1: LEADERBOARD (RESPONSIVE)
  // ============================================================
  Widget _buildTvLeaderboard(bool isMobile) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 36,
        vertical: isMobile ? 14 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title & Metrics Header
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Leaderboard',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'THIS WEEK',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Colors.white54,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildTvMetricBadge('Leader\'s Points', '1,620 XP', AppColors.radiantGold),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildTvMetricBadge('Matches Live', '2 Active', const Color(0xFF10B981)),
                    ),
                  ],
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'Leaderboard',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'THIS BRANCH · THIS WEEK',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Colors.white.withValues(alpha: 0.5),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildTvMetricBadge('Leader\'s points', '1,620 XP', AppColors.radiantGold),
                    const SizedBox(width: 12),
                    _buildTvMetricBadge('Matches live', '2 live', const Color(0xFF10B981)),
                  ],
                ),
              ],
            ),

          const SizedBox(height: 16),

          // 7 Leaderboard Rows
          _buildTvRow('1', 'Daniel L.', '1,620', '#1', 'Steady', '1,620', isMobile, rankColor: AppColors.radiantGold, crown: '👑'),
          _buildTvRow('2', 'Sara K.', '1,480', '#2', 'Steady', '1,480', isMobile, rankColor: const Color(0xFFD4DAE3)),
          _buildTvRow('3', 'Mei R.', '1,395', '#3', 'Steady', '1,395', isMobile, rankColor: const Color(0xFFD99B6A)),
          _buildTvRow('4', 'Aiman R.', '1,240', '#4', '▲ +40 this week', '1,240', isMobile, subName: '155 XP to #3', isUser: true, rankColor: const Color(0xFF38BDF8)),
          _buildTvRow('5', 'Jason T.', '1,180', '#5', '▼ -25 this week', '1,180', isMobile),
          _buildTvRow('6', 'Nurul P.', '1,050', '#6', '▲ +15 this week', '1,050', isMobile),
          _buildTvRow('7', 'Anonymous', '990', '#7', 'Steady', '990', isMobile, isAnonymous: true, subName: 'Photo & name hidden'),
        ],
      ),
    );
  }

  Widget _buildTvRow(
    String rank,
    String name,
    String points,
    String rankLabel,
    String form,
    String total,
    bool isMobile, {
    String? subName,
    bool isUser = false,
    bool isAnonymous = false,
    Color rankColor = Colors.white,
    String? crown,
  }) {
    if (isMobile) {
      // Mobile-Optimized Compact Card (Zero Horizontal Overflow)
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isUser
                ? [const Color(0xFF14293D), const Color(0xFF0F1E2E)]
                : [const Color(0xFF162544), const Color(0xFF0F1A2E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isUser ? const Color(0xFF38BDF8) : Colors.white.withValues(alpha: 0.12),
            width: isUser ? 1.8 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Line: Rank, Avatar, Name & subname, and Total XP
            Row(
              children: [
                SizedBox(
                  width: 26,
                  child: Row(
                    children: [
                      Text(
                        rank,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: rankColor,
                        ),
                      ),
                      if (crown != null)
                        Text(crown, style: const TextStyle(fontSize: 9)),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: rankColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: rankColor.withValues(alpha: 0.5), width: 1.2),
                  ),
                  child: Icon(
                    isAnonymous ? Icons.person_rounded : Icons.sports_tennis_rounded,
                    size: 16,
                    color: rankColor,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          if (isUser) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                color: const Color(0xFF38BDF8),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'YOU',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF070A0F),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (subName != null)
                        Text(
                          subName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$total XP',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: rankColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Bottom Line: 3 Compact Telemetry Pills (Points, Rank, Form)
            Row(
              children: [
                Expanded(child: _buildCompactPill('Points', points, const Color(0xFF10B981))),
                const SizedBox(width: 6),
                Expanded(child: _buildCompactPill('Rank', rankLabel, AppColors.radiantGold)),
                const SizedBox(width: 6),
                Expanded(child: _buildCompactPill('Form', form, isUser ? const Color(0xFF38BDF8) : Colors.white70)),
              ],
            ),
          ],
        ),
      );
    }

    // Widescreen 55" TV Row (>= 650px wide)
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isUser
              ? [const Color(0xFF132D42), const Color(0xFF0F1E2E)]
              : [const Color(0xFF162544), const Color(0xFF0F1A2E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isUser ? const Color(0xFF38BDF8) : Colors.white.withValues(alpha: 0.10),
          width: isUser ? 1.8 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Row(
              children: [
                Text(
                  rank,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: rankColor,
                  ),
                ),
                if (crown != null)
                  Text(crown, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: rankColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: rankColor.withValues(alpha: 0.5), width: 1.5),
            ),
            child: Icon(
              isAnonymous ? Icons.person_rounded : Icons.sports_tennis_rounded,
              size: 20,
              color: rankColor,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (isUser) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: const Color(0xFF38BDF8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'YOU',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF070A0F),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (subName != null)
                  Text(
                    subName,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
              ],
            ),
          ),
          const Spacer(),
          _buildTvPill('Points', points, const Color(0xFF10B981)),
          const SizedBox(width: 10),
          _buildTvPill('Rank', rankLabel, AppColors.radiantGold),
          const SizedBox(width: 10),
          _buildTvPill('Form', form, isUser ? const Color(0xFF38BDF8) : Colors.white70),
          const Spacer(),
          Text(
            '$total XP',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1E283C),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: Text(
              'Details →',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TV MODE 2: MORTAL KOMBAT MATCH CARD (RESPONSIVE)
  // ============================================================
  Widget _buildTvKombatCard(bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 36,
        vertical: isMobile ? 12 : 20,
      ),
      child: Column(
        children: [
          // Match Spotlight Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16233B),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF38BDF8).withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.table_restaurant_rounded, size: 14, color: Color(0xFF38BDF8)),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'TABLE NO. 4 · MATCH SPOTLIGHT',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E1018),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.5)),
                ),
                child: Text(
                  'POT 200 XP',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFEF4444),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),

          // 1v1 Arena Split (Responsive: Stack on Mobile, Row on TV)
          if (isMobile)
            Column(
              children: [
                _buildPlayerBattleCard(
                  title: 'YOU · CONTENDER',
                  name: 'AIMAN R.',
                  xp: '1,240 XP',
                  rank: 'RANK #4 · STREAK 3W',
                  color: const Color(0xFF38BDF8),
                  bgGradient: [const Color(0xFF0F2636), const Color(0xFF08141D)],
                  isCompact: true,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E283C),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Text(
                        'VS · 04:59 REMAINING',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF10B981),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildPlayerBattleCard(
                  title: 'CHALLENGER',
                  name: 'JASON T.',
                  xp: '1,180 XP',
                  rank: 'RANK #5 · STREAK 4W',
                  color: const Color(0xFFEF4444),
                  bgGradient: [const Color(0xFF320F1C), const Color(0xFF1A070E)],
                  isCompact: true,
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _buildPlayerBattleCard(
                    title: 'YOU · CONTENDER',
                    name: 'AIMAN R.',
                    xp: '1,240 XP',
                    rank: 'LEAGUE RANK #4 · WIN STREAK 3W',
                    color: const Color(0xFF38BDF8),
                    bgGradient: [const Color(0xFF0F2636), const Color(0xFF08141D)],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF38BDF8), Color(0xFFEF4444)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'VS',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '04:59',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildPlayerBattleCard(
                    title: 'CHALLENGER',
                    name: 'JASON T.',
                    xp: '1,180 XP',
                    rank: 'LEAGUE RANK #5 · WIN STREAK 4W',
                    color: const Color(0xFFEF4444),
                    bgGradient: [const Color(0xFF320F1C), const Color(0xFF1A070E)],
                  ),
                ),
              ],
            ),

          const Spacer(),

          // Bottom Broadcast Ticker
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0F1B2B), Color(0xFF18283E)],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF38BDF8).withValues(alpha: 0.4),
                width: 1.2,
              ),
            ),
            child: Center(
              child: Text(
                '⚡ COME TO TABLE NO. 4 — WINNER TAKES 200 XP ⚡',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: isMobile ? 12 : 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildPlayerBattleCard({
    required String title,
    required String name,
    required String xp,
    required String rank,
    required Color color,
    required List<Color> bgGradient,
    bool isCompact = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isCompact ? 16 : 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: bgGradient),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color, width: 1.8),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: isCompact ? 6 : 12),
          Text(
            name,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isCompact ? 24 : 34,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            xp,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isCompact ? 18 : 24,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          Text(
            rank,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactPill(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1A2E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(fontSize: 8, color: Colors.white54),
          ),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w800, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildTvPill(String label, String value, Color color) {
    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF141C2C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 8,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTvMetricBadge(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF16233B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 8,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
