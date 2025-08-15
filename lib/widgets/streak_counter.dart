import 'package:flutter/material.dart';

class StreakCounter extends StatelessWidget {
  final int streak;
  const StreakCounter({super.key, required this.streak});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.local_fire_department, color: Colors.orange[800]),
        const SizedBox(width: 4),
        Text('$streak يوم على التوالي!', style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
