import 'package:firebase_auth/firebase_auth.dart';

String authErrorMessage(Object error) {
  if (error is! FirebaseAuthException) {
    return 'Nao foi possivel concluir. Tente novamente.';
  }

  return switch (error.code) {
    'cancelled' => 'Login cancelado.',
    'invalid-email' => 'E-mail invalido.',
    'user-disabled' => 'Conta desativada.',
    'user-not-found' ||
    'wrong-password' ||
    'invalid-credential' => 'E-mail ou senha invalidos.',
    'email-already-in-use' => 'Este e-mail ja esta em uso.',
    'weak-password' => 'Use uma senha com pelo menos 6 caracteres.',
    'network-request-failed' => 'Verifique sua conexao e tente novamente.',
    'too-many-requests' => 'Muitas tentativas. Tente novamente mais tarde.',
    _ => 'Nao foi possivel concluir. Tente novamente.',
  };
}
