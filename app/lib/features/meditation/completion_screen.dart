import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/app_l10n.dart';
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
    final l10n = context.l10n;

    return AppScaffold(
      title: l10n.sessionCompleted,
      showBackButton: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.sessionRecorded,
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
            label: l10n.share,
            onPressed: () => _copyShareText(context),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => context.go('/'),
            child: Text(l10n.backToHome),
          ),
        ],
      ),
    );
  }

  Future<void> _copyShareText(BuildContext context) async {
    final minutes = duration.inMinutes;
    final l10n = context.l10n;
    final text = minutes <= 0
        ? l10n.shareShortSessionText
        : ShareText.session(l10n: l10n, minutes: minutes);
    final shared = await const ShareService().shareOrCopy(text);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text(shared ? l10n.shared : l10n.textCopied)),
      );
  }
}
