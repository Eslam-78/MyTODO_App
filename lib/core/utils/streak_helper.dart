import 'package:intl/intl.dart';
import 'package:mytodo_app/models/todo_item.dart';

class StreakHelper {
  static int calculateCurrentStreak(List<TodoItem> completedTasks) {
    if (completedTasks.isEmpty) return 0;

    final completedDates =
        completedTasks.where((task) => task.isCompleted).map((task) => task.completedAt!).toList()
          ..sort((a, b) => b.compareTo(a));

    if (completedDates.isEmpty) return 0;

    DateTime currentDate = DateTime.now();
    int streak = 0;
    bool firstIteration = true;

    for (final date in completedDates) {
      final dateOnly = DateTime(date.year, date.month, date.day);
      final currentDateOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);

      if (firstIteration) {
        if (dateOnly.isAtSameMomentAs(currentDateOnly) ||
            dateOnly.isAtSameMomentAs(currentDateOnly.subtract(const Duration(days: 1)))) {
          streak++;
          currentDate = dateOnly;
        } else {
          break;
        }
        firstIteration = false;
      } else {
        if (dateOnly.isAtSameMomentAs(currentDate.subtract(const Duration(days: 1)))) {
          streak++;
          currentDate = dateOnly;
        } else {
          break;
        }
      }
    }

    return streak;
  }

  static int calculateLongestStreak(List<TodoItem> allTasks) {
    final completedTasks = allTasks.where((task) => task.isCompleted).toList();
    if (completedTasks.isEmpty) return 0;

    final dates =
        completedTasks
            .map((task) => DateTime(task.completedAt!.year, task.completedAt!.month, task.completedAt!.day))
            .toSet()
            .toList()
          ..sort();

    if (dates.isEmpty) return 0;

    int maxStreak = 1;
    int currentStreak = 1;

    for (int i = 1; i < dates.length; i++) {
      final previousDate = dates[i - 1];
      final currentDate = dates[i];
      final difference = currentDate.difference(previousDate).inDays;

      if (difference == 1) {
        currentStreak++;
        maxStreak = currentStreak > maxStreak ? currentStreak : maxStreak;
      } else if (difference > 1) {
        currentStreak = 1;
      }
    }

    return maxStreak;
  }

  //باقي هذه لدالة ما استخدمناها في الواجهات
  static Map<String, int> getWeeklyCompletionStats(List<TodoItem> tasks) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final stats = <String, int>{};

    for (int i = 0; i < 7; i++) {
      final day = weekStart.add(Duration(days: i));
      final dayName = DateFormat('EEE').format(day);
      stats[dayName] = 0;
    }

    for (final task in tasks.where((t) => t.isCompleted)) {
      final taskDate = task.completedAt!;
      if (taskDate.isAfter(weekStart.subtract(const Duration(days: 1)))) {
        final dayName = DateFormat('EEE').format(taskDate);
        stats[dayName] = (stats[dayName] ?? 0) + 1;
      }
    }

    return stats;
  }
}
