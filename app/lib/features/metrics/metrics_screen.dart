import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/firebase/firebase_providers.dart';
import '../../core/l10n/app_l10n.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../meditation/session_repository.dart';
import '../share/share_service.dart';
import 'meditation_metrics.dart';

class MetricsScreen extends ConsumerWidget {
  const MetricsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(firebaseAuthProvider).currentUser;

    if (user == null) {
      return AppScaffold(
        title: context.l10n.metrics,
        showBackButton: true,
        child: Text(context.l10n.signInToViewMetrics),
      );
    }

    return AppScaffold(
      title: context.l10n.metrics,
      showBackButton: true,
      child: StreamBuilder(
        stream: ref.watch(sessionRepositoryProvider).watchRecent(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(context.l10n.metricsLoadError));
          }

          final metrics = MeditationMetrics.fromSessions(
            snapshot.data ?? const [],
            now: DateTime.now().toUtc(),
          );

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _MetricCard(
                      label: context.l10n.last7Days,
                      value: '${metrics.minutesLast7Days} min',
                    ),
                    _MetricCard(
                      label: context.l10n.last30Days,
                      value: '${metrics.minutesLast30Days} min',
                    ),
                    _MetricCard(
                      label: context.l10n.sessions,
                      value: '${metrics.totalSessions}',
                    ),
                    _MetricCard(
                      label: context.l10n.total,
                      value: '${metrics.totalMinutes} min',
                    ),
                    _MetricCard(
                      label: context.l10n.currentStreak,
                      value:
                          '${metrics.currentStreakDays} ${context.l10n.daysUnit}',
                    ),
                    _MetricCard(
                      label: context.l10n.longestStreak,
                      value:
                          '${metrics.longestStreakDays} ${context.l10n.daysUnit}',
                    ),
                    _MetricCard(
                      label: context.l10n.average,
                      value:
                          '${metrics.averageMinutesPerSession.toStringAsFixed(1)} min',
                    ),
                    _MetricCard(
                      label: context.l10n.daysThisWeek,
                      value: '${metrics.practiceDaysThisWeek}',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ..._milestones(context, metrics).map(
                  (text) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(text),
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: context.l10n.share,
                  onPressed: () => _copyMetrics(context, metrics),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<String> _milestones(BuildContext context, MeditationMetrics metrics) {
    return [
      if (metrics.totalSessions >= 1) context.l10n.firstSessionMilestone,
      if (metrics.practiceDaysThisWeek >= 7) context.l10n.sevenDaysMilestone,
      if (metrics.totalMinutes >= 30) context.l10n.thirtyMinutesMilestone,
      if (metrics.totalSessions >= 10) context.l10n.tenSessionsMilestone,
      if (metrics.totalMinutes >= 100) context.l10n.hundredMinutesMilestone,
    ];
  }

  Future<void> _copyMetrics(
    BuildContext context,
    MeditationMetrics metrics,
  ) async {
    final text = ShareText.metrics(
      l10n: context.l10n,
      totalMinutes: metrics.totalMinutes,
      sessionsThisWeek: metrics.practiceDaysThisWeek,
    );
    final shared = await const ShareService().shareOrCopy(text);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(shared ? context.l10n.shared : context.l10n.textCopied),
        ),
      );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 148,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 8),
              Text(value, style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
      ),
    );
  }
}
