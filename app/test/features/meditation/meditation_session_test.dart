import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/meditation/meditation_session.dart';

void main() {
  test('serializes fixed meditation session', () {
    final started = DateTime.utc(2026, 5, 26, 12);
    final ended = started.add(const Duration(minutes: 10));
    final session = MeditationSession(
      id: 's1',
      startedAt: started,
      endedAt: ended,
      durationSeconds: 600,
      mode: MeditationMode.fixed,
      plannedDurationSeconds: 600,
      completed: true,
      startSoundEnabled: true,
      endSoundEnabled: true,
      createdAt: started,
    );

    final json = session.toJson();

    expect(json, {
      'startedAt': started,
      'endedAt': ended,
      'durationSeconds': 600,
      'mode': 'fixed',
      'plannedDurationSeconds': 600,
      'completed': true,
      'startSoundEnabled': true,
      'endSoundEnabled': true,
      'createdAt': started,
    });
  });
}
