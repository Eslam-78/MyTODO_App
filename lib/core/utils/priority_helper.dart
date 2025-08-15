import 'package:flutter/material.dart';
import 'package:mytodo_app/core/utils/date_helper.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/models/priority_level.dart';

class PriorityHelper {
  static Color getPriorityColor(PriorityLevel priority) {
    return priority.color; // استخدم الخاصية المدمجة في enum
  }

  static String getTranslatedName(BuildContext context, PriorityLevel priority) {
    final s = S.of(context);
    switch (priority) {
      case PriorityLevel.none:
        return s.priorityNone; // أضف هذه الكلمة في ملف intl_ar.arb و intl_en.arb
      case PriorityLevel.low:
        return s.priorityLow;
      case PriorityLevel.medium:
        return s.priorityMedium;
      case PriorityLevel.high:
        return s.priorityHigh;
      case PriorityLevel.urgent:
        return s.priorityUrgent;
    }
  }

  static IconData getPriorityIcon(PriorityLevel priority) {
    switch (priority) {
      case PriorityLevel.low:
        return Icons.arrow_downward;
      case PriorityLevel.medium:
        return Icons.arrow_right;
      case PriorityLevel.high:
        return Icons.arrow_upward;
      case PriorityLevel.urgent:
        return Icons.warning;
      default:
        return Icons.circle;
    }
  }

  static PriorityLevel calculatePriority({
    required DateTime? dueDate,
    required bool isCompleted,
    required DateTime createdAt,
  }) {
    if (isCompleted) return PriorityLevel.low;

    final now = DateTime.now();
    if (dueDate == null) return PriorityLevel.medium;

    final daysRemaining = DateHelper.daysBetween(now, dueDate);

    if (daysRemaining <= 0) return PriorityLevel.urgent;
    if (daysRemaining <= 1) return PriorityLevel.high;
    if (daysRemaining <= 3) return PriorityLevel.medium;
    return PriorityLevel.low;
  }

  static String priorityToString(PriorityLevel priority, BuildContext context) {
    return getTranslatedName(context, priority);
  }
}
