import 'package:app/features/meditation/meditation_session.dart';
import 'package:app/features/metrics/meditation_metrics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('calculates totals and seven day minutes', () {
    final now = DateTime.utc(2026, 5, 26, 12);
    final sessions = [
      session(now.subtract(const Duration(days: 1)), 600),
      session(now.subtract(const Duration(days: 8)), 300),
    ];

    final metrics = MeditationMetrics.fromSessions(sessions, now: now);

    expect(metrics.totalSessions, 2);
    expect(metrics.totalMinutes, 15);
    expect(metrics.minutesLast7Days, 10);
    expect(metrics.averageMinutesPerSession, 7.5);
  });
}

MeditationSession session(DateTime startedAt, int seconds) {
  return MeditationSession(
    id: startedAt.toIso8601String(),
    startedAt: startedAt,
    endedAt: startedAt.add(Duration(seconds: seconds)),
    durationSeconds: seconds,
    mode: MeditationMode.fixed,
    plannedDurationSeconds: seconds,
    completed: true,
    startSoundEnabled: true,
    endSoundEnabled: true,
    createdAt: startedAt,
  );
}
