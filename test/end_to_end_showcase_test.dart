import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tsports_nomansho/core/theme/app_theme.dart';
import 'package:tsports_nomansho/core/theme/app_theme_controller.dart';
import 'package:tsports_nomansho/core/navigation/app_navigator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

  Widget wrapWithTheme(Widget child, bool isDark) {
    AppThemeController.setDarkMode(isDark);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: child,
    );
  }

  group('End-to-End Showcase Suite — All 17 Screens in Dark & Light Modes', () {
    for (final screenMeta in AppNavigator.screens) {
      testWidgets('Screen [${screenMeta.id}] "${screenMeta.title}" renders in DARK MODE without overflow',
          (WidgetTester tester) async {
        tester.view.physicalSize = const Size(414, 896);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        FlutterError.onError = (details) {
          debugPrint('>>> FULL ERROR:\n${details.toDiagnosticsNode().toStringDeep()}');
        };

        await tester.pumpWidget(wrapWithTheme(screenMeta.builder(), true));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 150));

        final dynamic exception = tester.takeException();
        if (exception is FlutterError) {
          debugPrint(exception.toStringDeep());
        }
        expect(exception, isNull, reason: 'Zero render or overflow exceptions in screen ${screenMeta.id}');
        expect(find.byType(Scaffold), findsWidgets);
      });

      testWidgets('Screen [${screenMeta.id}] "${screenMeta.title}" renders in LIGHT MODE without overflow',
          (WidgetTester tester) async {
        tester.view.physicalSize = const Size(414, 896);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(wrapWithTheme(screenMeta.builder(), false));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 150));

        final exception = tester.takeException();
        if (exception != null) {
          debugPrint('>>> ERROR ON SCREEN [${screenMeta.id}] LIGHT: $exception');
        }
        expect(exception, isNull, reason: 'Zero render or overflow exceptions in screen ${screenMeta.id}');
        expect(find.byType(Scaffold), findsWidgets);
      });
    }

    testWidgets('55" Venue TV Arena Broadcast view renders in 1920x1080 and Mobile 375x812',
        (WidgetTester tester) async {
      final tvScreen = AppNavigator.screens.firstWhere((s) => s.id == 'display');

      // Test Landscape 1920x1080 (Stadium TV)
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(wrapWithTheme(tvScreen.builder(), true));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150));
      final ex1 = tester.takeException();
      if (ex1 != null) debugPrint('>>> TV 1920x1080 ERROR: $ex1');
      expect(ex1, isNull);

      // Test Mobile Portrait 375x812 (Responsive Mobile TV inspect)
      tester.view.physicalSize = const Size(375, 812);
      await tester.pumpWidget(wrapWithTheme(tvScreen.builder(), true));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150));
      final ex2 = tester.takeException();
      if (ex2 != null) debugPrint('>>> TV 375x812 ERROR: $ex2');
      expect(ex2, isNull);

      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets('Live Theme Controller dynamically toggles from Dark to Light and repaints cleanly',
        (WidgetTester tester) async {
      AppThemeController.setDarkMode(true);
      expect(AppThemeController.isDark, isTrue);

      final splashMeta = AppNavigator.screens.firstWhere((s) => s.id == 'splash');
      await tester.pumpWidget(wrapWithTheme(splashMeta.builder(), true));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150));

      // Toggle theme live
      AppThemeController.toggleTheme();
      expect(AppThemeController.isDark, isFalse);

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150));
      final ex = tester.takeException();
      if (ex != null) debugPrint('>>> THEME TOGGLE ERROR: $ex');
      expect(ex, isNull);
    });
  });
}
