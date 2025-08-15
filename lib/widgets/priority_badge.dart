import 'package:flutter/material.dart';

enum Priority { low, medium, high }

class PriorityBadge extends StatelessWidget {
  final Priority priority;

  const PriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    final color = {Priority.low: Colors.green, Priority.medium: Colors.orange, Priority.high: Colors.red}[priority]!;

    final label = {Priority.low: 'منخفض', Priority.medium: 'متوسط', Priority.high: 'عالي'}[priority]!;

    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
