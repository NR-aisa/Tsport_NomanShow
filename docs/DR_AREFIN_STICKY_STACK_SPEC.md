# Dr. Arefin & KITA Sticky-Stack Animation Specification & GPU Acceleration Guide

> **Source Reference:** `C:\Users\naimu\Desktop\DrArefinProject\Dr-Arefin-Spec\components\sticky-stack-section.md`  
> **Target Project:** JOMNITTAKU (Tsport_NomanShow)  
> **Section Scope:** `.kit-stack` / `.sss-stack` (Interactive 4-Card Overlapping Stacking Deck)

---

## 1. Architectural Origin & The 4 Sequential Scroll States

From inspecting the Dr. Arefin project canonical spec (`sticky-stack-section.md`) and KITA (`kita.edu.au`), the sticky stacking animation operates across 4 distinct physical states:

### State 1: Initial Entry (Unscrolled)
- **Positioning:** Card 1 reaches `FIRST_STICKY_TOP = 80px` (or `90px` in Dr. Arefin spec) clearing the fixed glass navbar, and pins into sticky placement.
- **Successor Cards:** Card 2 sits naturally below Card 1 in standard document flow. There is zero initial overlap.

### State 2: Mid-Scroll Slide-Over
- **Kinematics:** As the user continues scrolling naturally, Card 1 stays locked at `top: 80px`.
- **Slide-Over:** Card 2 travels upward with natural page momentum and **glides directly over Card 1** because Card 2 has a higher z-index (`z-index: 2`).
- **Tactile Elevation:** Card 2's negative-spread ambient drop-shadow (`box-shadow: 0 8px 32px -8px rgba(0,0,0,0.55)`) casts a realistic 3D contact shadow onto the surface of Card 1 beneath it. Card 2 has *not* pinned yet—it is in smooth motion.

### State 3: Fanned Deck Stack (Locked Multi-Color Rim)
- **Progressive Stagger:** Card 2 reaches `top: 80px + 1 * 24px = 104px` and pins there.
- Card 3 travels up and pins at `top: 80px + 2 * 24px = 128px`.
- Card 4 travels up and pins at `top: 80px + 3 * 24px = 152px`.
- **Fanned Deck Look:** All 4 cards now rest stacked concurrently in view. The top `24px` tab of every card remains exposed, displaying the color spectrum (`#131726` Indigo ➔ `#1E190E` Amber ➔ `#0C1B2B` Oceanic Navy ➔ `#241217` Cyber Coral).

### State 4: Complete Exit
- Once all cards are stacked, continuing to scroll past the container moves the **entire stacked deck together upward and out of view**, continuing seamlessly to the next section (*10 ITTF Courts Live Radar Map*).

---

## 2. Forensic Diagnosis: Why the Previous Flutter Web Implementation Lagged

1. **Synchronous Render Tree Invalidation (`localToGlobal`):**  
   Calling `findRenderObject()?.localToGlobal()` inside an active scroll listener forces the browser engine and Flutter layout engine to compute synchronous matrix projections on every single pixel tick (60Hz–120Hz).
2. **Missing `RepaintBoundary`:**  
   Without layer isolation, sliding Card 2 over Card 1 forced Flutter to continuously repaint and rasterize all 4 complex cards, including background gradients, typography, and high-resolution images, overloading the CPU.
3. **Scroll Hijacking:**  
   Simulating `position: sticky` inside an artificially tall container using manual layout offsets fought against the browser's native momentum scrolling engine.

---

## 3. The GPU-Accelerated Engineering Fix

1. **Hardware Layer Isolation via `RepaintBoundary`:**  
   Wrap each card in a `RepaintBoundary`. This instructs the Flutter CanvasKit/Skia GPU compositor to keep each card pre-rendered as a cached GPU texture. When cards overlap, the GPU simply composites pre-rendered textures with zero CPU re-rasterization.
2. **$O(1)$ Pure Math Scroll Progression:**  
   Eliminate all synchronous `findRenderObject()?.localToGlobal()` calls. Compute the deck's progress using a cached initial section offset and the `ScrollController.offset` directly.
3. **Dr. Arefin Canonical Constants:**
   - `FIRST_STICKY_TOP = 80.0`
   - `CARD_OFFSET = 24.0`
   - `TRAVEL_PER_CARD = 320.0`
   - `ELEVATION_SHADOW = BoxShadow(color: Colors.black.withOpacity(0.55), blurRadius: 32, spreadRadius: -8, offset: Offset(0, 10))`
