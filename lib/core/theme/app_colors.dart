import 'package:flutter/material.dart';
import 'app_theme_controller.dart';

class AppColors {
  AppColors._();

  static bool get isDark => AppThemeController.isDark;

  // === STATIC TOKENS (DARK & LIGHT SPECIFIC CONSTANTS) ===
  static const darkObsidianBase = Color(0xFF0A1120);       // Deep Midnight Stadium Slate
  static const darkObsidianElevated = Color(0xFF101B30);   // Elevated stadium card base
  static const darkObsidianCard = Color(0xFF16233B);       // Primary card base
  static const darkObsidianCardLight = Color(0xFF1E2E4E);  // Active card surface
  static const darkObsidianBorder = Color(0x1FFFFFFF);     // 12% translucent border
  static const darkObsidianSpecular = Color(0x33FFFFFF);   // 20% white specular rim

  static const lightCanvasBg = Color(0xFFF1F5F9);          // Clean Olympic Day Slate
  static const lightElevated = Color(0xFFFFFFFF);          // Elevated card base
  static const lightCard = Color(0xFFFFFFFF);              // Primary white card base
  static const lightCardSurface = Color(0xFFF8FAFC);       // Soft light surface
  static const lightBorder = Color(0xFFE2E8F0);            // Slate 200 border
  static const lightSpecular = Color(0x0A000000);          // Subtle light rim

  // === DYNAMIC REACTIVE TOKENS (ADAPT INSTANTLY TO THEME) ===
  static Color get obsidianBase => isDark ? darkObsidianBase : lightCanvasBg;
  static Color get obsidianElevated => isDark ? darkObsidianElevated : lightElevated;
  static Color get obsidianCard => isDark ? darkObsidianCard : lightCard;
  static Color get obsidianCardLight => isDark ? darkObsidianCardLight : lightCardSurface;
  static Color get obsidianBorder => isDark ? darkObsidianBorder : lightBorder;
  static Color get obsidianSpecular => isDark ? darkObsidianSpecular : lightSpecular;

