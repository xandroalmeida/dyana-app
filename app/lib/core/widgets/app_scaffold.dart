import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              leading: showBackButton
                  ? IconButton(
                      tooltip: 'Voltar',
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
        child: Stack(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(padding: const EdgeInsets.all(16), child: child),
              ),
            ),
            if (AppVersion.value != 'dev')
              Positioned(
                right: 12,
                bottom: 8,
                child: Text(
                  AppVersion.value,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.45),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
