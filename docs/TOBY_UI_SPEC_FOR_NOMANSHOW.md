# Toby UI/UX Deep Inspection — Spec Notes for NoManShow Upgrade

Source: user screen recording, 2026-11-19. Video: 1920×1032, ~37 fps, 3 min 25 s (205 s), recorded in Microsoft Edge on Windows.
Method: full download, frames extracted every 5 s (41 frames) + scene-change detection + dense 1–2 fps strips around animation moments (47–65 s, 66–86 s). Colours below are **sampled from the frames**, not guessed.
Privacy note: the recording contains a login attempt and browsing history; credentials/history titles are deliberately NOT recorded in this spec.

---

## 1. Video map — what happens, second by second

| Time | Section |
|---|---|
| 0:00–0:10 | gettoby.com homepage hero (marketing UI + live product mock) |
| 0:10–0:15 | Chrome Web Store listing (in Edge) → install |
| 0:15–0:20 | Edge Extensions page — Toby had been auto-disabled by Edge; user re-enables toggle |
| 0:20–0:30 | Toby new-tab opens; welcome modal over blurred board: "Your browser, under control." → Start |
| 0:30–0:40 | Onboarding step 1 coachmark: "Save your first tab" + hand-drawn "Drag a tab" arrow → user drags a tab from Open Tabs into the empty collection |
| 0:40–0:45 | Success card: "Nice! Your tab is saved." + choice: Keep Tabs Open / Close Tabs |
| 0:45–0:55 | Onboarding step 2: "Save all tabs in one click" + "Save session" callout → click → **pink confetti burst** → new session collection auto-named "Nov 19 at 13:01" with 4 cards → success card "Your first session is saved!" |
| 0:55–1:05 | Onboarding step 3: "Open one, or open all" spotlight arrows → session opened → success card fades out (captured mid-fade at 1:00) |
| 1:05–1:25 | Sign-up modal ("Sign up to access your tabs anywhere, anytime") → Log in → "Welcome back!" form with **floating tab cards drifting around the modal** → wrong-password error state ("Incorrect email or password." in red under the fields) |
| 1:25–1:30 | Logged in. Personal space empty state: "No collections yet" |
| 1:30–1:40 | Personal → drag between collections; card hover reveals action bar + red delete icon |
| 1:40–1:50 | Delete → **top-centre toast pill**: green check, `Deleted "Extensions"`, "Show" (undo) button; auto-dismisses in a few seconds |
| 1:50–2:10 | Board browsing; sidebar nav states |
| 2:10–2:20 | Starred page (empty state) + **Sort dropdown** opened (Custom order / Last modified / Alphabetical / Starred to Top / Date created) |
| 2:20–2:30 | To/Links page: segmented My Links / All Links, explainer steps, demo card with example shortcut rows |
| 2:30–2:40 | History click → permission panel ("See your browsing history in Toby… stays on this device") → Allow access; simultaneously Create To/Link modal (validation: Done disabled until URL filled) |
| 2:40–2:50 | History panel opens as a **second left column** (~400 px): date-grouped list with checkboxes; Create To/Link modal still open on top — panels compose instead of replacing |
| 2:50–3:05 | Next page with History panel still open: explainer + demo to-do card; clicking a row's circle checkbox completes it — row leaves the list, "In Progress" count 6 → 5, rows reflow up |
| 3:05–3:10 | Updates popover from sidebar footer: "You're all caught up." |
| 3:10–3:20 | Settings modal — Preferences: toggles (Dark Mode, Auto Theme, Colour Filters, side panel, auto-close tabs…), "Upgrade" pill on a paid feature, Free-plan usage bar "Tabs Saved 9 / 60" |
| 3:20–3:25 | Workspace Preferences: theme swatches (10 two-tone circles) — **hovering a theme live-re-tints the whole app behind the modal** (UI turns teal/brown); Import/Export; Delete Workspace danger zone. Then Privacy Policy pane inside the same modal |

---

## 2. Colour system (sampled)

