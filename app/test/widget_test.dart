import 'package:app/core/widgets/app_scaffold.dart';
import 'package:app/core/widgets/primary_button.dart';
import 'package:app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const appVersion = String.fromEnvironment('APP_VERSION', defaultValue: 'dev');

  testWidgets('PrimaryButton renders its label', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(label: 'Entrar', onPressed: () {}),
        ),
      ),
    );

    expect(find.text('Entrar'), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);
  });

  testWidgets('AppScaffold can show an explicit back action', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AppScaffold(
          title: 'Historico',
          showBackButton: true,
          child: Text('Conteudo'),
        ),
      ),
    );

    expect(find.byTooltip('Back'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('AppScaffold shows release version stamp', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AppScaffold(title: 'Inicio', child: Text('Conteudo')),
      ),
    );

    if (appVersion == 'dev') {
      expect(find.textContaining('Version'), findsNothing);
    } else {
      expect(find.text('Version $appVersion'), findsOneWidget);
    }
  });
}
