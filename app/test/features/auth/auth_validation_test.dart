import 'package:app/features/auth/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('requiredEmail', () {
    test('requires a non-empty email address', () {
      expect(requiredEmail(null), 'Informe seu e-mail.');
      expect(requiredEmail('   '), 'Informe seu e-mail.');
    });

    test('requires an email-shaped value', () {
      expect(requiredEmail('dyana'), 'Informe um e-mail valido.');
      expect(requiredEmail('user@example.com'), isNull);
    });
  });
}
