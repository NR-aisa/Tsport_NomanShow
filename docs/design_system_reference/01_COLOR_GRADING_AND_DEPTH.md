# 🎨 01. Color Grading, Surface Depth & Illumination

## 1. The Core Philosophy: "Two Shades Only" Per Accent

In Dr. Arefin (`01-design-system.md`), a fundamental rule prevents visual chaos:
> *"The entire system uses only two greens. Never introduce additional green hues. All other green-named tokens are aliases that resolve to one of the two."*

| Role | Dr. Arefin Token | Value | Purpose |
| :--- | :--- | :--- | :--- |
| **Resting State** | `--primary-bright` | `#14bb3e` | Buttons, kickers, numerals, badges at rest |
| **Active / Hover** | `--primary-darker` | `#079a14` | Mouse hover, pressed states, focused borders |

### 🏸 Analogy for JOMNITTAKU ("No Man Show")
Instead of randomly using different pinks, reds, and neon purples across buttons and cards:
1. **Primary Conversion Accent (Coral Rose)**:
   - **Resting**: `#FF4B72` (Punchy, energetic Coral)
   - **Active / Pressed**: `#E03258` (Deeper rich crimson on hover/press)
2. **Telemetry & Live Status Accent (Volt Emerald)**:
   - **Resting**: `#10B981` (Crisp tournament green for "Open", "Free", "60 FPS")
   - **Active / Pulse**: `#059669` (Darker emerald on interaction)
3. **Forbidden**: Fuzzy gradients between neon blue and hot pink that muddy the typography.

---

## 2. Canvas & Surface Elevation Ladder

Dr. Arefin constructs depth using a 3-tier deep navy ladder rather than flat black:

```
[ Canvas Deepest ] #061314 (Footer, deep background)
       ▲
[ Canvas Base ]    #111A28 (Main dark sections)
       ▲
[ Elevated Hero ]  #1C2A3C (Hero and focused cards)
```

### 🏸 Analogy for JOMNITTAKU
Table tennis arenas at midnight require a **Deep Obsidian Stadium Ladder**:
```
Level 0: #080A10 — Base Canvas (Infinite stadium darkness)
Level 1: #0F121C — Elevated Section Base (Navbar, hero canvas)
Level 2: #161A28 — Interactive Card Base (Court cards, live match hud)
Level 3: #20263A — Active Surface / Pressed state
```

---

## 3. Translucent "Frosted Glass" Islands vs. Opaque Cuts

### The Anti-Pattern:
Wrapping a section in a solid opaque `#161926` background with `border-top` and `border-bottom` creates a **"Band-Aid Cut"** that harshly slices across ambient background curves.

### Dr. Arefin's Solution:
```css
/* Translucent Glass Island */
background: rgba(255, 255, 255, 0.04);
border: 1px solid rgba(255, 255, 255, 0.08);
border-radius: 24px; /* rounded-3xl */
backdrop-filter: blur(12px);
```
- The ambient background gradients and subtle stadium spotlights **pass through the container seamlessly**.
- The card feels elevated and lightweight rather than a heavy rectangular block.
