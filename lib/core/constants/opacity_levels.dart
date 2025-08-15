import 'package:flutter/material.dart';

class OpacityLevels {
  static const double level5 = 0.05;
  static const double level10 = 0.10;
  static const double level20 = 0.20;
  static const double level30 = 0.30;
  static const double level50 = 0.50;
  static const double level70 = 0.70;
  static const double level80 = 0.80;
  static const double level90 = 0.90;

  /// الاستخدام الآمن بدلاً من withOpacity (لتجنّب التحذير من deprecated)
  static Color apply(Color color, double opacity) {
    final alpha = (opacity * 255).round().clamp(0, 255);
    return color.withAlpha(alpha);
  }
}
