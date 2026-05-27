import 'package:app/features/auth/auth_error_message.dart';
import 'package:app/features/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  group('authErrorMessage', () {
    test('maps Firebase auth codes to short Portuguese messages', () {
      expect(
        authErrorMessage(FirebaseAuthException(code: 'cancelled')),
        'Login cancelado.',
      );
      expect(
        authErrorMessage(FirebaseAuthException(code: 'invalid-email')),
        'E-mail invalido.',
      );
      expect(
        authErrorMessage(FirebaseAuthException(code: 'user-disabled')),
        'Conta desativada.',
      );
      expect(
        authErrorMessage(FirebaseAuthException(code: 'user-not-found')),
        'E-mail ou senha invalidos.',
      );
      expect(
        authErrorMessage(FirebaseAuthException(code: 'wrong-password')),
        'E-mail ou senha invalidos.',
      );
      expect(
        authErrorMessage(FirebaseAuthException(code: 'invalid-credential')),
        'E-mail ou senha invalidos.',
      );
      expect(
        authErrorMessage(FirebaseAuthException(code: 'email-already-in-use')),
        'Este e-mail ja esta em uso.',
      );
      expect(
        authErrorMessage(FirebaseAuthException(code: 'weak-password')),
        'Use uma senha com pelo menos 6 caracteres.',
      );
      expect(
        authErrorMessage(FirebaseAuthException(code: 'network-request-failed')),
        'Verifique sua conexao e tente novamente.',
      );
      expect(
        authErrorMessage(FirebaseAuthException(code: 'too-many-requests')),
        'Muitas tentativas. Tente novamente mais tarde.',
      );
    });

    test('uses generic fallback for unknown errors', () {
      expect(
        authErrorMessage(FirebaseAuthException(code: 'unknown')),
        'Nao foi possivel concluir. Tente novamente.',
      );
      expect(
        authErrorMessage(Exception('boom')),
        'Nao foi possivel concluir. Tente novamente.',
      );
    });
  });
}
