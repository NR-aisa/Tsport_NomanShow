import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock/mock_data.dart';
import '../../../core/theme/app_typography.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const stats = MockData.adminStats;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        Widget contentArea = SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 16 : 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isMobile) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.maybePop(context),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: AppColors.textPrimary),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                'ADMIN OVERVIEW',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.bebasNeue(fontSize: 22, color: AppColors.primary, letterSpacing: 1.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          '10 TABLES LIVE',
                          style: AppTypography.ui(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ] else ...[
                  // Desktop Header Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ARENA OVERVIEW & REVENUE ANALYTICS',
                            style: GoogleFonts.bebasNeue(fontSize: 32, letterSpacing: 1.5, color: AppColors.textPrimary),
                          ),
                          Text(
                            'Real-time automated venue telemetry • No human intervention required',
                            style: AppTypography.ui(fontSize: 13, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, size: 14, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Text('Today, 18 Nov 2026', style: AppTypography.ui(fontSize: 12, color: AppColors.textPrimary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],

                // 4 Top KPI Metric Cards
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    SizedBox(
                      width: isMobile ? (constraints.maxWidth - 44) / 2 : 220,
                      child: _buildMetricCard(
                        title: 'ACTIVE PLAYERS',
                        value: '${stats.activeNow}',
                        sub: 'of 20 max capacity (70%)',
                        subColor: AppColors.primary,
                        icon: Icons.groups_rounded,
                      ),
                    ),
                    SizedBox(
                      width: isMobile ? (constraints.maxWidth - 44) / 2 : 220,
                      child: _buildMetricCard(
                        title: 'TABLES OCCUPIED',
                        value: '4/10',
                        sub: '6 tables currently free',
                        subColor: AppColors.ittfTableBorder,
                        icon: Icons.table_restaurant_rounded,
                      ),
                    ),
                    SizedBox(
                      width: isMobile ? (constraints.maxWidth - 44) / 2 : 220,
                      child: _buildMetricCard(
                        title: 'TODAY REVENUE',
                        value: 'RM ${stats.todayRevenue.toStringAsFixed(2)}',
                        sub: '+18% vs yesterday',
                        subColor: AppColors.primary,
                        icon: Icons.monetization_on_rounded,
                        isGold: true,
                      ),
                    ),
                    SizedBox(
                      width: isMobile ? (constraints.maxWidth - 44) / 2 : 220,
                      child: _buildMetricCard(
                        title: 'MONTH TO DATE',
                        value: 'RM ${stats.totalRevenueThisMonth.toStringAsFixed(0)}',
                        sub: 'Target: RM 25,000',
                        subColor: AppColors.textMuted,
                        icon: Icons.trending_up_rounded,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Live Table Sensors & Automation Status
                Text(
                  'ARENA HARDWARE & AUTOMATION HEALTH',
                  style: GoogleFonts.bebasNeue(fontSize: 20, letterSpacing: 1.2, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 10),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    SizedBox(
                      width: isMobile ? double.infinity : 380,
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'DOOR ACCESS CONTROLLER',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(color: AppColors.voltLime.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                                  child: Text('ONLINE', style: AppTypography.ui(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.voltLime)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text('Main Turnstile QR Scanner: Active', style: AppTypography.ui(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                            Text('DuitNow Dynamic QR Sync: Operational', style: AppTypography.ui(fontSize: 12, color: AppColors.textSecondary)),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.surface2,
                                    foregroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Text('TRIGGER EMERGENCY OPEN', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: isMobile ? double.infinity : 380,
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'DYNAMIC VENUE PRICING',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(color: AppColors.ittfTableSurface.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                                  child: Text('AUTO PILOT', style: AppTypography.ui(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.ittfTableBorder)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildSettingRow('Monthly Pro Membership', 'RM 90.00 / mo'),
                            _buildSettingRow('Walk-in Rate (3 hrs)', 'RM 17.00'),
                            _buildSettingRow('Unpaid Entry Penalty', 'RM 200.00 (Active)'),
                            _buildSettingRow('Starting XP Bonus', '1,500 XP'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Recent Real-time Transactions Table
                Text(
                  'REAL-TIME AUDIT & TRANSACTION LOG',
                  style: GoogleFonts.bebasNeue(fontSize: 20, letterSpacing: 1.2, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 10),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 700,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: [
                          _buildLogHeader(),
                          Divider(color: AppColors.border, height: 1),
                          _buildLogRow('Noman Rashid', 'Pro Membership Pass', 'RM 90.00', 'DuitNow QR', '2 min ago', 'COMPLETED'),
                          _buildLogRow('Lee Wei Ming', 'Walk-in 3hr Pass', 'RM 17.00', 'Touch \'n Go', '15 min ago', 'COMPLETED'),
                          _buildLogRow('Priya Nair', 'XP Recharge Pack (1,200 XP)', 'RM 10.00', 'Maybank QR', '42 min ago', 'COMPLETED'),
                          _buildLogRow('Rajan Kumar', 'Pro Membership Renewal', 'RM 90.00', 'Credit Card', '1h ago', 'COMPLETED'),
                          _buildLogRow('Farah Zainudin', 'Walk-in 3hr Pass', 'RM 17.00', 'GrabPay', '2h ago', 'COMPLETED'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );

        if (isMobile) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: contentArea,
          );
        }

        return Scaffold(
          backgroundColor: Colors.black,
          body: Row(
            children: [
              _buildSidebar(context),
              Expanded(child: contentArea),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Admin Logo
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGlow,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Icon(Icons.admin_panel_settings_rounded, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'T SPORTS ADMIN',
                        style: GoogleFonts.bebasNeue(fontSize: 20, color: AppColors.primary, letterSpacing: 1),
                      ),
                      Text(
                        'Multi-Tenant Portal',
                        style: AppTypography.ui(fontSize: 10, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: AppColors.border, height: 1),

            // Hierarchy Selector
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ACTIVE BRANCH', style: AppTypography.ui(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('KL Central Arena', style: AppTypography.ui(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        Icon(Icons.arrow_drop_down, color: AppColors.primary, size: 20),
                      ],
                    ),
                    Text('Branch #01 • 10 Tables', style: AppTypography.ui(fontSize: 10, color: AppColors.primary)),
                  ],
                ),
              ),
            ),

            // Nav Items
            _buildNavItem(Icons.dashboard_rounded, 'Dashboard', true),
            _buildNavItem(Icons.receipt_long_rounded, 'Transactions', false),
            _buildNavItem(Icons.people_alt_rounded, 'Players & Members', false),
            _buildNavItem(Icons.table_restaurant_rounded, 'Arena Tables (10)', false),
            _buildNavItem(Icons.tv_rounded, 'TV Display Screens', false),
            _buildNavItem(Icons.stars_rounded, 'Champion Events', false),
            _buildNavItem(Icons.tune_rounded, 'Dynamic Settings', false),

            const Spacer(),
            Divider(color: AppColors.border, height: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.surface3,
                    child: Icon(Icons.person, size: 18, color: AppColors.primary),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('System Admin', style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      Text('admin@tsports.my', style: AppTypography.ui(fontSize: 10, color: AppColors.textMuted)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildNavItem(IconData icon, String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryGlow : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: AppColors.primary.withValues(alpha: 0.5)) : null,
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: isSelected ? AppColors.primary : AppColors.textSecondary),
          const SizedBox(width: 12),
          Text(
            title,
            style: AppTypography.ui(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildMetricCard({
    required String title,
    required String value,
    required String sub,
    required Color subColor,
    required IconData icon,
    bool isGold = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isGold ? AppColors.xpGold.withValues(alpha: 0.4) : AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.8),
                ),
              ),
              const SizedBox(width: 4),
              Icon(icon, size: 18, color: isGold ? AppColors.xpGold : AppColors.primary),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.bebasNeue(fontSize: 26, color: isGold ? AppColors.xpGold : AppColors.textPrimary, letterSpacing: 1),
          ),
          Text(
            sub,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.ui(fontSize: 10, color: subColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  static Widget _buildSettingRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTypography.ui(fontSize: 12, color: AppColors.textSecondary))),
          const SizedBox(width: 8),
          Text(value, style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  static Widget _buildLogHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('PLAYER NAME', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textMuted))),
          Expanded(flex: 3, child: Text('PURCHASE / PASS', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textMuted))),
          Expanded(flex: 2, child: Text('AMOUNT', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textMuted))),
          Expanded(flex: 2, child: Text('GATEWAY', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textMuted))),
          Expanded(flex: 2, child: Text('STATUS', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textMuted))),
        ],
      ),
    );
  }

  static Widget _buildLogRow(String name, String item, String amount, String method, String time, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                Text(time, style: AppTypography.ui(fontSize: 10, color: AppColors.textMuted)),
              ],
            ),
          ),
          Expanded(flex: 3, child: Text(item, style: AppTypography.ui(fontSize: 11, color: AppColors.textSecondary))),
          Expanded(flex: 2, child: Text(amount, style: AppTypography.mono(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.xpGold))),
          Expanded(flex: 2, child: Text(method, style: AppTypography.ui(fontSize: 11, color: AppColors.textMuted))),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.voltLime.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  status,
                  style: AppTypography.ui(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.voltLime),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
