import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../share/share_service.dart';

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key, required this.duration});

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return AppScaffold(
      title: 'Sessao concluida',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sessao registrada.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 16),
          Text(
            '${minutes}min ${seconds}s',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Compartilhar',
            onPressed: () => _copyShareText(context),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => context.go('/'),
            child: const Text('Voltar ao inicio'),
          ),
        ],
      ),
    );
  }

  Future<void> _copyShareText(BuildContext context) async {
    final minutes = duration.inMinutes;
    final text = minutes <= 0
        ? 'Conclui uma sessao de meditacao hoje.'
        : ShareText.session(minutes: minutes);
    final shared = await const ShareService().shareOrCopy(text);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text(shared ? 'Compartilhado.' : 'Texto copiado.')),
      );
  }
}
