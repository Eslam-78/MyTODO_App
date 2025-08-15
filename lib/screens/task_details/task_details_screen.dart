import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mytodo_app/components/custom_alert_dialog.dart';
import 'package:mytodo_app/components/task_dialog_fields.dart';
import 'package:mytodo_app/core/services/navigation_service.dart';
import 'package:mytodo_app/core/utils/priority_helper.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/models/priority_level.dart';
import 'package:mytodo_app/models/todo_item.dart';
import 'package:mytodo_app/providers/todo_provider.dart';
import 'package:mytodo_app/screens/task_details/components/task_action_buttons.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/core/services/massenger_service.dart';
import 'package:provider/provider.dart';

class TaskDetailsScreen extends StatelessWidget {
  final String taskId;

  const TaskDetailsScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);

    final provider = Provider.of<TodoProvider>(context);

    // تحقق أولاً إذا كانت المهمة موجودة
    if (!provider.todos.any((t) => t.id == taskId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        NavigationService.goBack(); // أغلق الصفحة إذا المهمة غير موجودة
      });
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final task = provider.todos.firstWhere((t) => t.id == taskId);
    return Scaffold(
      appBar: AppBar(
        title: Text(transalateText.taskDetails),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, size: getFixedWidth(24)),
            onPressed: () => _showEditTaskDialog(context, task),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(getFixedWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان المهمة

            // عنوان المهمة - مع الليبل
            Text(
              transalateText.taskTitle,
              style: TextStyle(
                fontSize: getFixedWidth(16),
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: getFixedHeight(8)),
            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: getFixedWidth(22),
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: getFixedHeight(24)),

            // معلومات المهمة
            _buildTaskInfoRow(context, task),
            SizedBox(height: getFixedHeight(20)),

            // خط فاصل
            Divider(height: 1, thickness: 1, color: Colors.grey[300]),
            SizedBox(height: getFixedHeight(20)),

            // الوصف (إذا موجود)
            if (task.description?.isNotEmpty ?? false) ...[
              Text(
                transalateText.description,
                style: TextStyle(
                  fontSize: getFixedWidth(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: getFixedHeight(8)),
              Container(
                padding: EdgeInsets.all(getFixedWidth(12)),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  task.description!,
                  style: TextStyle(fontSize: getFixedWidth(14), height: 1.5),
                ),
              ),
              SizedBox(height: getFixedHeight(24)),
            ],

            // تاريخ الإنشاء والاستحقاق
            _buildTaskDates(context, task),
            SizedBox(height: getFixedHeight(24)),
            /* _buildTaskSuggestionsSection(context, task),*/

            // أزرار التحكم
            TaskActionButtons(task: task),
          ],
        ),
      ),
    );
  }

  // ونضيف هذه الدالة
  /* Widget _buildTaskSuggestionsSection(BuildContext context, TodoItem task) {
    final suggestionService = TaskSuggestionService();
    final suggestions = suggestionService.generateSubTasks(task);

    if (suggestions.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getFixedHeight(24)),
        Divider(height: 1, thickness: 1, color: Colors.grey[300]),
        SizedBox(height: getFixedHeight(20)),
        Text(
          S.of(context).taskSuggestions,
          style: TextStyle(
            fontSize: getFixedWidth(16),
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: getFixedHeight(12)),
        ...suggestions
            .take(3)
            .map(
              (suggestion) => Padding(
                padding: EdgeInsets.only(bottom: getFixedHeight(8)),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.arrow_forward_ios,
                    size: getFixedWidth(16),
                  ),
                  title: Text(
                    suggestion.title,
                    style: TextStyle(fontSize: getFixedWidth(14)),
                  ),
                  onTap: () {
                    context.read<TodoProvider>().addTodo(suggestion);
                    MassengerService.success(S.of(context).taskAdded);
                  },
                ),
              ),
            ),
      ],
    );
  }*/

  Widget _buildTaskInfoRow(BuildContext context, TodoItem task) {
    final transalateText = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان الحالة
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${transalateText.taskStatusLabel}:",
              style: TextStyle(
                fontSize: getFixedWidth(16),
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: getFixedHeight(10)),

            // حالة المهمة
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getFixedWidth(10),
                vertical: getFixedHeight(6),
              ),
              decoration: BoxDecoration(
                color:
                    task.isCompleted
                        ? Colors.green.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: task.isCompleted ? Colors.green : Colors.orange,
                  width: 1,
                ),
              ),
              child: Text(
                task.isCompleted
                    ? transalateText.completed
                    : transalateText.inProgress,
                style: TextStyle(
                  fontSize: getFixedWidth(10),
                  color: task.isCompleted ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: getFixedHeight(20)),

            // عنوان الأولوية
            Text(
              " ${transalateText.priority}:",
              style: TextStyle(
                fontSize: getFixedWidth(16),
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: getFixedHeight(10)),

            // أولوية المهمة
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getFixedWidth(12),
                vertical: getFixedHeight(6),
              ),
              decoration: BoxDecoration(
                color: PriorityHelper.getPriorityColor(
                  task.priority,
                ).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: PriorityHelper.getPriorityColor(task.priority),
                  width: 1,
                ),
              ),
              child: Text(
                PriorityHelper.priorityToString(task.priority, context),
                style: TextStyle(
                  fontSize: getFixedWidth(10),
                  color: PriorityHelper.getPriorityColor(task.priority),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTaskDates(BuildContext context, TodoItem task) {
    final transalateText = S.of(context);
    final dateFormat = DateFormat('yyyy/MM/dd - hh:mm a');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          transalateText.dateInfo,
          style: TextStyle(
            fontSize: getFixedWidth(16),
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: getFixedHeight(12)),
        _buildDateItem(
          transalateText.createdDate,
          dateFormat.format(task.createdAt),
        ),
        if (task.dueDate != null)
          _buildDateItem(
            transalateText.dueDate,
            dateFormat.format(task.dueDate!),
            isOverdue:
                task.dueDate!.isBefore(DateTime.now()) && !task.isCompleted,
          ),
        if (task.completedAt != null)
          _buildDateItem(
            transalateText.completedDate,
            dateFormat.format(task.completedAt!),
          ),
      ],
    );
  }

  Widget _buildDateItem(String label, String value, {bool isOverdue = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getFixedHeight(6)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: getFixedWidth(120),
            child: Text(
              label,
              style: TextStyle(
                fontSize: getFixedWidth(14),
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: getFixedWidth(14),
                color: isOverdue ? Colors.red : Colors.grey[800],
                fontStyle: isOverdue ? FontStyle.italic : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditTaskDialog(BuildContext context, TodoItem task) {
    final trans = S.of(context);
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(
      text: task.description ?? '',
    );
    PriorityLevel selectedPriority = task.priority;
    DateTime? selectedDueDate = task.dueDate;
    int? selectedRecurringDay = task.recurringDay;
    // تحويل مفتاح الفئة إلى اسم معروض
    String? selectedCategory =
        task.category != null
            ? Provider.of<TodoProvider>(
              context,
              listen: false,
            ).getCategoryDisplayName(task.category!, context)
            : null;

    showDialog(
      context: context,
      builder:
          (_) => CustomAlertDialog(
            title: trans.editTask,
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
                  // تحويل الفئة المعروضة إلى مفتاح قبل الحفظ
                  final categoryKey =
                      selectedCategory != null
                          ? Provider.of<TodoProvider>(
                            context,
                            listen: false,
                          ).getCategoryKey(selectedCategory!, context)
                          : null;

                  final updatedTask = task.copyWith(
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    priority: selectedPriority,
                    dueDate: selectedDueDate,
                    recurringDay: selectedRecurringDay,
                    category: categoryKey, // أضفنا الفئة هنا
                  );

                  context.read<TodoProvider>().updateTodo(task.id, updatedTask);
                  MassengerService.success(trans.taskUpdated);
                  NavigationService.goBack();
                },
                child: Text(
                  trans.update,
                  style: TextStyle(fontSize: getFixedWidth(14)),
                ),
              ),
            ],
          ),
    );
  }
}
