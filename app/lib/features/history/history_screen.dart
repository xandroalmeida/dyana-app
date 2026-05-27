import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/firebase/firebase_providers.dart';
import '../../core/widgets/app_scaffold.dart';
import '../meditation/meditation_session.dart';
import '../meditation/session_repository.dart';

enum HistoryPeriod {
  sevenDays('7 dias', 7),
  thirtyDays('30 dias', 30),
  all('Tudo', null);

  const HistoryPeriod(this.label, this.days);

  final String label;
  final int? days;
}

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  HistoryPeriod _period = HistoryPeriod.sevenDays;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(firebaseAuthProvider).currentUser;

    if (user == null) {
      return const AppScaffold(
        title: 'Historico',
        showBackButton: true,
        child: Text('Entre para ver seu historico.'),
      );
    }

    return AppScaffold(
      title: 'Historico',
      showBackButton: true,
      child: StreamBuilder<List<MeditationSession>>(
        stream: ref.watch(sessionRepositoryProvider).watchRecent(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Nao foi possivel carregar o historico.'),
            );
          }

          final sessions = _filter(snapshot.data ?? const []);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SegmentedButton<HistoryPeriod>(
                segments: HistoryPeriod.values
                    .map(
                      (period) => ButtonSegment(
                        value: period,
                        label: Text(period.label),
                      ),
                    )
                    .toList(),
                selected: {_period},
                onSelectionChanged: (selection) {
                  setState(() => _period = selection.first);
                },
              ),
              const SizedBox(height: 16),
              if (sessions.isEmpty)
                const Expanded(
                  child: Center(child: Text('Suas sessoes aparecerao aqui.')),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: sessions.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      return _SessionTile(session: sessions[index]);
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  List<MeditationSession> _filter(List<MeditationSession> sessions) {
    final days = _period.days;
    if (days == null) return sessions;

    final start = DateTime.now().toUtc().subtract(Duration(days: days));
    return sessions
        .where((session) => !session.startedAt.toUtc().isBefore(start))
        .toList();
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.session});

  final MeditationSession session;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yyyy HH:mm').format(session.startedAt);
    final minutes = session.durationSeconds ~/ 60;
    final seconds = session.durationSeconds % 60;
    final mode = session.mode == MeditationMode.free
        ? 'Tempo livre'
        : 'Tempo definido';
    final status = session.completed ? 'Concluida' : 'Encerrada';

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('$minutes min ${seconds}s'),
      subtitle: Text('$date · $mode · $status'),
    );
  }
}
