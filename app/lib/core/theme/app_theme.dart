import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../features/profile/user_profile.dart';

const Color appPrimaryTextColor = Color(0xFF1D1D1F);
const Color appSecondaryTextColor = Color(0xFF6E6E73);
const Color appActionColor = Color(0xFF0071E3);
const Color appNeutralColor = Color(0xFFF5F5F7);
const Color appSurfaceColor = Color(0xFFFFFFFF);
const Color appDarkActionColor = Color(0xFF0A5CAD);
const Color appDarkPrimaryTextColor = Color(0xFFF5F5F7);
const Color appDarkSecondaryTextColor = Color(0xFFAEAEB2);
const Color appDarkNeutralColor = Color(0xFF000000);
const Color appDarkSurfaceColor = Color(0xFF1C1C1E);

ThemeData buildAppTheme() {
  return buildLightAppTheme();
}

ThemeData buildLightAppTheme() {
  final baseTheme = ThemeData(useMaterial3: true);
  final baseTextTheme = _interTextTheme(
    baseTheme,
    textColor: appPrimaryTextColor,
  );

  return baseTheme.copyWith(
    scaffoldBackgroundColor: appNeutralColor,
    colorScheme: const ColorScheme.light(
      primary: appActionColor,
      onPrimary: appSurfaceColor,
      secondary: appSecondaryTextColor,
      onSecondary: appSurfaceColor,
      surface: appSurfaceColor,
      onSurface: appPrimaryTextColor,
    ),
    textTheme: baseTextTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: appNeutralColor,
      foregroundColor: appPrimaryTextColor,
      centerTitle: false,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: appSurfaceColor,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: appActionColor,
        foregroundColor: appSurfaceColor,
        disabledBackgroundColor: appActionColor.withValues(alpha: 0.38),
        disabledForegroundColor: appSurfaceColor.withValues(alpha: 0.72),
        minimumSize: const Size.fromHeight(48),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: baseTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

ThemeData buildDarkAppTheme() {
  final baseTheme = ThemeData(useMaterial3: true, brightness: Brightness.dark);
  final baseTextTheme = _interTextTheme(
    baseTheme,
    textColor: appDarkPrimaryTextColor,
  );

  return baseTheme.copyWith(
    scaffoldBackgroundColor: appDarkNeutralColor,
    colorScheme: const ColorScheme.dark(
      primary: appDarkActionColor,
      onPrimary: appSurfaceColor,
      secondary: appDarkSecondaryTextColor,
      onSecondary: appDarkNeutralColor,
      surface: appDarkSurfaceColor,
      onSurface: appDarkPrimaryTextColor,
    ),
    textTheme: baseTextTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: appDarkNeutralColor,
      foregroundColor: appDarkPrimaryTextColor,
      centerTitle: false,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: appDarkSurfaceColor,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: appDarkActionColor,
        foregroundColor: appSurfaceColor,
        disabledBackgroundColor: appDarkActionColor.withValues(alpha: 0.38),
        disabledForegroundColor: appSurfaceColor.withValues(alpha: 0.72),
        minimumSize: const Size.fromHeight(48),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: baseTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

ThemeMode themeModeFromPreference(AppThemePreference preference) {
  return switch (preference) {
    AppThemePreference.system => ThemeMode.system,
    AppThemePreference.light => ThemeMode.light,
    AppThemePreference.dark => ThemeMode.dark,
  };
}

TextTheme _interTextTheme(ThemeData baseTheme, {required Color textColor}) {
  if (!GoogleFonts.config.allowRuntimeFetching) {
    return baseTheme.textTheme.apply(
      fontFamily: 'Inter',
      bodyColor: textColor,
      displayColor: textColor,
    );
  }

  return GoogleFonts.interTextTheme(
    baseTheme.textTheme,
  ).apply(bodyColor: textColor, displayColor: textColor);
}
