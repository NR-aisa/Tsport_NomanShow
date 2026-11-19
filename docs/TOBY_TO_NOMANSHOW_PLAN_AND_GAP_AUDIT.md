# NoManShow × Toby — Gap Audit & High-Level Application Plan

Prepared 2026-11-19, senior UI/UX review.
**Scope: front-end UI/UX only. No backend work is part of this plan** — all phases are design tokens, components, layout, motion, and front-end state presentation in the Flutter client.
Evidence base: (1) full code audit of this repo — 19 screens, ~12,300 lines of Dart; (2) live walk-through of https://tsport-nomanshow.vercel.app/ (every bottom-nav screen, reload behaviour); (3) the Toby inspection spec in `docs/TOBY_UI_SPEC_FOR_NOMANSHOW.md`.

**Verdict in one line:** NoManShow does not have a features problem — it has a *discipline* problem. Toby wins not with more UI, but with one accent, one card system, one motion language, and guidance at every step. NoManShow already owns most of the raw ingredients (tokens, animation packages, status colours); they are simply not enforced.

---

# Part 1 — The Gaps

Severity: **P0** = hurts trust/comprehension today · **P1** = inconsistency users feel but can't name · **P2** = polish.

| # | Gap | Evidence | Sev |
|---|---|---|---|
| G1 | **Accent sprawl — no primary colour** | Theme defines 15+ saturated accents (ITTF blue, paddle red, ball orange, emerald, cyan, crimson, gold, purple, neon pink, teal…). Live: bottom-nav active colour changes per tab (Home green, Leaderboard amber, Tables blue, Path purple) and the centre button is always blue — on some screens two items look "active" at once. Toby: one magenta for every action; green = success only, red = error only. | P0 |
| G2 | **Design tokens exist but are bypassed** | **399 hardcoded `Color(0x…)`** in feature code (splash alone: 115). Typography tokens declare Inter/Bebas/JetBrains Mono, yet screens call `GoogleFonts.plusJakartaSans` inline **287 times** — a 4th font that became the real UI font by accident. This is why theme fixes (e.g. the "light mode reactivity" commit) keep breaking: changes don't propagate. | P0 |
| G3 | **No motion system** | `flutter_animate` and `lottie` are in pubspec but effectively unused (animation code in 1 of 19 screens; **8 `Duration` values in the whole app**, no page transitions, no micro-interactions). Live proof: first load is a **blank white flash**, then the dashboard pops in — despite a 2,343-line splash screen existing in code. Toby: 200–300 ms fades everywhere, confetti for milestones, ambient motion on auth. | P0 |
| G4 | **No onboarding / first-run guidance** | The app opens straight into a dense dashboard under a demo identity. No coachmarks, no "do this first". A new player faces 10+ sections (hero, Live Now, rivals, Happy Hour, radar, 2×2 grid, venue map, pricing…) with no hierarchy of *next action*. Toby teaches 3 gestures in <45 s, inside the real UI. | P0 |
| G5 | **Home is overloaded AND unstable** | Live: home layout **changes between visits** — sections appear/disappear (Live Now, Happy Hour), stat tiles swap in, rivals list changes, radar chips change meaning. The venue-map card is duplicated on Home and Tables. Toby's board is one stable, predictable surface. | P0 |
| G6 | **No empty states; lists feel truncated** | Zero empty-state code found. Live: Leaderboard lists only 3 players and **omits the user's own #4 row**; Tables header says 10 tables but shows 6 tiles (T7–T10 missing); a completed Daily Quest shows "COMPLETED ✓" with **no claim button**; The Path ends in a large empty void with no CTA. Toby: every empty surface teaches the next action. | P0 |
| G7 | **State/logic mismatches that break trust** | Live: "Check In to T4 →" is offered while T4 is in a live match (11–9, two players named); the match-accept timer sits frozen at 04:59; labels "Lock", "Borrow XP", "Radar Ping" appear with no explanation anywhere. Toby's rule: a control is only offered in the state where it makes sense, and every label earns its place. | P0 |
| G8 | **Navigation ambiguity** | Bottom nav is icons-only (no labels); the centre icon opens Match-Accept, not Tables as its table icon suggests; active-tab colour differs per tab (see G1). Users can't build a mental map. Toby: persistent labelled sidebar, one selected style. | P1 |
| G9 | **Component & radius inconsistency** | **15 different corner radii (4→32)** in code. Only **3 shared widgets** (logo, nav bar, tactile button) serve 19 screens, so cards/buttons are re-invented per screen: flat cards beside full-gradient banners (orange Happy Hour, purple Quests, blue Drills, green Walk-In), gradient pills beside flat pills beside cyan rectangles. Splash screen is a 2,343-line monolith; gamification 1,016; display 1,000. | P1 |
| G10 | **Feedback & loading patterns missing** | SnackBar used in exactly 2 places; no toast+undo pattern; `shimmer` package installed but used **0 times** — no skeleton loading anywhere. Success is handled with a heavy full screen (payment) instead of Toby's light success card + celebration. | P1 |
| G11 | **Typography contrast chaos** | 4 font families live. Bebas Neue display at 72 px and gold JetBrains-Mono numbers compete with 10–11 px grey captions on the same screens ("1,240 XP", "04:59" shout; explanations whisper). Toby: counts sit quietly in grey next to titles; one voice per screen. | P1 |
| G12 | **Profile/settings are a dead end** | Live profile shows identity, XP and a top-up CTA — but no settings rows, no sign-out visible. Toby's two-pane Preferences (toggles, plan meter, workspace theme) is the model for a complete account surface. | P2 |

