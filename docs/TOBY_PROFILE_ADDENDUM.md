# Toby Spec Addendum — Profile / Settings Section

Source: user screenshot of Toby's Profile pane (Settings modal), 2026-11-19.
Colours below are pixel-sampled from the screenshot, same method as the main spec.
Companion to `TOBY_UI_SPEC_FOR_NOMANSHOW.md` (which covered the Settings modal's
Preferences + Workspace panes from the recording; this is the Profile pane).

## What the screenshot shows
Settings modal, Profile pane selected. Two-pane shell:
- **Left rail (~225 px):** grouped nav — *Account* (Profile, Preferences) →
  *workspace group* (Members, Preferences, Tags, Subscription) → *About*
  (FAQ, Shortcuts, Feedback, Terms of Service, Privacy Policy).
  Footer of the rail: plan meter → version → Log Out.
- **Content pane:** white card, H1 "Nahid's Profile", close × top-right.

## Colour system (sampled)
| Role | Hex | Notes |
|---|---|---|
| Rail background (this theme) | `#F5E9D9` | Warm sand/cream — a *theme tint*, see below |
| Selected nav pill | `#E1D6C7` | One tonal step darker than the rail — NOT the accent colour |
| Content surface | `#FFFFFF` | Content is always pure white |
| Security banner / avatar fill | `#B5CDF2` | Same soft periwinkle for info banner and avatar placeholder |
| Link blue | `#2B8DD3` | "Send Email", "Change", "Change Avatar" |
| Danger red | `#E03E3E` | Delete Account (outline button) and Log Out (text) |
| Heading text | `#1E1E26` | Near-black, slight blue cast |
| Body / label grey | `#5E5E5E` | Labels, explanations, rail group headers are lighter still |
| Plan meter fill / track | `#B8C9E0` / `#FBF7F2` | Muted blue-grey fill on near-white track |
| Backdrop dim | ≈ `#7F7F80` at ~50 % | Warm grey, never black |

**Theme law confirmed:** Toby themes tint the *chrome* (rail, selected pill,
meter) — the recording's default rail was `#F1EEE9`, this screenshot's theme is
sand `#F5E9D9` — while the content surface never changes from white. Accent
stays a single hue family (here: soft blues) plus the one danger red.

## UI/UX patterns worth stealing
1. **Tonal selection, not accent selection.** The active nav item is a filled
   pill one shade deeper than its own background. Zero accent colour spent on
   navigation state.
2. **Plan meter lives in the rail footer** — "Free plan · Tabs Saved 9 / 60"
   with a thin quiet progress bar. Always visible inside settings, never a
   banner, never nagging. Version number sits under it, muted.
3. **Security nudge as a soft banner** — light blue wash, one sentence,
   action link right-aligned ("Send Email"). Informational tone, not an alarm.
4. **Display + Change, not inline edit, for sensitive fields.** Email and
   password render as read-only values (password as dots) with a "Change"
   link — changing them is a deliberate flow. Only low-risk fields (first /
   last name) are directly editable inputs.
5. **Identity header:** 56 px avatar circle (soft fill + simple outline icon),
   name semibold 16, email grey 13 beneath, "Change Avatar" link right.
6. **Danger zone is calm:** bottom of the pane, separated by whitespace,
   explanation text left ("This action is irreversible…"), **outlined** red
   button right — white fill, red border + text. Present, honest, not shouting.
7. **Log Out in the rail footer, in danger red text** — account exit lives
   with account settings, not in the main app chrome.
8. **Form rhythm:** label above field (13 px grey), white inputs, light grey
   border, radius ≈ 8, two-column for first/last name, ~24 px group spacing.
   No cards inside cards; the only filled surfaces are banner, avatar, pill.

## Mapping to NoManShow (Phase 5 → Phase 6 upgrade)
- Our Profile already has Preferences + Sign Out (Phase 5). Toby's pattern
  upgrades it to a **grouped settings structure**: Account (Profile, Pass &
  Payment) → Arena (Notifications, Privacy/PDPA) → About (FAQ, Terms, Privacy).
- **XP/membership meter in a footer zone** — "Member · Renews 1 Dec · 6 of 10
  tables free" with a thin quiet bar, replacing louder promo cards.
- **Display + Change** for phone/email on the member profile; name editable.
- **Danger zone, outlined:** "Delete account" (front-end only) at the bottom,
  Delete/S sign-out in the settings footer area in crimson text.
- **Tonal selection** for any settings nav: one step deeper than the surface,
  never the emerald. Emerald stays for primary actions only.
- **Theme law for Arena DS:** tint chrome (nav pill, headers) with the
  emerald-tinted slate; content cards keep the one recipe.