| Role | Hex | Evidence |
|---|---|---|
| App canvas (board bg) | `#F3F2ED` / `#F5F4F0` | 45–53 % of every app frame — warm off-white, never pure white/grey |
| Sidebar / panel bg | `#F1EEE9` | one step darker/warmer than canvas |
| Card surface | `#FFFFFF`–`#FEFEFE` | cards are the only true whites → they "lift" off the warm canvas |
| Primary CTA (in-app) | `#C12860` (median `#C3366A` incl. anti-aliasing) | Start / Let's go / Close Tabs / New Collection buttons |
| Primary CTA (marketing site) | `#E63D76` | brighter, more saturated pink on gettoby.com |
| Logo pink | `#DE4176` | site logo mark |
| Pink wash / gradient | `#FCE6E9`, `#FAD3DB`, `#FDE4E8`, `#FCD7DE` | hero + auth backgrounds: soft pink wave gradient, bottom-weighted |
| Toggle ON | `#E43B74` | settings switches |
| Success green | `#59F39D` centre (bright mint) | check-circle in success cards and toast |
| Error red | muted red text (~`#D64545`) | login error line, delete icon, Log Out |
| Modal dim | warm grey ≈ `#7B7872` at ~50 % | settings overlay frame — dim is warm, not black |
| Text primary | near-black warm `#1F1B1B`-ish | headlines |
| Text secondary | warm grey `#8A8383`-ish | counts, domains, helper text |
| Theme system | 10 two-tone swatches (pink, blue, purple, teal, brown…) | one accent choice re-tints links, workspace icon, highlights app-wide |

Rules an expert reads from this:
- **One accent only.** Everything actionable is the same magenta family; green is reserved for success, red for destructive/error. No rainbow UI.
- **Warm neutrals.** Backgrounds are beige-warm, which makes white cards and the pink CTA feel soft instead of clinical.
- **Pink is a wash, not a fill.** Large areas get 5–15 % pink tints; full saturation is only for small CTA surfaces.

## 3. Typography

- Rounded geometric sans (Poppins-like): headlines bold, tight, sentence case — "All your resources. In one place.", "Your browser, under control.", "Welcome back!"
- Scale (at 1920 px wide): page title ≈ 26 px semibold; section/collection title ≈ 17 px semibold; card title ≈ 14 px medium; meta (counts, domains, times) ≈ 12 px grey; body/helper ≈ 14 px.
- Numbers are used as UI: "1 Collection · 5 tabs", "4 tabs", "In Progress: 6" — counts sit quietly next to titles in grey, never in badges competing with the accent.
- Empty-state headline semibold 16 px + one grey sentence that tells you the exact action to take.

## 4. Layout

- **3-column app shell:** left nav sidebar ≈ 230 px (`#F1EEE9`) · centre board (fluid, max content) · right "Open Tabs" rail ≈ 275 px. A 4th column (History ≈ 400 px) can dock between sidebar and board without breaking the shell.
- Board is a **white-ish rounded sheet** floating on the warm canvas with ~8 px outer margin and ~16 px radius — the whole app reads as one card.
- Collections stack vertically; inside each, cards flow in a responsive grid (up to 6 per row at 1920 px), card ≈ 215 × 95 px, gap ≈ 14 px, radius ≈ 12 px, shadow almost invisible (very soft, y-offset).
- Collection header row: title + chevron (collapse) left; count under title; icon actions right (open all, save, sort, bookmark, share, overflow) in light grey — visible but recessive.
- Toolbar row under space title: Custom order ▾ · Filter ▾ · View ▾ · zoom +/− left; primary "+ New Collection" right.
- Sidebar structure: workspace switcher (gradient initial tile + name) → Search pill with `/` shortcut hint → Next / To/Links / History → "Spaces" label + Starred / Personal (lock icon = private) / spaces with coloured initial tiles → Create Space → spacer → Trash / Updates (pink count dot) / Settings / profile (initial avatar + name).
- Selected nav item: light grey pill `#E7E2DC`-ish full-width radius 8; hover = same pill lighter.

## 5. Component specs

