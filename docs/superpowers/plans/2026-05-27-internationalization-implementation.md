# Dyana Internationalization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add English, Portuguese, and Spanish localization with OS-language default, English fallback, and a user-selectable language preference in settings.

**Architecture:** Use Flutter's official `gen-l10n` ARB pipeline with English as the template locale. Persist language preference in `UserPreferences` as `system`, `en`, `pt`, or `es`, then wire it into `MaterialApp.router.locale`.

**Tech Stack:** Flutter Web, `flutter_localizations`, `intl`, Riverpod, Firestore-backed profile preferences.

---

### Task 1: Locale Preference Model

**Files:**
- Modify: `app/lib/features/profile/user_profile.dart`
- Test: `app/test/features/profile/user_profile_test.dart`

- [ ] Write failing tests that `UserPreferences` parses, defaults, and serializes `language`.
- [ ] Add `AppLanguagePreference { system, en, pt, es }`.
- [ ] Add `language` to `UserPreferences`.
- [ ] Run `cd app && flutter test app/test/features/profile/user_profile_test.dart`.

### Task 2: Flutter Localization Pipeline

**Files:**
- Create: `app/l10n.yaml`
- Create: `app/lib/l10n/app_en.arb`
- Create: `app/lib/l10n/app_pt.arb`
- Create: `app/lib/l10n/app_es.arb`
- Modify: `app/pubspec.yaml`
- Modify: `app/lib/app.dart`

- [ ] Add `flutter_localizations` from the Flutter SDK.
- [ ] Configure `gen-l10n` to generate localizations under `app/lib/l10n/generated`.
- [ ] Add app strings in English, Portuguese, and Spanish.
- [ ] Wire delegates, supported locales, and locale selection into `DyanaApp`.

### Task 3: Replace UI Strings

**Files:**
- Modify: `app/lib/core/widgets/app_scaffold.dart`
- Modify: `app/lib/core/version/app_version.dart`
- Modify: auth, meditation, profile, settings, history, metrics, and share files under `app/lib/features`

- [ ] Replace hardcoded visible strings with `AppLocalizations`.
- [ ] Localize auth error messages and share text.
- [ ] Localize history date formatting with active locale.
- [ ] Add settings language dropdown.

### Task 4: Widget Tests and Validation

**Files:**
- Modify: `app/test/widget_test.dart`
- Add focused localization tests if needed.

- [ ] Add widget coverage for back tooltip/version strings through localizations.
- [ ] Run `cd app && flutter gen-l10n`.
- [ ] Run `cd app && flutter test`.
- [ ] Run `cd app && flutter analyze`.
- [ ] Run `cd app && flutter build web --release --dart-define=APP_VERSION=v0.0.0`.
