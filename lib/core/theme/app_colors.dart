import 'package:flutter/material.dart';
import 'app_theme_controller.dart';

class AppColors {
  AppColors._();

  static bool get isDark => AppThemeController.isDark;

  // === STATIC TOKENS (DARK & LIGHT SPECIFIC CONSTANTS) ===
  static const darkObsidianBase = Color(0xFF0A1120);       // Deep Midnight Stadium Slate
  static const darkObsidianElevated = Color(0xFF0E1626);   // Elevated stadium card base (Phase 8: compressed ladder)
  static const darkObsidianCard = Color(0xFF121C2E);       // Primary card base (Phase 8: softer step from canvas)
  static const darkObsidianCardLight = Color(0xFF1A2947);  // Active card surface (Phase 8)
  static const darkObsidianBorder = Color(0x12FFFFFF);     // 7% translucent border (Phase 8 Fluent pass: outlines fade)
  static const darkObsidianSpecular = Color(0x33FFFFFF);   // 20% white specular rim

  static const lightCanvasBg = Color(0xFFF7F0E6);          // Toby warm cream canvas (Phase 6: white mode = Toby gradient theme)
  static const lightPanelSand = Color(0xFFF5E9D9);         // Toby sand panel / tonal selection base
  static const lightCanvasDeep = Color(0xFFF1E7D7);        // Gradient end / deeper warm tone
  static const lightElevated = Color(0xFFFFFFFF);          // Elevated card base
  static const lightCard = Color(0xFFFFFFFF);              // Primary white card base
  static const lightCardSurface = Color(0xFFFBF7F2);       // Warm soft surface
  static const lightBorder = Color(0xFFE9DFCE);            // Warm border (legacy surfaces)
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
          colors: [Color(0xFFFFFFFF), Color(0xFFFDFBF7)],
        );

  /// Phase 6 canvas texture: Toby's warm gradient wash in light mode,
  /// a deep arena glow in dark mode. Screens paint this behind content.
  static LinearGradient get canvasGradient => isDark
      ? const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0D1526), Color(0xFF0A1120)],
        )
      : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // Phase 8.4: deeper base stop — white cards need a canvas with
          // enough tonal distance to actually lift off (flatness fix).
          colors: [Color(0xFFF9F4EC), Color(0xFFEEE0C4)],
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
          colors: [Color(0xFFFFFFFF), Color(0xFFFDFBF7)],
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

  /// Phase 6 card recipe (Toby): elevation is a warm, diffuse shadow —
  /// never a hard outline. Light: warm beige shadow on cream. Dark: deep
  /// soft shadow + a faint specular rim on the top edge.
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: isDark
              ? Colors.black.withValues(alpha: 0.40)
              : const Color(0xFF8A6D3B).withValues(alpha: 0.13),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : const Color(0xFF8A6D3B).withValues(alpha: 0.05),
          blurRadius: isDark ? 0 : 8,
          offset: Offset(0, isDark ? 1 : 2),
        ),
      ];

  /// Borderless by design (Phase 6). Kept as a token so legacy call sites
  /// compile; the width preserves layout while the colour is invisible in
  /// light mode and near-invisible in dark mode.
  static Border get cardBorder => Border.all(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.transparent,
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
  static Color get canvasDarker => isDark ? const Color(0xFF070D18) : lightCanvasDeep;
  static Color get canvasLight => isDark ? const Color(0xFF132037) : const Color(0xFFFFFFFF);

  static Color get surfaceCard => obsidianCard;
  static Color get surfaceSubtle => isDark ? const Color(0xFF1A2A46) : const Color(0xFFFBF7F2);
  static Color get surfaceMuted => isDark ? const Color(0xFF243656) : const Color(0xFFEFE6D8);
  static Color get surfaceDark => isDark ? const Color(0xFF0D1627) : const Color(0xFF0F172A);

  // === ATHLETIC SPORTS ACCENTS (Arena DS v1 discipline) ===
  // ONE primary: volt emerald. Blue is info/secondary only. Gold is XP only.
  // Red is LIVE + errors only. Purple survives ONLY as the Reserved table
  // status and inside gamification-path artwork. Pink/cyan/teal are retired.
  static const voltLime = Color(0xFF10B981);
  // Toby charming reddish CTA effect tokens (Phase 8.5)
  // Toby signature magenta/rose-crimson gradient & diffuse charming glow.
  static const tobyCtaStart = Color(0xFFE63970); // Vibrant rose-coral
  static const tobyCtaEnd = Color(0xFFBE123C);   // Deep ruby-crimson
  static const tobyCtaGlow = Color(0xFFE11D48);  // Charming rose diffuse glow

  static const tobyCtaGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [tobyCtaStart, tobyCtaEnd],
  );

  // Phase 8.1: BLUE = action, EMERALD = signal only.
  // The one filled CTA per screen wears this deep steel blue (Toby's
  // #2B72B2); emerald is reserved for live/free/success meaning.
  static const actionBlue = Color(0xFF2B72B2);
  // Deep variants for status TEXT on light surfaces (the bright hues
  // stay in dots/chips; words get the readable, adult depth).
  static const statusRedText = Color(0xFFB91C1C);
  static const statusPurpleText = Color(0xFF6D28D9);
  static const actionBlueDeep = Color(0xFF1F5A8F);               // PRIMARY — Athletic Tournament Emerald
  static Color get hyperCyan => isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB); // legacy name, now ITTF info blue
  static const electricCrimson = Color(0xFFEF4444);        // Tournament Adrenaline Red
  static const radiantGold = Color(0xFFF59E0B);            // Championship Trophy Gold — XP/rewards only
  static const goldDeep = Color(0xFFB45309);               // deep amber for gold TEXT/icons on light surfaces
  static const amethystPurple = Color(0xFFA855F7);         // Quest Amethyst — gamification artwork / Reserved status only
  static const neonPink = Color(0xFFEF4444);               // RETIRED — remapped to crimson (Arena DS: no pink in general UI)

  // === NEUTRAL SLATE SCALE (const, for swept literals) ===
  static const slate100 = Color(0xFFF1F5F9);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate300 = Color(0xFFCBD5E1);
  static const slate400 = Color(0xFF94A3B8);
  static const slate500 = Color(0xFF64748B);
  static const slate600 = Color(0xFF475569);
  static const slate900 = Color(0xFF0F172A);

  // === TACTILE 3D BUTTONS ===
  static Color get btnDark => isDark ? const Color(0xFF16233B) : const Color(0xFF0F172A);
  static Color get btnDarkBorder => isDark ? const Color(0xFF0A1120) : const Color(0xFF020617);
  static const btnGreen = Color(0xFF10B981);               // Crisp Emerald face
  static const btnGreenBorder = Color(0xFF047857);         // 4px Extruded green border
  static const btnTeal = Color(0xFF2563EB);                // RETIRED teal — remapped to ITTF info blue
  static const btnTealBorder = Color(0xFF1E40AF);
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
  static const mkCyanP1 = Color(0xFF60A5FA);               // Player 1 — info blue (cyan retired)
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
  static Color get primary => voltLime;                    // Arena DS: primary is emerald everywhere
  static Color get primaryDim => const Color(0xFF047857);
  static Color get primaryGlow => isDark ? const Color(0x3310B981) : const Color(0x1F10B981);
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
