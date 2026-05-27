# Dark Mode Design

## Goal

Add a dark visual theme to Dyana and let each signed-in user choose whether the app follows the system setting, always uses light mode, or always uses dark mode.

## Scope

- Keep the current light theme as the default visual identity.
- Add a dark theme that stays minimal, flat, calm, and premium.
- Save the theme choice in the existing Firestore user profile preferences.
- Default missing, invalid, or signed-out theme preference to the system setting.
- Add a theme selector to the existing settings screen.

## Architecture

The theme preference belongs in `UserPreferences` because settings already persist under `users/{uid}.preferences`. A small enum will represent the supported values: system, light, and dark. Serialization stores stable lowercase strings in Firestore so older profiles continue to load safely.

`DyanaApp` will provide both light and dark `ThemeData` objects to `MaterialApp.router` and set `themeMode` from the logged-in user's profile stream. If no user is signed in, or the profile has not loaded yet, the app uses `ThemeMode.system`.

The settings screen will sync the stored value with its local form state and save it together with the existing sound and default-duration settings.

## Visual Direction

The light theme remains based on `docs/design.md`: `#F5F5F7` background, white surfaces, `#1D1D1F` primary text, `#6E6E73` secondary text, and `#0071E3` as the only accent.

The dark theme keeps the same hierarchy without gradients or decorative colors:

- background: near black;
- surface: dark neutral;
- primary text: near white;
- secondary text: soft gray;
- interaction accent: `#0A5CAD`, a calmer dark-mode blue derived from the light accent.

## Components

- `app/lib/features/profile/user_profile.dart`: adds theme preference parsing and serialization.
- `app/lib/core/theme/app_theme.dart`: exposes light and dark app themes and maps app theme preference to Flutter `ThemeMode`.
- `app/lib/app.dart`: observes the current user profile and applies the chosen `ThemeMode`.
- `app/lib/features/settings/settings_screen.dart`: adds the appearance selector and persists it.

## Tests

- Profile tests cover valid theme preference parsing, serialization, and invalid-value fallback.
- Repository tests confirm preferences save the theme value.
- Theme tests confirm light and dark color schemes.
- A widget/app test confirms the app can apply a non-system theme preference from the profile provider if practical within the existing Firebase test setup.
