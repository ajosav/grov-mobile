import 'dart:typed_data';

import 'package:app_mobile/core/theme/app_performance.dart';
import 'package:app_mobile/core/theme/app_theme.dart';
import 'package:app_mobile/core/widgets/glass_card.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// A rendered frame we can read pixels from.
class _Frame(final ByteData bytes, final int width) {
  /// Red channel at logical pixel (x, y) (DPR 1).
  int r(int x, int y) => bytes.getUint8((y * width + x) * 4);
}

// The card is 200x100, centred in a 400x300 white field: x 100..300, y 100..200.
Future<_Frame> _render(
  WidgetTester tester, {
  ThemeData? theme,
  bool lowEnd = false,
  bool blur = false,
  bool highContrast = false,
}) async {
  final key = GlobalKey();
  tester.view
    ..physicalSize = const Size(400, 300)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(
        size: const Size(400, 300),
        highContrast: highContrast,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme ?? AppTheme.dark(),
        home: AppPerformanceScope(
          performance: AppPerformance(lowEnd: lowEnd),
          child: RepaintBoundary(
            key: key,
            // White behind the card, so any shadow shows as a drop in red.
            child: ColoredBox(
              color: const Color(0xFFFFFFFF),
              child: Center(
                child: GlassCard(
                  blur: blur,
                  padding: EdgeInsets.zero,
                  child: const SizedBox(width: 200, height: 100),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  late _Frame frame;
  await tester.runAsync(() async {
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final data = await image.toByteData();
    frame = _Frame(data!, image.width);
  });
  return frame;
}

void main() {
  group('shadows', () {
    testWidgets('the soft shadow lifts the card, drawn below it', (t) async {
      final f = await _render(t);
      // Well clear of the card, away from it: untouched white.
      expect(f.r(20, 20), 255);
      // 8px under the bottom edge, inside the soft shadow: darker than white.
      expect(f.r(200, 210), lessThan(250));
    });

    testWidgets('the shadow is drawn only outside the card, never under it', (
      t,
    ) async {
      // A translucent card must not be darkened from behind: dark-theme glass
      // is 72% of #161616 over white, so the middle of the card should be
      // 0.72*22 + 0.28*255 = 87. A shadow leaking underneath would pull it to
      // about 62.
      final f = await _render(t);
      expect(f.r(200, 185), closeTo(87, 4));
    });

    testWidgets('a low-end phone skips the large soft shadow', (t) async {
      final normal = await _render(t);
      final lowEnd = await _render(t, lowEnd: true);
      // 14px under the card: the soft shadow reaches it, the tight one does not.
      expect(normal.r(200, 214), lessThan(252));
      expect(lowEnd.r(200, 214), 255);
      // Just under the edge the tight shadow still anchors the card.
      expect(lowEnd.r(200, 202), lessThan(255));
    });
  });

  group('light and rim', () {
    testWidgets(
      'the rim catches light at the top-left more than the top middle',
      (t) async {
        final f = await _render(t);
        // Along the top edge (y=100): near the left corner versus the middle.
        expect(f.r(128, 100), greaterThan(f.r(200, 100)));
      },
    );

    testWidgets('renders in light and dark theme without error', (t) async {
      await _render(t, theme: AppTheme.light());
      expect(t.takeException(), isNull);
      await _render(t, theme: AppTheme.dark());
      expect(t.takeException(), isNull);
    });
  });

  group('blur (overlays only)', () {
    testWidgets('a card has no blur unless asked', (t) async {
      await _render(t);
      expect(find.byType(BackdropFilter), findsNothing);
    });

    testWidgets('blur: true blurs the backdrop on a capable phone', (t) async {
      await _render(t, blur: true);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('low-end falls back to the denser solid fill, no blur', (
      t,
    ) async {
      final f = await _render(t, blur: true, lowEnd: true);
      expect(find.byType(BackdropFilter), findsNothing);
      // glassStrong in dark theme is 88% of #161616 over white:
      // 0.878*22 + 0.122*255 = 50, darker than the plain glass fill (87).
      expect(f.r(200, 185), closeTo(50, 4));
    });

    testWidgets('high contrast also drops the blur', (t) async {
      await _render(t, blur: true, highContrast: true);
      expect(find.byType(BackdropFilter), findsNothing);
    });
  });
}
