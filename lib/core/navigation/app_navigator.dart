import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// Import all screens
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/entry_gate_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../theme/app_tokens.dart';
import '../../features/auth/screens/plan_selection_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/payment/screens/payment_screen.dart';
import '../../features/payment/screens/payment_success_screen.dart';
import '../../features/table/screens/table_selection_screen.dart';
import '../../features/challenge/screens/challenge_board_screen.dart';
import '../../features/challenge/screens/challenge_accepted_screen.dart';
import '../../features/challenge/screens/seek_player_screen.dart';
import '../../features/challenge/screens/post_challenge_screen.dart';
import '../../features/leaderboard/screens/leaderboard_screen.dart';
import '../../features/home/screens/profile_screen.dart';
import '../../features/xp/screens/xp_purchase_screen.dart';
import '../../features/bidding/screens/champion_bidding_screen.dart';
import '../../features/display/screens/display_leaderboard_screen.dart';
import '../../features/admin/screens/admin_dashboard_screen.dart';
import '../../features/gamification/screens/gamification_path_screen.dart';

class ScreenMeta {
  final String id;
  final String title;
  final String category;
  final String description;
  final IconData icon;
  final Color color;
  final Widget Function() builder;

  const ScreenMeta({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.icon,
    required this.color,
    required this.builder,
  });
}

class AppNavigator {
  static final List<ScreenMeta> screens = [
    ScreenMeta(
      id: 'splash',
      title: '01. Venue Entrance & Splash',
      category: 'MEMBER ONBOARDING',
      description: '"JUST play tonight at JOMNITTAKU" · 2 matches live · 6 free of 10',
      icon: Icons.home_rounded,
      color: Colors.white,
      builder: () => const SplashScreen(),
    ),
    ScreenMeta(
      id: 'plan',
      title: '02. 90 Sen Member Pass',
      category: 'MEMBER ONBOARDING',
      description: 'Save RM16.10 vs walk-in · Aiman Rahman LVL 12 · Daily Quest +200 XP',
      icon: Icons.confirmation_number_rounded,
      color: AppColors.pastelGreen,
      builder: () => const PlanSelectionScreen(),
    ),
    ScreenMeta(
      id: 'payment',
      title: '03. DuitNow QR Fast Checkout',
      category: 'PAYMENTS & ACCESS',
      description: 'RM 0.90 paid · JOMMENANG Malaysia National QR · Connected status',
      icon: Icons.qr_code_scanner_rounded,
      color: AppColors.pastelPurple,
      builder: () => const PaymentScreen(),
    ),
    ScreenMeta(
      id: 'pass',
      title: '04. Gate Pass & Door Unlock',
      category: 'PAYMENTS & ACCESS',
      description: 'Door locked -> Ready to scan · Room code KX8VQS · RM200 fine warning',
      icon: Icons.door_front_door_rounded,
      color: AppColors.pastelBlue,
      builder: () => const PaymentSuccessScreen(),
    ),
    ScreenMeta(
      id: 'tables',
      title: '05. Arena Table Radar',
      category: 'ARENA & MATCHMAKING',
      description: '3 Damansara venue map · T4 Spotlight card · T1-T6 matrix with game timers',
      icon: Icons.table_restaurant_rounded,
      color: Colors.white,
      builder: () => const TableSelectionScreen(),
    ),
    ScreenMeta(
      id: 'challenge_board',
      title: '06. Challenge Setup & Risk Picker',
      category: 'ARENA & MATCHMAKING',
      description: 'Pick rival (Sara, Jason, Nurul) · 100/200/500 risk tiers · Pot +/- 200 XP',
      icon: Icons.flash_on_rounded,
      color: AppColors.pastelYellow,
      builder: () => const ChallengeBoardScreen(),
    ),
    ScreenMeta(
      id: 'challenge_accepted',
      title: '07. Mortal Kombat 1v1 Accepted',
      category: 'ARENA & MATCHMAKING',
      description: 'Aiman R. vs Jason T. · 04:59 countdown · Room Code KX8VQS · Table No. 4',
      icon: Icons.sports_mma_rounded,
      color: AppColors.pastelPink,
      builder: () => const ChallengeAcceptedScreen(),
    ),
    ScreenMeta(
      id: 'leaderboard',
      title: '08. League Leaderboard',
      category: 'GAMIFICATION & RANKS',
      description: '#4 Aiman R. (1,240 XP) · Top 3 Daniel, Sara, Mei · Challenge buttons',
      icon: Icons.emoji_events_rounded,
      color: AppColors.pastelGreen,
      builder: () => const LeaderboardScreen(),
    ),
    ScreenMeta(
      id: 'profile',
      title: '09. Profile & PDPA Privacy Toggle',
      category: 'GAMIFICATION & RANKS',
      description: '1,240 XP wallet · Leaderboard consent toggle ("Untick = Anonymous")',
      icon: Icons.person_rounded,
      color: AppColors.pastelPurple,
      builder: () => const ProfileScreen(),
    ),
    ScreenMeta(
      id: 'xp_store',
      title: '10. XP Loan & Recharge Store',
      category: 'XP ECONOMY',
      description: 'Take +200 XP Loan (repay from winnings) + 100/500 XP buy packs',
      icon: Icons.monetization_on_rounded,
      color: AppColors.pastelYellow,
      builder: () => const XpPurchaseScreen(),
    ),
    ScreenMeta(
      id: 'bidding',
      title: '11. Play The Champion Live Auction',
      category: 'AUCTION ARENA',
      description: 'National Champion match · Highest bid RM320 · Bid ladder RM350-500',
      icon: Icons.stars_rounded,
      color: AppColors.pastelPink,
      builder: () => const ChampionBiddingScreen(),
    ),
    ScreenMeta(
      id: 'display',
      title: '12. 55" Venue TV Arena Broadcast',
      category: 'VENUE BROADCAST',
      description: 'Landscape TV View: 7-Row Live Leaderboard + Televised Mortal Kombat Card',
      icon: Icons.tv_rounded,
      color: AppColors.pastelBlue,
      builder: () => const DisplayLeaderboardScreen(),
    ),
    ScreenMeta(
      id: 'register',
      title: '13. New Guest Registration',
      category: 'MEMBER ONBOARDING',
      description: 'Full name, email, Malaysian phone (+60), DOB, avatar selfie, PDPA checkbox',
      icon: Icons.app_registration_rounded,
      color: Colors.white,
      builder: () => const RegisterScreen(),
    ),
    ScreenMeta(
      id: 'seek',
      title: '14. Seek Opponent Radar Ping',
      category: 'ARENA & MATCHMAKING',
      description: 'Send radar ping to free players nearby in 3 Damansara venue',
      icon: Icons.search_rounded,
      color: Colors.white,
      builder: () => const SeekPlayerScreen(),
    ),
    ScreenMeta(
      id: 'post_challenge',
      title: '15. Create Custom Challenge',
      category: 'ARENA & MATCHMAKING',
      description: 'Custom XP risk stake, game mode & reserved table allocation',
      icon: Icons.add_circle_outline_rounded,
      color: Colors.white,
      builder: () => const PostChallengeScreen(),
    ),
    ScreenMeta(
      id: 'admin',
      title: '16. Venue Admin & IoT Controller',
      category: 'VENUE OPERATIONS',
      description: 'Gate QR override, Table T1-T6 lighting switch, dispute arbitration',
      icon: Icons.admin_panel_settings_rounded,
      color: Colors.white,
      builder: () => const AdminDashboardScreen(),
    ),
    ScreenMeta(
      id: 'gamification_path',
      title: '17. Duolingo Progression Path & Quests',
      category: 'GAMIFICATION & ANIMATION',
      description: 'Animated S-curve ladder, bouncing star node, daily quests & loot chests',
      icon: Icons.alt_route_rounded,
      color: AppColors.radiantGold,
      builder: () => const GamificationPathScreen(),
    ),
    ScreenMeta(
      id: 'entry_gate',
      title: '18. Entry Gate — Member / New / Guest',
      category: 'MEMBER ONBOARDING',
      description: 'The front door: member login, new-player registration, or guest walk-in (Phase 1B)',
      icon: Icons.door_front_door_rounded,
      color: AppColors.voltLime,
      builder: () => const EntryGateScreen(),
    ),
    ScreenMeta(
      id: 'login',
      title: '19. Member Login',
      category: 'MEMBER ONBOARDING',
      description: 'Returning member login with phone/email + 6-digit code (front-end flow, Phase 1B)',
      icon: Icons.login_rounded,
      color: AppColors.voltLime,
      builder: () => const LoginScreen(),
    ),
  ];

