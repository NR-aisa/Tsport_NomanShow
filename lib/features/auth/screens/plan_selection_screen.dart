import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';
import '../../../core/theme/app_typography.dart';

class PlanSelectionScreen extends StatefulWidget {
  final VoidCallback? onPlanSelected;

  /// Guests arriving from the entry gate land on the Guest tab directly.
  final bool initialGuest;

  const PlanSelectionScreen({super.key, this.onPlanSelected, this.initialGuest = false});

  @override
  State<PlanSelectionScreen> createState() => _PlanSelectionScreenState();
}

class _PlanSelectionScreenState extends State<PlanSelectionScreen> {
  late int _activeTab = widget.initialGuest ? 1 : 0; // 0 = Member, 1 = Guest

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Toggle Tabs: Member vs Guest
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.obsidianBorder),
                      ),
                      child: Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: AppColors.textPrimary),
                    ),
                  ),
                  Expanded(
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
                                  color: _activeTab == 0 ? AppColors.ittfTableBlue : Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    'Member',
                                    style: AppTypography.ui(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
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
                                  color: _activeTab == 1 ? AppColors.ittfTableBlue : Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    'Guest',
                                    style: AppTypography.ui(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
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
                ],
              ),
            ),

            // Main Body Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: [
                    // Hero Athletic Sign-In Card
                    Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.darkObsidianCard, AppColors.darkObsidianElevated],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: AppColors.ittfTableBorder.withValues(alpha: 0.35),
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
                              Text(
                                "TODAY'S SIGN-IN",
                                style: AppTypography.ui(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.ittfTableBorder,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '90 SEN',
                                style: AppTypography.ui(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -1.0,
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Coin stack glyph
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.ittfTableSurface.withValues(alpha: 0.20),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.toll_rounded, size: 24, color: AppColors.ittfTableBorder),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                '0.90 RM for the whole day.',
                                style: AppTypography.ui(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Walk-ins pay RM17 — you save RM16.10.',
                                style: AppTypography.ui(
                                  fontSize: 12,
                                  color: AppColors.voltLime,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),

                        // Floating RM0.90 pill
                        Positioned(
                          bottom: -14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.ittfTableBlue,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.ittfTableBorder, width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.25),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              'RM0.90',
                              style: AppTypography.ui(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),

                    // 3 Mini Metric Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildPillCard(
                            label: 'Saves',
                            value: 'RM16.10',
                            accentColor: AppColors.voltLime,
                            icon: Icons.star_border_rounded,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildPillCard(
                            label: 'Walk-in',
                            value: 'RM17',
                            accentColor: AppColors.hyperCyan,
                            icon: Icons.crop_square_rounded,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildPillCard(
                            label: 'Member',
                            value: 'RM90/mo',
                            accentColor: AppColors.amethystPurple,
                            icon: Icons.diamond_outlined,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // User Profile Strip Card (Athletic Dark Card)
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: AppColors.obsidianBorder,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Aiman Rahman',
                                          style: AppTypography.ui(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.amethystPurple,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            'LVL 12',
                                            style: AppTypography.ui(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Member · Renews 1 Dec',
                                      style: AppTypography.ui(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // XP Progress
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('1,240 XP', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                              Text('360 XP to LVL 13', style: AppTypography.ui(fontSize: 11, color: AppColors.textMuted)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: const LinearProgressIndicator(
                              value: 1240 / 1600,
                              minHeight: 6,
                              backgroundColor: AppColors.darkObsidianCardLight,
                              valueColor: AlwaysStoppedAnimation(AppColors.ittfTableBorder),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Divider(color: AppColors.obsidianBorder, height: 1),
                          const SizedBox(height: 10),

                          Text(
                            'RM90 / month · Paid · 6 of 10 tables free',
                            style: AppTypography.ui(fontSize: 11, color: AppColors.textSecondary),
                          ),
                          Text(
                            'Today\'s quest: Win 1 challenge → +200 XP',
                            style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.voltLime),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 3D Tactile CTA Button
                    TactileButton.dark(
                      text: _activeTab == 0 ? 'Pay 0.90 RM & Enter →' : 'Pay RM 17 Walk-in →',
                      onPressed: widget.onPlanSelected ?? () => AppNavigator.toPayment(context),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // Bottom Nav
            const JomnittakuNavBar(activeIndex: 0),
          ],
        ),
      ),
    );
  }

  static Widget _buildPillCard({
    required String label,
    required String value,
    required Color accentColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.obsidianBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 12, color: accentColor),
          ),
          const SizedBox(height: 6),
          Text(label, style: AppTypography.ui(fontSize: 9, color: AppColors.textSecondary)),
          Text(value, style: AppTypography.ui(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
