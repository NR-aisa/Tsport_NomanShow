import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme_controller.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/arena_widgets.dart';

class GamificationPathScreen extends StatefulWidget {
  const GamificationPathScreen({super.key});

  @override
  State<GamificationPathScreen> createState() => _GamificationPathScreenState();
}

class _GamificationPathScreenState extends State<GamificationPathScreen> with TickerProviderStateMixin {
  int _activeNavTab = 0; // 0 = Path, 1 = Quests, 2 = Practice

  // Animation for bouncing active node
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  // Animation for pulsing glow ring
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Chest open state
  bool _chestOpened = false;
  bool _questClaimed = false;
  late final ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _bounceController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _onChestTap() {
    setState(() => _chestOpened = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.stars_rounded, color: AppColors.xpGold, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎉 CHEST UNLOCKED: +200 XP REWARD!',
                    style: AppTypography.ui(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 13),
                  ),
                  Text(
                    'Daily Quest complete. Balance updated to 1,440 XP.',
                    style: AppTypography.ui(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.ittfTableBorder,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      builder: (context, isDark) {
        return Scaffold(
          backgroundColor: isDark ? AppColors.darkObsidianElevated : AppColors.lightCanvasBg,
          body: Stack(
            children: [
              ArenaBackdrop(
                child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                // TOP STATUS BAR (Duolingo Style: Streak, Points, Battery)
                _buildTopStatusBar(isDark),

                // SUB-NAV TABS: Path | Quests | Practice
                _buildSubNavSelector(isDark),

                // MAIN CONTENT BODY
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _buildCurrentTabContent(),
                  ),
                ),

                // BOTTOM DOCK (Tab 4: The Winding Path)
                const JomnittakuNavBar(activeIndex: 4),
              ],
            ),
                ),
              ),
              // Phase 6 celebration layer — milestones only (quest claim).
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  emissionFrequency: 0.05,
                  numberOfParticles: 28,
                  gravity: 0.25,
                  shouldLoop: false,
                  colors: const [
                    AppColors.voltLime,
                    AppColors.radiantGold,
                    Colors.white,
                    AppColors.ittfTableSurface,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopStatusBar(bool isDark) {
    final barBg = isDark ? AppColors.darkObsidianElevated : Colors.white;
    final pillBg = isDark ? AppColors.paddleBlack : AppColors.lightCanvasBg;
    final borderColor = isDark ? AppColors.paddleBlack : AppColors.lightBorder;
    final textColor = isDark ? Colors.white : AppColors.slate900;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: barBg,
        border: Border(bottom: BorderSide(color: borderColor, width: 1.5)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Profile avatar
            GestureDetector(
              onTap: () => AppNavigator.toProfile(context),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: pillBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: isDark ? AppColors.slate600 : AppColors.slate300, width: 1.5),
                ),
                child: const Icon(Icons.person, color: AppColors.ittfTableBorder, size: 20),
              ),
            ),
            const SizedBox(width: 8),

            // Flag / Branch
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: pillBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Text('🇲🇾', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(
                    '3 Damansara',
                    style: AppTypography.ui(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Streak Flame (🔥 5 Days)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: pillBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_fire_department_rounded, color: AppColors.radiantGold, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '5',
                    style: AppTypography.ui(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: AppColors.radiantGold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // XP Balance (★ 1,240)
            GestureDetector(
              onTap: () => AppNavigator.toXpStore(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: pillBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: AppColors.xpGold, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '1,240',
                      style: AppTypography.ui(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: AppColors.xpGold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Energy Battery
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: pillBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.bolt_rounded, color: AppColors.electricCrimson, size: 18),
                  const SizedBox(width: 2),
                  Text(
                    '25',
                    style: AppTypography.ui(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: AppColors.electricCrimson,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubNavSelector(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      color: isDark ? AppColors.darkObsidianElevated : AppColors.lightCanvasBg,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDark ? AppColors.paddleBlack : Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: isDark ? AppColors.paddleBlack : AppColors.lightBorder),
        ),
        child: Row(
          children: [
            _buildSubTabItem(0, 'The Path', Icons.alt_route_rounded, isDark),
            _buildSubTabItem(1, 'Quests & Chests', Icons.inventory_2_rounded, isDark),
            _buildSubTabItem(2, 'Skill Drills', Icons.fitness_center_rounded, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildSubTabItem(int index, String title, IconData icon, bool isDark) {
    final isSelected = _activeNavTab == index;
    final unselectedColor = isDark ? AppColors.slate400 : AppColors.slate500;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeNavTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.voltLime : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                      color: AppColors.voltLime,
                      offset: Offset(0, 3),
                      blurRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: isSelected ? Colors.white : unselectedColor),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.ui(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: isSelected ? Colors.white : unselectedColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentTabContent() {
    switch (_activeNavTab) {
      case 0:
        return _buildThePathView();
      case 1:
        return _buildQuestsView();
      case 2:
        return _buildPracticeView();
      default:
        return _buildThePathView();
    }
  }

  // ==========================================
  // TAB 1: THE WINDING PROGRESSION PATH VIEW
  // ==========================================
  Widget _buildThePathView() {
    return SingleChildScrollView(
      key: const ValueKey('path_view'),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        children: [
          // Section 3 Unit Banner (From Duolingo Image 1)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              // Phase 7 (user-directed): the Duolingo terracotta orange is
              // replaced with an always-dark premium slate — adult, sporty,
              // and the white headline reads on it in both themes.
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(28),
              boxShadow: AppColors.cardShadow,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SECTION 3 · DIVISION 1',
                        style: AppTypography.ui(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: Colors.white70,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ROAD TO PLATINUM DIVISION',
                        style: AppTypography.ui(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 22),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Winding S-Curve Nodes Tree
          Stack(
            alignment: Alignment.center,
            children: [
              // Trophy Medallion (Phase 7 — replaced the Duolingo bear mascot)
              Positioned(
                right: 14,
                top: 140,
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.paddleBlack,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: AppColors.radiantGold, width: 1.5),
                      ),
                      child: const Center(
                        // Phase 7 (user-directed): the cartoon bear mascot is
                        // replaced with a championship trophy medallion.
                        child: Icon(Icons.emoji_events_rounded, color: AppColors.radiantGold, size: 40),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'BOSS GATE',
                      style: AppTypography.ui(
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        color: AppColors.slate400,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),

              // The Linear/Curved Nodes Column
              Column(
                children: [
                  // NODE 1: COMPLETED (Green checkmark)
                  _buildCompletedNode('01. Warmup Match', xOffset: -40),
                  const SizedBox(height: 18),

                  // NODE 2: CURRENT ACTIVE (Bouncing Orange Star with Tooltip)
                  _buildActiveBouncingNode('02. 200 XP Challenge', xOffset: 20),
                  const SizedBox(height: 24),

                  // NODE 3: LOCKED CHEST MILESTONE
                  _buildChestNode(xOffset: -30),
                  const SizedBox(height: 20),

                  // NODE 4: LOCKED (3-Day Streak Gate)
                  _buildLockedNode('03. 3-Day Venue Streak', xOffset: 30),
                  const SizedBox(height: 20),

                  // NODE 5: LOCKED (Division Promotion Boss)
                  _buildLockedNode('04. Division Boss Gate', xOffset: -20),
                  const SizedBox(height: 20),

                  // NODE 6: LOCKED (Play The Champion)
                  _buildCrownNode(xOffset: 0),
                  const SizedBox(height: 24),

                  // Next-goal CTA — the Path never ends in empty space.
                  Container(
                    width: 320,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.obsidianCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.obsidianBorder),
                    ),
                    child: Column(
                      children: [
                        Text('NEXT GOAL · DIVISION BOSS GATE',
                            style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textSecondary, letterSpacing: 0.8)),
                        const SizedBox(height: 6),
                        Text('Win 2 more matches to unlock the boss gate.',
                            textAlign: TextAlign.center,
                            style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => AppNavigator.toTables(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(color: AppColors.voltLime, borderRadius: BorderRadius.circular(12)),
                            child: Text('Find a match →',
                                style: AppTypography.ui(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedNode(String title, {required double xOffset}) {
    return Transform.translate(
      offset: Offset(xOffset, 0),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppColors.voltLime,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.voltLime,
                  offset: Offset(0, 5),
                  blurRadius: 0,
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.check_rounded, color: Colors.white, size: 34),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.slate400),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveBouncingNode(String title, {required double xOffset}) {
    return Transform.translate(
      offset: Offset(xOffset, 0),
      child: Column(
        children: [
          // Speech Bubble Tooltip ("Start Challenge!")
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.paddleBlack,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.slate600, width: 1.5),
            ),
            child: Text(
              'START MATCH · +200 XP',
              style: AppTypography.ui(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: AppColors.radiantGold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Bouncing Animated Star Node
          AnimatedBuilder(
            animation: _bounceAnimation,
            builder: (_, child) => Transform.translate(
              offset: Offset(0, _bounceAnimation.value),
              child: child,
            ),
            child: GestureDetector(
              onTap: () => AppNavigator.toChallengeBoard(context),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Pulsing Glow Ring
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (_, child) => Container(
                      width: 82 * _pulseAnimation.value,
                      height: 82 * _pulseAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.ittfTableSurface.withValues(alpha: 0.15),
                      ),
                    ),
                  ),

                  // 3D Extruded Orange Node
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      // Phase 7 (user-directed): adult championship blue
                      // instead of the Duolingo gold/orange star node.
                      color: AppColors.ittfTableSurface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.ittfTableBlue,
                          offset: Offset(0, 6),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.sports_tennis_rounded, color: Colors.white, size: 36),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildChestNode({required double xOffset}) {
    return Transform.translate(
      offset: Offset(xOffset, 0),
      child: GestureDetector(
        onTap: _onChestTap,
        child: Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: _chestOpened ? AppColors.paddleBlack : AppColors.xpGold,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _chestOpened ? AppColors.darkObsidianCard : AppColors.radiantGold,
                    offset: const Offset(0, 5),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  _chestOpened ? Icons.lock_open_rounded : Icons.inventory_2_rounded,
                  color: _chestOpened ? AppColors.slate400 : AppColors.darkObsidianElevated,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _chestOpened ? 'Claimed' : 'Loot Chest',
              style: AppTypography.ui(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: _chestOpened ? AppColors.voltLime : AppColors.xpGold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedNode(String title, {required double xOffset}) {
    return Transform.translate(
      offset: Offset(xOffset, 0),
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: AppColors.darkObsidianCardLight,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.paddleBlack,
                  offset: Offset(0, 5),
                  blurRadius: 0,
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.lock_rounded, color: AppColors.slate500, size: 24),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.slate500),
          ),
        ],
      ),
    );
  }

  Widget _buildCrownNode({required double xOffset}) {
    return Transform.translate(
      offset: Offset(xOffset, 0),
      child: GestureDetector(
        onTap: () => AppNavigator.toBidding(context),
        child: Column(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: const BoxDecoration(
                color: AppColors.amethystPurple, // Amethyst purple
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.slate600,
                    offset: Offset(0, 6),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.military_tech_rounded, color: Colors.white, size: 36),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '👑 Champion Arena (RM 200+)',
              style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.amethystPurple),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // TAB 2: DAILY & FRIEND QUESTS VIEW
  // ==========================================
  Widget _buildQuestsView() {
    return SingleChildScrollView(
      key: const ValueKey('quests_view'),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quests Amethyst Banner (From Duolingo Image 2)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.amethystPurple,
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(color: AppColors.slate600, offset: Offset(0, 5), blurRadius: 0),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VENUE QUESTS & EXPEDITIONS',
                        style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Complete Quests to Win Chests & XP!',
                        style: AppTypography.ui(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const Text('💎', style: TextStyle(fontSize: 36)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Friend Quest Card (From Image 2)
          Text(
            'FRIEND QUEST · 4 DAYS LEFT',
            style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.slate400, letterSpacing: 0.8),
          ),
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.paddleBlack,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.slate600, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Play a match with a Sparring Partner',
                        style: AppTypography.ui(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                    ),
                    const Text('🎁', style: TextStyle(fontSize: 26)),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const LinearProgressIndicator(
                    value: 0.0,
                    minHeight: 10,
                    backgroundColor: AppColors.darkObsidianElevated,
                    valueColor: AlwaysStoppedAnimation(AppColors.voltLime),
                  ),
                ),
                const SizedBox(height: 6),
                Text('0 / 1 matches completed', style: AppTypography.ui(fontSize: 10, color: AppColors.slate400)),
                const SizedBox(height: 14),

                TactileButton.primary(
                  text: '👤+ Find Sparring Partner',
                  onPressed: () => AppNavigator.toTables(context),
                  height: 44,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Daily Quest Card (From Image 2: 10/10 with Pink Progress Bar)
          Text(
            'DAILY QUEST · 5 HOURS LEFT',
            style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.slate400, letterSpacing: 0.8),
          ),
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.paddleBlack,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.slate600, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Earn 10 XP at 3 Damansara',
                            style: AppTypography.ui(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text('Reward: Blue Arena Loot Chest', style: AppTypography.ui(fontSize: 10, color: AppColors.ittfTableBorder)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _onChestTap,
                      child: Text(_chestOpened ? '🔓' : '📦', style: const TextStyle(fontSize: 32)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Vibrant Duolingo Pink/Ruby Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const LinearProgressIndicator(
                    value: 1.0, // 10/10 complete!
                    minHeight: 12,
                    backgroundColor: AppColors.darkObsidianElevated,
                    valueColor: AlwaysStoppedAnimation(AppColors.voltLime),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('10 / 10 XP EARNED', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.slate400)),
                    Text('COMPLETED ✔', style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.voltLime)),
                  ],
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: _questClaimed
                      ? null
                      : () {
                          setState(() => _questClaimed = true);
                          _confettiController.play();
                          ArenaToast.show(
                            context,
                            message: 'Reward claimed — Loot Chest added to your profile',
                            actionLabel: 'Undo',
                            onAction: () => setState(() => _questClaimed = false),
                          );
                        },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _questClaimed ? AppColors.darkObsidianElevated : AppColors.voltLime,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        _questClaimed ? 'Claimed ✓ · Reward added to your chest' : 'Claim Reward →',
                        style: AppTypography.ui(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: _questClaimed ? AppColors.voltLime : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 3: SKILL DRILLS PRACTICE VIEW
  // ==========================================
  Widget _buildPracticeView() {
    return SingleChildScrollView(
      key: const ValueKey('practice_view'),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Practice Sky Blue Banner (From Duolingo Image 4)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.ittfTableBorder,
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(color: AppColors.voltLime, offset: Offset(0, 5), blurRadius: 0),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRACTICE & SKILL DRILLS',
                        style: AppTypography.ui(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Sharpen Your Table Tennis Skills',
                        style: AppTypography.ui(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const Text('🏓', style: TextStyle(fontSize: 36)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Daily Drill CTA Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.paddleBlack,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.slate600, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Warmup Drill',
                  style: AppTypography.ui(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text('Rally 50 balls with Robot Trainer at Table T1', style: AppTypography.ui(fontSize: 11, color: AppColors.slate400)),
                const SizedBox(height: 14),

                TactileButton.blue(
                  text: 'Start Drill · +20 XP',
                  onPressed: () => AppNavigator.toTables(context),
                  height: 44,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Skill Practice List (From Image 4)
          Text(
            'SKILL DRILLS MATRIX',
            style: AppTypography.ui(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.slate400, letterSpacing: 0.8),
          ),
          const SizedBox(height: 10),

          _buildSkillDrillTile('Mistake Review & Match Replay', 'Analyze lost points from yesterday', Icons.replay_rounded, AppColors.radiantGold),
          const SizedBox(height: 10),
          _buildSkillDrillTile('Forehand Top-Spin Power Drill', 'Speed target training at Table T3', Icons.flash_on_rounded, AppColors.ittfTableBorder),
          const SizedBox(height: 10),
          _buildSkillDrillTile('Backhand Slice & Return Practice', 'Master defensive underspin returns', Icons.shield_rounded, AppColors.voltLime),
          const SizedBox(height: 10),
          _buildSkillDrillTile('Solo Robot Ball Machine Session', 'Book 30 mins solo drill', Icons.smart_toy_rounded, AppColors.amethystPurple),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSkillDrillTile(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.paddleBlack,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate600, width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  offset: const Offset(0, 3),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.ui(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTypography.ui(fontSize: 10, color: AppColors.slate400),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.slate400, size: 14),
        ],
      ),
    );
  }
}
