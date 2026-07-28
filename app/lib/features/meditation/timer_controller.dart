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
  DateTime? _pausedAt;

  bool get isPaused => _pausedAt != null;

  void start(DateTime now) {
    _startedAt = now;
    _pausedDuration = Duration.zero;
    _pausedAt = null;
  }

  void pause(DateTime now) {
    if (_startedAt == null || _pausedAt != null) return;
    _pausedAt = now;
  }

  void resume(DateTime now) {
    final pausedAt = _pausedAt;
    if (pausedAt == null) return;

    final pause = now.difference(pausedAt);
    if (!pause.isNegative) {
      _pausedDuration += pause;
    }
    _pausedAt = null;
  }

  MeditationTimerState tick(DateTime now) {
    final startedAt = _startedAt;
    if (startedAt == null) {
      return const MeditationTimerState(
        elapsed: Duration.zero,
        completed: false,
      );
    }

    final effectiveNow = _pausedAt ?? now;
    final measuredElapsed =
        effectiveNow.difference(startedAt) - _pausedDuration;
    final elapsed = measuredElapsed.isNegative
        ? Duration.zero
        : measuredElapsed;
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
