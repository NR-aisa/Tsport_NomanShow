import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';

class XpPurchaseScreen extends StatefulWidget {
  final VoidCallback? onPurchased;

  const XpPurchaseScreen({super.key, this.onPurchased});

  @override
  State<XpPurchaseScreen> createState() => _XpPurchaseScreenState();
}

class _XpPurchaseScreenState extends State<XpPurchaseScreen> {
  int _tabIndex = 0; // 0 = Loan, 1 = Buy

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
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: Colors.white),
                    ),
                  ),
                  Text(
                    'Your XP',
                    style: GoogleFonts.plusJakartaSans(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA855F7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'BALANCE',
                      style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            // Tabs: Loan vs Buy
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.obsidianCard,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Loan',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: _tabIndex == 0 ? Colors.white : Colors.white60,
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Buy',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: _tabIndex == 1 ? Colors.white : Colors.white60,
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
                    // Hero Balance Card (Athletic Slate & Gold)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF162544), Color(0xFF0F1A2E)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(26),
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
                          Text('YOUR BALANCE', style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.radiantGold, letterSpacing: 1.0)),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text('140', style: GoogleFonts.plusJakartaSans(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -1)),
                              const SizedBox(width: 6),
                              Text('XP', style: GoogleFonts.plusJakartaSans(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.radiantGold)),
                            ],
                          ),
                          Text('60 XP short of a Standard challenge (200 XP).', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70)),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: const LinearProgressIndicator(
                              value: 140 / 200,
                              minHeight: 6,
                              backgroundColor: Color(0xFF1E2E4E),
                              valueColor: AlwaysStoppedAnimation(AppColors.radiantGold),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text('140 of 200 XP to your next challenge', style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.white54)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Loan Terms Card (Athletic Obsidian Card)
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildLoanTermRow('You receive', '+200 XP', isBold: true, valueColor: const Color(0xFF34D399)),
                          Divider(color: Colors.white.withValues(alpha: 0.08), height: 16),
                          _buildLoanTermRow('Repay', '200 XP from winnings'),
                          Divider(color: Colors.white.withValues(alpha: 0.08), height: 16),
                          _buildLoanTermRow('Terms', 'One loan at a time', subValue: 'From Settings'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 3D Tactile Take Loan Button
                    TactileButton.dark(
                      text: 'Take Loan — +200 XP',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '🎉 +200 XP Loan Approved! Your balance is now 340 XP (Repayable from match winnings).',
                              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
                            ),
                            duration: const Duration(seconds: 3),
                            backgroundColor: const Color(0xFF286E79),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18),

                    // Buy XP Section
                    Text(
                      'BUY XP — PACKS · PRICE FROM SETTINGS',
                      style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: 0.8),
                    ),
                    const SizedBox(height: 8),

                    _buildBuyPackCard('100 XP pack', '100 XP', AppColors.pastelGreen),
                    const SizedBox(height: 8),
                    _buildBuyPackCard('500 XP pack', '500 XP', AppColors.pastelPurple),
                    const SizedBox(height: 14),

                    // Buy CTA
                    TactileButton.dark(
                      text: 'Buy XP → Payment',
                      onPressed: widget.onPurchased ?? () => AppNavigator.toPayment(context),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'XP is not cash. It can\'t be withdrawn.',
                        style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary),
                      ),
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

  Widget _buildLoanTermRow(String label, String value, {bool isBold = false, String? subValue, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.white60)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
                color: valueColor ?? Colors.white,
              ),
            ),
            if (subValue != null)
              Text(subValue, style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.white54)),
          ],
        ),
      ],
    );
  }

  Widget _buildBuyPackCard(String title, String xpLabel, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(Icons.toll_rounded, size: 20, color: color),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white)),
                Text('Price from Settings', style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.white54)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1A2E),
              border: Border.all(color: const Color(0xFF60A5FA).withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(xpLabel, style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w800, color: const Color(0xFF60A5FA))),
          ),
        ],
      ),
    );
  }
}
