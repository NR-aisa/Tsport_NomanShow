import '../models/app_models.dart';

class MockData {
  MockData._();

  static const currentUser = AppUser(
    id: 'u001',
    name: 'Noman Rashid',
    email: 'noman@example.com',
    phone: '+60 12-345 6789',
    xp: 1420,
    rank: 7,
    wins: 23,
    losses: 11,
    membershipStatus: MembershipStatus.active,
  );

  static const List<AppUser> players = [
    AppUser(id: 'u002', name: 'Amir Hassan', email: 'amir@e.com', phone: '', xp: 2340, rank: 1, wins: 56, losses: 8, membershipStatus: MembershipStatus.active),
    AppUser(id: 'u003', name: 'Priya Nair', email: 'priya@e.com', phone: '', xp: 1890, rank: 2, wins: 41, losses: 14, membershipStatus: MembershipStatus.active),
    AppUser(id: 'u004', name: 'Lee Wei Ming', email: 'wei@e.com', phone: '', xp: 1650, rank: 3, wins: 35, losses: 18, membershipStatus: MembershipStatus.none),
    AppUser(id: 'u005', name: 'Farah Zainudin', email: 'farah@e.com', phone: '', xp: 1540, rank: 4, wins: 29, losses: 15, membershipStatus: MembershipStatus.active),
    AppUser(id: 'u006', name: 'Rajan Kumar', email: 'rajan@e.com', phone: '', xp: 1500, rank: 5, wins: 25, losses: 20, membershipStatus: MembershipStatus.active),
    AppUser(id: 'u007', name: 'Siti Rahimah', email: 'siti@e.com', phone: '', xp: 1480, rank: 6, wins: 22, losses: 17, membershipStatus: MembershipStatus.expired),
  ];

  static List<LeaderboardEntry> get leaderboard => [
    LeaderboardEntry(position: 1, user: players[0], xp: 2340, change: 0),
    LeaderboardEntry(position: 2, user: players[1], xp: 1890, change: 1),
    LeaderboardEntry(position: 3, user: players[2], xp: 1650, change: -1),
    LeaderboardEntry(position: 4, user: players[3], xp: 1540, change: 2),
    LeaderboardEntry(position: 5, user: players[4], xp: 1500, change: 0),
    LeaderboardEntry(position: 6, user: players[5], xp: 1480, change: -1),
    const LeaderboardEntry(position: 7, user: currentUser, xp: 1420, isCurrentUser: true, change: 1),
  ];

  static final List<VenueTable> tables = [
    VenueTable(id: 't01', name: 'Table 01', status: TableStatus.occupied, currentPlayer: players[0], minutesElapsed: 80, sessionDurationHours: 3),
    const VenueTable(id: 't02', name: 'Table 02', status: TableStatus.free),
    const VenueTable(id: 't03', name: 'Table 03', status: TableStatus.free),
    VenueTable(id: 't04', name: 'Table 04', status: TableStatus.occupied, currentPlayer: players[1], minutesElapsed: 45, sessionDurationHours: 3),
    const VenueTable(id: 't05', name: 'Table 05', status: TableStatus.reserved),
    const VenueTable(id: 't06', name: 'Table 06', status: TableStatus.free),
    VenueTable(id: 't07', name: 'Table 07', status: TableStatus.occupied, currentPlayer: players[2], minutesElapsed: 120, sessionDurationHours: 3),
    const VenueTable(id: 't08', name: 'Table 08', status: TableStatus.free),
    const VenueTable(id: 't09', name: 'Table 09', status: TableStatus.free),
    VenueTable(id: 't10', name: 'Table 10', status: TableStatus.occupied, currentPlayer: players[3], minutesElapsed: 15, sessionDurationHours: 3),
  ];

  static final List<Challenge> openChallenges = [
    Challenge(id: 'c001', challenger: players[0], betTier: BetTier.high, xpStake: 500, status: ChallengeStatus.open, tableId: 't01', minutesAgo: 5, challengerNote: 'Pro players only. I\'m ready.'),
    Challenge(id: 'c002', challenger: players[2], betTier: BetTier.standard, xpStake: 200, status: ChallengeStatus.open, tableId: 't07', minutesAgo: 12, challengerNote: 'Friendly challenge, let\'s go!'),
    Challenge(id: 'c003', challenger: players[4], betTier: BetTier.standard, xpStake: 200, status: ChallengeStatus.open, tableId: 't10', minutesAgo: 2),
  ];

  static final acceptedChallenge = Challenge(
    id: 'c004',
    challenger: players[0],
    opponent: currentUser,
    betTier: BetTier.high,
    xpStake: 500,
    status: ChallengeStatus.accepted,
    tableId: 't03',
    minutesAgo: 0,
  );

  static const List<PricingPlan> plans = [
    PricingPlan(
      id: 'member',
      name: 'Membership',
      subtitle: 'Best value · Monthly',
      priceLabel: 'RM 90 / month',
      perVisitLabel: '+ RM 0.90 per visit',
      isRecommended: true,
      isMembership: true,
      features: [
        'Unlimited visits this month',
        'RM 0.90 per show-up',
        'Priority table selection',
        'XP & challenge system',
        'Leaderboard ranking',
        'Cancel anytime',
      ],
    ),
    PricingPlan(
      id: 'walkin',
      name: 'Walk-In',
      subtitle: 'No commitment',
      priceLabel: 'RM 17',
      perVisitLabel: '3 hours of play',
      features: [
        '3 hours full access',
        'Leaderboard viewing',
        'Casual play only',
        'Pay & play — done',
      ],
    ),
  ];

  static const List<XpTransaction> xpHistory = [
    XpTransaction(id: 'x1', amount: 500, isGain: false, reason: 'Challenge loss vs Amir Hassan', timeLabel: '2h ago'),
    XpTransaction(id: 'x2', amount: 200, isGain: true, reason: 'Challenge win vs Lee Wei Ming', timeLabel: 'Yesterday'),
    XpTransaction(id: 'x3', amount: 1500, isGain: true, reason: 'XP Purchase — Starter Pack', timeLabel: '3 days ago'),
    XpTransaction(id: 'x4', amount: 200, isGain: false, reason: 'Challenge loss vs Priya Nair', timeLabel: '4 days ago'),
    XpTransaction(id: 'x5', amount: 500, isGain: true, reason: 'Challenge win vs Farah Zainudin', timeLabel: '5 days ago'),
  ];

  static final championEvent = ChampionEvent(
    id: 'evt001',
    champion: const AppUser(
      id: 'champ01',
      name: 'Zhang Wei',
      email: 'zhang@pro.com',
      phone: '',
      avatarUrl: null,
      xp: 4800,
      rank: 1,
      wins: 142,
      losses: 12,
      membershipStatus: MembershipStatus.active,
    ),
    title: 'Play Against National Champion!',
    description:
        'Zhang Wei — 3× National Table Tennis Champion — is here tonight. '
        'One lucky player gets to face him in a 1v1 match. Place your bid now!',
    minBidAmount: 100.0,
    currentTopBid: 350.0,
    currentTopBidder: players[1],
    totalBids: 14,
    endsAt: DateTime.now().add(const Duration(hours: 1, minutes: 23)),
    isLive: true,
  );

  static const adminStats = AdminStats(
    todayVisitors: 34,
    activeNow: 10,
    todayRevenue: 892.50,
    newMembers: 5,
    openChallenges: 3,
    totalRevenueThisMonth: 12480.00,
  );

  static const weeklyRevenue = [420.0, 680.0, 540.0, 920.0, 750.0, 1100.0, 892.50];
  static const weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
}
