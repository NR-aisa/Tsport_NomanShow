import 'package:flutter/foundation.dart';

/// Central controller for responsive viewport presentation modes.
///
/// Modes:
///  0 = Mobile (440px framed view)
///  1 = Tablet / iPad (820px framed view)
///  2 = Desktop Web (Full bleed broadcast website experience)
///  3 = 55" Stadium TV (1440px stadium display)
class ViewportController {
  ViewportController._();

  static final ValueNotifier<int> mode = ValueNotifier<int>(2);

  static bool get isMobile => mode.value == 0;
  static bool get isTab => mode.value == 1;
  static bool get isWeb => mode.value == 2;
  static bool get isTv => mode.value == 3;

  static void setMode(int newMode) {
    if (mode.value != newMode) {
      mode.value = newMode;
    }
  }
}
