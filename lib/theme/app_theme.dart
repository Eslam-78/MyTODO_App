import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // تحديد نوع الخط بناءً على اللغة
  static TextTheme getTextTheme(TextTheme baseTextTheme, Locale locale) {
    final isArabic = locale.languageCode == 'ar';
    return isArabic
        ? GoogleFonts.tajawalTextTheme(baseTextTheme)
        : GoogleFonts.poppinsTextTheme(baseTextTheme);
  }

  // سمة الألوان الفاتحة
  static final lightColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
  );

  // سمة الألوان الداكنة
  static final darkColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.blueAccent,
    brightness: Brightness.dark,
  );

  // الثيم الفاتح
  static ThemeData lightTheme(Locale locale) {
    return ThemeData(
      colorScheme: lightColorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: lightColorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        elevation: 1,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
      ),
      cardTheme: CardTheme(
        color: lightColorScheme.surface,
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(lightColorScheme.primary),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: lightColorScheme.primary,
        linearTrackColor: lightColorScheme.primaryContainer,
        circularTrackColor: lightColorScheme.primaryContainer,
        linearMinHeight: 10,
      ),
      textTheme: getTextTheme(Typography.blackMountainView, locale),
    );
  }

  static ThemeData darkTheme(Locale locale) {
    return ThemeData(
      colorScheme: darkColorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: darkColorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: darkColorScheme.surface,
        foregroundColor: darkColorScheme.onSurface,
        elevation: 1,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
      ),
      cardTheme: CardTheme(
        color: darkColorScheme.surfaceVariant,
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(darkColorScheme.primary),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: darkColorScheme.primary,
        linearTrackColor: darkColorScheme.primaryContainer,
        circularTrackColor: darkColorScheme.primaryContainer,
        linearMinHeight: 10,
      ),
      textTheme: getTextTheme(Typography.whiteMountainView, locale),
    );
  }
}
