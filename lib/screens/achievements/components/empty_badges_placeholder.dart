import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';

class EmptyBadgesPlaceholder extends StatelessWidget {
  const EmptyBadgesPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final translatedText = S.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: getFixedHeight(30)),
      padding: EdgeInsets.all(getFixedWidth(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events, size: getFixedWidth(60), color: Colors.grey[300]),
          SizedBox(height: getFixedHeight(24)),
          Text(
            translatedText.noAchievements,
            style: TextStyle(fontSize: getFixedWidth(16), color: Colors.grey[600], fontWeight: FontWeight.bold),
          ),
          SizedBox(height: getFixedHeight(8)),
          Text(
            translatedText.completeTasksPrompt,
            style: TextStyle(fontSize: getFixedWidth(12), color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
