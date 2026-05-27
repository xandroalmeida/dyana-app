// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Dyana';

  @override
  String get back => 'Back';

  @override
  String versionLabel(Object version) {
    return 'Version $version';
  }

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get signOut => 'Sign out';

  @override
  String get homeSubtitle => 'Breathe. Start a session when you are ready.';

  @override
  String get start => 'Start';

  @override
  String get freeTime => 'Free time';

  @override
  String get history => 'History';

  @override
  String get metrics => 'Metrics';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get name => 'Name';

  @override
  String get signIn => 'Sign in';

  @override
  String get signingIn => 'Signing in...';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get createAccount => 'Create account';

  @override
  String get forgotPassword => 'Forgot password';

  @override
  String get creating => 'Creating...';

  @override
  String get resetPassword => 'Reset password';

  @override
  String get sendReset => 'Send reset email';

  @override
  String get sending => 'Sending...';

  @override
  String get passwordResetSent => 'Password recovery email sent.';

  @override
  String get requiredEmail => 'Enter your email.';

  @override
  String get invalidEmail => 'Enter a valid email.';

  @override
  String get requiredPassword => 'Enter your password.';

  @override
  String get requiredNewPassword => 'Enter a password.';

  @override
  String get weakSignupPassword => 'Use at least 6 characters.';

  @override
  String get authGenericError => 'We could not complete this. Try again.';

  @override
  String get authCancelled => 'Login cancelled.';

  @override
  String get authInvalidEmail => 'Invalid email.';

  @override
  String get authUserDisabled => 'Account disabled.';

  @override
  String get authInvalidCredentials => 'Invalid email or password.';

  @override
  String get authEmailAlreadyInUse => 'This email is already in use.';

  @override
  String get authWeakPassword => 'Use a password with at least 6 characters.';

  @override
  String get authNetworkFailed => 'Check your connection and try again.';

  @override
  String get authTooManyRequests => 'Too many attempts. Try again later.';

  @override
  String get meditation => 'Meditation';

  @override
  String get breathe => 'Breathe';

  @override
  String get timePracticed => 'time practiced';

  @override
  String get timeRemaining => 'time remaining';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Resume';

  @override
  String get finish => 'Finish';

  @override
  String get saving => 'Saving...';

  @override
  String get sessionSaveError => 'We could not save the session.';

  @override
  String get sessionCompleted => 'Session complete';

  @override
  String get sessionRecorded => 'Session recorded.';

  @override
  String get share => 'Share';

  @override
  String get backToHome => 'Back to home';

  @override
  String shareSessionText(Object minutes) {
    return 'I meditated for $minutes minutes today.';
  }

  @override
  String get shareShortSessionText => 'I completed a meditation session today.';

  @override
  String shareMetricsText(Object totalMinutes, Object sessionsThisWeek) {
    return 'I have practiced $totalMinutes minutes of meditation. This week, I completed $sessionsThisWeek sessions.';
  }

  @override
  String get shared => 'Shared.';

  @override
  String get textCopied => 'Text copied.';

  @override
  String get signInToEditProfile => 'Sign in to edit your profile.';

  @override
  String get profileLoadError => 'We could not load your profile.';

  @override
  String get gender => 'Gender';

  @override
  String get birthDate => 'Birth date';

  @override
  String get birthDateFormatError => 'Use the date format yyyy-MM-dd.';

  @override
  String get profileSaved => 'Profile saved.';

  @override
  String get saveError => 'We could not save.';

  @override
  String get tryAgain => 'Try again';

  @override
  String get signInToEditSettings => 'Sign in to edit your settings.';

  @override
  String get settingsLoadError => 'We could not load your settings.';

  @override
  String get startSound => 'Start sound';

  @override
  String get endSound => 'End sound';

  @override
  String get appearance => 'Appearance';

  @override
  String get language => 'Language';

  @override
  String get defaultDuration => 'Default duration';

  @override
  String get save => 'Save';

  @override
  String get settingsSaved => 'Settings saved.';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get english => 'English';

  @override
  String get portuguese => 'Portuguese';

  @override
  String get spanish => 'Spanish';

  @override
  String get signInToViewHistory => 'Sign in to view your history.';

  @override
  String get historyLoadError => 'We could not load your history.';

  @override
  String get historyEmpty => 'Your sessions will appear here.';

  @override
  String get periodSevenDays => '7 days';

  @override
  String get periodThirtyDays => '30 days';

  @override
  String get periodAll => 'All';

  @override
  String get definedTime => 'Timed session';

  @override
  String get completed => 'Completed';

  @override
  String get ended => 'Ended';

  @override
  String get signInToViewMetrics => 'Sign in to view your metrics.';

  @override
  String get metricsLoadError => 'We could not load your metrics.';

  @override
  String get last7Days => 'Last 7 days';

  @override
  String get last30Days => 'Last 30 days';

  @override
  String get sessions => 'Sessions';

  @override
  String get total => 'Total';

  @override
  String get currentStreak => 'Current streak';

  @override
  String get longestStreak => 'Longest streak';

  @override
  String get average => 'Average';

  @override
  String get daysThisWeek => 'Days this week';

  @override
  String get daysUnit => 'days';

  @override
  String get firstSessionMilestone => 'First session recorded.';

  @override
  String get sevenDaysMilestone => '7 days of accumulated practice.';

  @override
  String get thirtyMinutesMilestone => '30 minutes accumulated.';

  @override
  String get tenSessionsMilestone => '10 sessions completed.';

  @override
  String get hundredMinutesMilestone => '100 minutes accumulated.';
}
