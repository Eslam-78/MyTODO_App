import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';

class LevelProgressBar extends StatelessWidget {
  final int level;
  final int xp;
  final int nextLevelXp;

  const LevelProgressBar({super.key, required this.level, required this.xp, required this.nextLevelXp});

  @override
  Widget build(BuildContext context) {
    final translatedText = S.of(context);
    final progress = xp / nextLevelXp;
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getFixedWidth(12))),
      child: Padding(
        padding: EdgeInsets.all(getFixedWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${translatedText.level}$level',
                  style: TextStyle(fontSize: getFixedWidth(14), fontWeight: FontWeight.bold),
                ),
                Text('$xp / $nextLevelXp XP', style: TextStyle(fontSize: getFixedWidth(12), color: Colors.grey[600])),
              ],
            ),
            SizedBox(height: getFixedHeight(12)),
            ClipRRect(
              borderRadius: BorderRadius.circular(getFixedWidth(8)),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: getFixedHeight(12),
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
              ),
            ),
            SizedBox(height: getFixedHeight(8)),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${(progress * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: getFixedWidth(12),
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
