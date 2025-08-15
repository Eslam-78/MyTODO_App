import 'package:flutter/material.dart';
import 'package:mytodo_app/models/todo_item.dart';
import 'package:mytodo_app/widgets/priority_badge.dart';

class TaskCard extends StatelessWidget {
  final TodoItem todo;
  final VoidCallback onTap;

  const TaskCard({super.key, required this.todo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: todo.dueDate != null ? Text('تاريخ الانتهاء: ${todo.dueDate}') : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PriorityBadge(priority: Priority.values[todo.priority.index]),
            Checkbox(value: todo.isCompleted, onChanged: (_) => onTap()),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
