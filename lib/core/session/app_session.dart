import 'package:flutter/foundation.dart';
import 'demo_avatars.dart';

/// Front-end session state (Arena DS Phase 1B).
///
/// There is NO backend in this project — this simply records which honest
/// path the user took through the entry gate (member login, new-player
/// registration, or guest walk-in) so the UI never silently drops anyone
/// into a demo identity again.
enum SessionKind { none, member, guest }

class AppSession {
  /// Demo DP for the signed-in user (front-end only). Index into
  /// [DemoAvatars.all]; Register and Profile avatars tap to cycle it.
  static int avatarIndex = 0;
  static String get avatarAsset => DemoAvatars.all[avatarIndex];
  static void cycleAvatar() {
    avatarIndex = (avatarIndex + 1) % DemoAvatars.all.length;
  }

  AppSession._();

  static final ValueNotifier<SessionKind> kind =
      ValueNotifier<SessionKind>(SessionKind.none);

  static String displayName = 'Player';

  /// First-run coachmark tour completion (front-end flag, Phase 4).
  static bool coachmarkDone = false;

  static bool get isSignedIn => kind.value != SessionKind.none;
  static bool get isGuest => kind.value == SessionKind.guest;

  static void signInMember({String name = 'Alman Rahman'}) {
    displayName = name;
    kind.value = SessionKind.member;
  }

  static void continueAsGuest() {
    displayName = 'Guest Player';
    kind.value = SessionKind.guest;
  }

  static void signOut() {
    displayName = 'Player';
    kind.value = SessionKind.none;
  }
}


