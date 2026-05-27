import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../auth/auth_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      title: 'Dyana',
      actions: [
        IconButton(
          tooltip: 'Sair',
          onPressed: () => ref.read(authRepositoryProvider).signOut(),
          icon: const Icon(Icons.logout),
        ),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Dyana',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Respire. Comece uma sessao quando estiver pronto.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          const PrimaryButton(label: 'Iniciar', onPressed: null),
        ],
      ),
    );
  }
}
