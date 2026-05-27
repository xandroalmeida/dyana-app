import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/firebase/firebase_providers.dart';
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
      return const AppScaffold(
        title: 'Metricas',
        child: Text('Entre para ver suas metricas.'),
      );
    }

    return AppScaffold(
      title: 'Metricas',
      child: StreamBuilder(
        stream: ref.watch(sessionRepositoryProvider).watchRecent(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Nao foi possivel carregar suas metricas.'),
            );
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
                      label: 'Ultimos 7 dias',
                      value: '${metrics.minutesLast7Days} min',
                    ),
                    _MetricCard(
                      label: 'Ultimos 30 dias',
                      value: '${metrics.minutesLast30Days} min',
                    ),
                    _MetricCard(
                      label: 'Sessoes',
                      value: '${metrics.totalSessions}',
                    ),
                    _MetricCard(
                      label: 'Total',
                      value: '${metrics.totalMinutes} min',
                    ),
                    _MetricCard(
                      label: 'Sequencia atual',
                      value: '${metrics.currentStreakDays} dias',
                    ),
                    _MetricCard(
                      label: 'Maior sequencia',
                      value: '${metrics.longestStreakDays} dias',
                    ),
                    _MetricCard(
                      label: 'Media',
                      value:
                          '${metrics.averageMinutesPerSession.toStringAsFixed(1)} min',
                    ),
                    _MetricCard(
                      label: 'Dias na semana',
                      value: '${metrics.practiceDaysThisWeek}',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ..._milestones(metrics).map(
                  (text) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(text),
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Compartilhar',
                  onPressed: () => _copyMetrics(context, metrics),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<String> _milestones(MeditationMetrics metrics) {
    return [
      if (metrics.totalSessions >= 1) 'Primeira sessao registrada.',
      if (metrics.practiceDaysThisWeek >= 7) '7 dias com pratica acumulada.',
      if (metrics.totalMinutes >= 30) '30 minutos acumulados.',
      if (metrics.totalSessions >= 10) '10 sessoes concluidas.',
      if (metrics.totalMinutes >= 100) '100 minutos acumulados.',
    ];
  }

  Future<void> _copyMetrics(
    BuildContext context,
    MeditationMetrics metrics,
  ) async {
    final text = ShareText.metrics(
      totalMinutes: metrics.totalMinutes,
      sessionsThisWeek: metrics.practiceDaysThisWeek,
    );
    final shared = await const ShareService().shareOrCopy(text);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text(shared ? 'Compartilhado.' : 'Texto copiado.')),
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
