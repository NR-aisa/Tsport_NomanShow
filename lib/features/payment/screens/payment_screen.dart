import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';
import '../../../core/theme/app_typography.dart';

class PaymentScreen extends StatelessWidget {
  final VoidCallback? onPaymentSuccess;

  const PaymentScreen({super.key, this.onPaymentSuccess});

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
                  Row(
                    children: [
                      Text(
                        'Payment',
                        style: AppTypography.ui(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.amethystPurple,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check, size: 12, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              'Connected',
                              style: AppTypography.ui(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Text(
                      '← Back',
                      style: AppTypography.ui(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
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
                    // Hero Paid Confirmation Card (Athletic Blue)
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
                          Container(
                            width: 52,
                            height: 52,
                            decoration: const BoxDecoration(
                              color: AppColors.voltLime,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, size: 28, color: Colors.white),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Paid',
                            style: AppTypography.ui(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'MEMBER · TODAY',
                            style: AppTypography.ui(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: AppColors.voltLime,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '0.90',
                                style: AppTypography.ui(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -1,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'RM',
                                style: AppTypography.ui(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.ittfTableBorder,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'JOMNITTAKU — 3 Damansara',
                            style: AppTypography.ui(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Receipt Card (Athletic Obsidian Card)
                    Container(
                      padding: const EdgeInsets.all(20),
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
                          Text(
                            'RECEIPT',
                            style: AppTypography.ui(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: AppColors.ittfTableBorder,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 14),
                          _buildReceiptRow(
                            'Payee',
                            'JOMMENANG',
                            subValue: 'Malaysia National QR',
                          ),
                          Divider(color: AppColors.obsidianBorder, height: 16),
                          _buildReceiptRow('Method', 'DuitNow QR'),
                          Divider(color: AppColors.obsidianBorder, height: 16),
                          _buildReceiptRow(
                            'Card',
                            'via Wise or Stripe',
                            subValue: 'one gateway',
                          ),
                          Divider(color: AppColors.obsidianBorder, height: 16),
                          _buildReceiptRow(
                            'Status',
                            '✓ Connected',
                            valueColor: AppColors.voltLime,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 3 Info Pills Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoPill(
                            label: 'Method',
                            value: 'DuitNow QR',
                            bgColor: AppColors.pastelGreen,
                            icon: Icons.qr_code,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildInfoPill(
                            label: 'Tables free',
                            value: '6 of 10',
                            bgColor: AppColors.pastelBlue,
                            icon: Icons.grid_view_rounded,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildInfoPill(
                            label: 'Branch',
                            value: '3 Damansara',
                            bgColor: AppColors.pastelPurple,
                            icon: Icons.storefront_outlined,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // 3D Tactile Continue Button
                    TactileButton.dark(
                      text: 'Continue →',
                      onPressed: onPaymentSuccess ?? () => AppNavigator.toPass(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Walk-in · RM17 · Member · 0.90 RM · Card via Wise or Stripe',
                      style: AppTypography.ui(fontSize: 10, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 10),
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

  static Widget _buildReceiptRow(String label, String value, {String? subValue, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.ui(fontSize: 13, color: AppColors.textSecondary),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: AppTypography.ui(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: valueColor ?? AppColors.textPrimary,
              ),
            ),
            if (subValue != null)
              Text(
                subValue,
                style: AppTypography.ui(fontSize: 10, color: AppColors.textMuted),
              ),
          ],
        ),
      ],
    );
  }

  static Widget _buildInfoPill({
    required String label,
    required String value,
    required Color bgColor,
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
              color: bgColor.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 12, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(label, style: AppTypography.ui(fontSize: 9, color: AppColors.textSecondary)),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
