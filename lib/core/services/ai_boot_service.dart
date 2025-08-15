import 'package:flutter/material.dart';
import 'package:mytodo_app/core/constants/app_routes.dart';
import 'package:mytodo_app/core/services/location_service.dart';
import 'package:mytodo_app/core/services/navigation_service.dart';
import 'package:mytodo_app/core/services/notification_service.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/providers/todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AIBootService {
  static Future<void> smartStartup(BuildContext context) async {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    await Future.wait([
      _checkLastActivity(context),
      _suggestDailyPlan(context, todoProvider),
      _checkContextualSuggestions(context, todoProvider),
      _analyzeProductivity(context, todoProvider),
      _predictCriticalTasks(context, todoProvider),
      _activateSmartFocus(context),
      _generateDailyRecommendations(context, todoProvider),
    ]);
  }

  static Future<void> initialize(BuildContext context) async {
    await smartStartup(context);
  }

  // ------ الميزة 1: تذكر آخر شاشة ------
  static Future<void> _checkLastActivity(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final lastScreen = prefs.getString('last_screen');

    if (lastScreen == AppRoutes.focusMode && context.mounted) {
      NavigationService.navigateTo(AppRoutes.focusMode);
    }
  }

  // ------ الميزة 2: اقتراحات يومية ذكية ------
  static Future<void> _suggestDailyPlan(BuildContext context, TodoProvider todoProvider) async {
    final prefs = await SharedPreferences.getInstance();
    final lastShownDate = prefs.getString('last_suggestion_date');
    final today = DateTime.now().toString().split(' ')[0]; // تاريخ اليوم فقط

    if (lastShownDate == today) return; // إذا تم العرض اليوم، لا تكرر

    final pendingTasks = todoProvider.pendingTodos;
    final now = TimeOfDay.now();

    if (pendingTasks.isNotEmpty && now.hour < 12) {
      final highPriorityTasks = pendingTasks.where((t) => t.priority.index >= 3);
      if (highPriorityTasks.isNotEmpty && context.mounted) {
        NotificationService.showInstantNotification(
          id: 8,
          title: S.of(context).morning_suggestion_title,
          body: S.of(context).morning_suggestion_body(highPriorityTasks.length),
        );

        await prefs.setString('last_suggestion_date', today); // حفظ تاريخ العرض
      }
    }
  }

  // ------ الميزة 3: سياق ذكي (وقت + موقع) ------
  static Future<void> _checkContextualSuggestions(BuildContext context, TodoProvider todoProvider) async {
    final locationService = LocationService(
      context: context,
      onSuggestion:
          (message) => NotificationService.showInstantNotification(
            id: 7,
            title: S.of(context).smart_tracking_title,
            body: message,
          ),
    );
    await locationService.initGeofencing();
  }

  // ------ الميزة 4: تحليل إنتاجية ------
  static Future<void> _analyzeProductivity(BuildContext context, TodoProvider todoProvider) async {
    final completed = todoProvider.completedTodos.length;
    final total = todoProvider.todos.length;
    final ratio = total > 0 ? (completed / total) : 0;

    if (context.mounted) {
      if (ratio < 0.3) {
        NotificationService.showInstantNotification(
          id: 0,
          title: S.of(context).reminder_title,
          body: S.of(context).low_productivity_body,
        );
      } else if (ratio > 0.8) {
        NotificationService.showInstantNotification(
          id: 1,
          title: S.of(context).congrats_title,
          body: S.of(context).high_productivity_body,
        );
      }
    }
  }

  // ------ الميزة 5: توقع مهام حرجة ------
  static Future<void> _predictCriticalTasks(BuildContext context, TodoProvider todoProvider) async {
    final now = DateTime.now();
    final criticalTasks = todoProvider.pendingTodos.where((task) {
      if (task.dueDate == null) return false;
      final dueSoon = task.dueDate!.difference(now).inDays <= 2;
      return dueSoon && task.priority.index >= 3;
    });

    if (criticalTasks.isNotEmpty && context.mounted) {
      NotificationService.showInstantNotification(
        id: 2,
        title: S.of(context).alert_title,
        body: S.of(context).critical_tasks_body(criticalTasks.length),
      );
    }
  }

  // ------ الميزة 6: تفعيل ذكي لوضع التركيز ------
  static Future<void> _activateSmartFocus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isFocusTime = prefs.getBool('is_focus_time') ?? false;

    if (isFocusTime && context.mounted) {
      NavigationService.replaceWith(AppRoutes.focusMode);
      NotificationService.showInstantNotification(
        id: 3,
        title: S.of(context).focus_mode_title,
        body: S.of(context).focus_mode_active_body,
      );
    } else if (context.mounted) {
      NotificationService.showInstantNotification(
        id: 4,
        title: S.of(context).focus_mode_title,
        body: S.of(context).focus_suggestion_body,
      );
    }
  }

  // ------ الميزة 7: توصيات يومية ------
  static Future<void> _generateDailyRecommendations(BuildContext context, TodoProvider todoProvider) async {
    final today = DateTime.now().weekday;
    final recurringTasks = todoProvider.todos.where((t) => t.recurringDay == today);

    if (recurringTasks.isNotEmpty && context.mounted) {
      final dayName = _getDayName(today, context);
      NotificationService.showInstantNotification(
        id: 5,
        title: S.of(context).daily_recommendations_title,
        body: S.of(context).recurring_tasks_body(dayName, recurringTasks.length),
      );
    } else if (context.mounted) {
      NotificationService.showInstantNotification(
        id: 6,
        title: S.of(context).reminder_title,
        body: S.of(context).add_recurring_reminder,
      );
    }
  }

  static String _getDayName(int weekday, BuildContext context) {
    final localizations = S.of(context);
    switch (weekday) {
      case 1:
        return localizations.monday;
      case 2:
        return localizations.tuesday;
      case 3:
        return localizations.wednesday;
      case 4:
        return localizations.thursday;
      case 5:
        return localizations.friday;
      case 6:
        return localizations.saturday;
      case 7:
        return localizations.sunday;
      default:
        return '';
    }
  }
}

// ------ أداة مساعدة لعرض الاقتراحات ------
/* static void _showSuggestion(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.yellow),
            SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }*/

/* static void _showCelebration(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.celebration, color: Colors.yellow),
            SizedBox(width: 8),
            Text('مذهل! لقد أنجزت معظم مهامك اليوم! 🎉'),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );
  }*/
