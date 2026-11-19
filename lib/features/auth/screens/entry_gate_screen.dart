import 'package:flutter/material.dart';

import '../../../core/navigation/app_navigator.dart';
import '../../../core/session/app_session.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme_controller.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../../shared/widgets/tactile_button.dart';

/// Entry Gate (Phase 1B) — the app's honest front door.
///
/// Three paths, matching the business flow at the venue door:
///  1. Member login   — a returning registered player comes back in.
///  2. New player     — registration, then plan selection.
///  3. Guest walk-in  — RM17 at the door, no account.
///
/// Before this screen existed the app opened straight into a hardcoded
/// demo identity; nobody "entered" at all.
class EntryGateScreen extends StatelessWidget {
  const EntryGateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      builder: (context, isDark) {
        return Scaffold(
          backgroundColor: AppColors.canvasBg,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  const Center(child: AppLogo(size: 84)),
                  const SizedBox(height: 16),
                  Text(
                    'JOMNITTAKU',
                    textAlign: TextAlign.center,
                    style: AppTypography.ui(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'No Man Show · Live Table Tennis Arena',
                    textAlign: TextAlign.center,
                    style: AppTypography.ui(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'At the door: two QRs — Registered or Guest.',
                    textAlign: TextAlign.center,
                    style: AppTypography.ui(fontSize: 11, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 32),

                  // Path 1 — returning member (this login did not exist).
                  TactileButton.volt(
                    text: 'Member Login →',
                    onPressed: () => AppNavigator.toLogin(context),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Registered players: your XP, rank and pass live here.',
                    textAlign: TextAlign.center,
                    style: AppTypography.ui(fontSize: 11, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 20),

                  // Path 2 — new player registration.
                  _PathButton(
                    icon: Icons.person_add_alt_1_rounded,
                    title: 'New Player — Register',
                    subtitle: '90 sen/day member pass · RM90/month',
                    onTap: () => AppNavigator.toRegister(context),
                  ),
                  const SizedBox(height: 12),

                  // Path 3 — guest walk-in.
                  _PathButton(
                    icon: Icons.qr_code_2_rounded,
                    title: 'Guest Walk-In',
                    subtitle: 'RM17 at the door · no account needed',
                    onTap: () {
                      AppSession.continueAsGuest();
                      AppNavigator.toPlan(context, initialGuest: true);
                    },
                  ),
                  const SizedBox(height: 28),

                  Text(
                    'Front-end demo build — login and payment are simulated in the UI; no backend is connected.',
                    textAlign: TextAlign.center,
                    style: AppTypography.ui(fontSize: 10, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PathButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PathButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.obsidianCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.obsidianBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.surfaceSubtle,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: AppColors.textPrimary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.ui(
                      fontSize: 14,
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
            Icon(Icons.chevron_right_rounded, size: 20, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
