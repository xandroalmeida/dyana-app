import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Dyana'**
  String get appTitle;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(Object version);

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Breathe. Start a session when you are ready.'**
  String get homeSubtitle;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @freeTime.
  ///
  /// In en, this message translates to:
  /// **'Free time'**
  String get freeTime;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @metrics.
  ///
  /// In en, this message translates to:
  /// **'Metrics'**
  String get metrics;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @signingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get signingIn;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPassword;

  /// No description provided for @creating.
  ///
  /// In en, this message translates to:
  /// **'Creating...'**
  String get creating;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @sendReset.
  ///
  /// In en, this message translates to:
  /// **'Send reset email'**
  String get sendReset;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending;

  /// No description provided for @passwordResetSent.
  ///
  /// In en, this message translates to:
  /// **'Password recovery email sent.'**
  String get passwordResetSent;

  /// No description provided for @requiredEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email.'**
  String get requiredEmail;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email.'**
  String get invalidEmail;

  /// No description provided for @requiredPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password.'**
  String get requiredPassword;

  /// No description provided for @requiredNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter a password.'**
  String get requiredNewPassword;

  /// No description provided for @weakSignupPassword.
  ///
  /// In en, this message translates to:
  /// **'Use at least 6 characters.'**
  String get weakSignupPassword;

  /// No description provided for @authGenericError.
  ///
  /// In en, this message translates to:
  /// **'We could not complete this. Try again.'**
  String get authGenericError;

  /// No description provided for @authCancelled.
  ///
  /// In en, this message translates to:
  /// **'Login cancelled.'**
  String get authCancelled;

  /// No description provided for @authInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email.'**
  String get authInvalidEmail;

  /// No description provided for @authUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'Account disabled.'**
  String get authUserDisabled;

  /// No description provided for @authInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get authInvalidCredentials;

  /// No description provided for @authEmailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already in use.'**
  String get authEmailAlreadyInUse;

  /// No description provided for @authWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Use a password with at least 6 characters.'**
  String get authWeakPassword;

  /// No description provided for @authNetworkFailed.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again.'**
  String get authNetworkFailed;

  /// No description provided for @authTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Try again later.'**
  String get authTooManyRequests;

  /// No description provided for @meditation.
  ///
  /// In en, this message translates to:
  /// **'Meditation'**
  String get meditation;

  /// No description provided for @breathe.
  ///
  /// In en, this message translates to:
  /// **'Breathe'**
  String get breathe;

  /// No description provided for @timePracticed.
  ///
  /// In en, this message translates to:
  /// **'time practiced'**
  String get timePracticed;

  /// No description provided for @timeRemaining.
  ///
  /// In en, this message translates to:
  /// **'time remaining'**
  String get timeRemaining;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @sessionSaveError.
  ///
  /// In en, this message translates to:
  /// **'We could not save the session.'**
  String get sessionSaveError;

  /// No description provided for @sessionCompleted.
  ///
  /// In en, this message translates to:
  /// **'Session complete'**
  String get sessionCompleted;

  /// No description provided for @sessionRecorded.
  ///
  /// In en, this message translates to:
  /// **'Session recorded.'**
  String get sessionRecorded;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

  /// No description provided for @shareSessionText.
  ///
  /// In en, this message translates to:
  /// **'I meditated for {minutes} minutes today.'**
  String shareSessionText(Object minutes);

  /// No description provided for @shareShortSessionText.
  ///
  /// In en, this message translates to:
  /// **'I completed a meditation session today.'**
  String get shareShortSessionText;

  /// No description provided for @shareMetricsText.
  ///
  /// In en, this message translates to:
  /// **'I have practiced {totalMinutes} minutes of meditation. This week, I completed {sessionsThisWeek} sessions.'**
  String shareMetricsText(Object totalMinutes, Object sessionsThisWeek);

  /// No description provided for @shared.
  ///
  /// In en, this message translates to:
  /// **'Shared.'**
  String get shared;

  /// No description provided for @textCopied.
  ///
  /// In en, this message translates to:
  /// **'Text copied.'**
  String get textCopied;

  /// No description provided for @signInToEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Sign in to edit your profile.'**
  String get signInToEditProfile;

  /// No description provided for @profileLoadError.
  ///
  /// In en, this message translates to:
  /// **'We could not load your profile.'**
  String get profileLoadError;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get birthDate;

  /// No description provided for @birthDateFormatError.
  ///
  /// In en, this message translates to:
  /// **'Use the date format yyyy-MM-dd.'**
  String get birthDateFormatError;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile saved.'**
  String get profileSaved;

  /// No description provided for @saveError.
  ///
  /// In en, this message translates to:
  /// **'We could not save.'**
  String get saveError;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @signInToEditSettings.
  ///
  /// In en, this message translates to:
  /// **'Sign in to edit your settings.'**
  String get signInToEditSettings;

  /// No description provided for @settingsLoadError.
  ///
  /// In en, this message translates to:
  /// **'We could not load your settings.'**
  String get settingsLoadError;

  /// No description provided for @startSound.
  ///
  /// In en, this message translates to:
  /// **'Start sound'**
  String get startSound;

  /// No description provided for @endSound.
  ///
  /// In en, this message translates to:
  /// **'End sound'**
  String get endSound;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @defaultDuration.
  ///
  /// In en, this message translates to:
  /// **'Default duration'**
  String get defaultDuration;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved.'**
  String get settingsSaved;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @portuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get portuguese;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @signInToViewHistory.
  ///
  /// In en, this message translates to:
  /// **'Sign in to view your history.'**
  String get signInToViewHistory;

  /// No description provided for @historyLoadError.
  ///
  /// In en, this message translates to:
  /// **'We could not load your history.'**
  String get historyLoadError;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your sessions will appear here.'**
  String get historyEmpty;

  /// No description provided for @periodSevenDays.
  ///
  /// In en, this message translates to:
  /// **'7 days'**
  String get periodSevenDays;

  /// No description provided for @periodThirtyDays.
  ///
  /// In en, this message translates to:
  /// **'30 days'**
  String get periodThirtyDays;

  /// No description provided for @periodAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get periodAll;

  /// No description provided for @definedTime.
  ///
  /// In en, this message translates to:
  /// **'Timed session'**
  String get definedTime;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @ended.
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get ended;

  /// No description provided for @signInToViewMetrics.
  ///
  /// In en, this message translates to:
  /// **'Sign in to view your metrics.'**
  String get signInToViewMetrics;

  /// No description provided for @metricsLoadError.
  ///
  /// In en, this message translates to:
  /// **'We could not load your metrics.'**
  String get metricsLoadError;

  /// No description provided for @last7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get last7Days;

  /// No description provided for @last30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get last30Days;

  /// No description provided for @sessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get sessions;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @currentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current streak'**
  String get currentStreak;

  /// No description provided for @longestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest streak'**
  String get longestStreak;

  /// No description provided for @average.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get average;

  /// No description provided for @daysThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Days this week'**
  String get daysThisWeek;

  /// No description provided for @daysUnit.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get daysUnit;

  /// No description provided for @firstSessionMilestone.
  ///
  /// In en, this message translates to:
  /// **'First session recorded.'**
  String get firstSessionMilestone;

  /// No description provided for @sevenDaysMilestone.
  ///
  /// In en, this message translates to:
  /// **'7 days of accumulated practice.'**
  String get sevenDaysMilestone;

  /// No description provided for @thirtyMinutesMilestone.
  ///
  /// In en, this message translates to:
  /// **'30 minutes accumulated.'**
  String get thirtyMinutesMilestone;

  /// No description provided for @tenSessionsMilestone.
  ///
  /// In en, this message translates to:
  /// **'10 sessions completed.'**
  String get tenSessionsMilestone;

  /// No description provided for @hundredMinutesMilestone.
  ///
  /// In en, this message translates to:
  /// **'100 minutes accumulated.'**
  String get hundredMinutesMilestone;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
