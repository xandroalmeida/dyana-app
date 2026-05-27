import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color appPrimaryTextColor = Color(0xFF1D1D1F);
const Color appSecondaryTextColor = Color(0xFF6E6E73);
const Color appActionColor = Color(0xFF0071E3);
const Color appNeutralColor = Color(0xFFF5F5F7);
const Color appSurfaceColor = Color(0xFFFFFFFF);

ThemeData buildAppTheme() {
  final baseTheme = ThemeData(useMaterial3: true);
  final baseTextTheme = GoogleFonts.interTextTheme(
    baseTheme.textTheme,
  ).apply(bodyColor: appPrimaryTextColor, displayColor: appPrimaryTextColor);

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
