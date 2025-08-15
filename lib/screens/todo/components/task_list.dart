import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/models/todo_item.dart';
import 'package:mytodo_app/screens/home/components/task_item.dart';

class TaskList extends StatelessWidget {
  final List<TodoItem> tasks;
  final Function(String) onTaskCompleted;

  const TaskList({super.key, required this.tasks, required this.onTaskCompleted});

  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);
    if (tasks.isEmpty) {
      return Center(child: Text(transalateText.noTasksFound));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskItem(task: task, onCompleted: () => onTaskCompleted(task.id));
      },
    );
  }
}
