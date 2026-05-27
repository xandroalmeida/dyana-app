# Dark Mode Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add light/dark/system theme selection, persisted in the signed-in user's Firestore profile.

**Architecture:** Store the preference as a stable string in `UserPreferences`, expose light and dark `ThemeData` from the core theme module, and let `DyanaApp` stream the current profile to choose `ThemeMode`. The settings screen keeps the existing form pattern and saves the theme choice with the other preferences.

**Tech Stack:** Flutter Web, Riverpod, Firebase Auth, Firestore, Flutter widget/unit tests.

---

### Task 1: Persist Theme Preference

**Files:**
- Modify: `app/lib/features/profile/user_profile.dart`
- Test: `app/test/features/profile/user_profile_test.dart`
- Test: `app/test/features/profile/profile_repository_test.dart`

- [ ] **Step 1: Write failing tests**

Add expectations that `UserPreferences` parses `themeMode: 'dark'`, serializes `themeMode`, and falls back to `system` for invalid values.

- [ ] **Step 2: Run focused tests and verify failure**

Run: `cd app && flutter test test/features/profile/user_profile_test.dart test/features/profile/profile_repository_test.dart`

Expected: FAIL because `themeMode` does not exist yet.

- [ ] **Step 3: Implement minimal model support**

Add an app-level enum with values `system`, `light`, and `dark`. Store the preference in `UserPreferences`, parse only known strings, and serialize with lowercase names.

- [ ] **Step 4: Run focused tests and verify pass**

Run: `cd app && flutter test test/features/profile/user_profile_test.dart test/features/profile/profile_repository_test.dart`

Expected: PASS.

### Task 2: Add Dark Theme and ThemeMode Mapping

**Files:**
- Modify: `app/lib/core/theme/app_theme.dart`
- Test: `app/test/core/theme/app_theme_test.dart`

- [ ] **Step 1: Write failing tests**

Add tests for `buildLightAppTheme()`, `buildDarkAppTheme()`, and mapping each app theme preference to Flutter `ThemeMode`.

- [ ] **Step 2: Run focused theme test and verify failure**

Run: `cd app && flutter test test/core/theme/app_theme_test.dart`

Expected: FAIL because dark theme and mapping helpers do not exist yet.

- [ ] **Step 3: Implement minimal theme support**

Keep `buildAppTheme()` as a compatibility alias for the light theme. Add a dark theme with flat neutral colors and the existing blue action color.

- [ ] **Step 4: Run focused theme test and verify pass**

Run: `cd app && flutter test test/core/theme/app_theme_test.dart`

Expected: PASS.

### Task 3: Apply ThemeMode in the App and Settings Screen

**Files:**
- Modify: `app/lib/app.dart`
- Modify: `app/lib/features/settings/settings_screen.dart`
- Test: existing focused tests plus full Flutter test suite

- [ ] **Step 1: Add app wiring**

In `DyanaApp`, watch Firebase Auth, stream the signed-in user's profile through `ProfileRepository`, and apply `themeMode` from preferences. Fall back to `ThemeMode.system`.

- [ ] **Step 2: Add settings selector**

Add a dropdown labeled `Aparencia` with `Sistema`, `Claro`, and `Escuro`; sync it from preferences and save it in `UserPreferences`.

- [ ] **Step 3: Run full tests**

Run: `cd app && flutter test`

Expected: PASS.

- [ ] **Step 4: Run analyzer**

Run: `cd app && flutter analyze`

Expected: no issues.
