// lib/constants/colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Colors without opacity (Opaque)
  static const Color green = Color(0xFF388E3C); // Green 600
  static const Color red = Color(0xFFD32F2F); // Red 600
  static const Color blue = Color(0xFF1976D2); // Blue 600
  static const Color orange = Color(0xFFF57C00); // Orange 600

  // Alternative way using RGBO (without .withOpacity)
  static Color greenTransparentAlt = Color.fromRGBO(56, 142, 60, 0.6);
  static Color redTransparentAlt = Color.fromRGBO(211, 47, 47, 0.6);
  static Color blueTransparentAlt = Color.fromRGBO(25, 118, 210, 0.6);
  static Color orangeTransparentAlt = Color.fromRGBO(245, 124, 0, 0.6);
}
