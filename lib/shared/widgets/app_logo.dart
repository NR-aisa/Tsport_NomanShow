import 'package:flutter/material.dart';

/// Centralized Official JOMNITTAKU Company Logo Widget.
/// Renders the official circular emblem (3 red stars, motion ball, net)
/// with safe fallback in case of asset bundling delays.
class AppLogo extends StatelessWidget {
  final double size;
  final bool showShadow;
  final Color? borderColor;

  const AppLogo({
    super.key,
    this.size = 40,
    this.showShadow = true,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 1.2)
            : null,
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/company_logo.png',
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Elegant high-fidelity fallback emblem
            return Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1E3A8A), Color(0xFF0F172A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: size * 0.15,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star_rounded, size: size * 0.22, color: const Color(0xFFEF4444)),
                        Icon(Icons.star_rounded, size: size * 0.26, color: const Color(0xFFEF4444)),
                        Icon(Icons.star_rounded, size: size * 0.22, color: const Color(0xFFEF4444)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: size * 0.2,
                    child: Icon(
                      Icons.sports_tennis_rounded,
                      size: size * 0.45,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
