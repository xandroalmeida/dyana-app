import 'package:firebase_auth/firebase_auth.dart';

import '../../l10n/generated/app_localizations.dart';

String authErrorMessage(AppLocalizations l10n, Object error) {
  if (error is! FirebaseAuthException) {
    return l10n.authGenericError;
  }

  return switch (error.code) {
    'cancelled' => l10n.authCancelled,
    'invalid-email' => l10n.authInvalidEmail,
    'user-disabled' => l10n.authUserDisabled,
    'user-not-found' ||
    'wrong-password' ||
    'invalid-credential' => l10n.authInvalidCredentials,
    'email-already-in-use' => l10n.authEmailAlreadyInUse,
    'weak-password' => l10n.authWeakPassword,
    'network-request-failed' => l10n.authNetworkFailed,
    'too-many-requests' => l10n.authTooManyRequests,
    _ => l10n.authGenericError,
  };
}
