import 'package:flutter/material.dart';
import 'package:mytodo_app/components/custom_alert_dialog.dart';
import 'package:mytodo_app/components/task_dialog_fields.dart';
import 'package:mytodo_app/components/task_filter_utils.dart';
import 'package:mytodo_app/core/services/massenger_service.dart';
import 'package:mytodo_app/core/services/navigation_service.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/models/priority_level.dart';
import 'package:mytodo_app/models/todo_item.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/providers/gamification_provider.dart';
import 'package:mytodo_app/screens/home/components/category_filter.dart';
import 'package:mytodo_app/screens/todo/components/task_list.dart';
import 'package:provider/provider.dart';
import 'package:mytodo_app/providers/todo_provider.dart';
import 'package:mytodo_app/screens/todo/components/task_filter.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  String? _selectedCategoryKey;
  String _searchQuery = '';
  String? _selectedStatusKey; // أضفنا فلتر الحالة

  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);
    final todoProvider = context.watch<TodoProvider>();
    final todos = todoProvider.todos;
    final tasks = TaskFilterUtils.filterTasks(
      context: context,
      tasks: todos,
      selectedStatus:
          _selectedStatusKey != null
              ? todoProvider.getStatusDisplayName(_selectedStatusKey!, context)
              : null,
      searchQuery: _searchQuery,
      selectedCategory:
          _selectedCategoryKey != null
              ? todoProvider.getCategoryDisplayName(
                _selectedCategoryKey!,
                context,
              )
              : null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(transalateText.tasksManagement),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle, size: getFixedWidth(24)),
            onPressed: () => _showAddTaskDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: transalateText.searchTasks,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          // أضفنا CategoryFilter هنا
          CategoryFilter(
            categories: TodoProvider.getCategories(context),
            selectedCategory:
                _selectedCategoryKey != null
                    ? todoProvider.getCategoryDisplayName(
                      _selectedCategoryKey!,
                      context,
                    )
                    : null,
            onCategorySelected: (category) {
              final key = todoProvider.getCategoryKey(category, context);
              setState(() => _selectedCategoryKey = key);
            },
          ),
          TaskFilter(
            taskStatuses: todoProvider.getTaskStatuses(context),
            selectedStatus:
                _selectedStatusKey != null
                    ? todoProvider.getStatusDisplayName(
                      _selectedStatusKey!,
                      context,
                    )
                    : null,

            onStatusChanged: (status) {
              final key = todoProvider.getStatusKey(status, context);
              setState(() => _selectedStatusKey = key);
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TaskList(
              tasks: tasks,
              onTaskCompleted: (id) {
                final taskProvider = context.read<TodoProvider>();
                final gamificationProvider =
                    context.read<GamificationProvider>();
                final task = taskProvider.todos.firstWhere((t) => t.id == id);
                if (!task.isCompleted) {
                  taskProvider.toggleComplete(id);

                  gamificationProvider.calculateDynamicXp(task, context);
                  gamificationProvider.updateStreaks(
                    taskProvider.completedTodos,
                    context,
                  );
                  gamificationProvider.updateWeeklyStats(taskProvider.todos);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final trans = S.of(context);
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    PriorityLevel selectedPriority = PriorityLevel.none;
    DateTime? selectedDueDate;
    int? selectedRecurringDay;
    String? selectedCategory;

    showDialog(
      context: context,
      builder:
          (_) => CustomAlertDialog(
            title: trans.addNewTask,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: buildDialogFields(
                context,
                trans,
                titleController,
                descriptionController,
                selectedPriority,
                (val) => selectedPriority = val!,
                selectedDueDate,
                (val) => selectedDueDate = val,
                selectedRecurringDay,
                (val) => selectedRecurringDay = val,
                selectedCategory,
                (val) => selectedCategory = val, // أضفنا معالج الفئة هنا
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => NavigationService.goBack(),
                child: Text(
                  trans.cancel,
                  style: TextStyle(fontSize: getFixedWidth(14)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.trim().isEmpty) {
                    MassengerService.error(trans.pleaseEnterTitle);
                    return;
                  }
                  // تأكد أن الفئة محفوظة بالمفتاح وليس بالترجمة
                  final categoryKey =
                      selectedCategory != null
                          ? Provider.of<TodoProvider>(
                            context,
                            listen: false,
                          ).getCategoryKey(selectedCategory!, context)
                          : null;

                  final newTask = TodoItem(
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    priority: selectedPriority,
                    dueDate: selectedDueDate,
                    recurringDay: selectedRecurringDay,
                    category: categoryKey, // أضفنا الفئة هنا
                  );

                  context.read<TodoProvider>().addTodo(newTask);

                  MassengerService.success(trans.taskAdded);
                  NavigationService.goBack();
                },
                child: Text(
                  trans.save,
                  style: TextStyle(fontSize: getFixedWidth(14)),
                ),
              ),
            ],
          ),
    );
  }
}
