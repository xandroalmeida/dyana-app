class MeditationTimerState {
  const MeditationTimerState({
    required this.elapsed,
    required this.completed,
    this.remaining,
  });

  final Duration elapsed;
  final Duration? remaining;
  final bool completed;
}

class MeditationTimerController {
  MeditationTimerController.fixed(this.plannedDuration);
  MeditationTimerController.free() : plannedDuration = null;

  final Duration? plannedDuration;
  DateTime? _startedAt;
  Duration _pausedDuration = Duration.zero;

  void start(DateTime now) {
    _startedAt = now;
  }

  void addPausedDuration(Duration duration) {
    _pausedDuration += duration;
  }

  MeditationTimerState tick(DateTime now) {
    final startedAt = _startedAt;
    if (startedAt == null) {
      return const MeditationTimerState(
        elapsed: Duration.zero,
        completed: false,
      );
    }

    final elapsed = now.difference(startedAt) - _pausedDuration;
    final planned = plannedDuration;
    if (planned == null) {
      return MeditationTimerState(elapsed: elapsed, completed: false);
    }

    final remaining = planned - elapsed;
    final completed = remaining <= Duration.zero;
    return MeditationTimerState(
      elapsed: elapsed > planned ? planned : elapsed,
      remaining: completed ? Duration.zero : remaining,
      completed: completed,
    );
  }
}
