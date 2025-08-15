import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:provider/provider.dart';
import 'package:mytodo_app/providers/focus_mode_provider.dart';

class SessionStatsWidget extends StatelessWidget {
  const SessionStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);
    final sessions = context.watch<FocusModeProvider>().completedSessions;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(Icons.timer, '$sessions', transalateText.completedSessions),
        _buildStatItem(Icons.local_fire_department, '3', transalateText.currentStreak),
        _buildStatItem(Icons.star, '12', transalateText.totalSessions),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: getFixedWidth(28), color: Colors.blue[600]),
        SizedBox(height: getFixedHeight(5)),
        Text(value, style: TextStyle(fontSize: getFixedWidth(16), fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: getFixedWidth(10), color: Colors.grey[600])),
      ],
    );
  }
}
