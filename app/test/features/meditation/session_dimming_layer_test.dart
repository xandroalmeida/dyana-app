import 'package:app/features/meditation/session_dimming_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const delay = Duration(seconds: 1);
  const transitionDuration = Duration(milliseconds: 400);

  testWidgets('dims after the initial delay and reveals on the first touch', (
    WidgetTester tester,
  ) async {
    var childTaps = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: SessionDimmingLayer(
          active: true,
          delay: delay,
          transitionDuration: transitionDuration,
          child: GestureDetector(
            key: const ValueKey('session-content'),
            behavior: HitTestBehavior.opaque,
            onTap: () => childTaps++,
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );

    AnimatedOpacity overlay() =>
        tester.widget(find.byKey(const ValueKey('session-dimming-overlay')));

    expect(overlay().opacity, 0);

    await tester.pump(delay);
    expect(overlay().opacity, 0.72);
    expect(overlay().duration, transitionDuration);
    expect(overlay().curve, Curves.easeInOut);

    await tester.tap(find.byType(SessionDimmingLayer));
    await tester.pump();

    expect(overlay().opacity, 0);
    expect(childTaps, 0);

    await tester.pump(delay);
    expect(overlay().opacity, 0.72);
  });

  testWidgets('returns to normal when dimming becomes inactive', (
    WidgetTester tester,
  ) async {
    Widget buildLayer({required bool active}) {
      return MaterialApp(
        home: SessionDimmingLayer(
          active: active,
          delay: delay,
          transitionDuration: transitionDuration,
          child: const SizedBox.expand(),
        ),
      );
    }

    await tester.pumpWidget(buildLayer(active: true));
    await tester.pump(delay);

    AnimatedOpacity overlay = tester.widget(
      find.byKey(const ValueKey('session-dimming-overlay')),
    );
    expect(overlay.opacity, 0.72);

    await tester.pumpWidget(buildLayer(active: false));
    overlay = tester.widget(
      find.byKey(const ValueKey('session-dimming-overlay')),
    );

    expect(overlay.opacity, 0);
    expect(overlay.duration, transitionDuration);
  });

  testWidgets('interactions restart the delay before dimming', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SessionDimmingLayer(
          active: true,
          delay: delay,
          transitionDuration: transitionDuration,
          child: SizedBox.expand(),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 700));
    await tester.tap(find.byType(SessionDimmingLayer));
    await tester.pump(const Duration(milliseconds: 700));

    AnimatedOpacity overlay = tester.widget(
      find.byKey(const ValueKey('session-dimming-overlay')),
    );
    expect(overlay.opacity, 0);

    await tester.pump(const Duration(milliseconds: 300));
    overlay = tester.widget(
      find.byKey(const ValueKey('session-dimming-overlay')),
    );
    expect(overlay.opacity, 0.72);
  });
}
