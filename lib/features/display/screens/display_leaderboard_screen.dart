import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/session/demo_avatars.dart';
import '../../../core/session/app_session.dart';
import '../../../core/navigation/app_navigator.dart';

class DisplayLeaderboardScreen extends StatefulWidget {
  const DisplayLeaderboardScreen({super.key});

  @override
  State<DisplayLeaderboardScreen> createState() => _DisplayLeaderboardScreenState();
}

class _DisplayLeaderboardScreenState extends State<DisplayLeaderboardScreen> {
  int _tvMode = 0; // 0 = TV Leaderboard, 1 = TV Kombat VS Screen
  int _timeFilter = 0; // 0 = This Week, 1 = All Time

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 650;

        return Scaffold(
          backgroundColor: AppColors.darkObsidianBase,
          body: Container(
            decoration: const BoxDecoration(
              color: AppColors.darkObsidianBase,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // ==========================================
                  // TOP TV HEADER BAR (Broadcast & Branding)
                  // ==========================================
                  _buildTopHeaderBar(context, isMobile),

                  // TV Mode Content (Responsive)
                  Expanded(
                    child: _tvMode == 0
                        ? _buildTvLeaderboard(context, isMobile)
                        : _buildTvKombatCard(context, isMobile),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // TOP BROADCAST HEADER BAR
  // ============================================================
  Widget _buildTopHeaderBar(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 28, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.slate900,
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
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.darkObsidianCard,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),

          // Official Venue Logo
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

          // Venue & Feed Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'JOMNITTAKU · 3 DAMANSARA',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.ui(
                    fontSize: isMobile ? 11 : 13,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.4,
                  ),
                ),
                Text(
                  '55" STADIUM BROADCAST FEED',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.ui(
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ittfTableBorder,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Mode Switcher Chips (LEADERBOARD vs 1v1 KOMBAT)
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.darkObsidianCard,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTvModeChip(0, 'LEADERBOARD'),
                _buildTvModeChip(1, '1v1 VS'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTvModeChip(int mode, String label) {
    final isSelected = _tvMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _tvMode = mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.ittfTableSurface : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: AppTypography.ui(
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
  // TV MODE 1: RICH BROADCAST LEADERBOARD
  // ============================================================
  Widget _buildTvLeaderboard(BuildContext context, bool isMobile) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 36,
        vertical: isMobile ? 12 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Title & Live Broadcast Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Leaderboard',
                        style: AppTypography.ui(
                          fontSize: isMobile ? 22 : 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Live broadcast badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: AppColors.voltLime.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.voltLime.withValues(alpha: 0.4)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: AppColors.voltLime,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'LIVE',
                              style: AppTypography.ui(
                                fontSize: 8.5,
                                fontWeight: FontWeight.w900,
                                color: AppColors.voltLime,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'DAMANSARA ARENA · WEEK 47',
                    style: AppTypography.ui(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.white.withValues(alpha: 0.5),
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),

              // Filter Switcher: This Week vs All Time
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.darkObsidianCard,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                ),
                child: Row(
                  children: [
                    _buildTimeFilterChip(0, 'This week'),
                    _buildTimeFilterChip(1, 'All time'),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ========================================================
          // HERO: TOP 3 CHAMPIONS PODIUM (THE RICH SPORTS EXPERIENCE)
          // ========================================================
          _buildTop3Podium(context, isMobile),

          const SizedBox(height: 20),

          // Section Title: League Contenders Roster
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LEAGUE ROSTER',
                style: AppTypography.ui(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withValues(alpha: 0.7),
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                'RANKS 4 - 8 · TAP TO CHALLENGE',
                style: AppTypography.ui(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withValues(alpha: 0.4),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // ========================================================
          // STREAMLINED BROADCAST ROSTER (NO BOXCEPTION!)
          // ========================================================
          // #4 Aiman R. (THE CURRENT USER - PROMINENT HIGHLIGHT)
          _buildRosterRow(
            context: context,
            rank: '4',
            name: 'Aiman Rahman',
            xp: '1,240',
            avatarAsset: AppSession.avatarAsset,
            form: '▲ +40 this week',
            formColor: AppColors.voltLime,
            isUser: true,
            subName: '155 XP to #3 Podium',
            isMobile: isMobile,
          ),

          // #5 Jason T.
          _buildRosterRow(
            context: context,
            rank: '5',
            name: 'Jason Tan',
            xp: '1,180',
            avatarAsset: DemoAvatars.jason,
            form: '▼ -25 this week',
            formColor: AppColors.electricCrimson.withValues(alpha: 0.85),
            isMobile: isMobile,
          ),

          // #6 Nurul P.
          _buildRosterRow(
            context: context,
            rank: '6',
            name: 'Nurul Puteri',
            xp: '1,050',
            avatarAsset: DemoAvatars.nurul,
            form: '▲ +15 this week',
            formColor: AppColors.voltLime,
            isMobile: isMobile,
          ),

          // #7 Anonymous
          _buildRosterRow(
            context: context,
            rank: '7',
            name: 'Anonymous Player',
            xp: '990',
            isAnonymous: true,
            form: 'Steady',
            formColor: Colors.white54,
            subName: 'Photo & identity hidden',
            isMobile: isMobile,
          ),

          // #8 Rajan K.
          _buildRosterRow(
            context: context,
            rank: '8',
            name: 'Rajan Kumar',
            xp: '920',
            avatarAsset: DemoAvatars.rajan,
            form: '🔥 3W streak',
            formColor: AppColors.radiantGold,
            isMobile: isMobile,
          ),

          const SizedBox(height: 14),

          // Bottom Quick Broadcast Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.darkObsidianCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.bolt_rounded, size: 14, color: AppColors.radiantGold),
                const SizedBox(width: 6),
                Text(
                  'Top 3 enter Damascus Arena Tournament · Resets Sunday 23:59',
                  style: AppTypography.ui(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTimeFilterChip(int index, String label) {
    final isSelected = _timeFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _timeFilter = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.ittfTableSurface : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: AppTypography.ui(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: isSelected ? Colors.white : Colors.white60,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TOP 3 PODIUM (BROADCAST HERO COMPONENT)
  // ============================================================
  Widget _buildTop3Podium(BuildContext context, bool isMobile) {
    final avatar1Size = isMobile ? 54.0 : 70.0;
    final avatar2Size = isMobile ? 44.0 : 58.0;
    final avatar3Size = isMobile ? 42.0 : 54.0;

    final ped1Height = isMobile ? 80.0 : 108.0;
    final ped2Height = isMobile ? 56.0 : 78.0;
    final ped3Height = isMobile ? 44.0 : 62.0;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 24,
        vertical: isMobile ? 14 : 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.slate900.withValues(alpha: 0.95),
            AppColors.darkObsidianCard,
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Podium Players Layout (2 - 1 - 3)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // ----------------------------------------------------
              // #2 SILVER: SARA K.
              // ----------------------------------------------------
              Expanded(
                child: _buildPodiumAthlete(
                  context: context,
                  rank: '2',
                  name: 'Sara K.',
                  xp: '1,480 XP',
                  tag: '⚡ 4W Streak',
                  avatarAsset: DemoAvatars.sara,
                  avatarSize: avatar2Size,
                  ringColor: AppColors.slate300,
                  medallionIcon: '🥈',
                  pedestalHeight: ped2Height,
                  pedestalGradient: const [Color(0xFF1E293B), Color(0xFF0F172A)],
                  pedestalTopBorder: AppColors.slate300,
                  isCenter: false,
                ),
              ),

              const SizedBox(width: 8),

              // ----------------------------------------------------
              // #1 GOLD CHAMPION: DANIEL L. (TALLER & GLOWING)
              // ----------------------------------------------------
              Expanded(
                child: _buildPodiumAthlete(
                  context: context,
                  rank: '1',
                  name: 'Daniel L.',
                  xp: '1,620 XP',
                  tag: '👑 CHAMPION',
                  avatarAsset: DemoAvatars.daniel,
                  avatarSize: avatar1Size,
                  ringColor: const Color(0xFFFFD700),
                  glowColor: const Color(0xFFFFD700).withValues(alpha: 0.4),
                  medallionIcon: '👑',
                  pedestalHeight: ped1Height,
                  pedestalGradient: const [Color(0xFF2C2210), Color(0xFF151D2A)],
                  pedestalTopBorder: const Color(0xFFFFD700),
                  isCenter: true,
                ),
              ),

              const SizedBox(width: 8),

              // ----------------------------------------------------
              // #3 BRONZE: MEI R.
              // ----------------------------------------------------
              Expanded(
                child: _buildPodiumAthlete(
                  context: context,
                  rank: '3',
                  name: 'Mei R.',
                  xp: '1,395 XP',
                  tag: '🔥 3W Streak',
                  avatarAsset: DemoAvatars.mei,
                  avatarSize: avatar3Size,
                  ringColor: AppColors.rankBronze,
                  medallionIcon: '🥉',
                  pedestalHeight: ped3Height,
                  pedestalGradient: const [Color(0xFF261D18), Color(0xFF0F172A)],
                  pedestalTopBorder: AppColors.rankBronze,
                  isCenter: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumAthlete({
    required BuildContext context,
    required String rank,
    required String name,
    required String xp,
    required String tag,
    required String avatarAsset,
    required double avatarSize,
    required Color ringColor,
    required String medallionIcon,
    required double pedestalHeight,
    required List<Color> pedestalGradient,
    required Color pedestalTopBorder,
    Color? glowColor,
    bool isCenter = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Crown or Medallion floating indicator
        if (isCenter)
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            child: const Text('👑', style: TextStyle(fontSize: 16)),
          )
        else
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            child: Text(medallionIcon, style: const TextStyle(fontSize: 13)),
          ),

        // Real Avatar with metallic ring and optional champion glow
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ringColor, width: isCenter ? 2.5 : 2.0),
            boxShadow: [
              if (glowColor != null)
                BoxShadow(
                  color: glowColor,
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              avatarAsset,
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 6),

        // Athlete Name
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.ui(
            fontSize: isCenter ? 13 : 11,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 2),

        // Athlete XP Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: isCenter
                ? const Color(0xFFFFD700).withValues(alpha: 0.18)
                : Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isCenter
                  ? const Color(0xFFFFD700).withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.12),
              width: 0.8,
            ),
          ),
          child: Text(
            xp,
            style: AppTypography.ui(
              fontSize: isCenter ? 10.5 : 9.5,
              fontWeight: FontWeight.w900,
              color: isCenter ? const Color(0xFFFFD700) : Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 6),

        // Pedestal block with etched rank numeral
        Container(
          width: double.infinity,
          height: pedestalHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: pedestalGradient,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            border: Border(
              top: BorderSide(color: pedestalTopBorder, width: isCenter ? 2.5 : 1.5),
              left: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              right: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                rank,
                style: AppTypography.ui(
                  fontSize: isCenter ? 26 : 20,
                  fontWeight: FontWeight.w900,
                  color: pedestalTopBorder.withValues(alpha: 0.85),
                ),
              ),
              if (isCenter)
                Text(
                  'GOLD',
                  style: AppTypography.ui(
                    fontSize: 7.5,
                    fontWeight: FontWeight.w900,
                    color: pedestalTopBorder.withValues(alpha: 0.7),
                    letterSpacing: 1.0,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STREAMLINED ROSTER ROW (NO BOXCEPTION!)
  // ============================================================
  Widget _buildRosterRow({
    required BuildContext context,
    required String rank,
    required String name,
    required String xp,
    required String form,
    required Color formColor,
    required bool isMobile,
    String? avatarAsset,
    bool isUser = false,
    bool isAnonymous = false,
    String? subName,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 18,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: isUser
            ? AppColors.darkObsidianCard
            : AppColors.darkObsidianElevated,
        borderRadius: BorderRadius.circular(10), // Windows 11 Fluent 10px squircle
        border: Border.all(
          color: isUser
              ? AppColors.ittfTableBorder
              : Colors.white.withValues(alpha: 0.08),
          width: isUser ? 1.6 : 1.0,
        ),
        boxShadow: [
          if (isUser)
            BoxShadow(
              color: AppColors.ittfTableBorder.withValues(alpha: 0.20),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        children: [
          // Rank Badge
          Container(
            width: 26,
            alignment: Alignment.centerLeft,
            child: Text(
              '#$rank',
              style: AppTypography.ui(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: isUser ? AppColors.ittfTableBorder : Colors.white60,
              ),
            ),
          ),

          // Player Avatar Photo
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isUser
                    ? AppColors.ittfTableBorder
                    : Colors.white.withValues(alpha: 0.15),
                width: 1.2,
              ),
            ),
            child: ClipOval(
              child: isAnonymous || avatarAsset == null
                  ? Container(
                      color: AppColors.darkObsidianCard,
                      child: const Icon(
                        Icons.person_rounded,
                        size: 20,
                        color: Colors.white38,
                      ),
                    )
                  : Image.asset(
                      avatarAsset,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 10),

          // Player Name & Micro Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.ui(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (isUser) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: AppColors.ittfTableBorder,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'YOU',
                          style: AppTypography.ui(
                            fontSize: 7.5,
                            fontWeight: FontWeight.w900,
                            color: AppColors.darkObsidianBase,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      form,
                      style: AppTypography.ui(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: formColor,
                      ),
                    ),
                    if (subName != null) ...[
                      const SizedBox(width: 6),
                      Text(
                        '· $subName',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.ui(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white38,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Total XP
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$xp XP',
                style: AppTypography.ui(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w900,
                  color: isUser ? AppColors.ittfTableBorder : Colors.white,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),

          const SizedBox(width: 10),

          // Action Button: Challenge or Details
          if (isUser)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.ittfTableBorder.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.ittfTableBorder.withValues(alpha: 0.4)),
              ),
              child: Text(
                'Standing',
                style: AppTypography.ui(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ittfTableBorder,
                ),
              ),
            )
          else
            GestureDetector(
              onTap: () => AppNavigator.toChallengeBoard(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.actionBlue,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Challenge ⚔️',
                  style: AppTypography.ui(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // TV MODE 2: MORTAL KOMBAT MATCH CARD (BROADCAST SPOTLIGHT)
  // ============================================================
  Widget _buildTvKombatCard(BuildContext context, bool isMobile) {
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
                    color: AppColors.darkObsidianCard,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.ittfTableBorder.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.table_restaurant_rounded, size: 14, color: AppColors.ittfTableBorder),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'TABLE NO. 4 · MATCH SPOTLIGHT',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.ui(
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
                  color: AppColors.slate900,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.electricCrimson.withValues(alpha: 0.5)),
                ),
                child: Text(
                  'POT 200 XP',
                  style: AppTypography.ui(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: AppColors.electricCrimson,
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
                  name: 'Aiman Rahman',
                  xp: '1,240 XP',
                  rank: 'RANK #4 · STREAK 3W',
                  avatarAsset: AppSession.avatarAsset,
                  color: AppColors.ittfTableBorder,
                  bgGradient: [AppColors.darkObsidianCard, AppColors.darkObsidianBase],
                  isCompact: true,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.paddleBlack,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Text(
                        '⚔️ VS · 04:59 REMAINING',
                        style: AppTypography.ui(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: AppColors.voltLime,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildPlayerBattleCard(
                  title: 'CHALLENGER',
                  name: 'Jason Tan',
                  xp: '1,180 XP',
                  rank: 'RANK #5 · STREAK 4W',
                  avatarAsset: DemoAvatars.jason,
                  color: AppColors.electricCrimson,
                  bgGradient: [AppColors.slate900, AppColors.darkObsidianBase],
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
                    name: 'Aiman Rahman',
                    xp: '1,240 XP',
                    rank: 'LEAGUE RANK #4 · WIN STREAK 3W',
                    avatarAsset: AppSession.avatarAsset,
                    color: AppColors.ittfTableBorder,
                    bgGradient: [AppColors.darkObsidianCard, AppColors.darkObsidianBase],
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
                            colors: [AppColors.ittfTableBorder, AppColors.electricCrimson],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'VS',
                            style: AppTypography.ui(
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
                        style: AppTypography.ui(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.voltLime,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildPlayerBattleCard(
                    title: 'CHALLENGER',
                    name: 'Jason Tan',
                    xp: '1,180 XP',
                    rank: 'LEAGUE RANK #5 · WIN STREAK 4W',
                    avatarAsset: DemoAvatars.jason,
                    color: AppColors.electricCrimson,
                    bgGradient: [AppColors.slate900, AppColors.darkObsidianBase],
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
                colors: [AppColors.darkObsidianElevated, AppColors.paddleBlack],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.ittfTableBorder.withValues(alpha: 0.4),
                width: 1.2,
              ),
            ),
            child: Center(
              child: Text(
                '⚡ COME TO TABLE NO. 4 — WINNER TAKES 200 XP ⚡',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.ui(
                  fontSize: isMobile ? 11 : 14,
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
    String? avatarAsset,
    bool isCompact = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isCompact ? 14 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: bgGradient),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1.6),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              title,
              style: AppTypography.ui(
                fontSize: 8.5,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: isCompact ? 8 : 14),

          // Real Player Avatar in Battle Card
          if (avatarAsset != null)
            Container(
              width: isCompact ? 50 : 70,
              height: isCompact ? 50 : 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              child: ClipOval(
                child: Image.asset(avatarAsset, fit: BoxFit.cover),
              ),
            ),

          SizedBox(height: isCompact ? 6 : 10),
          Text(
            name,
            style: AppTypography.ui(
              fontSize: isCompact ? 18 : 28,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            xp,
            style: AppTypography.ui(
              fontSize: isCompact ? 15 : 20,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          Text(
            rank,
            style: AppTypography.ui(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}
