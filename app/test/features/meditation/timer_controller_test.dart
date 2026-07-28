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

  test('counts real elapsed time after the app was suspended', () {
    final controller = MeditationTimerController.free();
    controller.start(DateTime.utc(2026, 5, 26, 12));

    final state = controller.tick(DateTime.utc(2026, 5, 26, 12, 25));

    expect(state.elapsed, const Duration(minutes: 25));
  });

  test('does not count time while the meditation is manually paused', () {
    final controller = MeditationTimerController.free();
    controller.start(DateTime.utc(2026, 5, 26, 12));
    controller.pause(DateTime.utc(2026, 5, 26, 12, 3));

    expect(
      controller.tick(DateTime.utc(2026, 5, 26, 12, 8)).elapsed,
      const Duration(minutes: 3),
    );

    controller.resume(DateTime.utc(2026, 5, 26, 12, 8));
    final state = controller.tick(DateTime.utc(2026, 5, 26, 12, 10));

    expect(state.elapsed, const Duration(minutes: 5));
  });
}
