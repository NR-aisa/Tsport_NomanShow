import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/arena_video_player.dart';
import '../widgets/how_it_works_stacking_deck.dart';

/// High-Converting, Pulse-Pounding Public Landing Page for JOMNITTAKU.
///
/// Theme: "Malaysia's 1st 24/7 Autonomous Unmanned Table Tennis Arena"
/// Location: 3 Damansara Mall, Level 2
/// Core Goal: Attract, excite, and convert visitors with raw athletic energy ("Are you feeling the energy?").
class ArenaLandingScreen extends StatefulWidget {
  final VoidCallback onLaunchHub;
  final VoidCallback onWalkInTap;
  final VoidCallback onViewCourtsTap;
  final VoidCallback onViewLeagueTap;

  const ArenaLandingScreen({
    super.key,
    required this.onLaunchHub,
    required this.onWalkInTap,
    required this.onViewCourtsTap,
    required this.onViewLeagueTap,
  });

  @override
  State<ArenaLandingScreen> createState() => _ArenaLandingScreenState();
}

class _ArenaLandingScreenState extends State<ArenaLandingScreen> {
  final ScrollController _scrollController = ScrollController();

  // Global Keys for smooth scrolling to sections
  final GlobalKey _vibeKey = GlobalKey();
  final GlobalKey _howItWorksKey = GlobalKey();
  final GlobalKey _courtsKey = GlobalKey();
  final GlobalKey _pricingKey = GlobalKey();
  final GlobalKey _locationKey = GlobalKey();

