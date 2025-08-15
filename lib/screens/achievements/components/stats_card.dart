import 'package:flutter/material.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';

class StatsCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const StatsCard({super.key, required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getFixedWidth(12))),
      child: Padding(
        padding: EdgeInsets.all(getFixedWidth(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: getFixedWidth(44),
              height: getFixedWidth(44),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: getFixedWidth(20), color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: getFixedHeight(8)),
            Text(
              value,
              style: TextStyle(
                fontSize: getFixedWidth(20),
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: getFixedHeight(4)),
            Text(label, style: TextStyle(fontSize: getFixedWidth(12), color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
