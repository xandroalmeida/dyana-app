import 'package:app/features/auth/auth_error_message.dart';
import 'package:app/features/auth/login_screen.dart';
import 'package:app/l10n/generated/app_localizations_pt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsPt();

  group('requiredEmail', () {
    test('requires a non-empty email address', () {
      expect(
        requiredEmail(null, l10n.requiredEmail, l10n.invalidEmail),
        'Informe seu e-mail.',
      );
      expect(
        requiredEmail('   ', l10n.requiredEmail, l10n.invalidEmail),
        'Informe seu e-mail.',
      );
    });

    test('requires an email-shaped value', () {
      expect(
        requiredEmail('dyana', l10n.requiredEmail, l10n.invalidEmail),
        'Informe um e-mail valido.',
      );
      expect(
        requiredEmail(
          'user@example.com',
          l10n.requiredEmail,
          l10n.invalidEmail,
        ),
        isNull,
      );
    });
  });

  group('authErrorMessage', () {
    test('maps Firebase auth codes to short Portuguese messages', () {
      expect(
        authErrorMessage(l10n, FirebaseAuthException(code: 'cancelled')),
        'Login cancelado.',
      );
      expect(
        authErrorMessage(l10n, FirebaseAuthException(code: 'invalid-email')),
        'E-mail invalido.',
      );
      expect(
        authErrorMessage(l10n, FirebaseAuthException(code: 'user-disabled')),
        'Conta desativada.',
      );
      expect(
        authErrorMessage(l10n, FirebaseAuthException(code: 'user-not-found')),
        'E-mail ou senha invalidos.',
      );
      expect(
        authErrorMessage(l10n, FirebaseAuthException(code: 'wrong-password')),
        'E-mail ou senha invalidos.',
      );
      expect(
        authErrorMessage(
          l10n,
          FirebaseAuthException(code: 'invalid-credential'),
        ),
        'E-mail ou senha invalidos.',
      );
      expect(
        authErrorMessage(
          l10n,
          FirebaseAuthException(code: 'email-already-in-use'),
        ),
        'Este e-mail ja esta em uso.',
      );
      expect(
        authErrorMessage(l10n, FirebaseAuthException(code: 'weak-password')),
        'Use uma senha com pelo menos 6 caracteres.',
      );
      expect(
        authErrorMessage(
          l10n,
          FirebaseAuthException(code: 'network-request-failed'),
        ),
        'Verifique sua conexao e tente novamente.',
      );
      expect(
        authErrorMessage(
          l10n,
          FirebaseAuthException(code: 'too-many-requests'),
        ),
        'Muitas tentativas. Tente novamente mais tarde.',
      );
    });

    test('uses generic fallback for unknown errors', () {
      expect(
        authErrorMessage(l10n, FirebaseAuthException(code: 'unknown')),
        'Nao foi possivel concluir. Tente novamente.',
      );
      expect(
        authErrorMessage(l10n, Exception('boom')),
        'Nao foi possivel concluir. Tente novamente.',
      );
    });
  });
}
