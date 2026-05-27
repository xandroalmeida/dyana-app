import 'package:app/features/share/share_service.dart';
import 'package:app/l10n/generated/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsEn();

  test('builds completed session share text', () {
    expect(
      ShareText.session(l10n: l10n, minutes: 10),
      'I meditated for 10 minutes today.',
    );
  });

  test('builds metrics share text', () {
    expect(
      ShareText.metrics(l10n: l10n, totalMinutes: 120, sessionsThisWeek: 5),
      'I have practiced 120 minutes of meditation. This week, I completed 5 sessions.',
    );
  });
}
