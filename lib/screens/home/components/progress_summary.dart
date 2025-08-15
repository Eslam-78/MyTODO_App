import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/screens/home/components/section_header.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';

class ProgressSummary extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;
  final int dayStreak;
  final int weeklyStats;

  const ProgressSummary({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
    required this.dayStreak,
    required this.weeklyStats,
  });

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final theme = Theme.of(context);
    final progress =
        totalTasks > 0 ? (completedTasks / totalTasks).clamp(0.0, 1.0) : 0.0;

    final isComplete = progress == 1;

    final statsData = [
      (Icons.check_circle, t.completed, '$completedTasks'),
      (Icons.pending_actions, t.remaining, '${totalTasks - completedTasks}'),
      (Icons.local_fire_department, t.streak, '$dayStreak'),
      (Icons.calendar_view_week, t.weeklyTasks, '$weeklyStats'),
    ];

    return Column(
      children: [
        SectionHeader(title: t.yourProgress),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getFixedWidth(2)),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(getFixedWidth(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        statsData
                            .map(
                              (item) => Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: _buildStatItem(
                                    item.$1,
                                    item.$2,
                                    item.$3,
                                    theme,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                  SizedBox(height: getFixedHeight(20)),
                  _buildCircularProgress(progress, isComplete, theme),
                  SizedBox(height: getFixedHeight(20)),
                  _buildLinearProgress(progress, isComplete, theme),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(
    IconData icon,
    String label,
    String value,
    ThemeData theme,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: theme.colorScheme.secondary, size: getFixedWidth(20)),
        SizedBox(height: getFixedHeight(4)),
        Text(
          value,
          style: TextStyle(
            fontSize: getFixedWidth(14),
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyLarge?.color,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: getFixedWidth(10),
            color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularProgress(
    double progress,
    bool isComplete,
    ThemeData theme,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: getFixedWidth(70),
          height: getFixedWidth(70),
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 7,
            backgroundColor: theme.progressIndicatorTheme.circularTrackColor,
            valueColor: AlwaysStoppedAnimation<Color>(
              isComplete ? Colors.teal : theme.colorScheme.primary,
            ),
          ),
        ),
        isComplete
            ? Shimmer.fromColors(
              baseColor: Colors.teal,
              highlightColor: Colors.tealAccent,
              child: Icon(
                Icons.check,
                size: getFixedWidth(40),
                color: Colors.white,
              ),
            )
            : Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(
                fontSize: getFixedWidth(20),
                fontWeight: FontWeight.bold,
              ),
            ),
      ],
    );
  }

  Widget _buildLinearProgress(
    double progress,
    bool isComplete,
    ThemeData theme,
  ) {
    return Stack(
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: theme.progressIndicatorTheme.linearTrackColor,
          valueColor: AlwaysStoppedAnimation<Color>(
            isComplete ? Colors.teal : theme.colorScheme.primary,
          ),
          minHeight:
              theme.progressIndicatorTheme.linearMinHeight ??
              getFixedHeight(10),
          borderRadius: BorderRadius.circular(10),
        ),
        if (isComplete)
          Positioned.fill(
            child: Shimmer.fromColors(
              baseColor: Colors.teal,
              highlightColor: Colors.tealAccent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
