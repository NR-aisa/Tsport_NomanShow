import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/navigation/app_navigator.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';

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

  @override
  void initState() {
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
            const Icon(Icons.stars_rounded, color: Color(0xFFFFC800), size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎉 CHEST UNLOCKED: +200 XP REWARD!',
                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 13),
                  ),
                  Text(
                    'Daily Quest complete. Balance updated to 1,440 XP.',
                    style: GoogleFonts.plusJakartaSans(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1CB0F6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131F24), // Authentic Duolingo midnight slate
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // TOP STATUS BAR (Duolingo Style: Streak, Points, Battery)
            _buildTopStatusBar(),

            // SUB-NAV TABS: Path | Quests | Practice
            _buildSubNavSelector(),

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
    );
  }

  Widget _buildTopStatusBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFF131F24),
        border: Border(bottom: BorderSide(color: Color(0xFF202F36), width: 1.5)),
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
                  color: const Color(0xFF202F36),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF37464F), width: 2),
                ),
                child: const Icon(Icons.person, color: Color(0xFF1CB0F6), size: 20),
              ),
            ),
            const SizedBox(width: 8),

            // Flag / Branch
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF202F36),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Text('🇲🇾', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(
                    '3 Damansara',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
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
                color: const Color(0xFF202F36),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_fire_department_rounded, color: Color(0xFFFF9600), size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '5',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFFF9600),
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
                  color: const Color(0xFF202F36),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Color(0xFFFFC800), size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '1,240',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFFFC800),
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
                color: const Color(0xFF202F36),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.bolt_rounded, color: Color(0xFFFF4B72), size: 18),
                  const SizedBox(width: 2),
                  Text(
                    '25',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFFF4B72),
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

  Widget _buildSubNavSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      color: const Color(0xFF131F24),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFF202F36),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            _buildSubTabItem(0, 'The Path', Icons.alt_route_rounded),
            _buildSubTabItem(1, 'Quests & Chests', Icons.inventory_2_rounded),
            _buildSubTabItem(2, 'Skill Drills', Icons.fitness_center_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildSubTabItem(int index, String title, IconData icon) {
    final isSelected = _activeNavTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeNavTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF58CC02) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                      color: Color(0xFF46A302),
                      offset: Offset(0, 3),
                      blurRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: isSelected ? Colors.white : const Color(0xFF88A2B0)),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: isSelected ? Colors.white : const Color(0xFF88A2B0),
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
              color: const Color(0xFFD97724), // Terracotta orange from Duolingo screenshot
              borderRadius: BorderRadius.circular(22),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFA55312),
                  offset: Offset(0, 5),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SECTION 3 · DIVISION 1',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: Colors.white70,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ROAD TO PLATINUM DIVISION',
                        style: GoogleFonts.plusJakartaSans(
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
                    borderRadius: BorderRadius.circular(14),
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
              // Mascot Side Character (Duolingo Bear/Coach)
              Positioned(
                right: 14,
                top: 140,
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF202F36),
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: const Color(0xFF37464F), width: 2),
                      ),
                      child: const Center(
                        child: Text('🐻', style: TextStyle(fontSize: 42)),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      children: [
                        Icon(Icons.star_rounded, color: Color(0xFFFFC800), size: 14),
                        Icon(Icons.star_rounded, color: Color(0xFFFFC800), size: 14),
                        Icon(Icons.star_rounded, color: Color(0xFFFFC800), size: 14),
                      ],
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
              color: Color(0xFF58CC02),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF46A302),
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
            style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w800, color: const Color(0xFF88A2B0)),
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
              color: const Color(0xFF202F36),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF37464F), width: 1.5),
            ),
            child: Text(
              'START MATCH · +200 XP',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFFF9600),
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
                        color: const Color(0xFFFF9600).withValues(alpha: 0.15),
                      ),
                    ),
                  ),

                  // 3D Extruded Orange Node
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF9600), // Duolingo star orange
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFCE7000), // 20% darker extruded bottom lip
                          offset: Offset(0, 6),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.star_rounded, color: Colors.white, size: 40),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white),
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
                color: _chestOpened ? const Color(0xFF202F36) : const Color(0xFFFFC800),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: _chestOpened ? const Color(0xFF18252B) : const Color(0xFFE5A500),
                    offset: const Offset(0, 5),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  _chestOpened ? Icons.lock_open_rounded : Icons.inventory_2_rounded,
                  color: _chestOpened ? const Color(0xFF88A2B0) : const Color(0xFF131F24),
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _chestOpened ? 'Claimed' : 'Loot Chest',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: _chestOpened ? const Color(0xFF58CC02) : const Color(0xFFFFC800),
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
              color: Color(0xFF263842),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF1C2A31),
                  offset: Offset(0, 5),
                  blurRadius: 0,
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.lock_rounded, color: Color(0xFF5E7987), size: 24),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xFF5E7987)),
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
                color: Color(0xFF8549BA), // Amethyst purple
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF5F2D8C),
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
              style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w900, color: const Color(0xFFB97DE8)),
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
              color: const Color(0xFF8549BA),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(color: Color(0xFF5F2D8C), offset: Offset(0, 5), blurRadius: 0),
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
                        style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Complete Quests to Win Chests & XP!',
                        style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white),
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
            style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w800, color: const Color(0xFF88A2B0), letterSpacing: 0.8),
          ),
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF202F36),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFF37464F), width: 1.5),
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
                        style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white),
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
                    backgroundColor: Color(0xFF131F24),
                    valueColor: AlwaysStoppedAnimation(Color(0xFF58CC02)),
                  ),
                ),
                const SizedBox(height: 6),
                Text('0 / 1 matches completed', style: GoogleFonts.plusJakartaSans(fontSize: 10, color: const Color(0xFF88A2B0))),
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
            style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w800, color: const Color(0xFF88A2B0), letterSpacing: 0.8),
          ),
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF202F36),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFF37464F), width: 1.5),
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
                            style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text('Reward: Blue Arena Loot Chest', style: GoogleFonts.plusJakartaSans(fontSize: 10, color: const Color(0xFF1CB0F6))),
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
                    backgroundColor: Color(0xFF131F24),
                    valueColor: AlwaysStoppedAnimation(Color(0xFFFF4B72)),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('10 / 10 XP EARNED', style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w900, color: const Color(0xFFFF4B72))),
                    Text('COMPLETED ✔', style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w900, color: const Color(0xFF58CC02))),
                  ],
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
              color: const Color(0xFF1CB0F6),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(color: Color(0xFF1899D6), offset: Offset(0, 5), blurRadius: 0),
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
                        style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Sharpen Your Table Tennis Skills',
                        style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white),
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
              color: const Color(0xFF202F36),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFF37464F), width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Warmup Drill',
                  style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text('Rally 50 balls with Robot Trainer at Table T1', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: const Color(0xFF88A2B0))),
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
            style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w800, color: const Color(0xFF88A2B0), letterSpacing: 0.8),
          ),
          const SizedBox(height: 10),

          _buildSkillDrillTile('Mistake Review & Match Replay', 'Analyze lost points from yesterday', Icons.replay_rounded, const Color(0xFFFF9600)),
          const SizedBox(height: 10),
          _buildSkillDrillTile('Forehand Top-Spin Power Drill', 'Speed target training at Table T3', Icons.flash_on_rounded, const Color(0xFF1CB0F6)),
          const SizedBox(height: 10),
          _buildSkillDrillTile('Backhand Slice & Return Practice', 'Master defensive underspin returns', Icons.shield_rounded, const Color(0xFF58CC02)),
          const SizedBox(height: 10),
          _buildSkillDrillTile('Solo Robot Ball Machine Session', 'Book 30 mins solo drill', Icons.smart_toy_rounded, const Color(0xFF8549BA)),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSkillDrillTile(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF202F36),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF37464F), width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
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
                  style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(fontSize: 10, color: const Color(0xFF88A2B0)),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF88A2B0), size: 14),
        ],
      ),
    );
  }
}
