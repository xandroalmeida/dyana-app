import 'package:app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Dyana app shell renders', (WidgetTester tester) async {
    await tester.pumpWidget(const DyanaApp());

    expect(find.text('Dyana'), findsOneWidget);
  });
}
