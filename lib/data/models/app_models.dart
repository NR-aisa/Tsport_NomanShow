enum MembershipStatus { active, expired, none }
enum TableStatus { free, occupied, reserved }
enum ChallengeStatus { open, accepted, completed, cancelled }
enum BetTier { standard, high }
enum SessionType { membership, walkIn }

class AppUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? avatarUrl;
  final int xp;
  final int rank;
  final int wins;
  final int losses;
  final MembershipStatus membershipStatus;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.avatarUrl,
    required this.xp,
    required this.rank,
    required this.wins,
    required this.losses,
    required this.membershipStatus,
  });

  int get totalGames => wins + losses;
  double get winRate => totalGames == 0 ? 0 : wins / totalGames;
  bool get isMember => membershipStatus == MembershipStatus.active;
  String get rankLabel {
    if (xp >= 2000) return 'ELITE';
    if (xp >= 1500) return 'PRO';
    if (xp >= 1000) return 'ROOKIE';
    return 'BEGINNER';
  }
  String get initials => name.split(' ').map((w) => w[0]).take(2).join().toUpperCase();
}

class VenueTable {
  final String id;
  final String name;
  final TableStatus status;
  final AppUser? currentPlayer;
  final int? minutesElapsed;
  final int? sessionDurationHours;

  const VenueTable({
    required this.id,
    required this.name,
    required this.status,
    this.currentPlayer,
    this.minutesElapsed,
    this.sessionDurationHours,
  });
}

class Challenge {
  final String id;
  final AppUser challenger;
  final AppUser? opponent;
  final BetTier betTier;
  final int xpStake;
  final ChallengeStatus status;
  final String? tableId;
  final String? challengerNote;
  final int minutesAgo;

  const Challenge({
    required this.id,
    required this.challenger,
    this.opponent,
    required this.betTier,
    required this.xpStake,
    required this.status,
    this.tableId,
    this.challengerNote,
    required this.minutesAgo,
  });
}

class LeaderboardEntry {
  final int position;
  final AppUser user;
  final int xp;
  final bool isCurrentUser;
  final int change; // +/- rank change today

  const LeaderboardEntry({
    required this.position,
    required this.user,
    required this.xp,
    this.isCurrentUser = false,
    this.change = 0,
  });
}

class XpTransaction {
  final String id;
  final int amount;
  final bool isGain;
  final String reason;
  final String timeLabel;

  const XpTransaction({
    required this.id,
    required this.amount,
    required this.isGain,
    required this.reason,
    required this.timeLabel,
  });
}

class PricingPlan {
  final String id;
  final String name;
  final String subtitle;
  final String priceLabel;
  final String perVisitLabel;
  final bool isRecommended;
  final bool isMembership;
  final List<String> features;

  const PricingPlan({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.priceLabel,
    required this.perVisitLabel,
    this.isRecommended = false,
    this.isMembership = false,
    required this.features,
  });
}

class ChampionEvent {
  final String id;
  final AppUser champion;
  final String title;
  final String description;
  final double minBidAmount;
  final double currentTopBid;
  final AppUser? currentTopBidder;
  final int totalBids;
  final DateTime endsAt;
  final bool isLive;

  const ChampionEvent({
    required this.id,
    required this.champion,
    required this.title,
    required this.description,
    required this.minBidAmount,
    required this.currentTopBid,
    this.currentTopBidder,
    required this.totalBids,
    required this.endsAt,
    this.isLive = true,
  });
}

class AdminStats {
  final int todayVisitors;
  final int activeNow;
  final double todayRevenue;
  final int newMembers;
  final int openChallenges;
  final double totalRevenueThisMonth;

  const AdminStats({
    required this.todayVisitors,
    required this.activeNow,
    required this.todayRevenue,
    required this.newMembers,
    required this.openChallenges,
    required this.totalRevenueThisMonth,
  });
}
