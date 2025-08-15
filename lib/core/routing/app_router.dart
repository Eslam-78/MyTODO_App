import 'package:flutter/material.dart';
import 'package:mytodo_app/core/constants/app_routes.dart';
import 'package:mytodo_app/screens/achievements/achievements_screen.dart';
import 'package:mytodo_app/screens/focus_mode/focus_mode_screen.dart';
import 'package:mytodo_app/screens/home/home_screen.dart';
import 'package:mytodo_app/screens/settings/settings_screen.dart';
import 'package:mytodo_app/screens/task_details/task_details_screen.dart';
import 'package:mytodo_app/screens/todo/todo_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.todo:
        return MaterialPageRoute(builder: (_) => const TodoScreen());

      case AppRoutes.taskDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => TaskDetailsScreen(
                taskId: args['id'] as String, // فقط نمرر الـ ID
              ),
        );

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case AppRoutes.achievements:
        return MaterialPageRoute(builder: (_) => const AchievementsScreen());
      case AppRoutes.focusMode:
        return MaterialPageRoute(builder: (_) => const FocusModeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('لا يوجد مسار للصفحة ${settings.name}'))),
        );
    }
  }
}
