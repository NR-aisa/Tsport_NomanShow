import 'package:flutter/material.dart';
import '../../../core/session/app_session.dart';
import '../../../core/session/demo_avatars.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme_controller.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/arena_widgets.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';
import '../../../core/theme/app_typography.dart';

class LeaderboardScreen extends StatefulWidget {
  final VoidCallback? onChallengeTap;

  const LeaderboardScreen({super.key, this.onChallengeTap});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  int _tabIndex = 0; // 0 = This week, 1 = All time

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      builder: (context, isDark) {
        return Scaffold(
          backgroundColor: AppColors.canvasBg,
          body: ArenaBackdrop(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // ==========================================
                  // TOP APP BAR (Windows 11 Fluent)
                  // ==========================================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.maybePop(context),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.obsidianCard,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.obsidianBorder),
                                  ),
                                  child: Icon(Icons.arrow_back_ios_new, size: 14, color: AppColors.textPrimary),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  'Leaderboard',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.ui(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => AppNavigator.toTables(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4.5),
                            decoration: BoxDecoration(
                              color: AppColors.voltLime.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.voltLime.withValues(alpha: 0.35)),
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
                                const SizedBox(width: 5),
                                Text(
                                  '2 MATCHES LIVE',
                                  style: AppTypography.ui(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.voltLime,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ==========================================
                  // TABS: THIS WEEK VS ALL TIME
                  // ==========================================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.obsidianBorder),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _tabIndex = 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: _tabIndex == 0 ? AppColors.actionBlue : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'This week',
                                    style: AppTypography.ui(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: _tabIndex == 0 ? Colors.white : AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _tabIndex = 1),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: _tabIndex == 1 ? AppColors.actionBlue : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'All time',
                                    style: AppTypography.ui(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: _tabIndex == 1 ? Colors.white : AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ==========================================
                  // SCROLLABLE LEADERBOARD BODY
                  // ==========================================
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ----------------------------------------
                          // HERO: TOP 3 PODIUM
                          // ----------------------------------------
                          _buildPodium(context).arenaEntrance(1),

                          const SizedBox(height: 12),

                          // ----------------------------------------
                          // YOUR STANDING SUMMARY CHIP
                          // ----------------------------------------
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.obsidianCard,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.ittfTableBorder.withValues(alpha: 0.35)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.ittfTableBorder.withValues(alpha: 0.08),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.ittfTableBorder,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'YOUR STANDING',
                                    style: AppTypography.ui(
                                      fontSize: 8.5,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.darkObsidianBase,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Rank #4 · 1,240 XP · 155 XP to #3',
                                    style: AppTypography.ui(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.voltLime.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '▲ +40',
                                    style: AppTypography.ui(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.voltLime,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).arenaEntrance(2),

                          const SizedBox(height: 14),

                          // Section Header: League Contenders
                          Text(
                            'LEAGUE CONTENDERS',
                            style: AppTypography.ui(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textSecondary,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // ----------------------------------------
                          // STREAMLINED ROSTER CARDS (NO BOXCEPTION!)
                          // ----------------------------------------
                          // Player Card: #4 — YOU
                          _buildRosterRow(
                            context: context,
                            rank: '4',
                            name: 'You (Aiman R.)',
                            points: '1,240',
                            form: '▲ +40 this week',
                            formColor: AppColors.voltLime,
                            avatarAsset: AppSession.avatarAsset,
                            isYou: true,
                            onChallenge: null,
                          ).arenaEntrance(3),

                          // Player Card: #5 Rajan K.
                          _buildRosterRow(
                            context: context,
                            rank: '5',
                            name: 'Rajan K.',
                            points: '1,180',
                            form: 'Steady',
                            formColor: AppColors.textSecondary,
                            avatarAsset: DemoAvatars.rajan,
                            onChallenge: widget.onChallengeTap ?? () => AppNavigator.toChallengeBoard(context),
                          ).arenaEntrance(4),

                          // Player Card: #6 Jason T.
                          _buildRosterRow(
                            context: context,
                            rank: '6',
                            name: 'Jason T.',
                            points: '1,120',
                            form: '▼ -25 this week',
                            formColor: AppColors.electricCrimson,
                            avatarAsset: DemoAvatars.jason,
                            onChallenge: widget.onChallengeTap ?? () => AppNavigator.toChallengeBoard(context),
                          ).arenaEntrance(5),

                          // Player Card: #7 Nurul P.
                          _buildRosterRow(
                            context: context,
                            rank: '7',
                            name: 'Nurul P.',
                            points: '1,050',
                            form: '▲ +15 this week',
                            formColor: AppColors.voltLime,
                            avatarAsset: DemoAvatars.nurul,
                            onChallenge: widget.onChallengeTap ?? () => AppNavigator.toChallengeBoard(context),
                          ).arenaEntrance(6),

                          const SizedBox(height: 16),

                          // Charming Toby CTA Button
                          TactileButton.volt(
                            text: 'Challenge a Player ⚔️',
                            onPressed: widget.onChallengeTap ?? () => AppNavigator.toChallengeBoard(context),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Nav
                  const JomnittakuNavBar(activeIndex: 1),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // TOP 3 PODIUM (HERO SECTION)
  // ============================================================
  Widget _buildPodium(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.obsidianBorder),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // #2 Silver: Sara K.
          Expanded(
            child: _buildPodiumColumn(
              context: context,
              rank: '2',
              name: 'Sara K.',
              points: '1,480 XP',
              avatarAsset: DemoAvatars.sara,
              avatarSize: 42,
              ringColor: AppColors.slate300,
              badgeIcon: '🥈',
              pedestalHeight: 52,
              pedestalGradient: const [Color(0xFF1E293B), Color(0xFF0F172A)],
              pedestalBorder: AppColors.slate300,
              isCenter: false,
            ),
          ),
          const SizedBox(width: 8),

          // #1 Gold: Daniel L. (Champion)
          Expanded(
            child: _buildPodiumColumn(
              context: context,
              rank: '1',
              name: 'Daniel L.',
              points: '1,620 XP',
              avatarAsset: DemoAvatars.daniel,
              avatarSize: 52,
              ringColor: const Color(0xFFFFD700),
              glowColor: const Color(0xFFFFD700).withValues(alpha: 0.35),
              badgeIcon: '👑',
              pedestalHeight: 74,
              pedestalGradient: const [Color(0xFF2C2210), Color(0xFF151D2A)],
              pedestalBorder: const Color(0xFFFFD700),
              isCenter: true,
            ),
          ),
          const SizedBox(width: 8),

          // #3 Bronze: Mei R.
          Expanded(
            child: _buildPodiumColumn(
              context: context,
              rank: '3',
              name: 'Mei R.',
              points: '1,395 XP',
              avatarAsset: DemoAvatars.mei,
              avatarSize: 40,
              ringColor: AppColors.rankBronze,
              badgeIcon: '🥉',
              pedestalHeight: 40,
              pedestalGradient: const [Color(0xFF261D18), Color(0xFF0F172A)],
              pedestalBorder: AppColors.rankBronze,
              isCenter: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumColumn({
    required BuildContext context,
    required String rank,
    required String name,
    required String points,
    required String avatarAsset,
    required double avatarSize,
    required Color ringColor,
    required String badgeIcon,
    required double pedestalHeight,
    required List<Color> pedestalGradient,
    required Color pedestalBorder,
    Color? glowColor,
    bool isCenter = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Crown or medal icon
        Text(badgeIcon, style: TextStyle(fontSize: isCenter ? 15 : 12)),
        const SizedBox(height: 2),

        // Real Avatar
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ringColor, width: isCenter ? 2.4 : 1.8),
            boxShadow: [
              if (glowColor != null)
                BoxShadow(
                  color: glowColor,
                  blurRadius: 14,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(avatarAsset, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 5),

        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.ui(
            fontSize: isCenter ? 12.5 : 11,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 2),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
          decoration: BoxDecoration(
            color: isCenter ? const Color(0xFFFFD700).withValues(alpha: 0.15) : AppColors.surfaceSubtle,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            points,
            style: AppTypography.ui(
              fontSize: isCenter ? 10 : 9,
              fontWeight: FontWeight.w900,
              color: isCenter ? const Color(0xFFFFD700) : AppColors.textSecondary,
            ),
          ),
        ),

        const SizedBox(height: 6),

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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            border: Border(
              top: BorderSide(color: pedestalBorder, width: isCenter ? 2.0 : 1.2),
              left: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              right: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
            ),
          ),
          child: Center(
            child: Text(
              rank,
              style: AppTypography.ui(
                fontSize: isCenter ? 22 : 17,
                fontWeight: FontWeight.w900,
                color: pedestalBorder.withValues(alpha: 0.85),
              ),
            ),
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
    required String points,
    required String form,
    required Color formColor,
    String? avatarAsset,
    bool isYou = false,
    VoidCallback? onChallenge,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(10), // Windows 11 Fluent 10px squircle
        border: Border.all(
          color: isYou ? AppColors.ittfTableBorder : AppColors.obsidianBorder,
          width: isYou ? 1.5 : 1.0,
        ),
        boxShadow: [
          if (isYou)
            BoxShadow(
              color: AppColors.ittfTableBorder.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        children: [
          // Rank Badge
          Container(
            width: 24,
            alignment: Alignment.centerLeft,
            child: Text(
              '#$rank',
              style: AppTypography.ui(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: isYou ? AppColors.ittfTableBorder : AppColors.textSecondary,
              ),
            ),
          ),

          // Real Player Avatar
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isYou ? AppColors.ittfTableBorder : AppColors.obsidianBorder,
                width: 1.2,
              ),
            ),
            child: ClipOval(
              child: avatarAsset != null
                  ? Image.asset(avatarAsset, fit: BoxFit.cover)
                  : Container(
                      color: AppColors.surfaceSubtle,
                      child: Icon(Icons.person, size: 20, color: AppColors.textSecondary),
                    ),
            ),
          ),
          const SizedBox(width: 10),

          // Name & Form
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
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (isYou) ...[
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
                Text(
                  form,
                  style: AppTypography.ui(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: formColor,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Points
          Text(
            '$points XP',
            style: AppTypography.ui(
              fontSize: 13.5,
              fontWeight: FontWeight.w900,
              color: isYou ? AppColors.ittfTableBorder : AppColors.textPrimary,
            ),
          ),

          const SizedBox(width: 10),

          // Action Button
          if (isYou)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4.5),
              decoration: BoxDecoration(
                color: AppColors.ittfTableBorder.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.ittfTableBorder.withValues(alpha: 0.3)),
              ),
              child: Text(
                'Standing',
                style: AppTypography.ui(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ittfTableBorder,
                ),
              ),
            )
          else
            GestureDetector(
              onTap: onChallenge,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4.5),
                decoration: BoxDecoration(
                  color: AppColors.actionBlue,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Challenge ⚔️',
                  style: AppTypography.ui(
                    fontSize: 9,
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
}
