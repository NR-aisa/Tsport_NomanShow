import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';
import 'seek_player_screen.dart';
import '../../../core/theme/app_typography.dart';

class ChallengeBoardScreen extends StatefulWidget {
  final VoidCallback? onPostChallengeTap;
  final VoidCallback? onAcceptChallengeTap;

  const ChallengeBoardScreen({
    super.key,
    this.onPostChallengeTap,
    this.onAcceptChallengeTap,
  });

  @override
  State<ChallengeBoardScreen> createState() => _ChallengeBoardScreenState();
}

class _ChallengeBoardScreenState extends State<ChallengeBoardScreen> {
  int _activeTab = 0; // 0 = Challenge, 1 = Rivals
  int _selectedRisk = 200; // 100, 200, 500
  String _selectedRival = 'Jason T.';

  @override
  Widget build(BuildContext context) {
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
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.obsidianBorder),
                      ),
                      child: Icon(Icons.arrow_back_ios_new, size: 16, color: AppColors.textPrimary),
                    ),
                  ),
                  Text(
                    'Challenge',
                    style: AppTypography.ui(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.amethystPurple.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.amethystPurple.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.flash_on_rounded, size: 13, color: AppColors.amethystPurple),
                        const SizedBox(width: 4),
                        Text(
                          '1,240 XP',
                          style: AppTypography.ui(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppColors.amethystPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tabs: Challenge vs Rivals
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.obsidianCard,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.obsidianBorder),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _activeTab = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _activeTab == 0 ? AppColors.ittfTableSurface : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              'Challenge',
                              style: AppTypography.ui(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: _activeTab == 0 ? Colors.white : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _activeTab = 1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _activeTab == 1 ? AppColors.ittfTableSurface : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              'Rivals',
                              style: AppTypography.ui(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: _activeTab == 1 ? Colors.white : AppColors.textSecondary,
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

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // VS Dual Setup Header
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.pastelPurple,
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: AppColors.obsidianBorder),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: AppColors.obsidianElevated,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.circle, size: 10, color: AppColors.textPrimary),
                                ),
                                const SizedBox(height: 12),
                                Text('You', style: AppTypography.ui(fontSize: 10, color: AppColors.textSecondary)),
                                Text('1,240 XP', style: AppTypography.ui(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDark,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              'VS',
                              style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.pastelPink,
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: AppColors.obsidianBorder),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: AppColors.obsidianElevated,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.crop_square_rounded, size: 10, color: AppColors.textPrimary),
                                ),
                                const SizedBox(height: 12),
                                Text('Your rival', style: AppTypography.ui(fontSize: 10, color: AppColors.textSecondary)),
                                Text(
                                  _selectedRival,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.ui(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Rivals Selection List
                    _buildRivalRow('2', 'Sara K.', 'At Table 2 · Free', '1,480'),
                    const SizedBox(height: 8),
                    _buildRivalRow('5', 'Jason T.', 'Looking for a game · Free', '1,180'),
                    const SizedBox(height: 8),
                    _buildRivalRow('6', 'Nurul P.', 'Free', '1,050'),
                    const SizedBox(height: 16),

                    // Bet Tier / Pick Your Risk
                    Text(
                      'YOUR BET — PICK YOUR RISK',
                      style: AppTypography.ui(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textSecondary,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _buildRiskPill(100, '100 · Safe')),
                        const SizedBox(width: 8),
                        Expanded(child: _buildRiskPill(200, '200 · Standard')),
                        const SizedBox(width: 8),
                        Expanded(child: _buildRiskPill(500, '500 · Go Big')),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Win / Lose Pot Cards
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: AppColors.obsidianCard,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.obsidianBorder),
                            ),
                            child: Column(
                              children: [
                                Text('WIN', style: AppTypography.ui(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.textSecondary)),
                                const SizedBox(height: 2),
                                Text(
                                  '+$_selectedRisk XP',
                                  style: AppTypography.ui(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.voltLime,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: AppColors.obsidianCard,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.obsidianBorder),
                            ),
                            child: Column(
                              children: [
                                Text('LOSE', style: AppTypography.ui(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.textSecondary)),
                                const SizedBox(height: 2),
                                Text(
                                  '-$_selectedRisk XP',
                                  style: AppTypography.ui(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.electricCrimson,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Action Buttons: Custom Post vs 1v1 Kombat
                    TactileButton.volt(
                      text: 'Send Challenge to $_selectedRival →',
                      onPressed: widget.onAcceptChallengeTap ?? () => AppNavigator.toChallengeAccepted(context),
                    ),
                    const SizedBox(height: 10),

                    TactileButton.tonal(
                      text: 'Post Open Challenge to Venue Board',
                      onPressed: widget.onPostChallengeTap ?? () => AppNavigator.pushScreen(context, const SeekPlayerScreen()),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Bottom Nav
            const JomnittakuNavBar(activeIndex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskPill(int risk, String label) {
    final isSelected = _selectedRisk == risk;
    return GestureDetector(
      onTap: () => setState(() => _selectedRisk = risk),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.ittfTableSurface : AppColors.obsidianCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.white.withValues(alpha: 0.3) : AppColors.obsidianBorder,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.ui(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRivalRow(String rank, String name, String subtitle, String points) {
    final isSelected = _selectedRival == name;
    return GestureDetector(
      onTap: () => setState(() => _selectedRival = name),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (AppColors.isDark ? AppColors.darkObsidianCardLight : AppColors.lightBorder)
              : AppColors.obsidianCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.ittfTableSurface : AppColors.obsidianBorder,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.surfaceSubtle,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.obsidianBorder),
              ),
              child: Center(
                child: Text(
                  '#$rank',
                  style: AppTypography.ui(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTypography.ui(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.ui(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '$points XP',
              style: AppTypography.ui(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: AppColors.radiantGold,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
              size: 18,
              color: isSelected ? AppColors.ittfTableSurface : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
