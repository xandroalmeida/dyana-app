import '../meditation/meditation_session.dart';

class MeditationMetrics {
  const MeditationMetrics({
    required this.totalSessions,
    required this.totalMinutes,
    required this.minutesLast7Days,
    required this.minutesLast30Days,
    required this.averageMinutesPerSession,
    required this.currentStreakDays,
    required this.longestStreakDays,
    required this.practiceDaysThisWeek,
  });

  final int totalSessions;
  final int totalMinutes;
  final int minutesLast7Days;
  final int minutesLast30Days;
  final double averageMinutesPerSession;
  final int currentStreakDays;
  final int longestStreakDays;
  final int practiceDaysThisWeek;

  factory MeditationMetrics.fromSessions(
    List<MeditationSession> sessions, {
    required DateTime now,
  }) {
    final totalSeconds = sessions.fold<int>(
      0,
      (sum, session) => sum + session.durationSeconds,
    );
    final last7 = now.subtract(const Duration(days: 7));
    final last30 = now.subtract(const Duration(days: 30));
    final practiceDays = sessions
        .map(
          (session) => DateTime.utc(
            session.startedAt.year,
            session.startedAt.month,
            session.startedAt.day,
          ),
        )
        .toSet();

    return MeditationMetrics(
      totalSessions: sessions.length,
      totalMinutes: totalSeconds ~/ 60,
      minutesLast7Days: _minutesSince(sessions, last7),
      minutesLast30Days: _minutesSince(sessions, last30),
      averageMinutesPerSession: sessions.isEmpty
          ? 0
          : (totalSeconds / 60) / sessions.length,
      currentStreakDays: _currentStreak(practiceDays, now),
      longestStreakDays: _longestStreak(practiceDays),
      practiceDaysThisWeek: _practiceDaysThisWeek(practiceDays, now),
    );
  }

  static int _minutesSince(List<MeditationSession> sessions, DateTime date) {
    return sessions
            .where((session) => !session.startedAt.isBefore(date))
            .fold<int>(0, (sum, session) => sum + session.durationSeconds) ~/
        60;
  }

  static int _currentStreak(Set<DateTime> days, DateTime now) {
    var cursor = DateTime.utc(now.year, now.month, now.day);
    var count = 0;
    while (days.contains(cursor)) {
      count += 1;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return count;
  }

  static int _longestStreak(Set<DateTime> days) {
    final sorted = days.toList()..sort();
    var longest = 0;
    var current = 0;
    DateTime? previous;

    for (final day in sorted) {
      if (previous == null || day.difference(previous).inDays == 1) {
        current += 1;
      } else {
        current = 1;
      }
      if (current > longest) longest = current;
      previous = day;
    }

    return longest;
  }

  static int _practiceDaysThisWeek(Set<DateTime> days, DateTime now) {
    final today = DateTime.utc(now.year, now.month, now.day);
    final weekStart = today.subtract(Duration(days: today.weekday - 1));
    return days
        .where((day) => !day.isBefore(weekStart) && !day.isAfter(today))
        .length;
  }
}