**Strengths to protect (do not redesign away):** the token files themselves are well-structured; table status colours (Free/In-Game/Reserved) are a real semantic system; the floating frosted nav pill is a distinctive, modern shell; dual dark/light + 55″ TV display mode is a genuine differentiator; the tactile 3D button is memorable — it needs discipline (one colour), not deletion.

---

# Part 2 — High-Level Plan: applying Toby's system to NoManShow

## The translation principle
Do **not** copy Toby's look (pink, light, calm). Copy Toby's *laws* into NoManShow's arena identity (dark, energetic, competitive):

1. **One primary action colour.** Every tappable primary action, everywhere, is the same colour.
2. **Cards are a system, not a decoration.** One card recipe; content changes, the recipe doesn't.
3. **Motion is a language.** Fades for changes, celebration only for milestones, nothing moves without meaning.
4. **Every surface teaches.** Empty, first-run, and completed states all point at the next action.
5. **Quiet data, loud moments.** Counts and meta sit in muted text; only LIVE, wins and level-ups get colour and motion.

## Target design system — "Arena DS v1"
- **Colour discipline:** Primary = **volt emerald `#10B981`** (already the colour of Walk-In/Accept/Check-In CTAs — users have half-learned it). Secondary/info = ITTF blue `#2563EB` (links, selected table, TV mode). Gold `#F59E0B` is *reserved* for XP/rewards only. Red = LIVE matches + errors/destructive only. Purple, pink, cyan, teal accents are **retired** from general UI (may survive inside the gamification path artwork only). Surfaces stay 3-step: base `#0A1120` → panel `#101B30` → card `#16233B` (light theme mirrors with slate steps).
- **Radius scale:** 8 (chips/buttons) · 12 (cards) · 16 (sheets/modals) · 28 (nav pill). Nothing else.
- **Type:** 2 families max — Plus Jakarta Sans (UI; it's already the de-facto font, so formalise it) + Bebas Neue (display headlines only, max 1 per screen). JetBrains Mono only for live scores/timers. Counts/meta always in muted text style, never gold.
- **Motion tokens:** fade 250 ms easeOut (screens, cards), panel/sheet 300 ms easeOut, list reflow 250 ms, entrance stagger 40 ms per card, celebration ≤ 3 s (milestones only), ambient loop ≥ 15 s (auth/hero only).
- **Component kit (build once, use everywhere):** ArenaCard, TableCard, PlayerRow, SectionHeader (title + grey count + optional "View all"), PrimaryButton (emerald tactile), GhostButton, StatusPill (Free/Live/Reserved), Toast (with Undo), SuccessCard, EmptyState, Coachmark, SkeletonCard.

## Phases

**Phase 0 — Foundation (no visible redesign).** Freeze new hardcoded colours; sweep the 399 literals into `AppColors`; delete unused accents; add radius/spacing/motion tokens; make `AppTypography` the single font entry (Jakarta + Bebas). Split the 3 monolith screens (splash, gamification, display) into components. *Exit criteria:* 0 hardcoded colours in features; lint rule on.

**Phase 1 — Shell & Home stability.** Bottom nav gets labels + one active colour (emerald) + centre button restyled as the primary "Play" action it actually is. Home gets a **fixed section order** (Hero → Live Tables → Rivals → Path progress → Promo → Pricing) that never reshuffles between visits; remove the duplicated venue map from Home (it lives on Tables). One primary CTA per screen rule applied. *This kills G1, G5, G8.*

**Phase 2 — Core screens, Toby patterns applied.**
- *Tables = Toby board:* venue sections as Collections, TableCard grid (status dot, table #, players/score line, actions on tap), Live Tables rail pattern on TV view; **state-correct CTAs** (an occupied table offers Spectate/Scoreboard, never Check In); show all 10 tables.
- *Leaderboard:* full list with the user's own row pinned ("Your position" bar + row highlight), unexplained "Lock" label removed or explained.
- *Challenge/Match:* real ticking timer (or remove the ring), Decline/Accept as outline/primary pair, post-accept SuccessCard instead of a dead-end screen.
- *Quests/Path:* completed quest gets a Claim action; Path screen ends with a next-goal CTA, never a void.

**Phase 3 — Motion & feedback.** Branded splash (logo + ball loader, ≤1.2 s, no white flash); fade transitions on all routes; card entrance stagger on Home/Tables; **confetti + SuccessCard for match wins, XP level-ups and payment success** (replace the heavy payment-success screen); Toast+Undo for cancel/leave actions; skeleton cards for leaderboard/tables loading. *This kills G3, G10.*

**Phase 4 — Guidance layer.** 3-step first-run coachmark tour (spotlight + arrow, progress dots, must-do-the-tap): 1) Pick a free table, 2) Challenge a rival, 3) See your XP grow. EmptyState kit rolled out (no matches, no rivals, no quests, no tables free — each with icon, one line, one action). Explainer pattern (value line → 3 steps → demo card) for The Path and Champion Bidding, Toby-style. *This kills G4, G6.*

