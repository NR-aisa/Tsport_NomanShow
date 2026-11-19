import 'package:flutter/material.dart';

/// Arena DS — Windows 11 Fluent radius scale (crisp, flat, de-boxed).
/// Replaces hyper-round 28px bubble capsules with disciplined 4–12px corners.
class AppRadius {
  AppRadius._();

  /// Chips, badges, micro indicators.
  static const double sm = 4;

  /// Buttons, inputs, tiles.
  static const double md = 8;

  /// Secondary cards, headers.
  static const double lg = 10;

  /// Primary card recipe radius (clean modern squircle, never bubble).
  static const double card = 12;

  /// Modals, sheets, outer containers.
  static const double xl = 14;

  static const Radius rSm = Radius.circular(sm);
  static const Radius rMd = Radius.circular(md);
  static const Radius rLg = Radius.circular(lg);
  static const Radius rCard = Radius.circular(card);
  static const Radius rXl = Radius.circular(xl);

  static const BorderRadius brSm = BorderRadius.all(rSm);
  static const BorderRadius brMd = BorderRadius.all(rMd);
  static const BorderRadius brLg = BorderRadius.all(rLg);
  static const BorderRadius brCard = BorderRadius.all(rCard);
  static const BorderRadius brXl = BorderRadius.all(rXl);
}

class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

/// Motion language (Toby rule): fades for changes, celebration only for
/// milestones, nothing moves without meaning.
class AppMotion {
  AppMotion._();

  /// Screen & card fades — 250 ms easeOut.
  static const Duration fade = Duration(milliseconds: 250);
  static const Curve fadeCurve = Curves.easeOut;

  /// Panels and sheets — 300 ms easeOut.
  static const Duration panel = Duration(milliseconds: 300);
  static const Curve panelCurve = Curves.easeOut;

  /// List reflow.
  static const Duration reflow = Duration(milliseconds: 250);

  /// Entrance stagger per card.
  static const Duration staggerStep = Duration(milliseconds: 40);

  /// Celebration ceiling — milestones only.
  static const Duration celebration = Duration(seconds: 3);

  /// Ambient loops (auth / hero only) are slow.
  static const Duration ambient = Duration(seconds: 15);
}
