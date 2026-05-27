import 'package:app/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
}
