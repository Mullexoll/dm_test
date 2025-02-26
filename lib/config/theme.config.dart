import 'package:dayme_test/config/theme_extension.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  final TextTheme textTheme;

  const ThemeConfig(this.textTheme);
  const ThemeConfig.light() : textTheme = const TextTheme();
  const ThemeConfig.dark() : textTheme = const TextTheme();
  static const defaultFontFamily = 'Mariupol';

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF00696D),
      surfaceTint: Color(0xFF00696D),
      onPrimary: Colors.white,
      secondary: Color(0xFF004D40),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      extensions: [
        GradientTheme(
          backgroundGradient: const RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              Color(0xFFAE77FF),
              Color(0xFF7054FE),
            ],
          ),
        ),
      ],
      colorScheme: lightScheme(),
      useMaterial3: true,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontFamily: defaultFontFamily,
          fontSize: 32.0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontFamily: defaultFontFamily,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontFamily: defaultFontFamily,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          height: 0.95,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF00696D),
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF00696D),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
