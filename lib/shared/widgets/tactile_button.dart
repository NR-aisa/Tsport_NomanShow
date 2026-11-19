import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';

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

  const TactileButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF16233B),
    this.bottomBorderColor = const Color(0xFF0A1120),
    this.textColor = Colors.white,
    this.height = 54,
    this.width,
    this.icon,
    this.fontSize = 15,
    this.isFullWidth = true,
    this.borderRadius = 28,
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
      backgroundColor: const Color(0xFF10B981),
      bottomBorderColor: const Color(0xFF047857),
      textColor: Colors.white,
      icon: icon,
      isFullWidth: isFullWidth,
      height: height,
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
      backgroundColor: const Color(0xFF00F59B),
      bottomBorderColor: const Color(0xFF00B36B),
      textColor: const Color(0xFF080B10),
      icon: icon,
      isFullWidth: isFullWidth,
      height: height,
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
      backgroundColor: const Color(0xFF00F2FE),
      bottomBorderColor: const Color(0xFF00A8B3),
      textColor: const Color(0xFF080B10),
      icon: icon,
      isFullWidth: isFullWidth,
      height: height,
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
      backgroundColor: const Color(0xFF00F2FE),
      bottomBorderColor: const Color(0xFF00A8B3),
      textColor: const Color(0xFF080B10),
      icon: icon,
      isFullWidth: isFullWidth,
      height: height,
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
      backgroundColor: const Color(0xFFFF2E63),
      bottomBorderColor: const Color(0xFFC70039),
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
      backgroundColor: const Color(0xFF161E2E),
      bottomBorderColor: const Color(0xFF0A0F17),
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
      bottomBorderColor: const Color(0xFFCBD5E1),
      textColor: const Color(0xFF0F172A),
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
    final double currentPush = _isPressed ? extrusion - 1.0 : 0.0;
    final double currentBottom = _isPressed ? 1.0 : extrusion;

    Widget buttonContent = Container(
      height: widget.height,
      width: widget.isFullWidth ? double.infinity : widget.width,
      margin: EdgeInsets.only(top: currentPush, bottom: extrusion - currentPush),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
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
        ],
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
                style: GoogleFonts.plusJakartaSans(
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
      child: buttonContent,
    );
  }
}
