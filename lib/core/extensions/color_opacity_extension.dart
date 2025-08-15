import 'package:flutter/material.dart';

class OpacityLevels {
  static const double level1 = 0.01;
  static const double level2 = 0.02;
  static const double level3 = 0.03;
  static const double level4 = 0.04;
  static const double level5 = 0.05;
  static const double level10 = 0.1;
  static const double level20 = 0.2;
  static const double level30 = 0.3;
  static const double level40 = 0.4;
  static const double level50 = 0.5;
  static const double level60 = 0.6;
  static const double level70 = 0.7;
  static const double level80 = 0.8;
  static const double level90 = 0.9;
  static const double level100 = 1.0;
}

extension ColorOpacityExtension on Color {
  /// آمنة ومطابقة للمعايير الجديدة، بدون `withOpacity`
  Color opacity(double level) {
    assert(level >= 0.0 && level <= 1.0, 'Opacity must be between 0.0 and 1.0');
    return withAlpha((level * 255).round());
  }
}
