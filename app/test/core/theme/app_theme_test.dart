import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/features/profile/user_profile.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  test('light theme follows design identity colors', () {
    final theme = buildLightAppTheme();

    expect(theme.colorScheme.primary, const Color(0xFF0071E3));
    expect(theme.colorScheme.surface, Colors.white);
    expect(theme.scaffoldBackgroundColor, const Color(0xFFF5F5F7));
    expect(
      theme.textTheme.bodyMedium?.fontFamily,
      'Inter',
    );
  });

  test('dark theme keeps single accent and dark neutrals', () {
    final theme = buildDarkAppTheme();

    expect(theme.brightness, Brightness.dark);
    expect(theme.colorScheme.primary, const Color(0xFF0A5CAD));
    expect(theme.colorScheme.surface, const Color(0xFF1C1C1E));
    expect(theme.scaffoldBackgroundColor, const Color(0xFF000000));
    expect(theme.colorScheme.onSurface, const Color(0xFFF5F5F7));
  });

  test('theme mode maps from app preference', () {
    expect(themeModeFromPreference(AppThemePreference.system), ThemeMode.system);
    expect(themeModeFromPreference(AppThemePreference.light), ThemeMode.light);
    expect(themeModeFromPreference(AppThemePreference.dark), ThemeMode.dark);
  });
}
