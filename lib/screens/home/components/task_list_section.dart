import 'package:flutter/material.dart';
import 'package:mytodo_app/core/constants/app_routes.dart';
import 'package:mytodo_app/core/services/navigation_service.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/models/todo_item.dart';
import 'package:mytodo_app/screens/home/components/section_header.dart';
import 'package:mytodo_app/screens/todo/components/task_list.dart';

class TaskListSection extends StatelessWidget {
  final List<TodoItem> tasks;
  final Function(String) onTaskCompleted;

  const TaskListSection({
    super.key,
    required this.tasks,
    required this.onTaskCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      children: [
        SectionHeader(
          title: s.yourTasks,
          action: TextButton(
            child: Text(
              S.of(context).viewAll,
              style: TextStyle(fontSize: getFixedWidth(14)),
            ),
            onPressed: () => NavigationService.navigateTo(AppRoutes.todo),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: ScreenConfig.screenHeight! * 0.5,
          ),
          child: TaskList(tasks: tasks, onTaskCompleted: onTaskCompleted),
        ),
      ],
    );
  }
}
