import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/session/demo_avatars.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme_controller.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';
import '../../challenge/screens/seek_player_screen.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/session/app_session.dart';
import '../../../shared/widgets/arena_widgets.dart';
import '../../../shared/widgets/desktop_dock_rail.dart';
import '../../../shared/widgets/desktop_web_header.dart';
import '../widgets/desktop_web_sections.dart';
import '../../display/screens/display_leaderboard_screen.dart';

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
  @override
  void initState() {
    super.initState();
    // Phase 4: first-run coachmark tour, shown once per session over the
    // real home UI (Toby pattern — teach inside the product, briefly).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || kIsWeb || AppSession.coachmarkDone) return;
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          child: CoachmarkTour(
            onDone: () {
              AppSession.coachmarkDone = true;
              Navigator.of(dialogContext).pop();
            },
          ),
        ),
      );
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _activeTab = 'command';
  String _selectedLanguage = 'ENG';

  void _onNavChange(String id) {
    setState(() => _activeTab = id);
    if (id == 'tv') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const DisplayLeaderboardScreen(),
        ),
      );
    } else if (id == 'passes') {
      AppNavigator.toPass(context);
    } else if (id == 'league') {
      AppNavigator.toLeaderboard(context);
    } else if (id == 'challenge') {
      AppNavigator.toChallengeBoard(context);
    } else if (id == 'radar') {
      AppNavigator.toTables(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      builder: (context, isDark) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isDesktopWeb = constraints.maxWidth >= 800;

            if (isDesktopWeb) {
              return _buildDesktopWebsiteScaffold(context, isDark);
            }

            return _buildMobileScaffold(context, isDark, constraints);
          },
        );
      },
    );
  }

  Widget _buildDesktopWebsiteScaffold(BuildContext context, bool isDark) {
    return Scaffold(
      backgroundColor: AppColors.canvasBg,
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.canvasGradient),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // 56px Fixed Corporate Desktop Web Header
              DesktopWebHeader(
                activeTab: _activeTab,
                onTabChanged: _onNavChange,
                onTvTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const DisplayLeaderboardScreen(),
                    ),
                  );
                },
                onXpTap: () => AppNavigator.toXpStore(context),
                onProfileTap: () => AppNavigator.toProfile(context),
              ),

              // 100vh Shell Body: 56px Left Icon Dock Rail + Centered Bento Canvas
              Expanded(
                child: Row(
                  children: [
                    // Left Icon Dock Rail (56px fixed)
                    DesktopDockRail(
                      activeItem: _activeTab,
                      onItemTap: _onNavChange,
                    ),

                    // Main Bento Command Center Canvas
                    Expanded(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 1680,
                            minHeight: 680,
                          ),
                          child: DesktopWebSections.buildFullScreenCommandCenter(
                            context,
                            isDark,
                            activeTab: _activeTab,
                            onTabChanged: _onNavChange,
                            onWalkInTap: widget.onWalkInTap ??
                                widget.onRegisterTap ??
                                () => AppNavigator.toPlan(context),
                            onPassTap: () => AppNavigator.toPass(context),
                            onTvTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const DisplayLeaderboardScreen(),
                                ),
                              );
                            },
                            onChallengeTap: () => _onNavChange('challenge'),
                            onXpTap: () => AppNavigator.toXpStore(context),
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
      ),
    );
  }

  Widget _buildMobileScaffold(BuildContext context, bool isDark, BoxConstraints constraints) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.canvasBg,
      endDrawer: _buildBkashStyleSideDrawer(context, isDark),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.canvasGradient),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
                  // ==========================================
                  // TOP BAR: Profile (Left) | XP & Location | Menu (Right)
                  // ==========================================
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1140),
                      child: Padding(
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
                                  color: isDark
                                      ? Colors.black.withValues(alpha: 0.35)
                                      : AppColors.slate900.withValues(alpha: 0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // The signed-in user's demo DP (Phase 8.4 —
                                // was a generic person icon).
                                ClipOval(
                                  child: Image.asset(
                                    AppSession.avatarAsset,
                                    width: 44,
                                    height: 44,
                                    fit: BoxFit.cover,
                                  ),
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
                                        color: AppColors.canvasBg,
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
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isDark
                                          ? AppColors.radiantGold.withValues(alpha: 0.35)
                                          : AppColors.xpGold,
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isDark
                                            ? Colors.black.withValues(alpha: 0.25)
                                            : AppColors.slate900.withValues(alpha: 0.04),
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
                                        style: AppTypography.ui(
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
                                      style: AppTypography.ui(
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

                        // Right Drawer Menu Icon -> Opens Luxury Drawer
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
                                  color: isDark
                                      ? Colors.black.withValues(alpha: 0.35)
                                      : AppColors.slate900.withValues(alpha: 0.08),
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
                ),
              ),

                  // ==========================================
                  // SCROLLABLE BODY (Responsive: 1-Col Mobile, 2-Col Tablet/Desktop)
                  // ==========================================
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isTabletOrDesktop = constraints.maxWidth >= 650;

                        if (isTabletOrDesktop) {
                          return Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1140),
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                // Left Column: Player Standing, Passes & Actions
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildHeroStadiumCard(context, isDark).arenaEntrance(0),
                                      const SizedBox(height: 16),
                                      _buildThreeTelemetryCards(context, isDark).arenaEntrance(1),
                                      const SizedBox(height: 16),
                                      _buildFlashPromoBanner(isDark).arenaEntrance(2),
                                      const SizedBox(height: 16),
                                      _buildMemberPricingCard(context, isDark).arenaEntrance(3),
                                      const SizedBox(height: 16),
                                      TactileButton.volt(
                                        text: 'Walk In & Play →',
                                        onPressed: widget.onWalkInTap ??
                                            widget.onRegisterTap ??
                                            () => AppNavigator.toPlan(context),
                                      ),
                                      const SizedBox(height: 12),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () => AppNavigator.toPass(context),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                            decoration: BoxDecoration(
                                              color: isDark ? Colors.black12 : AppColors.lightCanvasBg,
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(
                                                color: isDark
                                                    ? AppColors.ittfTableBorder.withValues(alpha: 0.5)
                                                    : AppColors.slate300,
                                                width: 1.2,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: isDark
                                                      ? AppColors.ittfTableSurface.withValues(alpha: 0.15)
                                                      : AppColors.ittfTableSurface.withValues(alpha: 0.08),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.qr_code_scanner_rounded,
                                                  size: 16,
                                                  color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
                                                ),
                                                const SizedBox(width: 8),
                                                Flexible(
                                                  child: Text(
                                                    'Door Pass (KX8VQS) →',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: AppTypography.ui(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w800,
                                                      color: isDark ? AppColors.slate300 : AppColors.ittfTableBlue,
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
                                          style: AppTypography.ui(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textMuted,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),

                                // Right Column: Live Table Radar & Bento Game Nodes
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildBentoTelemetryGrid(context, isDark).arenaEntrance(4),
                                      const SizedBox(height: 20),
                                      _buildFavoriteRivalsSection(context, isDark).arenaEntrance(5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                        }

                        // Mobile View (< 650px): Single Column Stack
                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Dynamic Athletic Hero Card with 3D Table Tennis Court Stage
                              _buildHeroStadiumCard(context, isDark).arenaEntrance(0),
                              const SizedBox(height: 20),

                              // 3 Quick Telemetry Cards
                              _buildThreeTelemetryCards(context, isDark).arenaEntrance(1),
                              const SizedBox(height: 22),

                              // 1. Sparring Rivals Carousel (Athletic Player Cards)
                              _buildFavoriteRivalsSection(context, isDark).arenaEntrance(2),
                              const SizedBox(height: 22),

                              // 2. Flash Promo Countdown Banner (Happy Hour Sunset Pass)
                              _buildFlashPromoBanner(isDark).arenaEntrance(3),
                              const SizedBox(height: 24),

                              // 3. Asymmetrical Bento Telemetry Grid
                              _buildBentoTelemetryGrid(context, isDark).arenaEntrance(4),
                              const SizedBox(height: 24),

                              // Member Pricing & 90 Sen Anchor Card
                              _buildMemberPricingCard(context, isDark).arenaEntrance(5),
                              const SizedBox(height: 18),

                              // Primary Athletic Emerald 3D Tactile CTA Button
                              TactileButton.volt(
                                text: 'Walk In & Play →',
                                onPressed: widget.onWalkInTap ??
                                    widget.onRegisterTap ??
                                    () => AppNavigator.toPlan(context),
                              ),
                              const SizedBox(height: 12),

                              // Direct Door Pass Access Chip (Sapphire Glass)
                              Center(
                                child: GestureDetector(
                                  onTap: () => AppNavigator.toPass(context),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                    decoration: BoxDecoration(
                                      color: isDark ? Colors.black12 : AppColors.lightCanvasBg,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: isDark
                                            ? AppColors.ittfTableBorder.withValues(alpha: 0.5)
                                            : AppColors.slate300,
                                        width: 1.2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: isDark
                                              ? AppColors.ittfTableSurface.withValues(alpha: 0.15)
                                              : AppColors.ittfTableSurface.withValues(alpha: 0.08),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.qr_code_scanner_rounded,
                                          size: 16,
                                          color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            'Door Pass (KX8VQS) →',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTypography.ui(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: isDark ? AppColors.slate300 : AppColors.ittfTableBlue,
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
                                  style: AppTypography.ui(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Floating Glass Bottom Navigation Dock
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
  Widget _buildHeroStadiumCard(BuildContext context, bool isDark) {
    return SizedBox(
      width: double.infinity,
      // Phase 8 (Fluent pass): the hero has no box — headline and stage
      // sit directly on the canvas, Windows 11 page-header style.
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
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
                          color: AppColors.voltLime,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'JOMNITTAKU · 3 DAMANSARA',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.ui(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
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
                    color: isDark ? AppColors.voltLime.withValues(alpha: 0.15) : AppColors.lightCanvasBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? AppColors.voltLime.withValues(alpha: 0.35) : AppColors.slate300,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '6 OF 10 FREE',
                    style: AppTypography.ui(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: isDark ? AppColors.voltLime : AppColors.btnGreenBorder,
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
                                  color: isDark
                                      ? Colors.black.withValues(alpha: 0.35)
                                      : AppColors.slate900.withValues(alpha: 0.08),
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
                                  style: AppTypography.ui(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textPrimary,
                                    letterSpacing: -0.6,
                                    height: 1.0,
                                  ),
                                ),
                                Text(
                                  'TONIGHT',
                                  style: AppTypography.ui(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
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
                        style: AppTypography.ui(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 11,
                  child: _build3dTableTennisStage(context, isDark),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Bottom Quick Bar: Radar & Telemetry Button
            GestureDetector(
              onTap: () => AppNavigator.toTables(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black.withValues(alpha: 0.25) : AppColors.lightCanvasDeep,
                  borderRadius: BorderRadius.circular(16),
                  border: isDark
                      ? Border.all(color: Colors.white.withValues(alpha: 0.08), width: 1)
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.voltLime,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              'LIVE • 2 matches active now',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.ui(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Radar View',
                          style: AppTypography.ui(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 13,
                          color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
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
  Widget _build3dTableTennisStage(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => AppNavigator.toTables(context),
      child: Container(
        height: 118,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [AppColors.ittfTableBlue, AppColors.darkObsidianCard]
                : [AppColors.ittfTableBlue, AppColors.ittfTableBlue],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? AppColors.ittfTableBorder.withValues(alpha: 0.35)
                : AppColors.slate300,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.35)
                  : AppColors.ittfTableBlue.withValues(alpha: 0.15),
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
                    colors: [AppColors.ittfTableSurface, AppColors.ittfTableBlue],
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
                  color: AppColors.paddleBlack,
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
                      style: AppTypography.ui(
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
                  color: AppColors.paddleRed,
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
                      style: AppTypography.ui(
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
                  color: AppColors.pingPongOrange,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.pingPongOrange.withValues(alpha: 0.6),
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
                  color: AppColors.slate900,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.radiantGold, width: 1),
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
                        color: AppColors.electricCrimson,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'T4 · 11-9',
                      style: AppTypography.ui(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: AppColors.radiantGold,
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
  Widget _buildThreeTelemetryCards(BuildContext context, bool isDark) {
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
              isDark: isDark,
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
              isDark: isDark,
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
              accentColor: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
              isDark: isDark,
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
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(10), // Windows 11 Fluent 10px squircle
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : AppColors.obsidianBorder,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(builder: (_) {
                final iconColor = isDark
                    ? accentColor
                    : (accentColor == AppColors.voltLime
                        ? AppColors.primaryDim
                        : accentColor == AppColors.radiantGold
                            ? AppColors.goldDeep
                            : accentColor);
                return Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: isDark ? 0.18 : 0.20),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 15, color: iconColor),
                );
              }),
              Icon(Icons.arrow_forward_ios_rounded, size: 9, color: isDark ? Colors.white24 : AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.ui(
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
            style: AppTypography.ui(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FAVORITE SPARRING RIVALS (Athletic Player Cards)
  // ============================================================
  Widget _buildFavoriteRivalsSection(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.06) : AppColors.lightBorder,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
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
                  style: AppTypography.ui(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => AppNavigator.toLeaderboard(context),
                child: Text(
                  'Manage >',
                  style: AppTypography.ui(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
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
                  avatarAsset: DemoAvatars.jason,
                  level: 'LVL 14',
                  streak: '🔥 3W',
                  isLiveAtVenue: true,
                  ringColor: AppColors.ittfTableBorder,
                  isDark: isDark,
                ),
                const SizedBox(width: 14),
                _buildGamerRivalCard(
                  context,
                  name: 'Sara K.',
                  initial: 'S',
                  avatarAsset: DemoAvatars.sara,
                  level: 'LVL 18',
                  streak: '🔥 5W',
                  isLiveAtVenue: true,
                  ringColor: AppColors.voltLime,
                  isDark: isDark,
                ),
                const SizedBox(width: 14),
                _buildGamerRivalCard(
                  context,
                  name: 'Nurul P.',
                  initial: 'N',
                  avatarAsset: DemoAvatars.nurul,
                  level: 'LVL 11',
                  streak: '1W',
                  isLiveAtVenue: false,
                  ringColor: AppColors.ittfTableBorder,
                  isDark: isDark,
                ),
                const SizedBox(width: 14),
                _buildGamerRivalCard(
                  context,
                  name: 'Daniel L.',
                  initial: '👑',
                  avatarAsset: DemoAvatars.daniel,
                  level: 'LVL 22',
                  streak: '🔥 7W',
                  isLiveAtVenue: false,
                  ringColor: AppColors.radiantGold,
                  isDark: isDark,
                ),
                const SizedBox(width: 14),
                _buildAddRivalButton(context, isDark),
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
    String? avatarAsset,
    required String level,
    required String streak,
    required bool isLiveAtVenue,
    required Color ringColor,
    required bool isDark,
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
                    colors: [
                      ringColor.withValues(alpha: isDark ? 0.30 : 0.20),
                      isDark ? AppColors.darkObsidianElevated : AppColors.lightCanvasBg,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: ringColor, width: 1.8),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withValues(alpha: 0.25)
                          : AppColors.slate900.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: avatarAsset != null
                    ? ClipOval(
                        child: Image.asset(
                          avatarAsset,
                          width: 52,
                          height: 52,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Text(
                          initial,
                          style: AppTypography.ui(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: isDark ? Colors.white : AppColors.slate900,
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
                      color: AppColors.voltLime,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.canvasBg, width: 2),
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
                    color: isDark ? AppColors.slate900 : AppColors.lightCanvasBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark ? AppColors.radiantGold : AppColors.xpGold,
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    streak,
                    style: AppTypography.ui(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: isDark ? AppColors.btnGold : AppColors.electricCrimson,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: AppTypography.ui(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            level,
            style: AppTypography.ui(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddRivalButton(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => AppNavigator.toLeaderboard(context),
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : AppColors.lightCanvasBg,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark
                    ? AppColors.ittfTableBorder.withValues(alpha: 0.5)
                    : AppColors.slate300,
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.add_rounded,
              color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
              size: 26,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Add Rival',
            style: AppTypography.ui(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
            ),
          ),
          Text(
            'Search XP',
            style: AppTypography.ui(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FLASH COUNTDOWN BANNER (Sunset Athletic Pass)
  // ============================================================
  Widget _buildFlashPromoBanner(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: AppColors.promoBannerGradient,
        borderRadius: BorderRadius.circular(10), // Windows 11 Fluent 10px
        border: Border.all(
          color: isDark ? AppColors.radiantGold.withValues(alpha: 0.25) : AppColors.xpGold,
          width: 0.8,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.radiantGold, AppColors.pingPongOrange],
              ),
              borderRadius: BorderRadius.circular(6), // Windows 11 squircle
            ),
            child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⚡ Happy Hour · Save 50%',
                  style: AppTypography.ui(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: isDark ? AppColors.lightBorder : AppColors.electricCrimson,
                  ),
                ),
                Text(
                  'All tables 50 sen/hour for members',
                  style: AppTypography.ui(
                    fontSize: 11,
                    color: isDark ? Colors.white.withValues(alpha: 0.70) : AppColors.paddleRed,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.electricCrimson,
              borderRadius: BorderRadius.circular(6), // Windows 11 badge
              boxShadow: [
                BoxShadow(
                  color: AppColors.electricCrimson.withValues(alpha: 0.25),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Text(
              '18m : 45s',
              style: AppTypography.ui(
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
  Widget _buildBentoTelemetryGrid(BuildContext context, bool isDark) {
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
                style: AppTypography.ui(
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
                color: isDark ? AppColors.ittfTableBorder.withValues(alpha: 0.15) : AppColors.lightCanvasBg,
                borderRadius: BorderRadius.circular(4), // Windows 11 4px badge
                border: Border.all(
                  color: isDark ? AppColors.ittfTableBorder.withValues(alpha: 0.3) : AppColors.slate300,
                  width: 0.8,
                ),
              ),
              child: Text(
                'LIVE IOT',
                style: AppTypography.ui(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
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
              gradient: AppColors.cardGradient,
              borderRadius: BorderRadius.circular(12), // Windows 11 Fluent 12px
              border: Border.all(
                color: isDark ? Colors.white.withValues(alpha: 0.06) : AppColors.lightBorder,
                width: 1,
              ),
              boxShadow: AppColors.cardShadow,
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
                              color: isDark ? AppColors.ittfTableBorder.withValues(alpha: 0.15) : AppColors.lightCanvasBg,
                              borderRadius: BorderRadius.circular(6), // Windows 11 6px
                            ),
                            child: Icon(
                              Icons.radar_rounded,
                              size: 18,
                              color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Live Table Radar',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.ui(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '6 of 10 Free →',
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.voltLime : AppColors.btnGreenBorder,
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
                      _buildTableBeacon('T1', isOccupied: true, player: 'Aiman', isDark: isDark),
                      const SizedBox(width: 8),
                      _buildTableBeacon('T2', isOccupied: true, player: 'Sara', isDark: isDark),
                      const SizedBox(width: 8),
                      _buildTableBeacon('T3', isOccupied: false, isDark: isDark),
                      const SizedBox(width: 8),
                      _buildTableBeacon('T4', isOccupied: false, isDark: isDark),
                      const SizedBox(width: 8),
                      _buildTableBeacon('T5', isOccupied: false, isDark: isDark),
                      const SizedBox(width: 8),
                      _buildTableBeacon('T6', isOccupied: false, isDark: isDark),
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
                  isDark: isDark,
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
                  badgeColor: AppColors.electricCrimson,
                  icon: Icons.sports_mma_rounded,
                  accentColor: AppColors.electricCrimson,
                  isDark: isDark,
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
                  isDark: isDark,
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
                  badgeColor: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
                  icon: Icons.live_tv_rounded,
                  accentColor: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
                  isDark: isDark,
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
                child: _buildQuickPill('⚡ Borrow XP', AppColors.radiantGold, isDark),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () => AppNavigator.toLeaderboard(context),
                child: _buildQuickPill(
                  '🏆 #4 Rank',
                  isDark ? AppColors.voltLime : AppColors.btnGreenBorder,
                  isDark,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () => AppNavigator.pushScreen(context, const SeekPlayerScreen()),
                child: _buildQuickPill(
                  '📡 Radar Ping',
                  isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
                  isDark,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTableBeacon(String tableName,
      {required bool isOccupied, String? player, required bool isDark}) {
    final courtColor = isOccupied
        ? (isDark ? AppColors.paddleBlack : AppColors.lightBorder)
        : (isDark ? AppColors.ittfTableBlue : AppColors.lightCanvasBg);
    final borderColor = isOccupied ? AppColors.electricCrimson : AppColors.voltLime;
    final titleColor = isDark
        ? Colors.white
        : (isOccupied ? AppColors.paddleRed : AppColors.btnGreenBorder);
    final statusColor = isOccupied
        ? (isDark ? AppColors.rankBronze : AppColors.paddleRed)
        : (isDark ? AppColors.slate300 : AppColors.btnGreenBorder);

    return Container(
      width: 52,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: courtColor,
        borderRadius: BorderRadius.circular(6), // Windows 11 Fluent 6px tile
        border: Border.all(color: borderColor.withValues(alpha: isDark ? 0.7 : 0.9), width: 0.8),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withValues(alpha: 0.25) : AppColors.slate900.withValues(alpha: 0.05),
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
            style: AppTypography.ui(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: titleColor,
            ),
          ),
          Text(
            isOccupied ? (player ?? 'Live') : 'Free',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.ui(
              fontSize: 8,
              fontWeight: FontWeight.w800,
              color: statusColor,
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
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(10), // Windows 11 Fluent 10px squircle
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.06) : AppColors.lightBorder,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: isDark ? 0.15 : 0.12),
                  borderRadius: BorderRadius.circular(6), // Windows 11 6px icon tile
                ),
                child: Icon(icon, size: 20, color: accentColor),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: isDark ? 0.2 : 0.12),
                    borderRadius: BorderRadius.circular(4), // Windows 11 4px badge
                    border: Border.all(
                      color: badgeColor.withValues(alpha: isDark ? 0.35 : 0.25),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    badge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.ui(
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
            style: AppTypography.ui(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.ui(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickPill(String label, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(6), // Windows 11 Fluent 6px
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : AppColors.lightBorder,
          width: 0.8,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      child: Center(
        child: Text(
          label,
          style: AppTypography.ui(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MEMBER PRICING & 90 SEN ANCHOR CARD
  // ============================================================
  Widget _buildMemberPricingCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(12), // Windows 11 Fluent 12px
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : AppColors.lightBorder,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Walk-in',
                style: AppTypography.ui(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                'RM17',
                style: AppTypography.ui(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
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
                  style: AppTypography.ui(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppColors.voltLime : AppColors.btnGreenBorder,
                  ),
                ),
              ),
              Text(
                'a day · RM90/mo',
                style: AppTypography.ui(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.voltLime.withValues(alpha: 0.12)
                  : AppColors.lightCanvasBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? AppColors.voltLime.withValues(alpha: 0.25)
                    : AppColors.slate300,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                '🔥 Member saves RM16.10 a visit',
                style: AppTypography.ui(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: isDark ? AppColors.voltLime : AppColors.btnGreenBorder,
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
  Widget _buildBkashStyleSideDrawer(BuildContext context, bool isDark) {
    return Drawer(
      backgroundColor: AppColors.canvasBg,
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
                              color: isDark
                                  ? Colors.black.withValues(alpha: 0.3)
                                  : AppColors.slate900.withValues(alpha: 0.08),
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
                        style: AppTypography.ui(
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
                      borderRadius: BorderRadius.circular(16),
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
                onTap: () => _showJomAiBottomSheet(context, isDark),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: isDark
                        ? const LinearGradient(
                            colors: [AppColors.darkObsidianCard, AppColors.darkObsidianElevated],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : const LinearGradient(
                            colors: [Colors.white, AppColors.lightCanvasBg],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark
                          ? AppColors.ittfTableBorder.withValues(alpha: 0.4)
                          : AppColors.slate300,
                      width: 1.2,
                    ),
                    boxShadow: AppColors.cardShadow,
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
                              color: isDark
                                  ? Colors.black.withValues(alpha: 0.3)
                                  : AppColors.slate900.withValues(alpha: 0.08),
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
                                  style: AppTypography.ui(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? AppColors.ittfTableBorder.withValues(alpha: 0.25)
                                        : AppColors.lightCanvasBg,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'UMPIRE BETA',
                                    style: AppTypography.ui(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900,
                                      color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Virtual Venue Concierge & Umpire',
                              style: AppTypography.ui(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: isDark ? Colors.white38 : AppColors.slate400,
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
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    isDark ? 'Switch to Light Mode ☀️' : 'Switch to Dark Mode 🌙',
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
                    AppSession.signOut();
                    AppNavigator.toLoginAndClear(context);
                  }, isDestructive: true),
                ],
              ),
            ),

            // Version Footer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Version 2.4.0 · JOMNITTAKU 3 Damansara',
                style: AppTypography.ui(
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
          color: isSelected ? AppColors.voltLime : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          lang,
          style: AppTypography.ui(
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
        color: isDestructive ? AppColors.electricCrimson : AppColors.ittfTableBorder,
        size: 20,
      ),
      title: Text(
        title,
        style: AppTypography.ui(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: isDestructive ? AppColors.electricCrimson : AppColors.textPrimary,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }

  void _showJomAiBottomSheet(BuildContext context, bool isDark) {
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
                        color: isDark
                            ? Colors.black.withValues(alpha: 0.3)
                            : AppColors.slate900.withValues(alpha: 0.08),
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
                            style: AppTypography.ui(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.ittfTableBorder.withValues(alpha: 0.2)
                                  : AppColors.lightCanvasBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'UMPIRE BETA',
                              style: AppTypography.ui(
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Virtual Venue Umpire & Concierge',
                        style: AppTypography.ui(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildAiHelpTile(Icons.rule_folder_rounded, 'Dispute Resolution',
                'Automated table sensor reviews and official table tennis rules.', isDark),
            _buildAiHelpTile(Icons.lightbulb_outline_rounded, 'Table Automation',
                'Smart lighting active on T1-T6 during booked matches.', isDark),
            _buildAiHelpTile(Icons.shield_outlined, 'Gate Security & Penalty',
                'Unmanned check-in monitoring. RM200 non-pay walk-in fine.', isDark),
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

  static Widget _buildAiHelpTile(IconData icon, String title, String desc, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.ui(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  desc,
                  style: AppTypography.ui(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
