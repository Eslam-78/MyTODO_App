import 'package:flutter/material.dart';

enum PriorityLevel {
  none(0, 'لا يوجد', Colors.grey),
  low(1, 'منخفض', Colors.green),
  medium(2, 'متوسط', Colors.blue),
  high(3, 'عالي', Colors.orange),
  urgent(4, 'عاجل', Colors.red);

  final int value;
  final String displayName;
  final Color color;

  const PriorityLevel(this.value, this.displayName, this.color);

  static PriorityLevel fromValue(int value) {
    return PriorityLevel.values.firstWhere((e) => e.value == value, orElse: () => PriorityLevel.none);
  }
}
