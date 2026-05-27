import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/firebase/firebase_providers.dart';
import '../../core/l10n/app_l10n.dart';
import '../../core/widgets/app_scaffold.dart';
import '../meditation/meditation_session.dart';
import '../meditation/session_repository.dart';

enum HistoryPeriod {
  sevenDays(7),
  thirtyDays(30),
  all(null);

  const HistoryPeriod(this.days);

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
      return AppScaffold(
        title: context.l10n.history,
        showBackButton: true,
        child: Text(context.l10n.signInToViewHistory),
      );
    }

    return AppScaffold(
      title: context.l10n.history,
      showBackButton: true,
      child: StreamBuilder<List<MeditationSession>>(
        stream: ref.watch(sessionRepositoryProvider).watchRecent(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(context.l10n.historyLoadError));
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
                        label: Text(_periodLabel(context, period)),
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
                Expanded(child: Center(child: Text(context.l10n.historyEmpty)))
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

String _periodLabel(BuildContext context, HistoryPeriod period) {
  return switch (period) {
    HistoryPeriod.sevenDays => context.l10n.periodSevenDays,
    HistoryPeriod.thirtyDays => context.l10n.periodThirtyDays,
    HistoryPeriod.all => context.l10n.periodAll,
  };
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.session});

  final MeditationSession session;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final date = DateFormat.yMd(
      l10n.localeName,
    ).add_Hm().format(session.startedAt);
    final minutes = session.durationSeconds ~/ 60;
    final seconds = session.durationSeconds % 60;
    final mode = session.mode == MeditationMode.free
        ? l10n.freeTime
        : l10n.definedTime;
    final status = session.completed ? l10n.completed : l10n.ended;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('$minutes min ${seconds}s'),
      subtitle: Text('$date · $mode · $status'),
    );
  }
}