  // === CARD GRADIENTS & SHADOWS (DYNAMIC) ===
  static LinearGradient get heroCardGradient => isDark
      ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF162544), Color(0xFF0F1A2E)],
        )
      : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
        );

  static LinearGradient get cardGradient => isDark
      ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF162544), Color(0xFF101B30)],
        )
      : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
        );

  static LinearGradient get promoBannerGradient => isDark
      ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2E1C0C), Color(0xFF1E1308)],
        )
      : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
        );

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: isDark ? Colors.black.withValues(alpha: 0.35) : const Color(0xFF0F172A).withValues(alpha: 0.06),
          blurRadius: 14,
          offset: const Offset(0, 4),
        ),
        if (isDark)
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.08),
            offset: const Offset(0, 1),
            blurRadius: 0,
          ),
      ];

  static Border get cardBorder => Border.all(
        color: isDark ? Colors.white.withValues(alpha: 0.10) : const Color(0xFFE2E8F0),
        width: 1,
      );

  // === ITTF TABLE TENNIS ATHLETIC TOKENS (UNIVERSAL) ===
  static const ittfTableBlue = Color(0xFF1E40AF);          // Official ITTF Championship Blue
  static const ittfTableSurface = Color(0xFF2563EB);       // Vivid Court Tabletop
  static const ittfTableBorder = Color(0xFF60A5FA);        // Crisp Table Boundary Lines
  static const ittfCourtNet = Color(0xFFE2E8F0);           // Tournament Net White
  static const paddleRed = Color(0xFFDC2626);              // Red Rubber Paddle
  static const paddleBlack = Color(0xFF1E293B);            // Black Rubber Paddle
  static const pingPongOrange = Color(0xFFF97316);         // 40+ Celluloid Ball Orange

  // === CANVAS & SURFACES (DYNAMIC) ===
  static Color get canvasBg => obsidianBase;
  static const canvasNordicLegacy = Color(0xFF9CC3C9);
  static Color get canvasDarker => isDark ? const Color(0xFF070D18) : const Color(0xFFE2E8F0);
  static Color get canvasLight => isDark ? const Color(0xFF132037) : const Color(0xFFFFFFFF);

  static Color get surfaceCard => obsidianCard;
  static Color get surfaceSubtle => isDark ? const Color(0xFF1A2A46) : const Color(0xFFF8FAFC);
  static Color get surfaceMuted => isDark ? const Color(0xFF243656) : const Color(0xFFE2E8F0);
  static Color get surfaceDark => isDark ? const Color(0xFF0D1627) : const Color(0xFF0F172A);

  // === ATHLETIC SPORTS ACCENTS ===
  static const voltLime = Color(0xFF10B981);               // Athletic Tournament Emerald
  static Color get hyperCyan => isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7);
  static const electricCrimson = Color(0xFFEF4444);        // Tournament Adrenaline Red
  static const radiantGold = Color(0xFFF59E0B);            // Championship Trophy Gold
  static const amethystPurple = Color(0xFFA855F7);         // Quest Amethyst
  static const neonPink = Color(0xFFF43F5E);

  // === TACTILE 3D BUTTONS ===
  static Color get btnDark => isDark ? const Color(0xFF16233B) : const Color(0xFF0F172A);
  static Color get btnDarkBorder => isDark ? const Color(0xFF0A1120) : const Color(0xFF020617);
  static const btnGreen = Color(0xFF10B981);               // Crisp Emerald face
  static const btnGreenBorder = Color(0xFF047857);         // 4px Extruded green border
  static const btnTeal = Color(0xFF00B4D8);
  static const btnTealBorder = Color(0xFF007799);
  static const btnGold = Color(0xFFFFB800);
  static const btnGoldBorder = Color(0xFFCC9300);

  // === METRIC TINTS ===
  static Color get pastelPurple => isDark ? const Color(0x26A855F7) : const Color(0x1AA855F7);
  static Color get pastelGreen => isDark ? const Color(0x2610B981) : const Color(0x1A10B981);
  static Color get pastelBlue => isDark ? const Color(0x2638BDF8) : const Color(0x1A0284C7);
  static Color get pastelPink => isDark ? const Color(0x26EF4444) : const Color(0x1AEF4444);
  static Color get pastelYellow => isDark ? const Color(0x26F59E0B) : const Color(0x1AF59E0B);

  // === GAMIFICATION & COMBAT ===
  static const xpGold = Color(0xFFFFC800);
  static const xpGoldDark = Color(0xFFE5B400);
  static const streakFlame = Color(0xFFFF7A00);
  static const mkCyanP1 = Color(0xFF38BDF8);
  static const mkCrimsonP2 = Color(0xFFEF4444);
  static Color get vsEmblem => isDark ? const Color(0xFF161E2E) : const Color(0xFF0F172A);

  // === STATUS & LEGAL ===
  static const tableFree = Color(0xFF10B981);
  static const tableInGame = Color(0xFFFF7A00);
  static const tableReserved = Color(0xFFA855F7);
  static const penaltyRed = Color(0xFFEF4444);
  static const duitNowRed = Color(0xFFED1C24);

  // === TEXT (DYNAMIC FOR HIGH CONTRAST) ===
  static Color get textPrimary => isDark ? const Color(0xFFFFFFFF) : const Color(0xFF0F172A);
  static Color get textSecondary => isDark ? const Color(0xB3FFFFFF) : const Color(0xFF475569);
  static Color get textMuted => isDark ? const Color(0x73FFFFFF) : const Color(0xFF64748B);
  static Color get textLight => isDark ? const Color(0xFFFFFFFF) : const Color(0xFF0F172A);

  // === BORDERS (DYNAMIC) ===
  static Color get borderLight => obsidianBorder;
  static Color get borderSubtle => isDark ? const Color(0x14FFFFFF) : const Color(0xFFCBD5E1);

  // === BACKWARD-COMPATIBLE ALIASES ===
  static Color get bg => canvasBg;
  static Color get primary => isDark ? const Color(0xFF2563EB) : const Color(0xFF1D4ED8);
  static Color get primaryDim => isDark ? const Color(0xFF1E40AF) : const Color(0xFF3B82F6);
  static Color get primaryGlow => isDark ? const Color(0x332563EB) : const Color(0x1F2563EB);
  static Color get surface => surfaceCard;
  static Color get surface2 => surfaceSubtle;
  static Color get surface3 => surfaceMuted;
  static Color get border => borderLight;
  static Color get borderBright => borderSubtle;
  static const error = penaltyRed;
  static const warning = streakFlame;
  static Color get info => hyperCyan;
  static const challengeRed = mkCrimsonP2;
  static const vsColor = Color(0xFFFF6B35);
  static const tableOccupied = penaltyRed;
  static const rankGold = xpGold;
  static Color get rankSilver => isDark ? const Color(0xFFD4DAE3) : const Color(0xFF94A3B8);
  static const rankBronze = Color(0xFFD99B6A);
}
