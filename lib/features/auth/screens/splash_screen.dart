import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme_controller.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';
import '../../challenge/screens/seek_player_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback? onRegisterTap;
  final VoidCallback? onWalkInTap;

  const SplashScreen({
    super.key,
    this.onRegisterTap,
    this.onWalkInTap,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedLanguage = 'ENG';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.obsidianBase,
      endDrawer: _buildBkashStyleSideDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.obsidianBase,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // ==========================================
              // TOP BAR: Profile (Left) | XP & Location | Menu (Right)
              // ==========================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top-Left: Player Profile Button -> Profile Screen
                    GestureDetector(
                      onTap: () => AppNavigator.toProfile(context),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.obsidianCard,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.border,
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.isDark ? Colors.black.withValues(alpha: 0.35) : Colors.black.withValues(alpha: 0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.person_rounded,
                              size: 22,
                              color: AppColors.textPrimary,
                            ),
                            Positioned(
                              right: 2,
                              bottom: 2,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppColors.voltLime,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.obsidianBase,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Center Location & XP Capsule
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => AppNavigator.toXpStore(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.obsidianCard,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.radiantGold.withValues(alpha: 0.35),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.isDark ? Colors.black.withValues(alpha: 0.25) : Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star_rounded, size: 14, color: AppColors.radiantGold),
                                  const SizedBox(width: 4),
                                  Text(
                                    '1,240 XP',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'assets/images/company_logo.png',
                                  width: 15,
                                  height: 15,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Tonight · 3 Damansara',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Right Drawer Menu Icon -> Opens Luxury Obsidian Drawer
                    GestureDetector(
                      onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.obsidianCard,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.border,
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.isDark ? Colors.black.withValues(alpha: 0.35) : Colors.black.withValues(alpha: 0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.menu_rounded,
                          size: 22,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
              ],
            ),
          ),

              // ==========================================
              // SCROLLABLE BODY
              // ==========================================
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dynamic Athletic Hero Card with 3D Table Tennis Court Stage
                      _buildHeroStadiumCard(context),
                      const SizedBox(height: 14),

                      // 3 Quick Telemetry Cards
                      _buildThreeTelemetryCards(context),
                      const SizedBox(height: 14),

                      // 1. Sparring Rivals Carousel (Athletic Player Cards)
                      _buildFavoriteRivalsSection(context),
                      const SizedBox(height: 14),

                      // 2. Flash Promo Countdown Banner (Happy Hour Sunset Pass)
                      _buildFlashPromoBanner(),
                      const SizedBox(height: 16),

                      // 3. Asymmetrical Bento Telemetry Grid
                      _buildBentoTelemetryGrid(context),
                      const SizedBox(height: 16),

                      // Venue Map Card
                      _buildVenueMapCard(context),
                      const SizedBox(height: 14),

                      // Member Pricing & 90 Sen Anchor Card
                      _buildMemberPricingCard(context),
                      const SizedBox(height: 18),

                      // Primary Athletic Emerald 3D Tactile CTA Button
                      TactileButton.volt(
                        text: 'Walk In & Play →',
                        onPressed: widget.onWalkInTap ?? widget.onRegisterTap ?? () => AppNavigator.toPlan(context),
                      ),
                      const SizedBox(height: 12),

                      // Direct Door Pass Access Chip (Royal Sapphire Glass)
                      Center(
                        child: GestureDetector(
                          onTap: () => AppNavigator.toPass(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                            decoration: BoxDecoration(
                              color: const Color(0x262563EB),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF60A5FA).withValues(alpha: 0.5),
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF2563EB).withValues(alpha: 0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.qr_code_scanner_rounded,
                                  size: 16,
                                  color: Color(0xFF60A5FA),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    'Door Pass (KX8VQS) →',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF93C5FD),
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          'At the door: two QRs — Registered or Guest.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.45),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Floating Obsidian Glass Bottom Navigation Dock
              const JomnittakuNavBar(activeIndex: 0),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HERO STADIUM CARD (Dynamic Athletic Stage with 3D Court Visual)
  // ============================================================
  Widget _buildHeroStadiumCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF162544),
            Color(0xFF0F1A2E),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.08),
            offset: const Offset(0, 1),
            blurRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.40),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Tag: Venue Arena & Live Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              'JOMNITTAKU · 3 DAMANSARA',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF60A5FA),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF10B981).withValues(alpha: 0.35),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '6 OF 10 FREE',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF10B981),
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Main Content Row: Company Logo & Typography (Left) + 3D Table Tennis Court Arena (Right)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left Column: Company Logo + Catchphrase & Subtitle
                    Expanded(
                      flex: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.35),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/company_logo.png',
                                    width: 44,
                                    height: 44,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'JUST PLAY',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        letterSpacing: -0.6,
                                        height: 1.0,
                                      ),
                                    ),
                                    Text(
                                      'TONIGHT',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: const Color(0xFF38BDF8),
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Autonomous table tennis arena.\nWalk in & challenge rivals now.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withValues(alpha: 0.70),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Right Column: Interactive 3D Table Tennis Court Stage
                    Expanded(
                      flex: 11,
                      child: _build3dTableTennisStage(context),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Bottom Interactive Ticker & Action Bar
                GestureDetector(
                  onTap: () => AppNavigator.toTables(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F1A2E),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'assets/images/company_logo.png',
                                  width: 18,
                                  height: 18,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  '• LIVE • 2 matches active now',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Text(
                              'Radar View',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF38BDF8),
                              ),
                            ),
                            const SizedBox(width: 3),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 13,
                              color: Color(0xFF38BDF8),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }

  // ============================================================
  // 3D TABLE TENNIS COURT STAGE (Fills right side of Hero Card)
  // ============================================================
  Widget _build3dTableTennisStage(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigator.toTables(context),
      child: Container(
        height: 118,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E3A8A),
              Color(0xFF0F2256),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF60A5FA).withValues(alpha: 0.35),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Table top perspective representation (Championship ITTF Blue Court)
            Positioned(
              top: 22,
              left: 14,
              right: 14,
              bottom: 22,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Center White Line
                    Container(width: 1.2, color: Colors.white.withValues(alpha: 0.7)),
                    // Center Net (White Mesh)
                    Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Top-Left: Player 2 Paddle (Black Rubber - Jason)
            Positioned(
              top: 8,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white30, width: 0.8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.sports_tennis_rounded, size: 10, color: Colors.white70),
                    const SizedBox(width: 3),
                    Text(
                      'Jason',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom-Right: Player 1 Paddle (Red Rubber - Aiman)
            Positioned(
              bottom: 8,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFDC2626),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white30, width: 0.8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.sports_tennis_rounded, size: 10, color: Colors.white),
                    const SizedBox(width: 3),
                    Text(
                      'Aiman',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Center: 40+ Tournament Orange Ping Pong Ball
            Positioned(
              top: 48,
              left: 48,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFFF97316),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF97316).withValues(alpha: 0.6),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),

            // Floating Live Score Badge (Top Right)
            Positioned(
              top: 6,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFF59E0B), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'T4 · 11-9',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // 3 QUICK TELEMETRY CARDS (Athletic Glass)
  // ============================================================
  Widget _buildThreeTelemetryCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => AppNavigator.toTables(context),
            child: _buildTelemetryPill(
              title: 'Live tables',
              value: '6 Free',
              icon: Icons.table_restaurant_rounded,
              accentColor: AppColors.voltLime,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () => AppNavigator.toGamificationPath(context),
            child: _buildTelemetryPill(
              title: 'The Path',
              value: 'Node 2 ⭐',
              icon: Icons.alt_route_rounded,
              accentColor: AppColors.radiantGold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () => AppNavigator.toXpStore(context),
            child: _buildTelemetryPill(
              title: 'XP balance',
              value: '1,240 XP',
              icon: Icons.military_tech_rounded,
              accentColor: const Color(0xFF38BDF8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTelemetryPill({
    required String title,
    required String value,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.isDark ? Colors.black.withValues(alpha: 0.25) : Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: accentColor),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FAVORITE SPARRING RIVALS (Athletic Player Cards)
  // ============================================================
  Widget _buildFavoriteRivalsSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF162544),
            Color(0xFF101B30),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Favorite Sparring Rivals',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => AppNavigator.toLeaderboard(context),
                child: Text(
                  'Manage >',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF60A5FA),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildGamerRivalCard(
                  context,
                  name: 'Jason T.',
                  initial: 'J',
                  level: 'LVL 14',
                  streak: '🔥 3W',
                  isLiveAtVenue: true,
                  ringColor: const Color(0xFF38BDF8),
                ),
                const SizedBox(width: 14),
                _buildGamerRivalCard(
                  context,
                  name: 'Sara K.',
                  initial: 'S',
                  level: 'LVL 18',
                  streak: '🔥 5W',
                  isLiveAtVenue: true,
                  ringColor: const Color(0xFF10B981),
                ),
                const SizedBox(width: 14),
                _buildGamerRivalCard(
                  context,
                  name: 'Nurul P.',
                  initial: 'N',
                  level: 'LVL 11',
                  streak: '1W',
                  isLiveAtVenue: false,
                  ringColor: const Color(0xFF818CF8),
                ),
                const SizedBox(width: 14),
                _buildGamerRivalCard(
                  context,
                  name: 'Daniel L.',
                  initial: '👑',
                  level: 'LVL 22',
                  streak: '🔥 7W',
                  isLiveAtVenue: false,
                  ringColor: AppColors.radiantGold,
                ),
                const SizedBox(width: 14),
                _buildAddRivalButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGamerRivalCard(
    BuildContext context, {
    required String name,
    required String initial,
    required String level,
    required String streak,
    required bool isLiveAtVenue,
    required Color ringColor,
  }) {
    return GestureDetector(
      onTap: () => AppNavigator.toChallengeAccepted(context),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ringColor.withValues(alpha: 0.30), const Color(0xFF101B30)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: ringColor, width: 1.8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    initial,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (isLiveAtVenue)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.obsidianBase, width: 2),
                    ),
                  ),
                ),
              // Win streak mini-badge
              Positioned(
                top: -5,
                right: -6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: const Color(0xFF261808),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFF59E0B), width: 0.8),
                  ),
                  child: Text(
                    streak,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFFBBF24),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          Text(
            level,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddRivalButton(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigator.toLeaderboard(context),
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0x1A38BDF8),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF38BDF8).withValues(alpha: 0.5),
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.add_rounded,
              color: Color(0xFF38BDF8),
              size: 26,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Add Rival',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF38BDF8),
            ),
          ),
          Text(
            'Search XP',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FLASH COUNTDOWN BANNER (Sunset Athletic Pass)
  // ============================================================
  Widget _buildFlashPromoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2E1C0C),
            Color(0xFF1E1308),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF59E0B).withValues(alpha: 0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF59E0B), Color(0xFFEA580C)],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⚡ Happy Hour · Save 50%',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFFDE68A),
                  ),
                ),
                Text(
                  'All tables 50 sen/hour for members',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.70),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Text(
              '18m : 45s',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ASYMMETRICAL BENTO TELEMETRY GRID
  // ============================================================
  Widget _buildBentoTelemetryGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'VENUE TELEMETRY & COMMAND',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF38BDF8).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'LIVE IOT',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF38BDF8),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 1. WIDE BENTO (Span 2 columns): LIVE TABLE RADAR
        GestureDetector(
          onTap: () => AppNavigator.toTables(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF162544), Color(0xFF101B30)],
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFF38BDF8).withValues(alpha: 0.25),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.08),
                  offset: const Offset(0, 1),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF38BDF8).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.radar_rounded,
                              size: 18,
                              color: Color(0xFF38BDF8),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Live Table Radar',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '6 of 10 Free →',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Table beacon matrix (T1-T6)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildTableBeacon('T1', isOccupied: true, player: 'Aiman'),
                      const SizedBox(width: 8),
                      _buildTableBeacon('T2', isOccupied: true, player: 'Sara'),
                      const SizedBox(width: 8),
                      _buildTableBeacon('T3', isOccupied: false),
                      const SizedBox(width: 8),
                      _buildTableBeacon('T4', isOccupied: false),
                      const SizedBox(width: 8),
                      _buildTableBeacon('T5', isOccupied: false),
                      const SizedBox(width: 8),
                      _buildTableBeacon('T6', isOccupied: false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // 2. 2-COLUMN SQUARE BENTO TILES (Row 1: The Path & 1v1 Kombat)
        Row(
          children: [
            // The Winding Path
            Expanded(
              child: GestureDetector(
                onTap: () => AppNavigator.toGamificationPath(context),
                child: _buildBentoSquareTile(
                  title: 'The Path',
                  subtitle: 'Node 2 ⭐ Claim XP',
                  badge: 'QUEST ACTIVE',
                  badgeColor: AppColors.amethystPurple,
                  icon: Icons.alt_route_rounded,
                  accentColor: AppColors.amethystPurple,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // 1v1 Mortal Kombat Arena
            Expanded(
              child: GestureDetector(
                onTap: () => AppNavigator.toChallengeAccepted(context),
                child: _buildBentoSquareTile(
                  title: '1v1 Match',
                  subtitle: 'RM200 Pot · Fight',
                  badge: 'BOUNTY',
                  badgeColor: const Color(0xFFEF4444),
                  icon: Icons.sports_mma_rounded,
                  accentColor: const Color(0xFFEF4444),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 3. 2-COLUMN SQUARE BENTO TILES (Row 2: Champion Auction & Live Scoreboard)
        Row(
          children: [
            // Play Champion Live Auction
            Expanded(
              child: GestureDetector(
                onTap: () => AppNavigator.toBidding(context),
                child: _buildBentoSquareTile(
                  title: 'Champion',
                  subtitle: 'Top Bid RM320 · Bid',
                  badge: 'AUCTION',
                  badgeColor: AppColors.radiantGold,
                  icon: Icons.military_tech_rounded,
                  accentColor: AppColors.radiantGold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // 55" Live Scoreboard (Spectator Stream)
            Expanded(
              child: GestureDetector(
                onTap: () => AppNavigator.toDisplay(context),
                child: _buildBentoSquareTile(
                  title: 'Live Scoreboard',
                  subtitle: '55" TV Broadcast View',
                  badge: 'ARENA TV',
                  badgeColor: const Color(0xFF38BDF8),
                  icon: Icons.live_tv_rounded,
                  accentColor: const Color(0xFF38BDF8),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 4. QUICK TELEMETRY ACTION PILLS (XP Loan, Leaderboard Ranks, Seek Radar)
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => AppNavigator.toXpStore(context),
                child: _buildQuickPill('⚡ Borrow XP', AppColors.radiantGold),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () => AppNavigator.toLeaderboard(context),
                child: _buildQuickPill('🏆 #4 Rank', const Color(0xFF10B981)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () => AppNavigator.pushScreen(context, const SeekPlayerScreen()),
                child: _buildQuickPill('📡 Radar Ping', const Color(0xFF38BDF8)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTableBeacon(String tableName, {required bool isOccupied, String? player}) {
    final courtColor = isOccupied ? const Color(0xFF1E293B) : const Color(0xFF1D4ED8);
    final borderColor = isOccupied ? const Color(0xFFEF4444) : const Color(0xFF10B981);
    return Container(
      width: 52,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: courtColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: borderColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tableName,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Text(
            isOccupied ? (player ?? 'Live') : 'Free',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 8,
              fontWeight: FontWeight.w800,
              color: isOccupied ? const Color(0xFFFCA5A5) : const Color(0xFF6EE7B7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBentoSquareTile({
    required String title,
    required String subtitle,
    required String badge,
    required Color badgeColor,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF162544), Color(0xFF101B30)],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.25),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.08),
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: accentColor),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: badgeColor.withValues(alpha: 0.4), width: 0.8),
                  ),
                  child: Text(
                    badge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: badgeColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickPill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // VENUE MAP CARD (Athletic Slate)
  // ============================================================
  Widget _buildVenueMapCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF162544), Color(0xFF101B30)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Venue map',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterPill('Tables', true),
                      const SizedBox(width: 6),
                      _buildFilterPill('Live', false),
                      const SizedBox(width: 6),
                      _buildFilterPill('All', false),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => AppNavigator.toTables(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMiniTable(hasDotLeft: true),
                _buildMiniTable(hasDotRight: true),
                _buildMiniTable(hasDotLeft: true),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              '3 Damansara · 6 free of 10 tables',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.55),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MEMBER PRICING & 90 SEN ANCHOR CARD
  // ============================================================
  Widget _buildMemberPricingCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF162544), Color(0xFF101B30)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.25),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Walk-in',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
              Text(
                'RM17',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Member · 90 sen',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ),
              Text(
                'a day · RM90/mo',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.25), width: 1),
            ),
            child: Center(
              child: Text(
                '🔥 Member saves RM16.10 a visit',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF10B981),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // bKash PATTERN: SLIDE-OUT RIGHT DRAWER (Obsidian Glass)
  // ============================================================
  Widget _buildBkashStyleSideDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.obsidianBase,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header with Language Switch
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/company_logo.png',
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'JOMNITTAKU',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  // Language Toggle (ENG | BM | 中文)
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: AppColors.obsidianCard,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        _buildLangBtn('ENG'),
                        _buildLangBtn('BM'),
                        _buildLangBtn('中文'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.border),

            // JOM AI Virtual Concierge & Umpire Card
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () => _showJomAiBottomSheet(context),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF162544), Color(0xFF0F1A2E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFF38BDF8).withValues(alpha: 0.4),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/company_logo.png',
                            width: 38,
                            height: 38,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'JOM AI',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF38BDF8).withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'UMPIRE BETA',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900,
                                      color: const Color(0xFF38BDF8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Virtual Venue Concierge & Umpire',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                color: Colors.white.withValues(alpha: 0.65),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white38,
                        size: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Drawer Items List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildDrawerTile(Icons.home_rounded, 'Venue Home', () => Navigator.pop(context)),
                  _buildDrawerTile(Icons.door_front_door_rounded, 'Gate Pass & Door Unlock (KX8VQS)', () {
                    Navigator.pop(context);
                    AppNavigator.toPass(context);
                  }),
                  _buildDrawerTile(Icons.person_rounded, 'My Profile & Rankings', () {
                    Navigator.pop(context);
                    AppNavigator.toProfile(context);
                  }),
                  _buildDrawerTile(Icons.receipt_long_rounded, 'Match & XP Statement', () {
                    Navigator.pop(context);
                    AppNavigator.toXpStore(context);
                  }),
                  _buildDrawerTile(Icons.alt_route_rounded, 'The Winding Path', () {
                    Navigator.pop(context);
                    AppNavigator.toGamificationPath(context);
                  }),
                  _buildDrawerTile(
                    AppColors.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    AppColors.isDark ? 'Switch to Light Mode ☀️' : 'Switch to Dark Mode 🌙',
                    () {
                      Navigator.pop(context);
                      AppThemeController.toggleTheme();
                    },
                  ),
                  _buildDrawerTile(Icons.support_agent_rounded, 'Venue Support & Lost Paddle', () {
                    Navigator.pop(context);
                  }),
                  _buildDrawerTile(Icons.map_rounded, '3 Damansara Venue Map', () {
                    Navigator.pop(context);
                    AppNavigator.toTables(context);
                  }),
                  _buildDrawerTile(Icons.lightbulb_rounded, 'IoT Table Lights Override', () {
                    Navigator.pop(context);
                  }),
                  _buildDrawerTile(Icons.card_giftcard_rounded, 'Refer a Friend (+200 XP)', () {
                    Navigator.pop(context);
                  }),
                  Divider(color: AppColors.border),
                  _buildDrawerTile(Icons.logout_rounded, 'Log Out / Switch Account', () {
                    Navigator.pop(context);
                  }, isDestructive: true),
                ],
              ),
            ),

            // Version Footer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Version 2.4.0 · JOMNITTAKU 3 Damansara',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLangBtn(String lang) {
    final isSelected = _selectedLanguage == lang;
    return GestureDetector(
      onTap: () => setState(() => _selectedLanguage = lang),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF10B981) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          lang,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerTile(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: Icon(
        icon,
        color: isDestructive ? const Color(0xFFEF4444) : const Color(0xFF38BDF8),
        size: 20,
      ),
      title: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: isDestructive ? const Color(0xFFEF4444) : AppColors.textPrimary,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }

  void _showJomAiBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: AppColors.obsidianElevated,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/company_logo.png',
                      width: 44,
                      height: 44,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'JOM AI',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF38BDF8).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'UMPIRE BETA',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF38BDF8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Virtual Venue Umpire & Concierge',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildAiHelpTile(Icons.rule_folder_rounded, 'Dispute Resolution', 'Automated table sensor reviews and official table tennis rules.'),
            _buildAiHelpTile(Icons.lightbulb_outline_rounded, 'Table Automation', 'Smart lighting active on T1-T6 during booked matches.'),
            _buildAiHelpTile(Icons.shield_outlined, 'Gate Security & Penalty', 'Unmanned check-in monitoring. RM200 non-pay walk-in fine.'),
            const SizedBox(height: 16),
            TactileButton.volt(
              text: 'Close Concierge',
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildAiHelpTile(IconData icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF38BDF8)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  desc,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildFilterPill(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF10B981) : AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? const Color(0xFF10B981) : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  static Widget _buildMiniTable({bool hasDotLeft = false, bool hasDotRight = false}) {
    return Container(
      width: 68,
      height: 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1D4ED8), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(width: 1.2, color: Colors.white.withValues(alpha: 0.7)),
          if (hasDotLeft)
            Positioned(
              left: 14,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFFDC2626), // Red paddle
                  shape: BoxShape.circle,
                ),
              ),
            ),
          if (hasDotRight)
            Positioned(
              right: 14,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Colors.white, // White ping pong ball
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
