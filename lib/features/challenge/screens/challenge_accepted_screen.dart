import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';
import '../../../core/theme/app_typography.dart';

class ChallengeAcceptedScreen extends StatefulWidget {
  final VoidCallback? onAtTableTap;

  const ChallengeAcceptedScreen({super.key, this.onAtTableTap});

  @override
  State<ChallengeAcceptedScreen> createState() => _ChallengeAcceptedScreenState();
}

class _ChallengeAcceptedScreenState extends State<ChallengeAcceptedScreen> {
  /// Real ticking countdown (Arena DS: a timer that doesn't move is a bug,
  /// not a design). Starts at 5:00 and expires honestly.
  int _secondsLeft = 5 * 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool get _expired => _secondsLeft <= 0;

  String get _mmss {
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final sec = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Badge
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.voltLime.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.voltLime.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.voltLime,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Challenge Accepted',
                        style: AppTypography.ui(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppColors.voltLime,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Column(
                  children: [
                    // Dual Fighter Cards
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(14),
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
                                const SizedBox(height: 8),
                                Text('You', style: AppTypography.ui(fontSize: 10, color: AppColors.textSecondary)),
                                Text('1,240 XP', style: AppTypography.ui(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                                const SizedBox(height: 6),
                                const Icon(Icons.show_chart_rounded, size: 16, color: AppColors.amethystPurple),
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
                            padding: const EdgeInsets.all(14),
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
                                const SizedBox(height: 8),
                                Text('Jason T.', style: AppTypography.ui(fontSize: 10, color: AppColors.textSecondary)),
                                Text('1,180 XP', style: AppTypography.ui(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                                const SizedBox(height: 6),
                                const Icon(Icons.show_chart_rounded, size: 16, color: AppColors.electricCrimson),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Table Assignment Pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.ittfTableSurface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Table No. 4 · Ready for Play',
                        style: AppTypography.ui(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Analog Countdown Clock Graphic
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.obsidianCard,
                        border: Border.all(color: AppColors.ittfTableBorder, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: AppColors.isDark ? 0.3 : 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.access_time_rounded, size: 40, color: AppColors.ittfTableSurface),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      _mmss,
                      style: AppTypography.mono(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: _expired ? AppColors.electricCrimson : AppColors.textPrimary,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      _expired ? 'Time expired — this challenge was released' : 'Accept within 5 minutes',
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Pot Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.obsidianBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'POT · WINNER TAKES ALL',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.ui(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textMuted,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '200 XP',
                            style: AppTypography.ui(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: AppColors.radiantGold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Room Code Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.obsidianBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ROOM CODE',
                                style: AppTypography.ui(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textMuted,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'KX8VQS',
                                style: AppTypography.ui(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.textPrimary,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                'or scan the QR at Table 4',
                                style: AppTypography.ui(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SizedBox(
                              width: 52,
                              height: 52,
                              child: QrImageView(
                                data: 'jomnittaku://match/KX8VQS',
                                size: 52,
                                version: QrVersions.auto,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Action Buttons: Decline vs Accept
                    Row(
                      children: [
                        Expanded(
                          child: TactileButton.white(
                            text: 'Decline',
                            onPressed: () => Navigator.maybePop(context),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TactileButton.volt(
                            text: 'Accept Match →',
                            onPressed: widget.onAtTableTap ?? () => AppNavigator.toLeaderboard(context),
                          ),
                        ),
                      ],
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
}
