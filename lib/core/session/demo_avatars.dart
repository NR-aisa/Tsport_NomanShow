/// Demo profile pictures (DPs) bundled with the app.
///
/// Front-end only: illustrated avatar assets under
/// `assets/images/avatars/`. Seeded players reference these through
/// `AppUser.avatarUrl`, and the signed-in demo user picks theirs via
/// `AppSession.avatarAsset` (tap the avatar on Register/Profile to cycle).
class DemoAvatars {
  DemoAvatars._();

  static const String user = 'assets/images/avatars/dp_user.png';
  static const String jason = 'assets/images/avatars/dp_jason.png';
  static const String sara = 'assets/images/avatars/dp_sara.png';
  static const String nurul = 'assets/images/avatars/dp_nurul.png';
  static const String daniel = 'assets/images/avatars/dp_daniel.png';
  static const String mei = 'assets/images/avatars/dp_mei.png';
  static const String rajan = 'assets/images/avatars/dp_rajan.png';
  static const String champion = 'assets/images/avatars/dp_champion.png';
  static const String amir = 'assets/images/avatars/dp_amir.png';
  static const String priya = 'assets/images/avatars/dp_priya.png';
  static const String lee = 'assets/images/avatars/dp_lee.png';
  static const String siti = 'assets/images/avatars/dp_siti.png';

  /// The picker set for the signed-in user's own DP.
  static const List<String> all = [
    user,
    jason,
    sara,
    nurul,
    daniel,
    mei,
    rajan,
    champion,
    amir,
    priya,
    lee,
    siti,
  ];
}
