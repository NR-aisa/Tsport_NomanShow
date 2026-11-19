# Arena DS — Implementation Report

Implements `docs/TOBY_TO_NOMANSHOW_PLAN_AND_GAP_AUDIT.md` (gaps G1–G13).
**Scope: front-end UI/UX only. No backend.** Login/payment remain simulated
in the UI, exactly as the rest of this front-end project already was — but
now the flows exist, are wired, and are honest about it.

## Phase 0 — Foundation (G1, G2, G9, G11)
- `AppColors.primary` is now the one primary: **volt emerald `#10B981`**.
  Blue = info/secondary only, gold = XP/rewards only, red = LIVE/errors only.
  Pink and teal tokens are remapped to crimson / ITTF blue; cyan → info blue.
  Purple survives only as the Reserved table status + gamification artwork.
- **500 hardcoded `Color(0x…)` literals swept to tokens — 0 remain outside
  `core/theme`.** Neutral slate consts added for exact greys.
- Typography has a single entry point: `AppTypography.ui()` (Plus Jakarta
  Sans) and `AppTypography.mono()` (scores/timers only). All 287 inline
  Jakarta + 84 Inter calls rerouted; Bebas Neue remains display-only.
  `AppTypography` headings/body switched from Inter to Jakarta.
- Radius scale locked to **8 / 12 / 16 / 28** (133 values snapped).
- New `core/theme/app_tokens.dart`: `AppRadius`, `AppSpacing`, `AppMotion`
  (fade 250 ms, panel 300 ms, stagger 40 ms, celebration ≤ 3 s).

## Phase 1 — Shell & Home (G1, G5, G8)
- Bottom nav rebuilt: **labels on every tab** (Home / Ranks / Play / Tables /
  Path), **one active colour** (emerald) for all tabs, centre button is an
  emerald **"Play"** action instead of an always-blue mystery icon.
- Home: duplicated Venue Map card removed (it lives on Tables); section
  order fixed and commented so it cannot silently reshuffle.

## Phase 1B — Entry & identity (G13)
- **New `EntryGateScreen`** — the app now opens at a front door:
  Member Login / New Player / Guest Walk-In. Nobody is dropped silently
  into a demo identity anymore.
- **New `LoginScreen`** — the login that did not exist: phone/email →
  6-digit code → arena, with explicit, recoverable error states
  (Toby pattern). Front-end flow; `core/session/app_session.dart` records
  member vs guest.
- Guest path wired: Entry Gate → Plan Selection **on the Guest tab**
  (`initialGuest`) → RM17 → Gate Pass, with a visible Guest state in Profile.
- Register's submit button now works standalone (it was a dead button when
  no callback was supplied): registers → session → plan selection.
- Sign-out (Profile) returns to the Entry Gate.

## Phase 2 — Core screens (G5, G6, G7)
- **Tables:** all **10 tables** now shown (T7–T10 added). One status map
  drives spotlight + CTAs: a free table offers **Check In**; a live/in-game
  table offers **Spectate**; reserved is labelled. The "Check in to a live
  match" bug is gone. Default selection is a free table (T1).
- **Leaderboard:** the user's own **#4 row is in the list**, emerald-
  highlighted, with no self-challenge button; a #5 row added. The mystery
  **"Lock" label is now "Stake · 200 XP pot"**.
- **Challenge Accepted:** the frozen 04:59 is now a **real ticking 5:00
  countdown** (mono digits) with an honest expired state.
- **Quests:** completed quest has a **Claim Reward** action → claimed state
  + Toast with Undo. Progress bar is emerald (complete), counts are quiet.
- **The Path:** ends with a **Next Goal CTA card**, not empty space.

## Phase 3 — Motion & feedback (G3, G10)
- **No more blank white first load:** `web/index.html` paints arena-dark
  (`#0A1120`) with a branded boot label from the first frame.
- **All routes fade at 250 ms** (`AppNavigator.fadeRoute`, AppMotion token).
- Component kit in `shared/widgets/arena_widgets.dart`: **ArenaToast**
  (with Undo), **SuccessCard**, **EmptyState**, **SkeletonCard**.
- Payment success now leads with a light **SuccessCard** above the gate
  pass instead of relying on the heavy screen alone.

## Phase 4 — Guidance (G4, G6)
- **First-run coachmark tour** on Home: 3 steps (pick a free table →
  challenge a rival → watch XP grow), progress dots, Skip/Next, shown once
  per session over the real UI.
- EmptyState component shipped in the kit for every list surface.

## Phase 5 — Account & polish (G12)
- Profile is a real account surface: **Preferences** section (dark-theme
  switch wired to the theme controller, membership row with renewal +
  price, signed-in-as row reflecting member/guest session) and a
  **Sign Out** action. The PDPA leaderboard-visibility toggle stays.

## Verification (2026-11-19, Flutter SDK installed fresh for this pass)
- `flutter analyze`: **0 errors** (remaining items are info-level notices
  from the newest Flutter SDK plus two pre-existing pubspec asset-dir
  warnings that predate this work).
- `flutter test`: **41 / 41 passed** — including the full 17-screen
  dark & light showcase suite. One pre-existing failure found on the
  original code (Splash light-mode row overflow) was also fixed here.
- `flutter build web --release`: **succeeded**.
- Known remaining item from the plan: splitting the three monolith screens
  (splash ~2,300 lines, gamification, display) into components is internal
  refactoring with no visual effect; it is the only Phase 0 sub-item not
  completed in this pass and is safe to do incrementally next.