- **Buttons:** primary = magenta fill, white text, radius 8, padding ≈ 10×22, semibold 14. Secondary = white/transparent with magenta 1 px outline + magenta text. Disabled = light grey fill, grey text (Done in To/Link modal until URL is valid). Hover = fill darkens one step (seen on site CTA and Start).
- **Cards (tabs):** white, radius 12, favicon 16 px + title 2-line clamp; optional grey note line under title. Hover: bottom action bar fades in (bookmark, copy, …) + red trash at top-right — **actions are hidden until hover** (progressive disclosure keeps the grid calm).
- **Drag & drop:** dragged card becomes a slightly rotated, shadowed ghost following the cursor; empty collection shows a **dashed-border drop zone** with centred grey text "No tabs in this collection."
- **Open Tabs rail rows:** white pills radius 8, favicon + truncated title; header "This window", count, and 3 icon actions — the save-session icon is the one the onboarding highlights.
- **Modals:** centre white card radius ≈ 16, width ≈ 600 px (auth) / ≈ 860 px (settings, two-pane: 190 px cream nav + white content). Background = board **blurred + pink wave wash** for auth; warm-grey dim for settings.
- **Coachmark card (onboarding):** bottom-right floating white card ≈ 500 × 330, radius 16, soft shadow; top progress tracker = dots connected by a line (done = green check, current = magenta ring+dot, next = pale pink dot); title 22 px semibold; one grey sentence; single Continue button (grey until the step's action is done, then magenta).
- **Success card:** same coachmark shell, big green check circle (≈ 56 px) on top, celebratory title ("Nice! Your tab is saved." / "Your first session is saved!" / "Your session is open!").
- **Toast:** top-centre white pill, green check icon, message, text action ("Show"); slides down, auto-dismisses after a few seconds.
- **Dropdowns:** white menu radius 12, shadow, items 14 px with 16 px left icons; opens under the trigger with a quick fade/scale.
- **Segmented control:** grey track pill, active segment white pill with shadow (My Links / All Links).
- **Toggles:** ≈ 36 × 20 pill, white knob; ON = `#E43B74`, OFF = dark grey.
- **Inputs:** radius 8, 1 px light border; focus = magenta border + soft pink outer glow (email/password fields); labels 13 px semibold above; error = red 13 px line centred under fields.
- **Empty states:** centred outline icon (star, layers) ≈ 32 px grey, semibold headline, one grey instructional sentence — never a dead end, always teaches the gesture.
- **Explainer pages (Next, To/Links):** same recipe — title, one-line value prop, numbered 3 steps with bolded key actions, then a **live-looking demo card** (grey `#ECE9E4` container, radius 16) showing fake data, then "Learn more" outline button.

## 6. Animation & motion system (from frame-sequence analysis)

Scene detection across the whole video finds almost **no hard cuts inside the app** — Toby's motion language is soft:

1. **Cross-fades everywhere.** Screen changes, coachmark steps and modal content swaps are opacity fades (~200–300 ms). The success card's exit was captured mid-fade at ~50 % opacity (1:00) — fade-out, no slide.
2. **Confetti celebration (signature move).** On Save Session, ~100+ small pink rectangles burst across the top of the board and rain down, thinning out over ≈ 2–3 s. Used only for a "first" achievement — not for routine saves.
3. **Floating ambient cards (auth).** Behind the login modal, 4–5 mini tab-cards drift slowly across the screen at 20–40° rotations, entering/exiting at the edges on a long loop (positions differ in every 1 fps frame over 20 s). Motion is slow and physics-light — decoration, never competing with the form.
4. **Spotlight coachmarks.** During onboarding the board dims to ~60 % and only the target element stays bright; hand-drawn magenta arrows + handwritten-style labels ("Drag a tab", "Save session", "Open one" / "Open all") point at the exact control. The arrow/label style is deliberately sketchy vs the clean UI — it reads as a human annotating your screen.
5. **Blur-behind modals.** Auth modal sits over a blurred, desaturated board + pink gradient wave that sweeps the bottom half — depth cue: the app is still "there" under glass.
6. **List reflow.** Completing a Next item: row disappears, remaining rows glide up to close the gap, counter decrements — no page reload feel.
7. **Panel docking.** History slides in as an extra column; the board narrows instead of being covered (except modals, which overlay).
8. **Hover micro-states.** Card action bar fades in on hover; buttons darken on hover; cursor becomes a hand/grab on draggable items; sidebar profile row highlights.
9. **Progress-line animation.** Onboarding tracker line fills green up to the completed step, current node pulses as a magenta ring.
10. **Live theme preview.** Hovering a theme swatch in Workspace Preferences immediately re-tints the app behind the modal — try-before-you-apply.
11. **Toast timing.** Delete toast appears instantly at top centre and self-dismisses in ≈ 4–5 s (present at 1:40, gone by 1:50 frame).

Motion budget an expert would copy: fades 200–300 ms, panel slides ~300 ms ease-out, celebrations ≤ 3 s and only for milestones, ambient loops ≥ 15 s and very slow.

## 7. UX patterns worth stealing

- **Teach by doing, in the real UI.** Onboarding isn't a carousel — each step requires the real gesture (drag, save session, open) and celebrates it. 3 steps, each < 15 s.
- **One primary action per surface.** Every screen has exactly one magenta button.
- **Forgiving by default.** Delete → toast with undo; saved tab → "Keep open or close?" choice asked once, with a pointer to where the setting lives.
- **Permission with a reason + privacy promise** before asking (History panel explains *local only, never sent to Toby* before the Allow button).
- **Demo data as documentation.** Next/To/Links pages show realistic fake content inside a framed mock — users learn the shape of success before creating anything.
- **Freemium without nagging.** Usage meter ("9 / 60") lives quietly in Settings; the only upsell is a small "Upgrade" pill beside the one locked feature.

---

## 8. Mapping to NoManShow (JOMNITTAKU Arena) — upgrade spec

NoManShow today: dark arena theme, live tables, XP, telemetry. Toby's lesson is **not** "go pink" — it's the system underneath: warm calm surfaces, one accent, hidden-until-hover actions, coachmarks, and milestone celebrations. Translation:

| Toby pattern | NoManShow equivalent | Concrete spec to apply |
|---|---|---|
| Spaces (sidebar) | Venues / arenas | Left (desktop/TV) or top (mobile) venue switcher with coloured initial tiles; lock icon → "Members only" tables |
| Collections | Match groups / table groups ("Tonight's matches", "League A") | Section header: title + count in grey ("6 tables · 2 live"), collapsible chevron, icon actions recessive right |
| Tab cards | **Table cards** | White/raised card, radius 12, status favicon-equivalent = coloured dot (Free = green, Live = magenta/red pulse, Reserved = amber); title = Table #, second line = players/score; hover/tap reveals actions (Join, Spectate, Reserve) — hidden until interaction |
| Open Tabs rail | **Live Tables rail** | Right rail (TV/desktop) / bottom sheet (mobile): "This venue — 6 Free", one-tap "Join table" = Toby's Save Session moment |
| Save Session (1 click) | "Book all / Save my night" | One primary button saves the whole current setup (table + rivals + XP session) |
| Confetti burst | **Win / XP level-up celebration** | Confetti in brand accent on match win & level-up only, ≤ 3 s, ~100 particles, then success card with green check equivalent |
| Coachmark onboarding | First-visit arena tour | 3 steps max: 1) Pick a table (spotlight + arrow), 2) Challenge a rival, 3) Track XP. Progress dots+line, Continue disabled until the real tap happens |
| Spotlight dim + sketch arrows | Tutorial overlays | Dim arena to 60 %, keep target at full brightness, hand-drawn style arrow in accent |
| Success card (bottom-right) | Post-match summary card | Slides/fades in: result, XP gained, two choices (Rematch = primary, Leave = outline) — mirrors Keep Open / Close Tabs |
| Toast with undo | Cancel reservation / leave table | Top-centre pill, icon + message + Undo, auto-dismiss ~4 s |
| Empty states | No live matches | Centred outline icon + "No live matches right now" + action sentence ("Tables open at 5 PM — reserve ahead") with the action as the one accent button |
| Explainer + demo card | How-it-works / Telemetry intro | Value line, 3 numbered steps, framed demo card with sample telemetry before real data |
| Warm canvas + white cards | Arena surfaces | Keep NoManShow dark identity but borrow the *structure*: one step between page bg, panel bg, and card bg; cards are the lightest surface; single accent (arena magenta/red) reserved for Live + primary CTA |
| Toggles & settings modal | Player preferences | Two-pane settings (mobile: full-screen list → detail), toggles in accent when ON, usage/stat meter quiet at the bottom (XP progress = "Tabs Saved 9/60" pattern) |
| Theme swatches | Arena themes | Two-tone circle swatches with **live preview** behind the settings sheet |
| Focus glow on inputs | Login / booking forms | Accent border + soft outer glow on focus; single red error line under the form, not per-field popups |
| Floating ambient cards (auth) | Login screen | Slow-drifting mini table/match cards behind the login card — reuse the arena's own content as decoration |
| Counts next to titles | Everywhere | "3 DAMANSARA · 6 of 10 Free" style meta in grey beside headings — information without badges |

### Flutter implementation tokens (ready to drop in)
- Radius: cards 12, modals 16, pills full, buttons 8.
- Motion: fade 250 ms (`Curves.easeOut`), panel slide 300 ms easeOut, list reflow 250 ms, celebration confetti 2.5 s one-shot, ambient float loop 18 s easeInOut alternate.
- Elevation: one soft shadow only — `rgba(0,0,0,0.06), y=4, blur=16` on cards; modals `rgba(0,0,0,0.12), y=12, blur=32`.
- Accent discipline: 1 primary colour, success green, error red, everything else = 3-step neutral ramp (bg / panel / card).
- Spacing: 8-pt grid; card grid gap 14; section gap 28; page padding 24 (TV 40).

---

## 9. What the video did NOT show (gaps for a future recording)
- Search (`/`), Next drag-reordering, Create Space / Create Collection dialogs, View/Filter menu contents, Dark Mode, mobile app views, TV view. One more 2-minute recording of just those would complete the spec.

*Inspection completed 2026-11-19. Frames + montages kept in `~/workspace/toby-inspection/` (frames5/, anim/).*
