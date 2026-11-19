import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme_controller.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';

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
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.maybePop(context),
                          child: Container(
                            width: 38,
                            height: 38,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: AppColors.obsidianCard,
                              shape: BoxShape.circle,
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
                            style: GoogleFonts.plusJakartaSans(
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        '2 MATCHES LIVE',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF34D399),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tabs: This week vs All time
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.obsidianCard,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.obsidianBorder),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _tabIndex = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _tabIndex == 0 ? AppColors.ittfTableSurface : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'This week',
                              style: GoogleFonts.plusJakartaSans(
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _tabIndex == 1 ? AppColors.ittfTableSurface : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'All time',
                              style: GoogleFonts.plusJakartaSans(
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

            // Scrollable Leaderboard
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: [
                    // Sticky User Standing Hero Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.obsidianBorder),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: AppColors.isDark ? 0.3 : 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildUserStandingPill('Your rank', '#4', AppColors.pastelPurple, Icons.arrow_drop_up_rounded),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildUserStandingPill('Your points', '1,240', AppColors.pastelGreen, Icons.auto_awesome),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDark,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'Your position: #4',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Player Card: #1 Daniel L.
                    _buildPlayerCard(
                      name: 'Daniel L.',
                      points: '1,620',
                      rank: '#1',
                      form: 'Steady',
                      onChallenge: widget.onChallengeTap ?? () => AppNavigator.toChallengeBoard(context),
                    ),
                    const SizedBox(height: 12),

                    // Player Card: #2 Sara K.
                    _buildPlayerCard(
                      name: 'Sara K.',
                      points: '1,480',
                      rank: '#2',
                      form: 'Steady',
                      onChallenge: widget.onChallengeTap ?? () => AppNavigator.toChallengeBoard(context),
                    ),
                    const SizedBox(height: 12),

                    // Player Card: #3 Mei R.
                    _buildPlayerCard(
                      name: 'Mei R.',
                      points: '1,395',
                      rank: '#3',
                      form: 'Steady',
                      onChallenge: widget.onChallengeTap ?? () => AppNavigator.toChallengeBoard(context),
                    ),
                    const SizedBox(height: 16),

                    // 3D Tactile CTA Button
                    TactileButton.volt(
                      text: 'Challenge a Player →',
                      onPressed: widget.onChallengeTap ?? () => AppNavigator.toChallengeBoard(context),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Bottom Nav
            const JomnittakuNavBar(activeIndex: 1),
          ],
        ),
      ),
    );
      },
    );
  }

  Widget _buildPlayerCard({
    required String name,
    required String points,
    required String rank,
    required String form,
    VoidCallback? onChallenge,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.obsidianBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: AppColors.isDark ? 0.25 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.surfaceSubtle,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.obsidianBorder),
                ),
                child: const Icon(Icons.sports_tennis, size: 20, color: Color(0xFF60A5FA)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.obsidianBorder),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'Details →',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: _buildPlayerStatPill('Points', points, AppColors.pastelGreen)),
              const SizedBox(width: 6),
              Expanded(child: _buildPlayerStatPill('Rank', rank, AppColors.pastelPurple)),
              const SizedBox(width: 6),
              Expanded(child: _buildPlayerStatPill('Form', form, AppColors.pastelBlue)),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lock',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textSecondary,
                ),
              ),
              GestureDetector(
                onTap: onChallenge,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.ittfTableSurface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Challenge →',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserStandingPill(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: AppColors.obsidianElevated,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 12, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 6),
          Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.textSecondary)),
          Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildPlayerStatPill(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 9, color: AppColors.textSecondary)),
          Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