  /// Arena DS motion token: every route is a 250 ms fade (Toby rule —
  /// changes fade, nothing slides or pops without meaning).
  static PageRouteBuilder<T> fadeRoute<T>(Widget screen) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: AppMotion.fade,
    );
  }

  static void pushScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(fadeRoute(screen));
  }

  static void toEntry(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      fadeRoute(const EntryGateScreen()),
      (route) => false,
    );
  }

  static void toLogin(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const LoginScreen()));
  }

  static void toRegister(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const RegisterScreen()));
  }

  static void toHomeAndClear(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      fadeRoute(const SplashScreen()),
      (route) => false,
    );
  }

  static void toHome(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const SplashScreen()));
  }

  static void toPlan(BuildContext context, {bool initialGuest = false}) {
    Navigator.of(context).push(
      fadeRoute(PlanSelectionScreen(initialGuest: initialGuest)),
    );
  }

  static void toPayment(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const PaymentScreen()));
  }

  static void toPass(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const PaymentSuccessScreen()));
  }

  static void toTables(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const TableSelectionScreen()));
  }

  static void toChallengeBoard(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const ChallengeBoardScreen()));
  }

  static void toChallengeAccepted(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const ChallengeAcceptedScreen()));
  }

  static void toLeaderboard(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const LeaderboardScreen()));
  }

  static void toProfile(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const ProfileScreen()));
  }

  static void toXpStore(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const XpPurchaseScreen()));
  }

  static void toBidding(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const ChampionBiddingScreen()));
  }

  static void toDisplay(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const DisplayLeaderboardScreen()));
  }

  static void toGamificationPath(BuildContext context) {
    Navigator.of(context).push(fadeRoute(const GamificationPathScreen()));
  }
}
