import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/arena_widgets.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final VoidCallback? onSelectTable;
  final VoidCallback? onGoDashboard;

  const PaymentSuccessScreen({
    super.key,
    this.onSelectTable,
    this.onGoDashboard,
  });

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  int _tabIndex = 0; // 0 = Registered QR, 1 = Guest QR
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    // Phase 6: payment success is a milestone — celebrate once, briefly.
    WidgetsBinding.instance.addPostFrameCallback((_) => _confettiController.play());
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBg,
      body: Stack(
        children: [
          ArenaBackdrop(
            child: SafeArea(
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
                        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: Colors.white),
                    ),
                  ),
                  Text(
                    'Entry Pass',
                    style: AppTypography.ui(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.obsidianCard,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                    ),
                    child: const Icon(Icons.notifications_rounded, size: 20, color: AppColors.radiantGold),
                  ),
                ],
              ),
            ),

            // Tabs: REGISTERED QR vs GUEST QR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.obsidianCard,
                  borderRadius: BorderRadius.circular(28),
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
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              'REGISTERED QR',
                              style: AppTypography.ui(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: _tabIndex == 0 ? Colors.white : Colors.white60,
                                letterSpacing: 0.5,
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
                              'GUEST QR',
                              style: AppTypography.ui(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: _tabIndex == 1 ? Colors.white : Colors.white60,
                                letterSpacing: 0.5,
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
                  children: [
                    // Light success surface first (Toby pattern), then the pass.
                    const SuccessCard(
                      title: 'Payment successful',
                      message: 'Your entry pass is ready — scan at the turnstile.',
                    ),
                    const SizedBox(height: 12),
                    // Hero QR Card (Dark Obsidian with High-Contrast White QR Box)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: AppColors.voltLime.withValues(alpha: 0.35),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.electricCrimson.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.electricCrimson.withValues(alpha: 0.4)),
                                ),
                                child: Text(
                                  'DOOR LOCKED',
                                  style: AppTypography.ui(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.rankBronze),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.voltLime.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.voltLime.withValues(alpha: 0.4)),
                                ),
                                child: Text(
                                  'Ready to scan',
                                  style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.voltLime),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // QR Code Container
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 140,
                              height: 140,
                              child: QrImageView(
                                data: 'jomnittaku://entry/3damansara/KX8VQS',
                                size: 140.0,
                                version: QrVersions.auto,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Text(
                            'Show',
                            style: AppTypography.ui(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                          ),
                          Text(
                            'at the venue turnstile scanner',
                            style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white60),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.darkObsidianElevated,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.ittfTableBorder.withValues(alpha: 0.4)),
                            ),
                            child: Text(
                              'KX8VQS',
                              style: AppTypography.ui(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                color: AppColors.ittfTableBorder,
                                letterSpacing: 4.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 3 Info Pills Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildGatePill('Ticket', 'Registered', AppColors.voltLime, Icons.circle),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildGatePill('Gate', 'Main', AppColors.hyperCyan, Icons.crop_square_rounded),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildGatePill('Entry', '90 sen/day', AppColors.amethystPurple, Icons.auto_awesome),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Venue Map Strip
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Venue map', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white)),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  '3 Damansara · 6 of 10 Free',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.ui(fontSize: 11, color: AppColors.voltLime),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildMiniTable(hasDotLeft: true),
                              _buildMiniTable(hasDotRight: true),
                              _buildMiniTable(hasDotLeft: true),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 3D Tactile CTA Button
                    TactileButton.dark(
                      text: 'Select Arena Table →',
                      onPressed: widget.onSelectTable ?? widget.onGoDashboard ?? () => AppNavigator.toTables(context),
                    ),
                    const SizedBox(height: 10),

                    // RM 200 Fine Warning Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Center(
                        child: Text(
                          'No proof of payment when asked = RM200 fine',
                          style: AppTypography.ui(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.05,
              numberOfParticles: 28,
              gravity: 0.25,
              shouldLoop: false,
              colors: const [
                AppColors.voltLime,
                AppColors.radiantGold,
                Colors.white,
                AppColors.ittfTableSurface,
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildGatePill(String label, String value, Color accentColor, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
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
          Text(label, style: AppTypography.ui(fontSize: 9, color: Colors.white60)),
          Text(value, style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white)),
        ],
      ),
    );
  }

  static Widget _buildMiniTable({bool hasDotLeft = false, bool hasDotRight = false}) {
    return Container(
      width: 64,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.ittfTableBlue,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 1.2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(width: 1.2, color: Colors.white70),
          if (hasDotLeft)
            Positioned(
              left: 12,
              child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.pingPongOrange, shape: BoxShape.circle)),
            ),
          if (hasDotRight)
            Positioned(
              right: 12,
              child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.pingPongOrange, shape: BoxShape.circle)),
            ),
        ],
      ),
    );
  }
}
