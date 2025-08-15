import 'package:mytodo_app/models/priority_level.dart';
import 'package:mytodo_app/models/todo_item.dart';
import 'package:mytodo_app/core/utils/date_helper.dart';
import 'package:mytodo_app/core/utils/priority_helper.dart';
import 'package:mytodo_app/core/utils/streak_helper.dart';

class TaskSuggestionService {
  List<TodoItem> generateSubTasks(TodoItem mainTask) {
    final suggestions = <TodoItem>[];
    final now = DateTime.now();

    if (mainTask.dueDate != null && mainTask.dueDate!.isAfter(now)) {
      final daysBetween = DateHelper.daysBetween(now, mainTask.dueDate!);

      if (daysBetween > 3) {
        // تقسيم المهمة الكبيرة إلى مهام فرعية
        suggestions.addAll(_splitLargeTask(mainTask).map((t) => t.copyWith(tags: [...t.tags ?? [], 'subTask'])));
      }
    }

    // اقتراح مهام متعلقة
    suggestions.addAll(_generateRelatedTasks(mainTask).map((t) => t.copyWith(tags: [...t.tags ?? [], 'related'])));

    // إضافة اقتراحات بناء على العادات
    final habitSuggestions = _generateHabitBasedSuggestions(mainTask);
    suggestions.addAll(habitSuggestions.map((t) => t.copyWith(tags: [...t.tags ?? [], 'habit'])));

    return suggestions;
  }

  List<TodoItem> _generateHabitBasedSuggestions(TodoItem task) {
    final suggestions = <TodoItem>[];

    // اقتراح فترات راحة للمهام الطويلة
    if (task.title.length > 30) {
      suggestions.add(TodoItem(title: 'استراحة قصيرة بعد إكمال: ${task.title}', priority: PriorityLevel.low));
    }

    // اقتراح مراجعة للمهام المهمة
    if (task.priority == PriorityLevel.high || task.priority == PriorityLevel.urgent) {
      suggestions.add(
        TodoItem(
          title: 'مراجعة: ${task.title}',
          dueDate: task.dueDate?.add(Duration(days: 1)),
          priority: task.priority,
        ),
      );
    }

    return suggestions;
  }

  List<TodoItem> _splitLargeTask(TodoItem task) {
    final subtasks = <TodoItem>[];
    final dueDate = task.dueDate ?? DateTime.now().add(const Duration(days: 7));
    final parts = _estimateTaskComplexity(task.title);

    for (int i = 0; i < parts; i++) {
      subtasks.add(
        TodoItem(
          title: '${task.title} (الجزء ${i + 1})',
          dueDate: DateTime.now().add(Duration(days: (i + 1) * 2)),
          priority: task.priority,
        ),
      );
    }

    return subtasks;
  }

  int _estimateTaskComplexity(String title) {
    // تحليل نص المهمة لتقدير تعقيدها
    final wordCount = title.split(' ').length;
    if (wordCount > 10) return 3;
    if (wordCount > 5) return 2;
    return 1;
  }

  List<TodoItem> _generateRelatedTasks(TodoItem task) {
    final relatedTasks = <TodoItem>[];
    final keywords = _extractKeywords(task.title);

    for (final keyword in keywords) {
      switch (keyword) {
        case 'تصميم':
          relatedTasks.add(TodoItem(title: 'إنشاء مسودة لـ ${task.title}', priority: task.priority));
          break;
        case 'برمجة':
          relatedTasks.add(TodoItem(title: 'كتابة اختبارات لـ ${task.title}', priority: task.priority));
          break;
        case 'بحث':
          relatedTasks.add(TodoItem(title: 'جمع مصادر لـ ${task.title}', priority: task.priority));
          break;
      }
    }

    return relatedTasks;
  }

  List<String> _extractKeywords(String text) {
    final keywords = <String>[];
    final commonKeywords = ['تصميم', 'برمجة', 'بحث', 'مراجعة', 'تحليل'];

    for (final keyword in commonKeywords) {
      if (text.contains(keyword)) {
        keywords.add(keyword);
      }
    }

    return keywords;
  }

  List<TodoItem> suggestPriorityTasks(List<TodoItem> allTasks) {
    final now = DateTime.now();
    return allTasks.where((task) {
      if (task.isCompleted) return false;

      final priority = PriorityHelper.calculatePriority(
        dueDate: task.dueDate,
        isCompleted: task.isCompleted,
        createdAt: task.createdAt,
      );

      return priority == PriorityLevel.high || priority == PriorityLevel.urgent;
    }).toList();
  }

  List<TodoItem> suggestBasedOnHabits(List<TodoItem> allTasks, List<TodoItem> completedTasks) {
    final habitTasks = <TodoItem>[];
    final streak = StreakHelper.calculateCurrentStreak(completedTasks);

    if (streak >= 3) {
      // اقتراح مكافآت للاستمرارية
      habitTasks.add(TodoItem(title: 'مكافأة: خذ قسطًا من الراحة'));
    }

    // اقتراح مهام مشابهة للمكتملة سابقًا
    final recentCompleted = completedTasks.take(3).toList();
    for (final task in recentCompleted) {
      habitTasks.add(TodoItem(title: 'متابعة: ${task.title}'));
    }

    return habitTasks;
  }
}
