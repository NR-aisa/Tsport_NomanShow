# 🎴 03. Card Architecture, Grid Precision & Hover Stability

## 1. The "Gap-px" Razor Border Technique

In traditional web development, developers place `border: 1px solid gray` on every card. When cards are placed next to each other, borders either double up to 2px, or borders must be selectively turned off (`border-r-0`), leading to fragile CSS.

### Dr. Arefin's Elegant Architectural Pattern:
```tsx
<div 
  className="grid grid-cols-2 lg:grid-cols-4 gap-px rounded-2xl overflow-hidden"
  style={{ background: "hsl(var(--border))" }} /* e.g. rgba(255,255,255,0.08) */
>
  <div className="bg-card p-6">Cell 1</div>
  <div className="bg-card p-6">Cell 2</div>
  <div className="bg-card p-6">Cell 3</div>
  <div className="bg-card p-6">Cell 4</div>
</div>
```

### Why It's Superior:
- The outer container has `rounded-2xl` and `overflow-hidden`.
- The background of the container shines through the 1px `gap-px` between grid items.
- Every single horizontal and vertical divider is **mathematically guaranteed to be exactly 1px**, perfectly aligned with zero border-clipping or border-doubling.

### 🏸 Analogy for JOMNITTAKU ("No Man Show")
In Flutter, we implement this by nesting a `Container` with a 1px border or `Wrap` with subtle `BorderSide` dividers, guaranteeing that the 5 stats items (`24/7`, `10 Courts`, `0.3s Gate`, `RM0.90/day`, `60 FPS AI`) maintain razor-sharp separation without clipping.

---

## 2. The "No-Shift" Hover Stability Contract (`07-inherited-patterns.md`)

In Dr. Arefin's design system:
> **Hard Rule:** ❌ `translateY` or `translateX` on hover is **STRICTLY FORBIDDEN**.

### Why Moving Cards on Hover is an Anti-Pattern:
1. **Layout Jitter**: Shifting cards upward can cause neighboring elements to reflow or jitter.
2. **Touch Screen Confusion**: On tablets and mobile touchscreens, hover-lifts cause sticky transform bugs where cards get stuck in the air.
3. **Subpixel Blur**: GPU translation often blurs text during the CSS transform matrix animation.

### Allowed Hover Behaviors:
| Element | Permitted Reaction |
| :--- | :--- |
| **Card Border** | Transition from `rgba(255,255,255,0.08)` → `rgba(255,75,114,0.4)` (Accent tint) |
| **Card Shadow** | **Zero-blur directional shadow**: `box-shadow: 0 4px 0 0 rgba(255, 75, 114, 0.35)` |
| **Buttons / CTA** | `filter: brightness(1.12)` |
| **Image Thumbnail** | Subtle zoom (`transform: scale(1.025)`) inside an `overflow: hidden` mask (card container stays completely still) |

---

## 3. Specular Rim Lighting

In luxury dark UI, cards do not use fuzzy blur shadows to separate from the background. They use **Specular Rim Borders**:
```dart
BoxDecoration(
  color: const Color(0xFF161A28),
  borderRadius: BorderRadius.circular(16),
  border: Border.all(
    color: Colors.white.withValues(alpha: 0.08), // 8% white specular rim
    width: 1,
  ),
)
```
This gives cards an etched, precision-milled physical appearance like high-end electronic hardware or luxury watches.
