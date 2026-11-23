# 🏛️ 04. Presentation Analogy & Layout Rhythm

## 1. The Signature Dual-State CTA Capsule

### In Dr. Arefin:
The header features a signature component: `CallBookPill`.
```
┌──────────────────────────────────────────────────┐
│  [  📞 Call  ]       Or       [  📅 Book  ]     │
└──────────────────────────────────────────────────┘
```
- Floating pill container (`rounded-full`, subtle border).
- Left: Direct call (`tel:` link, white background, dark text).
- Center: Tiny "Or" separator in muted text.
- Right: Primary conversion (`/contact/`, bright green background, white text).

### 🏸 Analogy for JOMNITTAKU ("No Man Show")
Instead of cluttering the top right with multiple disconnected buttons, unify the core user journeys into one **Dual-State Action Capsule**:
```
┌────────────────────────────────────────────────────────┐
│  [  ⚡ Walk-In Pass (RM17)  ]   •   [  🌐 Arena Hub →  ]│
└────────────────────────────────────────────────────────┘
```
- **Left (New User / Quick Play)**: Generates an instant turnstile QR code for walk-in players.
- **Right (Regular / Command Center)**: Opens the real-time live stadium dashboard & court radar.

---

## 2. Asymmetric Storytelling & Bento Rhythms

In Dr. Arefin (`MetricsV04LightC.tsx` & `DrArefinHomeDark.tsx`), pages do not alternate between boring centered text blocks. They use **Asymmetric 5:7 Rhythms**:

```
Desktop (1248px Max Container):
┌───────────────────────────────┬──────────────────────────────────────────────┐
│  LEFT (5 Columns - 42%):      │  RIGHT (7 Columns - 58%):                    │
│                               │                                              │
│  [ KICKER: BY THE NUMBERS ]   │  ┌────────────────────┬────────────────────┐ │
│  Headline:                    │  │ 24/7 VENUE         │ 10 COURTS          │ │
│  "Midnight Smashes.           │  │ Always Unlocked    │ ITTF Olympic Spec  │ │
│   Zero Staff."                │  ├────────────────────┼────────────────────┤ │
│                               │  │ 0.3s GATE          │ RM0.90 / DAY       │ │
│  Value Pitch paragraph        │  │ QR Turnstile Entry │ Unlimited Passes   │ │
│                               │  └────────────────────┴────────────────────┘ │
└───────────────────────────────┴──────────────────────────────────────────────┘
```

### Why This Rhythm Works:
1. **Left side grounds the narrative**: Gives the user the "Why" (story, headline, proof).
2. **Right side delivers hard data**: Gives the user the "What" (metrics, numbers, proof).
3. **Mobile collapse**: On screens `< 900px`, the layout seamlessly stacks with the headline first, followed by a balanced 2-column or single-column card grid.

---

## 3. Micro-Interaction Rhythms: Staggered Fade-Up (`Reveal`)

In Dr. Arefin, content mounts using a staggered entrance sequence:
- Kicker: `delay: 0ms`
- Headline: `delay: 80ms`
- Subtitle: `delay: 140ms`
- CTA Capsule: `delay: 200ms`

This creates a high-end, orchestrated feeling as the page loads, establishing confidence before the user clicks a single button.
