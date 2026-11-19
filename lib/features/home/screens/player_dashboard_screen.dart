import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock/mock_data.dart';
import '../../../data/models/app_models.dart';
import '../../../core/theme/app_typography.dart';

class PlayerDashboardScreen extends StatelessWidget {
  final VoidCallback? onChallengeBoardTap;
  final VoidCallback? onLeaderboardTap;
  final VoidCallback? onSeekPlayerTap;
  final VoidCallback? onChampionBiddingTap;
  final VoidCallback? onProfileTap;

  const PlayerDashboardScreen({
    super.key,
    this.onChallengeBoardTap,
    this.onLeaderboardTap,
    this.onSeekPlayerTap,
    this.onChampionBiddingTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    const user = MockData.currentUser;
    final challenges = MockData.openChallenges;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'T SPORTS',
                            style: GoogleFonts.bebasNeue(
                              fontSize: 22,
                              color: AppColors.primary,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGlow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'NO-MAN HUB',
                              style: AppTypography.ui(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Good evening, ${user.name}',
                        style: AppTypography.ui(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: onProfileTap,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surface2,
                        border: Border.all(color: AppColors.primary, width: 1.5),
                      ),
                      child: user.avatarUrl != null
                          ? ClipOval(
                              child: Image.asset(
                                user.avatarUrl!,
                                width: 44,
                                height: 44,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Text(
                                user.initials,
                                style: GoogleFonts.bebasNeue(fontSize: 18, color: AppColors.primary),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Active Session Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.paddleBlack, AppColors.darkObsidianBase],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'ACTIVE TABLE SESSION',
                              style: AppTypography.ui(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Table 02',
                            style: AppTypography.mono(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '01h 37m Remaining',
                              style: AppTypography.mono(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'Session expires automatically at 16:30',
                              style: AppTypography.ui(fontSize: 11, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        Icon(Icons.timer_outlined, size: 32, color: AppColors.primary),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Gamification XP Hero Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.xpGold.withValues(alpha: 0.05),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.bolt, color: AppColors.xpGold, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              'PLAYER XP WALLET',
                              style: AppTypography.ui(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.xpGold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.xpGold.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.xpGold, width: 1),
                          ),
                          child: Text(
                            'TIER: ${user.rankLabel}',
                            style: AppTypography.ui(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppColors.xpGold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${user.xp}',
                          style: AppTypography.mono(
                            fontSize: 38,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'XP',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 22,
                            color: AppColors.xpGold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Rank #${user.rank} in Venue',
                          style: AppTypography.ui(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: user.xp / 2000,
                        backgroundColor: AppColors.surface3,
                        valueColor: AlwaysStoppedAnimation(AppColors.primary),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${2000 - user.xp} XP to Elite Tier',
                          style: AppTypography.ui(fontSize: 11, color: AppColors.textMuted),
                        ),
                        Text(
                          '23W - 11L (68% Win Rate)',
                          style: AppTypography.mono(fontSize: 11, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Quick Action Grid (4 Buttons)
              Text(
                'VENUE ARENA ACTIONS',
                style: AppTypography.ui(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildActionTile(
                      icon: Icons.sports_mma_rounded,
                      title: 'CHALLENGES',
                      subtitle: 'Bet & Win XP',
                      color: AppColors.challengeRed,
                      onTap: onChallengeBoardTap,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildActionTile(
                      icon: Icons.leaderboard_rounded,
                      title: 'LEADERBOARD',
                      subtitle: 'Live TV Rank',
                      color: AppColors.xpGold,
                      onTap: onLeaderboardTap,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildActionTile(
                      icon: Icons.person_search_rounded,
                      title: 'SEEK PLAYER',
                      subtitle: 'Find Teammate',
                      color: AppColors.info,
                      onTap: onSeekPlayerTap,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildActionTile(
                      icon: Icons.stars_rounded,
                      title: 'STAR BIDDING',
                      subtitle: 'Play Champion',
                      color: AppColors.primary,
                      onTap: onChampionBiddingTap,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Open Challenges Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'LIVE CHALLENGES WAITING',
                    style: AppTypography.ui(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                      letterSpacing: 1.2,
                    ),
                  ),
                  GestureDetector(
                    onTap: onChallengeBoardTap,
                    child: Text(
                      'View All (${challenges.length})',
                      style: AppTypography.ui(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Challenges List Cards
              ...challenges.take(2).map((c) => _buildChallengeCard(c, onChallengeBoardTap)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.bebasNeue(
                fontSize: 16,
                letterSpacing: 1.0,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              subtitle,
              style: AppTypography.ui(fontSize: 10, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildChallengeCard(Challenge c, VoidCallback? onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.surface3,
            backgroundImage:
                c.challenger.avatarUrl != null ? AssetImage(c.challenger.avatarUrl!) : null,
            child: c.challenger.avatarUrl != null
                ? null
                : Text(
                    c.challenger.initials,
                    style: GoogleFonts.bebasNeue(fontSize: 14, color: AppColors.primary),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.challenger.name,
                  style: AppTypography.ui(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${c.tableId?.toUpperCase() ?? "Any Table"} • ${c.minutesAgo}m ago',
                  style: AppTypography.ui(fontSize: 11, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.xpGold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.xpGold),
            ),
            child: Text(
              '⚡ ${c.xpStake} XP',
              style: AppTypography.mono(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.xpGold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
