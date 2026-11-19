import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class TactileButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color bottomBorderColor;
  final Color textColor;
  final double height;
  final double? width;
  final IconData? icon;
  final double fontSize;
  final bool isFullWidth;
  final double borderRadius;

  /// Flat = Toby recipe: no extruded 3D lip, no rim light — one soft
  /// shadow and a 0.98 press scale. Used by action/tonal variants.
  final bool flat;
  final Gradient? gradient;
  final Color? glowColor;

  const TactileButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.darkObsidianCard,
    this.bottomBorderColor = AppColors.darkObsidianBase,
    this.textColor = Colors.white,
    this.height = 54,
    this.width,
    this.icon,
    this.fontSize = 15,
    this.isFullWidth = true,
    this.borderRadius = 8, // Windows 11 Fluent: crisp 8px radius, never 28px bubble
    this.flat = false,
    this.gradient,
    this.glowColor,
  });

  factory TactileButton.volt({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isFullWidth = true,
    double height = 54,
  }) {
    return TactileButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColors.tobyCtaStart,
      bottomBorderColor: AppColors.tobyCtaEnd,
      textColor: Colors.white,
      icon: icon,
      isFullWidth: isFullWidth,
      height: height,
      flat: true,
      gradient: AppColors.tobyCtaGradient,
      glowColor: AppColors.tobyCtaGlow,
    );
  }

  factory TactileButton.green({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isFullWidth = true,
  }) {
    return TactileButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColors.btnGreen,
      bottomBorderColor: AppColors.btnGreenBorder,
      textColor: Colors.white,
      icon: icon,
      isFullWidth: isFullWidth,
    );
  }

  factory TactileButton.primary({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isFullWidth = true,
    double height = 54,
  }) {
    return TactileButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColors.tobyCtaStart,
      bottomBorderColor: AppColors.tobyCtaEnd,
      textColor: Colors.white,
      icon: icon,
      isFullWidth: isFullWidth,
      height: height,
      flat: true,
      gradient: AppColors.tobyCtaGradient,
      glowColor: AppColors.tobyCtaGlow,
    );
  }

  factory TactileButton.blue({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isFullWidth = true,
    double height = 54,
  }) {
    return TactileButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColors.actionBlue,
      bottomBorderColor: AppColors.actionBlueDeep,
      textColor: Colors.white,
      icon: icon,
      isFullWidth: isFullWidth,
      height: height,
      flat: true,
    );
  }

  factory TactileButton.cyan({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isFullWidth = true,
    double height = 54,
  }) {
    return TactileButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColors.actionBlue,
      bottomBorderColor: AppColors.actionBlueDeep,
      textColor: Colors.white,
      icon: icon,
      isFullWidth: isFullWidth,
      height: height,
      flat: true,
    );
  }

  /// Quiet secondary action (Toby rule: one loud button per screen).
  factory TactileButton.tonal({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isFullWidth = true,
    double height = 54,
  }) {
    return TactileButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColors.obsidianCard,
      bottomBorderColor: AppColors.obsidianCard,
      textColor: AppColors.textPrimary,
      icon: icon,
      isFullWidth: isFullWidth,
      height: height,
      flat: true,
    );
  }

  factory TactileButton.crimson({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isFullWidth = true,
    double height = 54,
  }) {
    return TactileButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColors.electricCrimson,
      bottomBorderColor: AppColors.duitNowRed,
      textColor: Colors.white,
      icon: icon,
      isFullWidth: isFullWidth,
      height: height,
    );
  }

  factory TactileButton.dark({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isFullWidth = true,
    double height = 54,
  }) {
    return TactileButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColors.darkObsidianElevated,
      bottomBorderColor: AppColors.darkObsidianBase,
      textColor: Colors.white,
      icon: icon,
      isFullWidth: isFullWidth,
      height: height,
    );
  }

  factory TactileButton.white({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isFullWidth = true,
  }) {
    return TactileButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: Colors.white,
      bottomBorderColor: AppColors.slate300,
      textColor: AppColors.slate900,
      icon: icon,
      isFullWidth: isFullWidth,
    );
  }

  @override
  State<TactileButton> createState() => _TactileButtonState();
}

class _TactileButtonState extends State<TactileButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    const double extrusion = 4.0;
    final double currentPush =
        widget.flat ? 0.0 : (_isPressed ? extrusion - 1.0 : 0.0);
    final double currentBottom = _isPressed ? 1.0 : extrusion;

    final hasGradient = widget.gradient != null;
    final hasGlow = widget.glowColor != null;

    Widget buttonContent = Container(
      height: widget.height,
      width: widget.isFullWidth ? double.infinity : widget.width,
      margin: EdgeInsets.only(top: currentPush, bottom: extrusion - currentPush),
      decoration: BoxDecoration(
        color: hasGradient ? null : widget.backgroundColor,
        gradient: widget.gradient,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: hasGradient
            ? Border.all(
                color: Colors.white.withValues(alpha: 0.22),
                width: 1.0,
              )
            : null,
        boxShadow: hasGlow
            ? [
                BoxShadow(
                  color: widget.glowColor!.withValues(
                    alpha: AppColors.isDark ? 0.40 : 0.28,
                  ),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: AppColors.isDark ? 0.25 : 0.08,
                  ),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : (widget.flat
                ? [
                    BoxShadow(
                      color: Colors.black
                          .withValues(alpha: AppColors.isDark ? 0.35 : 0.16),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: widget.bottomBorderColor,
                      offset: Offset(0, currentBottom),
                      blurRadius: 0,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.18),
                      offset: const Offset(0, 1),
                      blurRadius: 0,
                      spreadRadius: 0,
                    ),
                  ]),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, color: widget.textColor, size: 18),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Text(
                widget.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.ui(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w900,
                  color: widget.textColor,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return GestureDetector(
      onTapDown: widget.onPressed == null ? null : (_) => setState(() => _isPressed = true),
      onTapUp: widget.onPressed == null
          ? null
          : (_) {
              setState(() => _isPressed = false);
              widget.onPressed?.call();
            },
      onTapCancel: () => setState(() => _isPressed = false),
      child: widget.flat
          ? AnimatedScale(
              scale: _isPressed ? 0.98 : 1.0,
              duration: const Duration(milliseconds: 120),
              child: buttonContent,
            )
          : buttonContent,
    );
  }
}
