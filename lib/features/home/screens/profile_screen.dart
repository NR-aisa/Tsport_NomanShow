import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../core/session/app_session.dart';
import '../../../core/theme/app_theme_controller.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/arena_widgets.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/app_typography.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback? onPurchaseXpTap;

  const ProfileScreen({super.key, this.onPurchaseXpTap});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showOnLeaderboard = true;
  bool _notificationsOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBg,
      body: ArenaBackdrop(
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
                        border: Border.all(color: AppColors.obsidianBorder),
                      ),
                      child: Icon(Icons.arrow_back_ios_new, size: 16, color: AppColors.textPrimary),
                    ),
                  ),
                  Text(
                    'Profile',
                    style: AppTypography.ui(
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
                              GestureDetector(
                                onTap: () => setState(() => AppSession.cycleAvatar()),
                                child: AvatarPhoto(
                                  size: 52,
                                  initial: 'A',
                                  asset: AppSession.avatarAsset,
                                  ringColor: AppColors.obsidianBorder,
                                  ringWidth: 1,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Aiman Rahman',
                                      style: AppTypography.ui(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      'aiman@email.com · +60 12-345 6789',
                                      style: AppTypography.ui(
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
                                  style: AppTypography.ui(
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
                                  style: AppTypography.ui(
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
                                      style: AppTypography.ui(
                                        fontSize: 44,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.textPrimary,
                                        letterSpacing: -1,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'XP',
                                      style: AppTypography.ui(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.radiantGold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '360 XP to LVL 13',
                                  style: AppTypography.ui(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: 1240 / 1600,
                              minHeight: 6,
                              backgroundColor: AppColors.isDark ? AppColors.darkObsidianCardLight : AppColors.lightBorder,
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
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.obsidianBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Today\'s quest', style: AppTypography.ui(fontSize: 12, color: AppColors.textSecondary)),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Win 1 challenge → +200 XP',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.ui(
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
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.obsidianBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Member card', style: AppTypography.ui(fontSize: 12, color: AppColors.textSecondary)),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'RM90 / MO',
                                  style: AppTypography.ui(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  'Valid to 1 Dec · 90 sen / day',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.ui(fontSize: 10, color: AppColors.textMuted),
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
                      style: AppTypography.ui(fontSize: 11, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 16),

                    // Privacy Consent Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: BorderRadius.circular(16),
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
                                style: AppTypography.ui(
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
                    const SizedBox(height: 18),

                    // Settings (Phase 6 — Toby's profile pattern: grouped
                    // sections, quiet meter, Display+Change for identity,
                    // calm danger zone. See docs/TOBY_PROFILE_ADDENDUM.md.)
                    _settingsGroup(
                      'ACCOUNT',
                      [
                        _prefRow(
                          icon: Icons.badge_rounded,
                          title: 'Signed in as',
                          subtitle: AppSession.isGuest
                              ? 'Guest walk-in · RM17 at the door'
                              : 'Registered member · ${AppSession.displayName}',
                          trailing: GestureDetector(
                            onTap: () => ArenaToast.show(
                              context,
                              message: 'Demo build — account changes are simulated',
                            ),
                            child: Text(
                              'Change',
                              style: AppTypography.ui(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.hyperCyan,
                              ),
                            ),
                          ),
                        ),
                        Divider(height: 1, color: AppColors.obsidianBorder),
                        _prefRow(
                          icon: Icons.card_membership_rounded,
                          title: 'Membership',
                          subtitle: 'Member pass · RM90/month',
                          trailing: Text(
                            'RM90/mo',
                            style: AppTypography.ui(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _settingsGroup(
                      'ARENA',
                      [
                        _prefRow(
                          icon: Icons.dark_mode_rounded,
                          title: 'Dark theme',
                          subtitle: 'Midnight Stadium look',
                          trailing: Switch(
                            value: AppColors.isDark,
                            activeThumbColor: AppColors.voltLime,
                            onChanged: (_) => setState(() => AppThemeController.toggleTheme()),
                          ),
                        ),
                        Divider(height: 1, color: AppColors.obsidianBorder),
                        _prefRow(
                          icon: Icons.notifications_rounded,
                          title: 'Notifications',
                          subtitle: 'Match invites & quest reminders',
                          trailing: Switch(
                            value: _notificationsOn,
                            activeThumbColor: AppColors.voltLime,
                            onChanged: (v) => setState(() => _notificationsOn = v),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Quiet membership meter (Toby's plan meter, Arena version).
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianCard,
                        borderRadius: AppRadius.brCard,
                        boxShadow: AppColors.cardShadow,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Member pass',
                                style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                              ),
                              Text(
                                'Renews 1 Dec',
                                style: AppTypography.ui(fontSize: 11, color: AppColors.textMuted),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: 0.6,
                              minHeight: 5,
                              backgroundColor: AppColors.surfaceMuted,
                              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.voltLime),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '6 of 10 tables free tonight · 18 days left in this cycle',
                            style: AppTypography.ui(fontSize: 11, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _settingsGroup(
                      'ABOUT',
                      [
                        _linkRow(Icons.help_outline_rounded, 'FAQ'),
                        Divider(height: 1, color: AppColors.obsidianBorder),
                        _linkRow(Icons.description_rounded, 'Terms of Service'),
                        Divider(height: 1, color: AppColors.obsidianBorder),
                        _linkRow(Icons.privacy_tip_rounded, 'Privacy Policy'),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Danger zone — calm and outlined, like Toby's.
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'DANGER ZONE',
                        style: AppTypography.ui(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textSecondary,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Delete account — this action is irreversible and your XP will be gone forever.',
                            style: AppTypography.ui(fontSize: 11, color: AppColors.textSecondary),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => ArenaToast.show(
                            context,
                            message: 'Demo build — accounts are simulated, nothing to delete',
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.electricCrimson),
                            ),
                            child: Text(
                              'Delete Account',
                              style: AppTypography.ui(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.electricCrimson,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Log out — signs out and returns to the Login screen.
                    GestureDetector(
                      onTap: () {
                        AppSession.signOut();
                        AppNavigator.toLoginAndClear(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.logout_rounded, size: 16, color: AppColors.electricCrimson),
                          const SizedBox(width: 6),
                          Text(
                            'Log Out',
                            style: AppTypography.ui(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.electricCrimson,
                            ),
                          ),
                        ],
                      ),
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
      ),
    );
  }

  /// Toby settings group: quiet grey header + one borderless recipe card.
  Widget _settingsGroup(String label, List<Widget> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.ui(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: AppColors.textSecondary,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.obsidianCard,
            borderRadius: AppRadius.brCard,
            boxShadow: AppColors.cardShadow,
          ),
          child: Column(children: rows),
        ),
      ],
    );
  }

  Widget _linkRow(IconData icon, String title) {
    return GestureDetector(
      onTap: () => ArenaToast.show(
        context,
        message: 'Demo build — this page is not wired yet',
      ),
      child: _prefRow(
        icon: icon,
        title: title,
        subtitle: '',
        trailing: Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.textMuted),
      ),
    );
  }

  Widget _prefRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.ui(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.ui(fontSize: 11, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          trailing,
        ],
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
          Text(label, style: AppTypography.ui(fontSize: 10, color: AppColors.textSecondary)),
          Text(
            value,
            style: AppTypography.ui(
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
