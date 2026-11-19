import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback? onPurchaseXpTap;

  const ProfileScreen({super.key, this.onPurchaseXpTap});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showOnLeaderboard = true;

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
                    'Profile',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.obsidianCard,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.obsidianBorder),
                    ),
                    child: const Icon(Icons.notifications_rounded, size: 20, color: AppColors.radiantGold),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: [
                    // Profile Hero Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: AppColors.obsidianBorder),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: AppColors.isDark ? 0.3 : 0.05),
                            blurRadius: 12,
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
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceSubtle,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.obsidianBorder),
                                ),
                                child: const Icon(Icons.sports_tennis, size: 28, color: Color(0xFF60A5FA)),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Aiman Rahman',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      'aiman@email.com · +60 12-345 6789',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.obsidianBorder),
                                  borderRadius: BorderRadius.circular(16),
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
                          const SizedBox(height: 20),

                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'YOUR POINTS',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textMuted,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '1,240',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 44,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.textPrimary,
                                        letterSpacing: -1,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'XP',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.radiantGold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '360 XP to LVL 13',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: 1240 / 1600,
                              minHeight: 6,
                              backgroundColor: AppColors.isDark ? const Color(0xFF1E2D4A) : const Color(0xFFE2E8F0),
                              valueColor: const AlwaysStoppedAnimation(AppColors.ittfTableSurface),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 3 Metric Pills Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatTile('Rank', '#4', AppColors.pastelPurple, Icons.arrow_drop_up_rounded),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildStatTile('Level', 'LVL 12', AppColors.pastelGreen, Icons.star_border_rounded),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildStatTile('Member', 'RM90/mo', AppColors.pastelBlue, Icons.storefront_outlined),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Quest Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.obsidianBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Today\'s quest', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary)),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Win 1 challenge → +200 XP',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: AppColors.voltLime,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Member card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.obsidianBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Member card', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary)),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'RM90 / MO',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  'Valid to 1 Dec · 90 sen / day',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.textMuted),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    Text(
                      'Everyone starts at 1,500 XP. Win = up, lose = down.',
                      style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 16),

                    // Privacy Consent Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.obsidianBorder),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _showOnLeaderboard,
                            activeColor: AppColors.ittfTableSurface,
                            onChanged: (val) => setState(() => _showOnLeaderboard = val ?? true),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Show me on the leaderboard — photo + name on mobile & TV. Untick = Anonymous.',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 3D Tactile Action Button
                    TactileButton.volt(
                      text: 'Top Up XP Balance →',
                      onPressed: widget.onPurchaseXpTap ?? () => AppNavigator.toXpStore(context),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Bottom Nav
            const JomnittakuNavBar(activeIndex: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
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
            child: Icon(icon, size: 14, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.textSecondary)),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
