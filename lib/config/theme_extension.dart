import 'package:flutter/material.dart';

class GradientTheme extends ThemeExtension<GradientTheme> {
  final Gradient backgroundGradient;

  GradientTheme({required this.backgroundGradient});

  @override
  ThemeExtension<GradientTheme> copyWith({Gradient? backgroundGradient}) {
    return GradientTheme(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }

  @override
  ThemeExtension<GradientTheme> lerp(
      ThemeExtension<GradientTheme>? other, double t) {
    if (other is! GradientTheme) return this;

    if (backgroundGradient is LinearGradient &&
        other.backgroundGradient is LinearGradient) {
      return GradientTheme(
        backgroundGradient: LinearGradient.lerp(
            backgroundGradient as LinearGradient,
            other.backgroundGradient as LinearGradient,
            t)!,
      );
    } else {
      return this;
    }
  }
}