**Phase 5 — Account & polish.** Profile rebuilt on Toby's two-pane preferences model (Profile / Preferences toggles / Membership with quiet usage meter / About; sign-out present). Theme stays dual but both themes consume the same Arena DS tokens. TV (55″) view re-checked against the same card system. Final consistency pass: radius, spacing, one-CTA-per-screen, label audit (every pill must be explainable in 3 words). *This kills G9, G11, G12.*

## Screen-by-screen map (Toby → NoManShow)
| Toby | NoManShow target |
|---|---|
| Spaces sidebar | Venue switcher ("Tonight · 3 Damansara ⌄" becomes a real, consistent venue picker) |
| Collections board | Tables screen sections + Home "Live Tables" block |
| Open Tabs rail | Live Tables rail (TV) / sticky "6 Free — Join" bar (mobile) |
| Save Session 1-click | "Walk In & Play" as the single home primary action |
| Confetti + success card | Win / level-up / payment moments |
| Coachmark tour | First-run arena tour (3 steps) |
| Toast + Undo | Cancel booking, leave table, decline challenge |
| Empty states | No-match / no-rival / all-tables-busy surfaces |
| Two-pane settings | Profile & preferences |
| Theme swatches w/ live preview | Arena theme picker (later; P2) |

## Success measures
- 0 hardcoded colours/fonts outside the theme layer; ≤ 4 accent roles app-wide.
- Home layout identical across sessions (same sections, same order).
- Every list screen has a designed empty state; every destructive action has Undo.
- Time-to-first-action for a new user: one guided tap within 10 s of first open.
- Motion budget respected: no animation > 300 ms except celebrations ≤ 3 s.

## Don'ts
- Don't import Toby's pink/light aesthetic — NoManShow's dark arena identity is an asset.
- Don't animate everything; Toby's restraint is the point.
- Don't redesign screens before Phase 0 tokens land — that's how the current sprawl happened.

*Next step on approval: Phase 0 token sweep + Arena DS component kit, starting with Tables and Home.*
