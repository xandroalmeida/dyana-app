enum MeditationMode { fixed, free }

class MeditationSession {
  const MeditationSession({
    required this.id,
    required this.startedAt,
    required this.endedAt,
    required this.durationSeconds,
    required this.mode,
    required this.completed,
    required this.startSoundEnabled,
    required this.endSoundEnabled,
    required this.createdAt,
    this.plannedDurationSeconds,
  });

  final String id;
  final DateTime startedAt;
  final DateTime endedAt;
  final int durationSeconds;
  final MeditationMode mode;
  final int? plannedDurationSeconds;
  final bool completed;
  final bool startSoundEnabled;
  final bool endSoundEnabled;
  final DateTime createdAt;

  Map<String, Object?> toJson() {
    return {
      'startedAt': startedAt,
      'endedAt': endedAt,
      'durationSeconds': durationSeconds,
      'mode': mode.name,
      'plannedDurationSeconds': plannedDurationSeconds,
      'completed': completed,
      'startSoundEnabled': startSoundEnabled,
      'endSoundEnabled': endSoundEnabled,
      'createdAt': createdAt,
    };
  }
}
