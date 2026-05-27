import 'package:app/features/share/share_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('builds completed session share text', () {
    expect(ShareText.session(minutes: 10), 'Meditei por 10 minutos hoje.');
  });

  test('builds metrics share text', () {
    expect(
      ShareText.metrics(totalMinutes: 120, sessionsThisWeek: 5),
      'Ja pratiquei 120 minutos de meditacao. Nesta semana, completei 5 sessoes.',
    );
  });
}
