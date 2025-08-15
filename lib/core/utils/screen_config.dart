//ويهدف إلى إنشاء SizeConfig لتهيئة أبعاد الشاشة وضبط النسب حسب حجم الجهاز.

import 'package:flutter/material.dart';

class ScreenConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}

double getFixedHeight(double inputHeight) {
  double screenHeight = ScreenConfig.screenHeight!;
  return (inputHeight / 740.0) * screenHeight; //Galaxy s9 logical height
}

double getFixedWidth(double inputWidth) {
  double screenWidth = ScreenConfig.screenWidth!;
  return (inputWidth / 360.0) * screenWidth; //Galaxy S9 logical width
}
