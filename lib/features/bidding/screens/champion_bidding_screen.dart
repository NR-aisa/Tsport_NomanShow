import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';
import '../../../core/theme/app_typography.dart';

class ChampionBiddingScreen extends StatefulWidget {
  final VoidCallback? onBidPlaced;

  const ChampionBiddingScreen({super.key, this.onBidPlaced});

  @override
  State<ChampionBiddingScreen> createState() => _ChampionBiddingScreenState();
}

class _ChampionBiddingScreenState extends State<ChampionBiddingScreen> {
  int _tabIndex = 0; // 0 = Bid, 1 = History
  int _selectedBid = 400; // 350, 400, 500

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar: Bid vs History Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                        onTap: () => setState(() => _tabIndex = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _tabIndex == 0 ? AppColors.ittfTableBlue : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              'Bid',
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _tabIndex == 1 ? AppColors.ittfTableBlue : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              'History',
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

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Champion Header Card (Athletic Dark Card with Company Logo)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: AppColors.obsidianBorder),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.obsidianBorder),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/company_logo.png',
                                width: 44,
                                height: 44,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('PLAY THE', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.ittfTableBorder, letterSpacing: 0.8)),
                                Text('Champion', style: AppTypography.ui(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                                Text('National champion · This branch · One game', style: AppTypography.ui(fontSize: 10, color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Highest Bid Card (Athletic Navy & Gold)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: AppColors.radiantGold.withValues(alpha: 0.35),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.radiantGold.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.radiantGold.withValues(alpha: 0.4)),
                            ),
                            child: Text(
                              'HIGHEST BID',
                              style: AppTypography.ui(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.radiantGold),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'RM320',
                            style: AppTypography.ui(fontSize: 44, fontWeight: FontWeight.w900, color: AppColors.textPrimary, letterSpacing: -1),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'MINIMUM SET BY THE OWNER · PER BRANCH / PLAYER',
                            textAlign: TextAlign.center,
                            style: AppTypography.ui(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.textSecondary, letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Analog Clock Countdown (Obsidian Dial)
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.obsidianCard,
                              border: Border.all(color: AppColors.ittfTableBorder, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.25),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(Icons.access_time_rounded, size: 36, color: AppColors.ittfTableBorder),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '02:14:36',
                            style: AppTypography.ui(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textPrimary, letterSpacing: 1),
                          ),
                          Text(
                            'Closes in',
                            style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Bid Ladder Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.obsidianBorder),
                      ),
                      child: Row(
                        children: [
                          Text('BID LADDER', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.ittfTableBorder, letterSpacing: 0.8)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '320 HIGH · 350 · 400 YOU · 500 MAX',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Your Bid Presets
                    Text(
                      'YOUR BID (RM) · RANGE 100–500',
                      style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: 0.8),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(child: _buildBidPill(350)),
                        const SizedBox(width: 8),
                        Expanded(child: _buildBidPill(400)),
                        const SizedBox(width: 8),
                        Expanded(child: _buildBidPill(500)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 3D Tactile CTA Button
                    TactileButton.dark(
                      text: 'Place Bid — $_selectedBid RM',
                      onPressed: widget.onBidPlaced,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Minimum set by the owner. You\'ll be notified if you\'re outbid. Winner pays via Payment (06).',
                      textAlign: TextAlign.center,
                      style: AppTypography.ui(fontSize: 10, color: AppColors.textSecondary),
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

  Widget _buildBidPill(int amount) {
    final isSelected = _selectedBid == amount;

    return GestureDetector(
      onTap: () => setState(() => _selectedBid = amount),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.ittfTableBlue : AppColors.obsidianCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.ittfTableBorder : AppColors.obsidianBorder,
          ),
        ),
        child: Center(
          child: Text(
            'RM$amount',
            style: AppTypography.ui(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
