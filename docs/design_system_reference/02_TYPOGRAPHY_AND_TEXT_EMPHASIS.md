# ✍️ 02. Typography Hierarchy & Text Emphasis Strategy

## 1. The 3-Tier Metric & Section Hierarchy

In Dr. Arefin (`MetricsV04LightC.tsx` & `HeroSection.tsx`), text hierarchy is never arbitrary. It follows a mathematically balanced 3-tier vertical stack:

```
┌────────────────────────────────────────────────────────┐
│ 1. KICKER TAG:    BY THE NUMBERS · SURGICAL EXCELLENCE │
│    - 10px / 11px uppercase                             │
│    - tracking-widest (letter-spacing: 0.15em - 0.25em)  │
│    - Accent color (Primary Green)                      │
│                                                        │
│ 2. HERO HEADLINE / NUMERAL: 800+ · 10,000+             │
│    - Fluid clamp font size (H1/H2)                     │
│    - Heavy bold weight (700 / 900)                     │
│    - Tight leading (line-height: 1.05 - 1.15)          │
│                                                        │
│ 3. DESCRIPTIVE LEDE / LABEL:                           │
│    - 13px - 15px                                       │
│    - Muted secondary tone (Slate / Muted Gray)         │
│    - Relaxed line-height (1.6 - 1.75) for effortless   │
│      reading                                           │
└────────────────────────────────────────────────────────┘
```

### 🏸 Analogy for JOMNITTAKU ("No Man Show")
This structure fixes the **Zigzag stats ticker bug**:
```dart
// Stat Cell Example:
Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Text('UNMANNED SPEED', style: TextStyle(fontSize: 10, letterSpacing: 1.2, color: voltEmerald, fontWeight: FontWeight.w900)),
    const SizedBox(height: 6),
    Text('0.3 SEC', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white)),
    const SizedBox(height: 4),
    Text('Fastest turnstile in KL', style: TextStyle(fontSize: 12, color: mutedText)),
  ],
)
```

---

## 2. In-Text Bold & Color Emphasis (The "Hook" Technique)

Dr. Arefin never dumps long blocks of plain text. Instead, body paragraphs use a selective bolding strategy that allows scanning eyes to capture the value proposition in 2 seconds:

```html
<!-- Example from Dr. Arefin: -->
After being diagnosed with <strong>end-stage liver disease</strong>, the patient 
received <strong>expert surgical care</strong>. Today, they lead a 
<strong>healthy, active life</strong> — a true testament to <strong>precision surgery</strong>.
```

### 🏸 Analogy for JOMNITTAKU
In the hero and bento grid descriptions, bold key power words:
> *"Smashes at **3 AM**! Zero receptionists, **no queues**, and **10 ITTF Olympic tables**. Scan your dynamic QR, step through the **0.3s turnstile**, and let the **Edge AI cameras** track your smash velocity in real-time."*

---

## 3. Pure Numerals Styling

Numbers (e.g. `24/7`, `0.3s`, `RM17`, `60 FPS`) must receive special typographic treatment:
1. **Never insert loose spaces around slashes**: Write `24/7`, not `24 / 7`.
2. **Tabular Figures**: Ensure numerals have consistent proportional or monospaced widths to prevent shifting when counters tick.
3. **High-Contrast Value vs. Unit**:
   - The number (`17` or `0.3`) is bold 28px white.
   - The unit (`RM` or `sec`) is slightly smaller (16px) or subtly tinted with the accent color.
