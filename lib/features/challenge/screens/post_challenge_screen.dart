import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock/mock_data.dart';
import '../../../core/theme/app_typography.dart';

class PostChallengeScreen extends StatefulWidget {
  final VoidCallback? onChallengePosted;

  const PostChallengeScreen({super.key, this.onChallengePosted});

  @override
  State<PostChallengeScreen> createState() => _PostChallengeScreenState();
}

class _PostChallengeScreenState extends State<PostChallengeScreen> {
  int _selectedStake = 200; // 200 or 500
  final _messageController = TextEditingController(text: 'Ready for a high-speed match on Table 02!');

  @override
  Widget build(BuildContext context) {
    const user = MockData.currentUser;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        title: Text(
          'CREATE OPEN CHALLENGE',
          style: GoogleFonts.bebasNeue(fontSize: 22, letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current XP Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('YOUR WALLET BALANCE', style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                  Text('${user.xp} XP', style: AppTypography.mono(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.xpGold)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Select Bet Tier
            Text(
              'SELECT XP STAKE TIER',
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
                  child: _buildBetTierCard(
                    stake: 200,
                    title: 'STANDARD BET',
                    subtitle: 'Casual Competitive',
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildBetTierCard(
                    stake: 500,
                    title: 'HIGH STAKES',
                    subtitle: 'Pro Match • Red TV Alert',
                    color: AppColors.challengeRed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Challenge message
            Text(
              'CHALLENGE SHOUTOUT MESSAGE (OPTIONAL)',
              style: AppTypography.ui(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _messageController,
              maxLines: 2,
              style: AppTypography.ui(color: AppColors.textPrimary, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'e.g. Pro players only!',
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.border),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Your Broadcast Card Preview
            Text(
              'TV & MOBILE BROADCAST PREVIEW',
              style: AppTypography.ui(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _selectedStake == 500 ? AppColors.challengeRed : AppColors.primary,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (_selectedStake == 500 ? AppColors.challengeRed : AppColors.primary).withValues(alpha: 0.15),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.surface3,
                    child: Text(
                      user.initials,
                      style: GoogleFonts.bebasNeue(
                        fontSize: 16,
                        color: _selectedStake == 500 ? AppColors.challengeRed : AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.name} (Rank #${user.rank})',
                          style: AppTypography.ui(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                        ),
                        Text(
                          'Seeking 1v1 on Table 02 • Bet: $_selectedStake XP',
                          style: AppTypography.ui(fontSize: 11, color: AppColors.textSecondary),
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
                      '⚡ $_selectedStake XP',
                      style: AppTypography.mono(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.xpGold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Submit Button
            ElevatedButton(
              onPressed: widget.onChallengePosted,
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedStake == 500 ? AppColors.challengeRed : AppColors.primary,
                foregroundColor: _selectedStake == 500 ? Colors.white : AppColors.bg,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.campaign_rounded, size: 20),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'BROADCAST CHALLENGE ($_selectedStake XP)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.ui(fontSize: 13, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Uses Broadcasting Design Pattern to notify all venue TV screens instantly',
                style: AppTypography.ui(fontSize: 11, color: AppColors.textMuted),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBetTierCard({
    required int stake,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    final isSelected = _selectedStake == stake;

    return GestureDetector(
      onTap: () => setState(() => _selectedStake = stake),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surface2 : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.25),
                    blurRadius: 16,
                  )
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$stake XP',
              style: AppTypography.mono(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: isSelected ? color : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.bebasNeue(
                fontSize: 16,
                letterSpacing: 1.0,
                color: isSelected ? color : AppColors.textSecondary,
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
}
