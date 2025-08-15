import 'package:flutter/material.dart';
import 'package:mytodo_app/models/todo_item.dart';
import 'package:mytodo_app/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TaskFilterUtils {
  static List<TodoItem> filterTasks({
    required BuildContext context,
    required List<TodoItem> tasks,
    required String? selectedStatus,
    required String searchQuery,
    required String? selectedCategory,
  }) {
    final provider = Provider.of<TodoProvider>(context, listen: false);

    // تحويل الاسم المعروض إلى مفتاح إذا كان not null
    final categoryKey =
        selectedCategory != null
            ? provider.getCategoryKey(selectedCategory, context)
            : null;

    // تحويل الاسم المعروض إلى مفتاح إذا كان not null
    final statusKey =
        selectedStatus != null
            ? provider.getStatusKey(selectedStatus, context)
            : null;

    final filteredTasks = provider.getFilteredTasks(
      categoryKey: categoryKey,
      statusKey: statusKey,
    );
    return filteredTasks.where((task) {
      return searchQuery.isEmpty ||
          task.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          (task.description?.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ) ??
              false);
    }).toList();
  }
}
