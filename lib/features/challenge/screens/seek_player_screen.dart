import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock/mock_data.dart';
import '../../../core/theme/app_typography.dart';

class SeekPlayerScreen extends StatefulWidget {
  final VoidCallback? onInviteSent;

  const SeekPlayerScreen({super.key, this.onInviteSent});

  @override
  State<SeekPlayerScreen> createState() => _SeekPlayerScreenState();
}

class _SeekPlayerScreenState extends State<SeekPlayerScreen> {
  int _matchMode = 0; // 0 = 1v1 Opponent, 1 = 2v2 Doubles Teammate

  @override
  Widget build(BuildContext context) {
    const freePlayers = MockData.players;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        title: Text(
          'SEEK TEAMMATE / OPPONENT',
          style: GoogleFonts.bebasNeue(fontSize: 22, letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Location Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGlow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.location_on_rounded, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'YOU ARE AT TABLE 02',
                          style: GoogleFonts.bebasNeue(fontSize: 18, color: AppColors.textPrimary, letterSpacing: 1),
                        ),
                        Text(
                          '01h 37m session active • Looking for players in arena',
                          style: AppTypography.ui(fontSize: 11, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Match Type Toggle
            Text(
              'WHAT ARE YOU LOOKING FOR?',
              style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 1.2),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildToggleOption(
                    index: 0,
                    title: '1v1 OPPONENT',
                    subtitle: 'Singles friendly match',
                    icon: Icons.person_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildToggleOption(
                    index: 1,
                    title: '2v2 TEAMMATE',
                    subtitle: 'Doubles match partner',
                    icon: Icons.group_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Broadcast Banner CTA
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.paddleBlack, AppColors.darkObsidianBase],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.campaign_rounded, color: AppColors.primary, size: 24),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Ping All Active Venue Members',
                          style: AppTypography.ui(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pushes a notification to all free players in the venue asking if anyone wants to join Table 02.',
                    style: AppTypography.ui(fontSize: 11, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: widget.onInviteSent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.bg,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      '📢 BROADCAST INVITE TO VENUE NOW',
                      style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Free Players in Venue List
            Text(
              'FREE PLAYERS PRESENT IN ARENA (4)',
              style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 1.2),
            ),
            const SizedBox(height: 10),

            ...freePlayers.take(4).map(
              (p) => Container(
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
                      child: Text(
                        p.initials,
                        style: GoogleFonts.bebasNeue(fontSize: 14, color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  p.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.ui(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                decoration: BoxDecoration(color: AppColors.surface3, borderRadius: BorderRadius.circular(8)),
                                child: Text(p.rankLabel, style: AppTypography.ui(fontSize: 8, fontWeight: FontWeight.w700, color: AppColors.xpGold)),
                              ),
                            ],
                          ),
                          Text(
                            '${p.xp} XP • Casual match',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.ui(fontSize: 11, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: widget.onInviteSent,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      ),
                      child: Text('INVITE', style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = _matchMode == index;

    return GestureDetector(
      onTap: () => setState(() => _matchMode = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surface2 : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.textMuted, size: 22),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.bebasNeue(
                fontSize: 16,
                letterSpacing: 1.0,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
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
