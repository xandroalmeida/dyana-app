import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('theme follows design identity colors', () {
    final theme = buildAppTheme();

    expect(theme.colorScheme.primary, const Color(0xFF0071E3));
    expect(theme.colorScheme.surface, Colors.white);
    expect(theme.scaffoldBackgroundColor, const Color(0xFFF5F5F7));
    expect(
      theme.textTheme.bodyMedium?.fontFamily,
      GoogleFonts.interTextTheme().bodyMedium?.fontFamily,
    );
    expect(theme.textTheme.bodyMedium?.fontFamilyFallback, contains('Inter'));
  });
}
