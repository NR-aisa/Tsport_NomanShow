import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/theme/app_typography.dart';

/// Arena DS component kit — built once, used everywhere.
/// (Phase 3/4: Toast+Undo, EmptyState, SuccessCard, SkeletonCard.)

/// Toby pattern: a light toast with Undo that auto-dismisses, instead of a
/// heavy full-screen confirmation or a bare SnackBar.
class ArenaToast {
  static void show(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.darkObsidianCardLight,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.brLg),
        duration: const Duration(seconds: 5),
        content: Text(
          message,
          style: AppTypography.ui(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        action: (actionLabel != null && onAction != null)
            ? SnackBarAction(
                label: actionLabel,
                textColor: AppColors.voltLime,
                onPressed: onAction,
              )
            : null,
      ),
    );
  }
}

/// Every empty surface teaches the next action (icon, one line, one action).
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: AppRadius.brLg,
        border: Border.all(color: AppColors.obsidianBorder),
      ),
      child: Column(
        children: [
          Icon(icon, size: 36, color: AppColors.textMuted),
          const SizedBox(height: 10),
          Text(
            title,
            style: AppTypography.ui(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTypography.ui(fontSize: 12, color: AppColors.textSecondary),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 12),
            GestureDetector(
              onTap: onAction,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                decoration: BoxDecoration(
                  color: AppColors.voltLime,
                  borderRadius: AppRadius.brSm,
                ),
                child: Text(
                  actionLabel!,
                  style: AppTypography.ui(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Light success surface (Toby): replaces heavy full-screen confirmations
/// for in-flow wins. Milestone celebrations stay rare on purpose.
class SuccessCard extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const SuccessCard({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.check_circle_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.voltLime.withValues(alpha: 0.12),
        borderRadius: AppRadius.brLg,
        border: Border.all(color: AppColors.voltLime.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: AppColors.voltLime),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.ui(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  message,
                  style: AppTypography.ui(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton placeholder while lists load (the shimmer package sat unused;
/// this is a dependency-free pulse with the same job).
class SkeletonCard extends StatelessWidget {
  final double height;

  const SkeletonCard({super.key, this.height = 84});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.35, end: 0.75),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
      builder: (context, t, _) => Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.obsidianCard.withValues(alpha: t),
          borderRadius: AppRadius.brLg,
          border: Border.all(color: AppColors.obsidianBorder),
        ),
      ),
    );
  }
}

/// First-run coachmark tour (Phase 4, Toby pattern): three steps, progress
/// dots, taught inside a card over the real UI — pick a table, challenge a
/// rival, watch XP grow. Skippable, shown once per session.
class CoachmarkTour extends StatefulWidget {
  final VoidCallback onDone;

  const CoachmarkTour({super.key, required this.onDone});

  @override
  State<CoachmarkTour> createState() => _CoachmarkTourState();
}

class _CoachmarkTourState extends State<CoachmarkTour> {
  int _step = 0;

  static const _steps = [
    (
      Icons.table_restaurant_rounded,
      '1 · Pick a free table',
      'Emerald means free. Tap a table on the Tables tab and check in — occupied tables offer Spectate instead.'
    ),
    (
      Icons.sports_mma_rounded,
      '2 · Challenge a rival',
      'Hit Play, stake XP in the pot, winner takes all. You have 5 minutes to accept — the timer is real.'
    ),
    (
      Icons.alt_route_rounded,
      '3 · Watch your XP grow',
      'Quests, streaks and the Path turn every visit into progress. Completed a quest? Claim the reward.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final (icon, title, body) = _steps[_step];
    final isLast = _step == _steps.length - 1;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: AppRadius.brLg,
        border: Border.all(color: AppColors.obsidianBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40, color: AppColors.voltLime),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.ui(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            textAlign: TextAlign.center,
            style: AppTypography.ui(fontSize: 12, color: AppColors.textSecondary, height: 1.45),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < _steps.length; i++)
                Container(
                  width: i == _step ? 18 : 7,
                  height: 7,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: i == _step ? AppColors.voltLime : AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: widget.onDone,
                  child: Center(
                    child: Text(
                      'Skip',
                      style: AppTypography.ui(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isLast) {
                      widget.onDone();
                    } else {
                      setState(() => _step++);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.voltLime,
                      borderRadius: AppRadius.brSm,
                    ),
                    child: Center(
                      child: Text(
                        isLast ? 'Start Playing →' : 'Next →',
                        style: AppTypography.ui(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Phase 6 — the canvas texture behind a screen: Toby's warm gradient wash
/// in light mode, a deep arena glow in dark mode.
class ArenaBackdrop extends StatelessWidget {
  final Widget child;
  const ArenaBackdrop({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.canvasGradient),
      child: child,
    );
  }
}

/// Phase 6 — the ArenaCard recipe, translated from Toby's board cards:
/// borderless, radius 20, one warm step above the canvas, soft diffuse
/// shadow, generous padding, and a gentle press scale when tappable.
/// Resting content should be a title + one meta line; details belong
/// one tap deeper (Toby's resting-state rule).
class ArenaCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;

  const ArenaCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.onTap,
    this.color,
  });

  @override
  State<ArenaCard> createState() => _ArenaCardState();
}

class _ArenaCardState extends State<ArenaCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final card = AnimatedScale(
      scale: _pressed ? 0.98 : 1.0,
      duration: const Duration(milliseconds: 120),
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.color ?? AppColors.obsidianCard,
          borderRadius: AppRadius.brCard,
          boxShadow: AppColors.cardShadow,
        ),
        child: widget.child,
      ),
    );
    if (widget.onTap == null) return card;
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: card,
    );
  }
}

/// Entrance choreography (Phase 6): fade + slight rise with a 40 ms
/// stagger — Toby's "everything arrives softly" rule. Apply to list and
/// section children with their index.
extension ArenaEntrance on Widget {
  Widget arenaEntrance(int index) {
    return animate()
        .fadeIn(
          duration: AppMotion.fade,
          delay: AppMotion.staggerStep * index,
          curve: AppMotion.fadeCurve,
        )
        .slideY(
          begin: 0.04,
          end: 0,
          duration: AppMotion.fade,
          delay: AppMotion.staggerStep * index,
          curve: AppMotion.fadeCurve,
        );
  }
}

/// Circular profile picture (DP). Shows the bundled demo photo when
/// [asset] is set, otherwise falls back to an initial letter — the same
/// fallback the app used everywhere before DPs were wired.
class AvatarPhoto extends StatelessWidget {
  const AvatarPhoto({
    super.key,
    required this.size,
    required this.initial,
    this.asset,
    this.ringColor,
    this.ringWidth = 1.5,
  });

  final double size;
  final String initial;
  final String? asset;
  final Color? ringColor;
  final double ringWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surfaceSubtle,
        border: ringColor != null
            ? Border.all(color: ringColor!, width: ringWidth)
            : null,
      ),
      child: ClipOval(
        child: asset != null
            ? Image.asset(
                asset!,
                width: size,
                height: size,
                fit: BoxFit.cover,
              )
            : Center(
                child: Text(
                  initial,
                  style: AppTypography.ui(
                    fontSize: size * 0.38,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
              ),
      ),
    );
  }
}