  // Active court for mini-interactive floorplan preview
  int _selectedPreviewCourt = 4; // Center Court (T04)

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  // Design Tokens
  static const Color luxuryBg = Color(0xFF0C0E15);
  static const Color luxuryCard = Color(0xFF161925);
  static const Color luxuryCardElevated = Color(0xFF1E2232);
  static const Color luxuryCoralRose = Color(0xFFFF4B72);
  static const Color luxuryVoltEmerald = Color(0xFF10B981);
  static const Color luxuryElectricCyan = Color(0xFF00F0FF);
  static const Color luxuryGold = Color(0xFFF59E0B);
  static const Color luxuryMuted = Color(0xFF8A90A5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: luxuryBg,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Glass Navbar
            _buildNavbar(context),

            // Hero Section: "Midnight Smashes. Zero Staff."
            _buildHeroSection(context),

            // Live Arena Energy & Stats Ticker
            _buildLiveEnergyTicker(context),

                // Section 2: "How It Works" (4-Step Unmanned Funnel)
                _buildHowItWorksSection(context),

                // Section 3: "Are You Feeling The Energy?" (Vibe & Culture Bento Grid)
                _buildVibeCultureSection(context),

                // Section 4: Live 10-Court Interactive Radar Teaser
                _buildLiveCourtsTeaser(context),

                // Section 5: Arena Passes & Transparent Pricing
                _buildPricingSection(context),

                // Section 6: How to Enter at Midnight (Mall Closed? No Problem!)
                _buildNightAccessSection(context),

                // Section 7: Final High-Voltage CTA Section
                _buildFinalCtaSection(context),

                // Section 8: Footer
                _buildFooter(context),
              ],
            ),
          ),
    );
  }

  // ========================================================================
  // 1. TOP GLASS NAVBAR (Adaptive to Real Screen & Simulated Viewports)
  // ========================================================================
  Widget _buildNavbar(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        final isCompact = constraints.maxWidth < 1100;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : (isCompact ? 20 : 40),
            vertical: isMobile ? 12 : 16,
          ),
          decoration: BoxDecoration(
            color: luxuryBg.withValues(alpha: 0.85),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Brand Logo + Tag
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: isMobile ? 32 : 38,
                        height: isMobile ? 32 : 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: luxuryCoralRose.withValues(alpha: 0.15),
                          border: Border.all(
                            color: luxuryCoralRose.withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/company_logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                'JOMNITTAKU',
                                style: AppTypography.ui(
                                  fontSize: isMobile ? 13 : 15,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: luxuryCoralRose.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '24/7',
                                  style: AppTypography.ui(
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.w900,
                                    color: luxuryCoralRose,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (!isMobile)
                            Text(
                              'NO MAN SHOW • 3 DAMANSARA (L2)',
                              style: AppTypography.ui(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: luxuryVoltEmerald,
                                letterSpacing: 0.8,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Desktop Nav Links (Hidden on Compact/Mobile)
              if (!isCompact) ...[
                const SizedBox(width: 20),
                _buildNavLink('The Vibe', () => _scrollTo(_vibeKey)),
                const SizedBox(width: 16),
                _buildNavLink('How It Works', () => _scrollTo(_howItWorksKey)),
                const SizedBox(width: 16),
                _buildNavLink('10 Courts', () => _scrollTo(_courtsKey)),
                const SizedBox(width: 16),
                _buildNavLink('Passes & Pricing', () => _scrollTo(_pricingKey)),
                const SizedBox(width: 16),
                _buildNavLink('Tournaments', widget.onViewLeagueTap),
                const Spacer(),
              ],

              // Live Courts Badge (clickable to open Radar, compact on mobile)
              if (!isMobile)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: widget.onViewCourtsTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: luxuryVoltEmerald.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: luxuryVoltEmerald.withValues(alpha: 0.35),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: luxuryVoltEmerald,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '6 OF 10 FREE',
                            style: AppTypography.ui(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: luxuryVoltEmerald,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              if (!isMobile) const SizedBox(width: 10),

              // Action Button / Capsule
              isMobile
                  ? ArenaInteractiveButton(
                      label: 'Walk In (RM17)',
                      icon: Icons.bolt_rounded,
                      onTap: widget.onWalkInTap,
                      isPrimary: true,
                      fontSize: 11,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // State A: Instant Walk-In
                          ArenaInteractiveButton(
                            label: 'Walk In (RM17)',
                            icon: Icons.bolt_rounded,
                            onTap: widget.onWalkInTap,
                            isPrimary: true,
                            fontSize: 11,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          const SizedBox(width: 4),
                          // State B: Arena Hub Destination
                          ArenaInteractiveButton(
                            label: 'Arena Hub →',
                            icon: Icons.grid_view_rounded,
                            onTap: widget.onLaunchHub,
                            isPrimary: false,
                            fontSize: 11,
                            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ],
                      ),
                    ),

              // Desktop safe margin for floating presentation switcher bar (ONLY ON DESKTOP!)
              if (!isCompact) const SizedBox(width: 440),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavLink(String label, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: AppTypography.ui(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: luxuryMuted,
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // 2. HERO SECTION ("Midnight Smashes. Zero Staff.")
  // KITA Full-Screen First View: Desktop 100vh Full-Bleed Canvas + Mobile Media-First Stage
  // ========================================================================
  Widget _buildHeroSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 960;
        final isMobile = constraints.maxWidth < 768;

        // Dedicated Mobile Architecture: Top Cinematic Video Stage + Narrative + Frosted Card
        if (isMobile) {
          return _buildMobileHeroSection(context);
        }

        final screenHeight = MediaQuery.of(context).size.height;
        // On desktop, the hero section fills the full desktop screen (100vh minus navbar)!
        final heroMinHeight = isDesktop 
            ? (screenHeight - 65).clamp(700.0, 1400.0) 
            : 0.0;

        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: heroMinHeight,
            minWidth: double.infinity,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // --------------------------------------------------------------
              // LAYER 1: Full-Bleed 100vh Background Video Canvas
              // --------------------------------------------------------------
              const Positioned.fill(
                child: IgnorePointer(
                  child: ArenaVideoPlayer(
                    videoPath: 'videos/arena_highlight.mp4',
                    fallbackImagePath: 'assets/images/arena_match_intensity.jpg',
                    borderRadius: 0,
                    showVignette: false,
                  ),
                ),
              ),

              // --------------------------------------------------------------
              // LAYER 2: Subtle Directional Scrim Overlay (KITA Technique)
              // Soft 40%-50% gradient: video stays bright & visible across 100vh
              // --------------------------------------------------------------
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF0A0B10).withValues(alpha: 0.40),
                          const Color(0xFF0A0B10).withValues(alpha: 0.50),
                          const Color(0xFF0A0B10).withValues(alpha: 0.85),
                        ],
                        stops: const [0.0, 0.60, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              // --------------------------------------------------------------
              // LAYER 3: Clean, Focused Content Layer (Anchored at Bottom of 100vh)
              // --------------------------------------------------------------
              Container(
                constraints: BoxConstraints(
                  minHeight: heroMinHeight,
                  maxWidth: 1300,
                ),
                padding: EdgeInsets.fromLTRB(
                  isDesktop ? 60 : 24,
                  isDesktop ? 100 : 80,
                  isDesktop ? 60 : 24,
                  isDesktop ? 64 : 40,
                ),
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Left Column: Clean, High-Impact Narrative
                    Expanded(
                      flex: 55,
                      child: _buildHeroLeftContent(context, isMobile: false),
                    ),
                    const SizedBox(width: 50),
                    // Right Column: KITA-Style Focused Offer Card
                    Expanded(
                      flex: 45,
                      child: _buildHeroRightCard(context, isMobile: false),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ========================================================================
  // MOBILE HERO SECTION (Media-First Cinematic Top Video + Clear Narrative + Frosted Pass)
  // ========================================================================
  Widget _buildMobileHeroSection(BuildContext context) {
    return Container(
      color: const Color(0xFF0A0B10),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Dedicated Cinematic 16:9 Video Stage (Live Match/Rally Showcase)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFFF5C38).withValues(alpha: 0.35),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF5C38).withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: const AspectRatio(
                aspectRatio: 16 / 9,
                child: ArenaVideoPlayer(
                  videoPath: 'videos/arena_highlight.mp4',
                  fallbackImagePath: 'assets/images/arena_match_intensity.jpg',
                  borderRadius: 15,
                  showVignette: false,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 2. High-Impact Headline & Subtitle & Action CTAs
          _buildHeroLeftContent(context, isMobile: true),

          const SizedBox(height: 24),

          // 3. Frosted Glassmorphic Signboard Card
          _buildHeroRightCard(context, isMobile: true),
        ],
      ),
    );
  }

  Widget _buildHeroLeftContent(BuildContext context, {bool isMobile = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Clean, High-Impact Headline (2-Color Discipline: Crisp White + Single Coral Accent)
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Midnight Smashes.\n',
                style: AppTypography.ui(
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.12,
                  letterSpacing: -0.5,
                ),
              ),
              TextSpan(
                text: 'Zero Staff.',
                style: AppTypography.ui(
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFFFF5C38),
                  height: 1.12,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: isMobile ? 12 : 16),

        // Short, Punchy 2-Line Subtitle (No Paragraph Wall)
        Text(
          '10 Olympic ITTF tables, robot ball dispensers, and optical smash tracking. Open 24/7 at 3 Damansara Mall (Level 2). Scan, enter, and play.',
          style: AppTypography.ui(
            fontSize: isMobile ? 13.5 : 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFCBD5E1),
            height: 1.5,
          ),
        ),

        SizedBox(height: isMobile ? 22 : 28),

        // 2 Clean Buttons (Exactly like KITA's [Courses] and [Our Impact])
        // With luxury satisfying hover color transitions
        Row(
          children: [
            // Primary Action Button (Solid Coral -> Electric Golden Amber on Hover)
            ArenaInteractiveButton(
              label: 'Walk In (RM17)',
              onTap: widget.onWalkInTap,
              isPrimary: true,
              fontSize: isMobile ? 13 : 14,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 18 : 24,
                vertical: isMobile ? 12 : 14,
              ),
            ),

            const SizedBox(width: 14),

            // Secondary Action Button (Clean Ghost Outline -> Solid White on Hover)
            ArenaInteractiveButton(
              label: 'Live Arena Hub',
              onTap: widget.onLaunchHub,
              isPrimary: false,
              fontSize: isMobile ? 13 : 14,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 18 : 24,
                vertical: isMobile ? 12 : 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ========================================================================
  // KITA FLOATING HERO OFFER CARD (Right Column)
  // Single Clear Offer: Clean, Ultra-Readable, Zero Visual Clutter
  // ========================================================================
  Widget _buildHeroRightCard(BuildContext context, {bool isMobile = false}) {
    return Container(
      decoration: BoxDecoration(
        color: isMobile
            ? const Color(0xFF11141E).withValues(alpha: 0.58)
            : const Color(0xFF11141E).withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(isMobile ? 18 : 20),
        border: Border.all(
          color: isMobile
              ? Colors.white.withValues(alpha: 0.16)
              : Colors.white.withValues(alpha: 0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isMobile ? 0.35 : 0.5),
            blurRadius: isMobile ? 20 : 28,
            offset: Offset(0, isMobile ? 8 : 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isMobile ? 18 : 20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 18 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Offer Pill & Location Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF5C38).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'INSTANT PASS',
                        style: AppTypography.ui(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFFF5C38),
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '3 DAMANSARA (L2)',
                        style: AppTypography.ui(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Card Main Headline (White + Coral Accent)
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Get In. ',
                        style: AppTypography.ui(
                          fontSize: isMobile ? 20 : 23,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      TextSpan(
                        text: 'Start Playing.',
                        style: AppTypography.ui(
                          fontSize: isMobile ? 20 : 23,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFFF5C38),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Dynamic QR unlocks turnstiles in 0.3s. No receptionist, no booking friction, no queues.',
                  style: AppTypography.ui(
                    fontSize: isMobile ? 12 : 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF94A3B8),
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 14),

                // Clean Checklist (Exactly like KITA's bundle list)
                _buildCleanCheckItem('10 ITTF Olympic Tables (6 Free Now)', isMobile: isMobile),
                const SizedBox(height: 7),
                _buildCleanCheckItem('Carbon Pro Rackets & Balls Included', isMobile: isMobile),
                const SizedBox(height: 7),
                _buildCleanCheckItem('Smart Robot Ball Dispensers Active', isMobile: isMobile),
                const SizedBox(height: 7),
                _buildCleanCheckItem('60 FPS AI Smash Tracking & Speedometer', isMobile: isMobile),

                const SizedBox(height: 18),

                // Clean Solid Action Button (Like KITA's [BOOK NOW] -> Electric Golden Amber on hover)
                ArenaInteractiveButton(
                  label: 'Unlock Turnstile (RM17)',
                  icon: Icons.arrow_forward_rounded,
                  onTap: widget.onWalkInTap,
                  isPrimary: true,
                  isFullWidth: true,
                  fontSize: isMobile ? 13 : 14,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),

                const SizedBox(height: 10),

                // Quiet secondary link
                Center(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => _scrollTo(_pricingKey),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'or RM27/mo Unlimited VIP Pass',
                            style: AppTypography.ui(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward_rounded, size: 12, color: Color(0xFF94A3B8)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCleanCheckItem(String text, {bool isMobile = false}) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: Color(0xFFFF5C38),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTypography.ui(
              fontSize: isMobile ? 11.5 : 12.5,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ),
      ],
    );
  }

  // ========================================================================
  // 3. LIVE ENERGY & STATS TICKER (Floating Glass Island with Razor Alignment)
  // ========================================================================
  Widget _buildLiveEnergyTicker(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 960;

        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            margin: EdgeInsets.symmetric(
              horizontal: isDesktop ? 40 : 16,
              vertical: 20,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 28 : 16,
              vertical: isDesktop ? 22 : 18,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: isDesktop
                ? Row(
                    children: [
                      Expanded(
                        child: _build3TierStat(
                          kicker: 'ALWAYS UNLOCKED',
                          metric: '24 / 7',
                          label: 'Open 365 Days • Midnight Friendly',
                          accentColor: luxuryVoltEmerald,
                        ),
                      ),
                      _buildStatDivider(),
                      Expanded(
                        child: _build3TierStat(
                          kicker: 'ITTF CERTIFIED',
                          metric: '10 Courts',
                          label: 'Olympic DHS & Nittaku Tables',
                          accentColor: luxuryCoralRose,
                        ),
                      ),
                      _buildStatDivider(),
                      Expanded(
                        child: _build3TierStat(
                          kicker: 'OPTICAL SPEED',
                          metric: '0.3 Sec',
                          label: 'Fastest Turnstile Gate in KL',
                          accentColor: luxuryElectricCyan,
                        ),
                      ),
                      _buildStatDivider(),
                      Expanded(
                        child: _build3TierStat(
                          kicker: 'UNBEATABLE VALUE',
                          metric: '90 Sen',
                          label: 'Per Day Unlimited VIP Pass',
                          accentColor: luxuryGold,
                        ),
                      ),
                      _buildStatDivider(),
                      Expanded(
                        child: _build3TierStat(
                          kicker: 'EDGE VISION',
                          metric: '60 FPS AI',
                          label: 'Smash Speed & Rally Camera',
                          accentColor: luxuryVoltEmerald,
                        ),
                      ),
                    ],
                  )
                : Wrap(
                    spacing: 16,
                    runSpacing: 18,
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      _build3TierStatMobile(
                        kicker: 'ALWAYS UNLOCKED',
                        metric: '24 / 7',
                        label: 'Open 365 Days',
                        accentColor: luxuryVoltEmerald,
                      ),
                      _build3TierStatMobile(
                        kicker: 'ITTF CERTIFIED',
                        metric: '10 Courts',
                        label: 'Olympic Tables',
                        accentColor: luxuryCoralRose,
                      ),
                      _build3TierStatMobile(
                        kicker: 'OPTICAL SPEED',
                        metric: '0.3s Gate',
                        label: 'QR Turnstile',
                        accentColor: luxuryElectricCyan,
                      ),
                      _build3TierStatMobile(
                        kicker: 'UNBEATABLE VALUE',
                        metric: '90 Sen/d',
                        label: 'VIP Unlimited',
                        accentColor: luxuryGold,
                      ),
                      _build3TierStatMobile(
                        kicker: 'EDGE VISION',
                        metric: '60 FPS AI',
                        label: 'Smash Tracking',
                        accentColor: luxuryVoltEmerald,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white.withValues(alpha: 0.07),
    );
  }

  Widget _build3TierStat({
    required String kicker,
    required String metric,
    required String label,
    required Color accentColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          kicker,
          style: AppTypography.ui(
            fontSize: 9.5,
            fontWeight: FontWeight.w900,
            color: accentColor,
            letterSpacing: 0.8,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          metric,
          style: AppTypography.ui(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTypography.ui(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            color: luxuryMuted,
            height: 1.25,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _build3TierStatMobile({
    required String kicker,
    required String metric,
    required String label,
    required Color accentColor,
  }) {
    return SizedBox(
      width: 130,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            kicker,
            style: AppTypography.ui(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: accentColor,
              letterSpacing: 0.6,
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 3),
          Text(
            metric,
            style: AppTypography.ui(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.ui(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: luxuryMuted,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // 4. "HOW IT WORKS" (4-STEP UNMANNED FUNNEL)
  // ========================================================================
  Widget _buildHowItWorksSection(BuildContext context) {
    return Container(
      key: _howItWorksKey,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 70),
      child: Column(
        children: [
          _buildSectionHeader(
            tag: 'THE UNMANNED REVOLUTION',
            title: 'How It Works in 4 Frictionless Steps',
            subtitle:
                'No reception desk, no queues, no phone bookings. Complete autonomy from parking lot to match point.',
          ),
          const SizedBox(height: 36),

          // Scroll-Driven Tactile Stacking Deck for the 4-Step Funnel
          HowItWorksStackingDeck(
            scrollController: _scrollController,
            steps: [
              HowItWorksStepItem(
                step: '01',
                tag: '12 AM – 8 AM MIDNIGHT CHILL',
                title: 'Show Up Anytime (24/7)',
                desc:
                    'Arrive at 2 PM or 3 AM. Basement P2 lifts take you straight up to Level 2 even when 3 Damansara Mall is closed and dark.',
                icon: Icons.nightlife_rounded,
                accentColor: const Color(0xFF10B981),
                surfaceColor: const Color(0xFF111722),
                imageAsset: 'assets/images/arena_match_intensity.jpg',
                hudBadgeText: 'P2 LIFT DIRECT ACCESS',
                hudBadgeIcon: Icons.elevator_rounded,
                ctaLabel: 'View Midnight Pass',
                onTap: widget.onWalkInTap,
                stats: const [
                  {'value': '24/7/365', 'label': 'Always Open'},
                  {'value': 'P2 Lift', 'label': 'Direct Mall Lift'},
                  {'value': '0 Sec', 'label': 'Queue Stress'},
                ],
              ),
              HowItWorksStepItem(
                step: '02',
                tag: 'INSTANT ENTRY',
                title: '0.3s Optical QR Turnstile',
                desc:
                    'Flash your phone QR code at Gate 1 or Gate 2. Anti-tailgating optical scanners verify membership and unlock in 300 milliseconds.',
                icon: Icons.qr_code_scanner_rounded,
                accentColor: const Color(0xFFFF5C38),
                surfaceColor: const Color(0xFF1A131C),
                imageAsset: 'assets/images/arena_table_equipment.jpg',
                hudBadgeText: '300ms OPTICAL SCAN',
                hudBadgeIcon: Icons.bolt_rounded,
                ctaLabel: 'Test QR Access',
                onTap: widget.onWalkInTap,
                stats: const [
                  {'value': '300 ms', 'label': 'Fast Unlock'},
                  {'value': 'Gate 1 & 2', 'label': 'Anti-Tailgate'},
                  {'value': 'Offline QR', 'label': 'Cached Auth'},
                ],
              ),
              HowItWorksStepItem(
                step: '03',
                tag: 'ZERO RENTAL FEES',
                title: 'Smart Gear & Robot Dispenser',
                desc:
                    'Sanitized ITTF 3-star balls dispense automatically at each court. Professional carbon composite paddles ready in your locker.',
                icon: Icons.sports_tennis_rounded,
                accentColor: const Color(0xFF00D2FF),
                surfaceColor: const Color(0xFF0E1A26),
                imageAsset: 'assets/images/arena_table_equipment.jpg',
                hudBadgeText: 'SANITIZED ITTF BALLS',
                hudBadgeIcon: Icons.verified_rounded,
                ctaLabel: 'Check Table Gear',
                onTap: widget.onViewCourtsTap,
                stats: const [
                  {'value': '3-Star', 'label': 'ITTF Approved'},
                  {'value': 'Carbon', 'label': 'Pro Paddles'},
                  {'value': 'RM 0', 'label': 'Gear Fee'},
                ],
              ),
              HowItWorksStepItem(
                step: '04',
                tag: 'LIVE LEADERBOARD',
                title: 'AI Optical HUD & XP Rewards',
                desc:
                    'Overhead 60 FPS vision cameras record smash velocity, spin, and match scores. Earn XP to climb the Damansara Leaderboard.',
                icon: Icons.military_tech_rounded,
                accentColor: const Color(0xFFFFB800),
                surfaceColor: const Color(0xFF1A1710),
                imageAsset: 'assets/images/arena_live_rally.jpg',
                hudBadgeText: '118 KM/H SMASH TRACKED',
                hudBadgeIcon: Icons.speed_rounded,
                ctaLabel: 'See Arena Leaderboard',
                onTap: widget.onViewLeagueTap,
                stats: const [
                  {'value': '60 FPS', 'label': 'AI Vision'},
                  {'value': 'Live Elo', 'label': 'Instant Rank'},
                  {'value': '+45 XP', 'label': 'Match Win'},
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // 5. "ARE YOU FEELING THE ENERGY?" (VIBE & CULTURE BENTO GRID WITH REAL PHOTOGRAPHY)
  // ========================================================================
  Widget _buildVibeCultureSection(BuildContext context) {
    return Container(
      key: _vibeKey,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 70),
      decoration: BoxDecoration(
        color: luxuryCard.withValues(alpha: 0.4),
      ),
      child: Column(
        children: [
          _buildSectionHeader(
            tag: 'ARE YOU FEELING THE ENERGY?',
            title: 'Table Tennis Like You’ve Never Seen Before',
            subtitle:
                'Forget humid community halls with broken nets. JOMNITTAKU combines cyberpunk stadium lighting, Olympic tournament hardware, and electric 24/7 culture.',
          ),
          const SizedBox(height: 48),

          // Bento Grid: 2 rows with Real High-Intensity Photography
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 960;
              return Column(
                children: [
                  // Row 1: Midnight Owl Culture + 90 sen pass
                  isDesktop
                      ? Row(
                          children: [
                            Expanded(
                              flex: 58,
                              child: _buildBentoCard(
                                tag: '12 AM – 8 AM MIDNIGHT CHILL',
                                title: 'The 3 AM Table Tennis Rush',
                                desc:
                                    'When the city goes to sleep, the smashes get louder. Enjoy 50% discount during midnight happy hours, ambient lofi-electronic beats, and zero queue stress.',
                                icon: Icons.dark_mode_rounded,
                                accentColor: const Color(0xFF818CF8),
                                badgeText: '50% OFF MIDNIGHT',
                                backgroundImageAsset: 'assets/images/arena_match_intensity.jpg',
                                ctaLabel: 'Experience Midnight Rush',
                                onTap: widget.onWalkInTap,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 42,
                              child: _buildBentoCard(
                                tag: 'UNBEATABLE VALUE',
                                title: '90 Sen / Day Freedom',
                                desc:
                                    'Cheaper than a cup of Kopi Ais (RM0.90/day). One monthly VIP pass gives you and your friends 24/7 unlimited walk-in freedom.',
                                icon: Icons.stars_rounded,
                                accentColor: luxuryCoralRose,
                                badgeText: 'RM27 / MO',
                                ctaLabel: 'View VIP Passes',
                                onTap: widget.onWalkInTap,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            _buildBentoCard(
                              tag: '12 AM – 8 AM MIDNIGHT CHILL',
                              title: 'The 3 AM Table Tennis Rush',
                              desc:
                                    'When the city goes to sleep, the smashes get louder. Enjoy 50% discount during midnight happy hours, ambient lofi-electronic beats, and zero queue stress.',
                              icon: Icons.dark_mode_rounded,
                              accentColor: const Color(0xFF818CF8),
                              badgeText: '50% OFF MIDNIGHT',
                              backgroundImageAsset: 'assets/images/arena_match_intensity.jpg',
                              ctaLabel: 'Experience Midnight Rush',
                              onTap: widget.onWalkInTap,
                            ),
                            const SizedBox(height: 16),
                            _buildBentoCard(
                              tag: 'UNBEATABLE VALUE',
                              title: '90 Sen / Day Freedom',
                              desc:
                                  'Cheaper than a cup of Kopi Ais (RM0.90/day). One monthly VIP pass gives you 24/7 unlimited walk-in freedom.',
                              icon: Icons.stars_rounded,
                              accentColor: luxuryCoralRose,
                              badgeText: 'RM27 / MO',
                              ctaLabel: 'View VIP Passes',
                              onTap: widget.onWalkInTap,
                            ),
                          ],
                        ),

                  const SizedBox(height: 20),

                  // Row 2: 1v1 Challenge Pot + ITTF Olympic standard
                  isDesktop
                      ? Row(
                          children: [
                            Expanded(
                              flex: 42,
                              child: _buildBentoCard(
                                tag: 'LIVE RADAR CHALLENGE',
                                title: '1v1 Match Pots & Elo Rank',
                                desc:
                                    'Scan the radar for nearby rivals. Bet XP or cash pots (RM50 – RM200) in verified AI-scored 1v1 matches.',
                                icon: Icons.local_fire_department_rounded,
                                accentColor: luxuryGold,
                                badgeText: 'RM200 POTS',
                                backgroundImageAsset: 'assets/images/arena_live_rally.jpg',
                                ctaLabel: 'Find Rivals on Radar',
                                onTap: widget.onViewCourtsTap,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 58,
                              child: _buildBentoCard(
                                tag: 'ITTF OLYMPIC EQUIPMENT',
                                title: 'Pro DHS & Nittaku Tables',
                                desc:
                                    'Championship-standard DHS Rainbow & Nittaku Premium 25mm bounce surfaces. Dual-split climate chillers (23°C / 54% humidity) and 480 Lux anti-stroboscopic LED lighting.',
                                icon: Icons.verified_rounded,
                                accentColor: luxuryVoltEmerald,
                                badgeText: '100% ITTF CERTIFIED',
                                backgroundImageAsset: 'assets/images/arena_table_equipment.jpg',
                                ctaLabel: 'Check Table Availability',
                                onTap: widget.onViewCourtsTap,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            _buildBentoCard(
                              tag: 'LIVE RADAR CHALLENGE',
                              title: '1v1 Match Pots & Elo Rank',
                              desc:
                                  'Scan the radar for nearby rivals. Bet XP or cash pots in verified AI-scored 1v1 matches.',
                              icon: Icons.local_fire_department_rounded,
                              accentColor: luxuryGold,
                              badgeText: 'RM200 POTS',
                              backgroundImageAsset: 'assets/images/arena_live_rally.jpg',
                              ctaLabel: 'Find Rivals on Radar',
                              onTap: widget.onViewCourtsTap,
                            ),
                            const SizedBox(height: 16),
                            _buildBentoCard(
                              tag: 'ITTF OLYMPIC EQUIPMENT',
                              title: 'Pro DHS & Nittaku Tables',
                              desc:
                                  'Championship-standard DHS Rainbow & Nittaku Premium 25mm surfaces. 23°C climate chillers and 480 Lux lighting.',
                              icon: Icons.verified_rounded,
                              accentColor: luxuryVoltEmerald,
                              badgeText: '100% ITTF CERTIFIED',
                              backgroundImageAsset: 'assets/images/arena_table_equipment.jpg',
                              ctaLabel: 'Check Table Availability',
                              onTap: widget.onViewCourtsTap,
                            ),
                          ],
                        ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBentoCard({
    required String tag,
    required String title,
    required String desc,
    required IconData icon,
    required Color accentColor,
    required String badgeText,
    String? backgroundImageAsset,
    VoidCallback? onTap,
    String? ctaLabel,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: luxuryCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dr. Arefin Canonical Pattern: 16/10 High-Res Image Header
            if (backgroundImageAsset != null)
              AspectRatio(
                aspectRatio: 16 / 10,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      backgroundImageAsset,
                      fit: BoxFit.cover,
                    ),
                    // Subtle bottom vignette gradient to blend image seamlessly into card body
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            luxuryCard.withValues(alpha: 0.75),
                          ],
                          stops: const [0.65, 1.0],
                        ),
                      ),
                    ),
                    // Top floating badge
                    Positioned(
                      top: 14,
                      right: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          badgeText,
                          style: AppTypography.ui(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Card Body Content (Clean Typography & Accent Kicker)
            Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: accentColor.withValues(alpha: 0.35),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(icon, size: 14, color: accentColor),
                            const SizedBox(width: 6),
                            Text(
                              tag,
                              style: AppTypography.ui(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: accentColor,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (backgroundImageAsset == null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            badgeText,
                            style: AppTypography.ui(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: AppTypography.ui(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    desc,
                    style: AppTypography.ui(
                      fontSize: 13.5,
                      color: const Color(0xFFBAC0D6),
                      height: 1.55,
                    ),
                  ),
                  if (ctaLabel != null && onTap != null) ...[
                    const SizedBox(height: 18),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onTap,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              ctaLabel,
                              style: AppTypography.ui(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w900,
                                color: accentColor,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(Icons.arrow_forward_rounded, size: 14, color: accentColor),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================================================================
  // 6. LIVE 10-COURT INTERACTIVE RADAR TEASER
  // ========================================================================
  Widget _buildLiveCourtsTeaser(BuildContext context) {
    return Container(
      key: _courtsKey,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 70),
      child: Column(
        children: [
          _buildSectionHeader(
            tag: 'LIVE VENUE MAP • 3 DAMANSARA LEVEL 2',
            title: '10 ITTF Courts. Check Status Right Now.',
            subtitle:
                'See which court is free before you arrive. Tap any table to preview hardware specifications.',
          ),
          const SizedBox(height: 40),

          // 10 Courts Interactive Floorplan
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: luxuryCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: Column(
              children: [
                // Top Telemetry Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.radar_rounded,
                          size: 16,
                          color: luxuryVoltEmerald,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'OPTICAL RADAR: 6 FREE • 3 IN PLAY • 1 RESERVED',
                          style: AppTypography.ui(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: widget.onViewCourtsTap,
                        child: Text(
                          'Open Full Screen Radar →',
                          style: AppTypography.ui(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            color: luxuryCoralRose,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // 10 Tables Grid
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: List.generate(10, (index) {
                    final courtNum = index + 1;
                    final courtId = 'T${courtNum.toString().padLeft(2, '0')}';

                    // Mock states matching actual venue
                    final isBusy = courtNum == 1 || courtNum == 2;
                    final isMatch = courtNum == 4;
                    final isReserved = courtNum == 9;

                    final isSelected = _selectedPreviewCourt == courtNum;

                    Color statusColor = luxuryVoltEmerald;
                    String statusText = 'FREE';
                    if (isBusy) {
                      statusColor = const Color(0xFFF59E0B);
                      statusText = 'IN PLAY';
                    } else if (isMatch) {
                      statusColor = luxuryCoralRose;
                      statusText = 'LIVE MATCH';
                    } else if (isReserved) {
                      statusColor = const Color(0xFF818CF8);
                      statusText = 'RESERVED';
                    }

                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _selectedPreviewCourt = courtNum);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: 110,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? statusColor.withValues(alpha: 0.2)
                                : luxuryCardElevated,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? statusColor
                                  : Colors.white.withValues(alpha: 0.08),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Ping Pong Table Icon Representation
                              Container(
                                width: 44,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: statusColor,
                                    width: 1.2,
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 1,
                                    height: 22,
                                    color: Colors.white.withValues(alpha: 0.5),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                courtId,
                                style: AppTypography.ui(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                statusText,
                                style: AppTypography.ui(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 24),

                // Selected Court Action Banner
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    color: luxuryCardElevated,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: luxuryVoltEmerald.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'T0$_selectedPreviewCourt',
                          style: AppTypography.ui(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: luxuryVoltEmerald,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _selectedPreviewCourt == 4
                              ? 'Centre Stadium Court • ITTF Rainbow • Currently Live Match (Jason vs Alman)'
                              : 'Olympic Tournament Table • ITTF 3-Star Balls Ready • Anti-Glare 480 Lux',
                          style: AppTypography.ui(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: widget.onWalkInTap,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: luxuryCoralRose,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Unlock Gate to Play →',
                              style: AppTypography.ui(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // 7. PRICING & PASSES SECTION
  // ========================================================================
  Widget _buildPricingSection(BuildContext context) {
    return Container(
      key: _pricingKey,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 70),
      decoration: BoxDecoration(
        color: luxuryCard.withValues(alpha: 0.3),
      ),
      child: Column(
        children: [
          _buildSectionHeader(
            tag: 'TRANSPARENT VALUE • NO HIDDEN FEES',
            title: 'Simple, Affordable Arena Passes',
            subtitle:
                'Whether you want a quick 1-hour midnight smash or unlimited 24/7 access every single day, choose the pass that fits your game.',
          ),
          const SizedBox(height: 48),

          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 960;
              return isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildPricingCard(
                            tier: 'WALK-IN QUICK PASS',
                            price: 'RM17',
                            period: '/ session (1 hr)',
                            desc: 'Perfect for quick spontaneous midnight games with a friend.',
                            features: [
                              'Instant 0.3s QR Turnstile Entry',
                              '2 Carbon Composite Rackets Included',
                              '10 ITTF 3-Star Balls Dispensed',
                              'Standard Court Access',
                              'No Membership Required',
                            ],
                            ctaText: 'Get Walk-In Pass',
                            isPopular: false,
                            onTap: widget.onWalkInTap,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildPricingCard(
                            tier: 'VIP UNLIMITED PASS',
                            price: '90 sen',
                            period: '/ day (RM27 / month)',
                            desc: 'Our most popular pass. Unlimited 24/7 access whenever you want.',
                            features: [
                              '24/7/365 Unlimited Arena Access',
                              'Smart RFID Keycard Included',
                              'Free Auto Robot Ball Dispenser',
                              '50% Off Guest Passes',
                              'AI Optical Smash Speed Tracking',
                              'Priority Midnight Table Access',
                            ],
                            ctaText: 'Get VIP 90 Sen Pass →',
                            isPopular: true,
                            onTap: widget.onWalkInTap,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildPricingCard(
                            tier: 'PRO OLYMPIC LEAGUE',
                            price: 'RM59',
                            period: '/ month',
                            desc: 'For competitive players aiming for city rankings and tournaments.',
                            features: [
                              'All VIP Pass Benefits Included',
                              'Weekly League Tournament Entry',
                              'AI 60 FPS Match Video Downloads',
                              'Private Dedicated Locker',
                              'Advance Table Reservations',
                              'Official City Ranking & Elo Profile',
                            ],
                            ctaText: 'Join Pro League',
                            isPopular: false,
                            onTap: widget.onViewLeagueTap,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildPricingCard(
                          tier: 'WALK-IN QUICK PASS',
                          price: 'RM17',
                          period: '/ session (1 hr)',
                          desc: 'Perfect for quick spontaneous midnight games with a friend.',
                          features: [
                            'Instant 0.3s QR Turnstile Entry',
                            '2 Carbon Composite Rackets Included',
                            '10 ITTF 3-Star Balls Dispensed',
                            'No Membership Required',
                          ],
                          ctaText: 'Get Walk-In Pass',
                          isPopular: false,
                          onTap: widget.onWalkInTap,
                        ),
                        const SizedBox(height: 20),
                        _buildPricingCard(
                          tier: 'VIP UNLIMITED PASS',
                          price: '90 sen',
                          period: '/ day (RM27 / month)',
                          desc: 'Our most popular pass. Unlimited 24/7 access whenever you want.',
                          features: [
                            '24/7/365 Unlimited Arena Access',
                            'Smart RFID Keycard Included',
                            'Free Auto Robot Ball Dispenser',
                            '50% Off Guest Passes',
                            'AI Optical Smash Speed Tracking',
                          ],
                          ctaText: 'Get VIP 90 Sen Pass →',
                          isPopular: true,
                          onTap: widget.onWalkInTap,
                        ),
                        const SizedBox(height: 20),
                        _buildPricingCard(
                          tier: 'PRO OLYMPIC LEAGUE',
                          price: 'RM59',
                          period: '/ month',
                          desc: 'For competitive players aiming for city rankings and tournaments.',
                          features: [
                            'All VIP Pass Benefits Included',
                            'Weekly League Tournament Entry',
                            'AI 60 FPS Match Video Downloads',
                            'Official City Ranking & Elo Profile',
                          ],
                          ctaText: 'Join Pro League',
                          isPopular: false,
                          onTap: widget.onViewLeagueTap,
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard({
    required String tier,
    required String price,
    required String period,
    required String desc,
    required List<String> features,
    required String ctaText,
    required bool isPopular,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isPopular ? luxuryCardElevated : luxuryCard,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isPopular
              ? luxuryCoralRose
              : Colors.white.withValues(alpha: 0.08),
          width: isPopular ? 2 : 1,
        ),
        boxShadow: isPopular
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: luxuryCoralRose,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'MOST POPULAR CHOICE',
                style: AppTypography.ui(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          Text(
            tier,
            style: AppTypography.ui(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: isPopular ? luxuryCoralRose : luxuryMuted,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                price,
                style: AppTypography.ui(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                period,
                style: AppTypography.ui(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: luxuryMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            style: AppTypography.ui(
              fontSize: 12.5,
              color: const Color(0xFFBAC0D6),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.white.withValues(alpha: 0.08)),
          const SizedBox(height: 16),
          // Features List
          ...features.map(
            (feat) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 14,
                    color: isPopular ? luxuryCoralRose : luxuryVoltEmerald,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feat,
                      style: AppTypography.ui(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Action Button
          ArenaInteractiveButton(
            label: ctaText,
            onTap: onTap,
            isPrimary: isPopular,
            isFullWidth: true,
            borderRadius: BorderRadius.circular(12),
            fontSize: 13,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // 8. AFTER-HOURS ACCESS GUIDE (MALL CLOSED? HOW TO ENTER)
  // ========================================================================
  Widget _buildNightAccessSection(BuildContext context) {
    return Container(
      key: _locationKey,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 70),
      child: Column(
        children: [
          _buildSectionHeader(
            tag: '3 DAMANSARA MALL • 24/7 ENTRANCE',
            title: 'Mall Closed at Midnight? Here’s How To Enter',
            subtitle:
                '3 Damansara Mall retail gates lock at 10 PM, but our arena is 100% open 24/7 via the dedicated car park express lifts.',
          ),
          const SizedBox(height: 48),

          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: luxuryCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth >= 840;
                return isDesktop
                    ? Row(
                        children: [
                          Expanded(
                            child: _buildAccessStep(
                              icon: Icons.directions_car_rounded,
                              stepNum: 'STEP 1',
                              title: 'Park at Basement P2',
                              desc: 'Enter via Jalan SS 20/27. Park near Green Zone Pillar B12.',
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 100,
                            color: Colors.white.withValues(alpha: 0.08),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          Expanded(
                            child: _buildAccessStep(
                              icon: Icons.elevator_rounded,
                              stepNum: 'STEP 2',
                              title: 'Take Lift Lobby B',
                              desc: 'Operates 24/7. Press button Level 2 (Sports & Entertainment wing).',
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 100,
                            color: Colors.white.withValues(alpha: 0.08),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          Expanded(
                            child: _buildAccessStep(
                              icon: Icons.qr_code_scanner_rounded,
                              stepNum: 'STEP 3',
                              title: 'Scan QR at Turnstile',
                              desc: 'JOMNITTAKU neon logo is right in front. Scan and play!',
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildAccessStep(
                            icon: Icons.directions_car_rounded,
                            stepNum: 'STEP 1',
                            title: 'Park at Basement P2',
                            desc: 'Enter via Jalan SS 20/27. Park near Green Zone Pillar B12.',
                          ),
                          const SizedBox(height: 20),
                          _buildAccessStep(
                            icon: Icons.elevator_rounded,
                            stepNum: 'STEP 2',
                            title: 'Take Lift Lobby B',
                            desc: 'Operates 24/7. Press button Level 2 (Sports wing).',
                          ),
                          const SizedBox(height: 20),
                          _buildAccessStep(
                            icon: Icons.qr_code_scanner_rounded,
                            stepNum: 'STEP 3',
                            title: 'Scan QR at Turnstile',
                            desc: 'JOMNITTAKU neon logo is right in front. Scan and play!',
                          ),
                        ],
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccessStep({
    required IconData icon,
    required String stepNum,
    required String title,
    required String desc,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: luxuryVoltEmerald),
            const SizedBox(width: 8),
            Text(
              stepNum,
              style: AppTypography.ui(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: luxuryVoltEmerald,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: AppTypography.ui(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          desc,
          style: AppTypography.ui(
            fontSize: 12.5,
            color: luxuryMuted,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  // ========================================================================
  // 9. FINAL HIGH-VOLTAGE CTA SECTION
  // ========================================================================
  Widget _buildFinalCtaSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 56),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E1428),
            Color(0xFF16192E),
            luxuryCard,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: luxuryCoralRose.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '⚡ READY FOR YOUR FIRST SMASH?',
                style: AppTypography.ui(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: luxuryCoralRose,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Your Table Is Waiting.\nUnlock The Gates In 30 Seconds.',
              textAlign: TextAlign.center,
              style: AppTypography.ui(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 14),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Text(
                'No membership required. Walk in right now at Level 2, 3 Damansara Mall, or dive into our live arena dashboard.',
                textAlign: TextAlign.center,
                style: AppTypography.ui(
                  fontSize: 14,
                  color: const Color(0xFFBAC0D6),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: widget.onWalkInTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF4B72), Color(0xFFFF6B4A)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'Unlock Instant QR Access (RM17) →',
                        style: AppTypography.ui(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: widget.onLaunchHub,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.dashboard_rounded,
                            size: 16,
                            color: luxuryElectricCyan,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Launch Arena Command Hub',
                            style: AppTypography.ui(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ========================================================================
  // 10. FOOTER
  // ========================================================================
  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      decoration: BoxDecoration(
        color: const Color(0xFF090A0F),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: luxuryCoralRose.withValues(alpha: 0.15),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/company_logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'JOMNITTAKU NO MAN SHOW',
                        style: AppTypography.ui(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: luxuryVoltEmerald,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'ALL 10 COURTS & GATES OPERATIONAL 24/7',
                        style: AppTypography.ui(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: luxuryVoltEmerald,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.white.withValues(alpha: 0.05)),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Level 2, 3 Damansara Mall, Petaling Jaya, Selangor, Malaysia',
                    style: AppTypography.ui(
                      fontSize: 11.5,
                      color: luxuryMuted,
                    ),
                  ),
                  Text(
                    '© 2026 JOMNITTAKU. Malaysia’s 1st Unmanned Sports Arena.',
                    style: AppTypography.ui(
                      fontSize: 11.5,
                      color: luxuryMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // REUSABLE SECTION HEADER
  // ========================================================================
  Widget _buildSectionHeader({
    required String tag,
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: luxuryCoralRose.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            tag,
            style: AppTypography.ui(
              fontSize: 10.5,
              fontWeight: FontWeight.w900,
              color: luxuryCoralRose,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTypography.ui(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTypography.ui(
              fontSize: 14,
              color: const Color(0xFFBAC0D6),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// LUXURY INTERACTIVE HOVER BUTTON
// Smooth, tactile hover transition into a satisfying, luminous contrasting color
// ============================================================================
class ArenaInteractiveButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final bool isFullWidth;
  final IconData? icon;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? normalColor;
  final Color? hoverColor;
  final Color? normalTextColor;
  final Color? hoverTextColor;

  const ArenaInteractiveButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isPrimary = true,
    this.isFullWidth = false,
    this.icon,
    this.fontSize,
    this.padding,
    this.borderRadius,
    this.normalColor,
    this.hoverColor,
    this.normalTextColor,
    this.hoverTextColor,
  });

  @override
  State<ArenaInteractiveButton> createState() => _ArenaInteractiveButtonState();
}

class _ArenaInteractiveButtonState extends State<ArenaInteractiveButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final br = widget.borderRadius ?? BorderRadius.circular(10);

    // Primary: Signature Warm Coral (#FF5C38) -> Electric Golden Amber (#FFB800) with dark obsidian text (#0A0B10)
    // Secondary: Dark Glass White (0.08) -> Pure Luminous White (#FFFFFF) with dark obsidian text (#0A0B10)
    final Color defaultNormalColor = widget.isPrimary
        ? const Color(0xFFFF5C38)
        : Colors.white.withValues(alpha: 0.08);

    final Color defaultHoverColor = widget.isPrimary
        ? const Color(0xFFFFB800)
        : Colors.white;

    final Color bgColor = _isHovered
        ? (widget.hoverColor ?? defaultHoverColor)
        : (widget.normalColor ?? defaultNormalColor);

    const Color defaultNormalTextColor = Colors.white;
    const Color defaultHoverTextColor = Color(0xFF0A0B10);

    final Color textColor = _isHovered
        ? (widget.hoverTextColor ?? defaultHoverTextColor)
        : (widget.normalTextColor ?? defaultNormalTextColor);

    final Border? border = widget.isPrimary
        ? null
        : Border.all(
            color: _isHovered ? Colors.white : Colors.white.withValues(alpha: 0.25),
            width: 1,
          );

    final List<BoxShadow> shadows = widget.isPrimary
        ? [
            BoxShadow(
              color: _isHovered
                  ? const Color(0xFFFFB800).withValues(alpha: 0.55)
                  : const Color(0xFFFF5C38).withValues(alpha: 0.35),
              blurRadius: _isHovered ? 22 : 14,
              spreadRadius: _isHovered ? 1 : 0,
              offset: _isHovered ? const Offset(0, 6) : const Offset(0, 4),
            ),
          ]
        : [
            if (_isHovered)
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.4),
                blurRadius: 18,
                offset: const Offset(0, 4),
              ),
          ];

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        onHover: (hovering) {
          if (_isHovered != hovering) {
            setState(() => _isHovered = hovering);
          }
        },
        borderRadius: br,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: _isHovered
              ? Matrix4.translationValues(0.0, -2.0, 0.0)
              : Matrix4.identity(),
          width: widget.isFullWidth ? double.infinity : null,
          padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: br,
            border: border,
            boxShadow: shadows,
          ),
          child: Row(
            mainAxisSize: widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: (widget.fontSize ?? 14) + 1,
                  color: textColor,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: AppTypography.ui(
                  fontSize: widget.fontSize ?? 14,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

