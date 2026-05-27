import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/app_l10n.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../auth/auth_repository.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static const _durations = [3, 5, 10, 15, 20, 30];
  int _selectedDuration = 10;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppScaffold(
      title: l10n.appTitle,
      actions: [
        IconButton(
          tooltip: l10n.profile,
          onPressed: () => context.go('/profile'),
          icon: const Icon(Icons.person_outline),
        ),
        IconButton(
          tooltip: l10n.settings,
          onPressed: () => context.go('/settings'),
          icon: const Icon(Icons.settings_outlined),
        ),
        IconButton(
          tooltip: l10n.signOut,
          onPressed: () => ref.read(authRepositoryProvider).signOut(),
          icon: const Icon(Icons.logout),
        ),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.appTitle,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.homeSubtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: _durations.map((minutes) {
              return ChoiceChip(
                label: Text('$minutes min'),
                selected: _selectedDuration == minutes,
                onSelected: (_) {
                  setState(() => _selectedDuration = minutes);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: l10n.start,
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              context.go('/session?mode=fixed&minutes=$_selectedDuration');
            },
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => context.go('/session?mode=free'),
            child: Text(l10n.freeTime),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => context.go('/history'),
                child: Text(l10n.history),
              ),
              TextButton(
                onPressed: () => context.go('/metrics'),
                child: Text(l10n.metrics),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
