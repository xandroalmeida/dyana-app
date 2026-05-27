import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_l10n.dart';
import '../version/app_version.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.child,
    super.key,
    this.title,
    this.actions,
    this.showBackButton = false,
    this.backLocation = '/',
  });

  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final String backLocation;

  @override
  Widget build(BuildContext context) {
    final versionStamp = AppVersion.isRelease
        ? Text(
            context.l10n.versionLabel(AppVersion.value),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.48),
            ),
          )
        : null;

    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              leading: showBackButton
                  ? IconButton(
                      tooltip: context.l10n.back,
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(backLocation);
                        }
                      },
                    )
                  : null,
              title: Text(title!),
              actions: actions,
            ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(child: child),
                  if (versionStamp != null) ...[
                    const SizedBox(height: 12),
                    versionStamp,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
