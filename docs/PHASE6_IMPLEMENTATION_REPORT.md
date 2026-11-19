# Phase 6 — The Feel Pass · Implementation Report (2026-11-19)

Implements Phase 6 of `TOBY_TO_NOMANSHOW_PLAN_AND_GAP_AUDIT.md` (Toby texture
& motion), front-end only. Verified: `flutter analyze` 0 errors,
`flutter test` 41/41 passed, `flutter build web --release` succeeded.

## 6A — Texture & surfaces
- **White mode = Toby's gradient theme** (user decision): light canvas is now
  warm cream `#F7F0E6`, gradient `#F8F3EA → #F3E9D8`, cards pure white, soft
  surfaces warmed (`#FBF7F2`), sand panel token `#F5E9D9` added.
- **Card recipe at the token level:** `AppColors.cardShadow` is now Toby's
  warm diffuse shadow (light: warm beige, blur 24, offset 8; dark: deep soft
  shadow + specular rim). `AppColors.cardBorder` is effectively borderless
  (transparent in light, 5% in dark), so every surface using the tokens —
  hero cards, venue map, spotlight, leaderboard rows — lost its hard outline.
- `ArenaCard` (radius 20, recipe shadow, press scale 0.98) and
  `ArenaBackdrop` (canvas gradient) added to the kit; backdrop applied to
  Home, Tables, Leaderboard, Gamification, Profile, Login, Entry Gate,
  Payment Success.

## 6B — Motion
- Entrance stagger (fade + rise, 40 ms steps) on Home sections, all 10 table
  tiles, and all 5 leaderboard rows, via an `arenaEntrance(i)` extension.
- Spotlight pills cross-fade when the selected table changes.
- **Confetti** (new `confetti` dependency) on milestones only: Daily Quest
  claim and Payment Success (auto, once). Arena palette: emerald/gold/white/blue.
- Entry Gate ambient layer: three mini table cards (T3/T7 free, T4 live)
  drifting slowly behind the form — Toby's floating cards, Arena version.
  Hand-rolled AnimationController (flutter_animate's repeat left a pending
  timer in widget tests; this disposes cleanly).

## 6C + 6E — Quieting & nits
- Free-table spotlight no longer names players: Players pill is state-aware
  ("Waiting for players" / "Booked · members" / "Aiman + Jason").
- Demo identity aligned: session display name now matches the profile hero
  ("Alman Rahman") everywhere, including Preferences.

## 6D — Profile, Toby-style
- Grouped settings — ACCOUNT (Signed in as with a "Change" link, Membership),
  ARENA (Dark theme, Notifications) — in borderless recipe cards with quiet
  grey group headers.
- Quiet membership meter card: "Member pass · Renews 1 Dec", thin emerald
  progress bar, "6 of 10 tables free tonight".
- ABOUT group (FAQ / Terms / Privacy — honest demo toasts), a calm outlined
  DANGER ZONE (Delete Account), and Log Out as quiet red text, Toby-style.

## Not in this pass (honest remainder)
- Bespoke in-screen mini-visuals (mini ITTF tables, telemetry pills) keep
  their thin outlines — they are diagrams, not cards.
- The 3 monolith screens still await the internal component split (no visual
  change), carried over from the Phase 0–5 report.
