import 'package:app/features/meditation/timer_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fixed timer completes when elapsed reaches planned duration', () {
    final controller = MeditationTimerController.fixed(
      const Duration(minutes: 10),
    );
    controller.start(DateTime.utc(2026, 5, 26, 12));

    final state = controller.tick(DateTime.utc(2026, 5, 26, 12, 10));

    expect(state.elapsed, const Duration(minutes: 10));
    expect(state.remaining, Duration.zero);
    expect(state.completed, true);
  });

  test('free timer has no remaining duration', () {
    final controller = MeditationTimerController.free();
    controller.start(DateTime.utc(2026, 5, 26, 12));

    final state = controller.tick(DateTime.utc(2026, 5, 26, 12, 3));

    expect(state.elapsed, const Duration(minutes: 3));
    expect(state.remaining, null);
    expect(state.completed, false);
  });
}
