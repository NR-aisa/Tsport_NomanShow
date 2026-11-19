# Phase 8 — Fluent Pass (Dark-Mode De-Boxing) — Implementation Report

**Direction (user, 2026-11-19):** dark theme felt "too boxy"; reference =
Windows 11 UI (floating, translucent, borderless surfaces; grouping by
space and typography). Scope approved: Home first + app-wide token pass.

## What changed

1. **Token pass (app-wide, `app_colors.dart`)** — the dark tonal ladder
   was compressed so cards stop reading as slabs: canvas `#0A1120` →
   elevated `#0E1626` → card `#121C2E` → active `#1A2947`; dark outline
   white 12% → 7%. Every dark card in the app calms down at once.
2. **Hero unboxed (Home)** — the "JUST PLAY TONIGHT" card lost its
   gradient, border and shadow; headline + 3D stage sit directly on the
   canvas (Fluent page-header style).
3. **Stat trio unboxed** — Live tables / The Path / XP balance are no
   longer three boxes: tinted icon chip + muted label + bold value on
   the bare canvas, taps unchanged.
4. **Rivals unboxed** — the outer card is gone; section title + avatar
   row group themselves on the canvas.
5. **More air** — Home section gaps grew (14→20/22, 16→24); the radar
   card's blue edge softened (25% → 12%).
6. **Acrylic nav** — the bottom dock is now true Fluent acrylic:
   `BackdropFilter` blur (18) under a translucent tint (black 62% /
   white 78%), shadow kept on an outer shell so the clip can't eat it.

## Deliberately kept boxed
Surfaces with a job: the flash-promo gradient banner, the member
pricing card, the 3D table stage and radar visuals, buttons and chips.
Fluent isn't "no surfaces" — it's "surfaces only where they mean
something".

## Verification
`flutter analyze` 0 errors · `flutter test` 41/41 · `flutter build web
--release` OK.
