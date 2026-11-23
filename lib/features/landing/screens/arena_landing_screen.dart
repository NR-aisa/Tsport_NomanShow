import 'package:flutter/material.dart';

import '../../../core/session/demo_avatars.dart';
import '../../../core/theme/app_typography.dart';

/// High-Converting, Pulse-Pounding Public Landing Page for JOMNITTAKU.
///
/// Theme: "Malaysia's 1st 24/7 Autonomous Unmanned Table Tennis Arena"
/// Location: 3 Damansara Mall, Level 2
/// Core Goal: Attract, excite, and convert visitors with raw athletic energy ("ধুমধাম খেলা হইতেছে! Are you feeling the energy?").
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

class _ArenaLandingScreenState extends State<ArenaLandingScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Global Keys for smooth scrolling to sections
  final GlobalKey _vibeKey = GlobalKey();
  final GlobalKey _howItWorksKey = GlobalKey();
  final GlobalKey _courtsKey = GlobalKey();
  final GlobalKey _pricingKey = GlobalKey();
  final GlobalKey _locationKey = GlobalKey();

  // Active court for mini-interactive floorplan preview
  int _selectedPreviewCourt = 4; // Center Court (T04)

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
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
      body: Stack(
        children: [
          // Background ambient glows
          Positioned(
            top: -150,
            left: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: luxuryCoralRose.withValues(alpha: 0.08),
                boxShadow: [
                  BoxShadow(
                    color: luxuryCoralRose.withValues(alpha: 0.12),
                    blurRadius: 180,
                    spreadRadius: 100,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 400,
            right: -100,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: luxuryElectricCyan.withValues(alpha: 0.06),
                boxShadow: [
                  BoxShadow(
                    color: luxuryElectricCyan.withValues(alpha: 0.08),
                    blurRadius: 220,
                    spreadRadius: 80,
                  ),
                ],
              ),
            ),
          ),

          // Main Scrollable Body
          SingleChildScrollView(
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
        ],
      ),
    );
  }

  // ========================================================================
  // 1. TOP GLASS NAVBAR
  // ========================================================================
  Widget _buildNavbar(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 960;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 16 : 40,
        vertical: 16,
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
                children: [
                  Container(
                    width: 38,
                    height: 38,
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
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            'JOMNITTAKU',
                            style: AppTypography.ui(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: luxuryCoralRose.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '24/7',
                              style: AppTypography.ui(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: luxuryCoralRose,
                              ),
                            ),
                          ),
                        ],
                      ),
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

          // Desktop Nav Links
          if (!isCompact) ...[
            _buildNavLink('The Vibe', () => _scrollTo(_vibeKey)),
            const SizedBox(width: 20),
            _buildNavLink('How It Works', () => _scrollTo(_howItWorksKey)),
            const SizedBox(width: 20),
            _buildNavLink('10 Courts Radar', () => _scrollTo(_courtsKey)),
            const SizedBox(width: 20),
            _buildNavLink('Passes & Pricing', () => _scrollTo(_pricingKey)),
            const SizedBox(width: 20),
            _buildNavLink('Night Entrance', () => _scrollTo(_locationKey)),
            const SizedBox(width: 24),
          ],

          // Live Courts Badge
          Container(
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

          const SizedBox(width: 14),

          // Primary Launch Dashboard Button
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: widget.onLaunchHub,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF4B72), Color(0xFFFF6B4A)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: luxuryCoralRose.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.dashboard_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Launch Arena Hub →',
                      style: AppTypography.ui(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
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
  // ========================================================================
  Widget _buildHeroSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1060;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: isDesktop ? 60 : 36,
      ),
      constraints: const BoxConstraints(maxWidth: 1400),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Column: High-Impact Typography & Sales Funnel
                Expanded(
                  flex: 55,
                  child: _buildHeroLeftContent(context),
                ),
                const SizedBox(width: 50),
                // Right Column: Interactive 3D Stadium Centre Court Card
                Expanded(
                  flex: 45,
                  child: _buildHeroRightCard(context),
                ),
              ],
            )
          : Column(
              children: [
                _buildHeroLeftContent(context),
                const SizedBox(height: 36),
                _buildHeroRightCard(context),
              ],
            ),
    );
  }

  Widget _buildHeroLeftContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tagline Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: luxuryCoralRose.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: luxuryCoralRose.withValues(alpha: 0.35),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.bolt_rounded,
                size: 14,
                color: luxuryCoralRose,
              ),
              const SizedBox(width: 6),
              Text(
                'MALAYSIA’S 1ST 24/7 UNMANNED ARENA',
                style: AppTypography.ui(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w900,
                  color: luxuryCoralRose,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Bold Punchy Headline
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Midnight Smashes.\n',
                style: AppTypography.ui(
                  fontSize: 44,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.1,
                  letterSpacing: -0.5,
                ),
              ),
              TextSpan(
                text: 'Zero Staff. ',
                style: AppTypography.ui(
                  fontSize: 44,
                  fontWeight: FontWeight.w900,
                  color: luxuryCoralRose,
                  height: 1.1,
                  letterSpacing: -0.5,
                ),
              ),
              TextSpan(
                text: 'Are You Feeling The Energy?',
                style: AppTypography.ui(
                  fontSize: 44,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF00F0FF),
                  height: 1.1,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Persuasive Story Copy
        Text(
          'রাত ৩টায় খেলা হবে ধুমধাম! কোনো রিসেপশনিস্ট নেই, কোনো বুকিংয়ের ঝামেলা নেই। ৩ দামানসারা মলে ১০টি অলিম্পিক টেবিল, অটোমেটিক বল ডিসপেনসার আর অপটিক্যাল স্ম্যাশ রাডার ২৪ ঘণ্টাই চালু। ফোন দিয়ে QR স্ক্যান করুন, টার্নস্টাইল আনলক হবে—বাকিটা শুধুই পিওর অ্যাড্রেনালিন!',
          style: AppTypography.ui(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFC0C5DC),
            height: 1.6,
          ),
        ),

        const SizedBox(height: 30),

        // CTA Buttons Row
        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: [
            // Instant QR Walk-In Button
            ScaleTransition(
              scale: _pulseAnimation,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: widget.onWalkInTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF4B72), Color(0xFFFF6B4A)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: luxuryCoralRose.withValues(alpha: 0.45),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.qr_code_2_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Walk In & Play Now (RM17) →',
                          style: AppTypography.ui(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Enter Live Arena Hub Button
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: widget.onLaunchHub,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: luxuryCardElevated,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.sensors_rounded,
                        size: 16,
                        color: luxuryElectricCyan,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Open Live Arena Hub',
                        style: AppTypography.ui(
                          fontSize: 13,
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

        const SizedBox(height: 24),

        // Live Trust Badges
        Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              size: 14,
              color: luxuryVoltEmerald,
            ),
            const SizedBox(width: 6),
            Text(
              'No Membership Required',
              style: AppTypography.ui(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: luxuryMuted,
              ),
            ),
            const SizedBox(width: 16),
            const Icon(
              Icons.check_circle_rounded,
              size: 14,
              color: luxuryVoltEmerald,
            ),
            const SizedBox(width: 6),
            Text(
              'Equipment Included (Paddles & Balls)',
              style: AppTypography.ui(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: luxuryMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroRightCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: luxuryCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: luxuryCoralRose.withValues(alpha: 0.1),
            blurRadius: 40,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Court & Tracking Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: luxuryCoralRose,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'CENTRE COURT T04 • LIVE HUD',
                    style: AppTypography.ui(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: luxuryVoltEmerald.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '60 FPS EDGE AI',
                  style: AppTypography.ui(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w900,
                    color: luxuryVoltEmerald,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Live Match Scoreboard
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: luxuryCardElevated,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
            child: Row(
              children: [
                // Player 1
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(DemoAvatars.jason),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jason T.',
                        style: AppTypography.ui(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Damansara Lvl 14',
                        style: AppTypography.ui(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: luxuryMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                // Score
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '14 — 11',
                    style: AppTypography.ui(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: luxuryCoralRose,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Player 2
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Alman R.',
                        style: AppTypography.ui(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Pro Member Lvl 12',
                        style: AppTypography.ui(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: luxuryMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(DemoAvatars.user),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // 3 Live Metric Mini-Cards
          Row(
            children: [
              Expanded(
                child: _buildHeroMetricPill(
                  label: 'Smash Speed',
                  value: '84.6 km/h',
                  icon: Icons.speed_rounded,
                  color: luxuryCoralRose,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildHeroMetricPill(
                  label: 'Active Rally',
                  value: '14 Hits',
                  icon: Icons.repeat_rounded,
                  color: luxuryElectricCyan,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildHeroMetricPill(
                  label: 'Turnstile',
                  value: '0.3s Open',
                  icon: Icons.door_sliding_rounded,
                  color: luxuryVoltEmerald,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Instant Play Callout
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: luxuryVoltEmerald.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: luxuryVoltEmerald.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.electric_bolt_rounded,
                  size: 16,
                  color: luxuryVoltEmerald,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Court T03 & T05 Free Right Now — Instant Turnstile QR ready.',
                    style: AppTypography.ui(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: widget.onWalkInTap,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      'Play Now →',
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: luxuryVoltEmerald,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroMetricPill({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: luxuryCardElevated,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: color),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.ui(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: luxuryMuted,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.ui(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // 3. LIVE ENERGY & STATS TICKER
  // ========================================================================
  Widget _buildLiveEnergyTicker(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: luxuryCard,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.white.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 36,
          runSpacing: 18,
          children: [
            _buildStatItem('24 / 7', 'Always Unlocked (Open 365 Days)'),
            _buildStatItem('10 Courts', 'ITTF Olympic Tournament Tables'),
            _buildStatItem('0.3 Sec', 'Fastest Turnstile Gate in KL'),
            _buildStatItem('90 Sen / Day', 'Unbeatable Pass Pricing'),
            _buildStatItem('60 FPS AI', 'Smash Speed & Rally Camera Tracking'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          number,
          style: AppTypography.ui(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(width: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 160),
          child: Text(
            label,
            style: AppTypography.ui(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: luxuryMuted,
              height: 1.25,
            ),
          ),
        ),
      ],
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
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 900;
              return isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildStepCard(
                            step: '01',
                            title: 'Show Up Anytime (24/7)',
                            desc:
                                'Arrive at 2 PM or 3 AM. Even when 3 Damansara Mall is closed, Basement P2 lifts take you straight up to Level 2.',
                            icon: Icons.nightlife_rounded,
                            accentColor: luxuryVoltEmerald,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStepCard(
                            step: '02',
                            title: '0.3s Optical QR Turnstile',
                            desc:
                                'Flash your phone QR code at Gate 1 or Gate 2. Anti-tailgating optical scanners verify and open the gates instantly.',
                            icon: Icons.qr_code_scanner_rounded,
                            accentColor: luxuryCoralRose,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStepCard(
                            step: '03',
                            title: 'Smart Gear & Robot Dispenser',
                            desc:
                                'Sanitized ITTF 3-star balls dispense automatically at each court. Professional carbon composite paddles ready in your locker.',
                            icon: Icons.sports_tennis_rounded,
                            accentColor: luxuryElectricCyan,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStepCard(
                            step: '04',
                            title: 'AI Optical HUD & XP Rewards',
                            desc:
                                'Overhead vision cameras record your smash velocity, spin, and match scores. Earn XP to climb the Damansara Leaderboard.',
                            icon: Icons.military_tech_rounded,
                            accentColor: luxuryGold,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildStepCard(
                          step: '01',
                          title: 'Show Up Anytime (24/7)',
                          desc:
                              'Arrive at 2 PM or 3 AM. Basement P2 lifts take you straight up to Level 2 even when the mall is dark.',
                          icon: Icons.nightlife_rounded,
                          accentColor: luxuryVoltEmerald,
                        ),
                        const SizedBox(height: 16),
                        _buildStepCard(
                          step: '02',
                          title: '0.3s Optical QR Turnstile',
                          desc:
                              'Flash your phone QR code at Gate 1 or 2. Turnstiles unlock in 300 milliseconds.',
                          icon: Icons.qr_code_scanner_rounded,
                          accentColor: luxuryCoralRose,
                        ),
                        const SizedBox(height: 16),
                        _buildStepCard(
                          step: '03',
                          title: 'Smart Gear & Robot Dispenser',
                          desc:
                              'Sanitized balls dispense automatically. Carbon rackets ready in your locker.',
                          icon: Icons.sports_tennis_rounded,
                          accentColor: luxuryElectricCyan,
                        ),
                        const SizedBox(height: 16),
                        _buildStepCard(
                          step: '04',
                          title: 'AI Optical HUD & XP Rewards',
                          desc:
                              '60 FPS cameras track smash velocity and earn you leaderboard XP.',
                          icon: Icons.military_tech_rounded,
                          accentColor: luxuryGold,
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard({
    required String step,
    required String title,
    required String desc,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: luxuryCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.35),
                  ),
                ),
                child: Icon(icon, color: accentColor, size: 22),
              ),
              Text(
                step,
                style: AppTypography.ui(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withValues(alpha: 0.15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: AppTypography.ui(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            style: AppTypography.ui(
              fontSize: 13,
              color: luxuryMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // 5. "ARE YOU FEELING THE ENERGY?" (VIBE & CULTURE BENTO GRID)
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
                'Forget humid community halls with broken nets. JOMNITTAKU combines cyberpunk stadium lighting, tournament hardware, and electric 24/7 culture.',
          ),
          const SizedBox(height: 48),

          // Bento Grid: 2 rows
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
  }) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: luxuryCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
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
          const SizedBox(height: 18),
          Text(
            title,
            style: AppTypography.ui(
              fontSize: 18,
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
        ],
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
                  color: luxuryCoralRose.withValues(alpha: 0.2),
                  blurRadius: 28,
                  offset: const Offset(0, 8),
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
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: isPopular
                      ? const LinearGradient(
                          colors: [Color(0xFFFF4B72), Color(0xFFFF6B4A)],
                        )
                      : null,
                  color: isPopular ? null : Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: isPopular
                      ? null
                      : Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                ),
                alignment: Alignment.center,
                child: Text(
                  ctaText,
                  style: AppTypography.ui(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1E1428),
            const Color(0xFF16192E),
            luxuryCard,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: luxuryCoralRose.withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: luxuryCoralRose.withValues(alpha: 0.15),
            blurRadius: 40,
            offset: const Offset(0, 10),
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
                            color: luxuryCoralRose.withValues(alpha: 0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
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
