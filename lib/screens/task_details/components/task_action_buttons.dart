import 'package:flutter/material.dart';
import 'package:mytodo_app/core/services/navigation_service.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/models/todo_item.dart';
import 'package:mytodo_app/providers/todo_provider.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:provider/provider.dart';
import 'package:mytodo_app/core/services/massenger_service.dart';

class TaskActionButtons extends StatelessWidget {
  final TodoItem task;

  const TaskActionButtons({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);
    final provider = Provider.of<TodoProvider>(context, listen: false);

    return Column(
      children: [
        Row(
          children: [
            // زر تغيير الحالة
            Expanded(
              child: ElevatedButton.icon(
                icon: Icon(
                  task.isCompleted ? Icons.refresh : Icons.check,
                  size: getFixedWidth(18),
                  color: Colors.white,
                ),
                label: Text(
                  task.isCompleted ? transalateText.reopen : transalateText.markComplete,
                  style: TextStyle(fontSize: getFixedWidth(14), color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  provider.toggleComplete(task.id);
                  MassengerService.success(
                    task.isCompleted ? transalateText.taskReopened : transalateText.taskCompleted,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: task.isCompleted ? Colors.tealAccent[700] : Colors.redAccent[700],
                  padding: EdgeInsets.symmetric(vertical: getFixedHeight(14)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getFixedWidth(10))),
                ),
              ),
            ),
            SizedBox(width: getFixedWidth(12)),

            // زر الحذف
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400],
                padding: EdgeInsets.all(getFixedWidth(14)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getFixedWidth(10))),
              ),
              onPressed: () => _confirmDelete(context, provider),
              child: Icon(Icons.delete, size: getFixedWidth(20), color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: getFixedHeight(12)),
        // زر جديد لاقتراح المهام
        /*  OutlinedButton.icon(
          icon: Icon(Icons.lightbulb_outline, size: getFixedWidth(18)),
          label: Text(
            transalateText.taskSuggestions,
            style: TextStyle(fontSize: getFixedWidth(14)),
          ),
          onPressed: () => _showTaskSuggestions(context, provider),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: getFixedHeight(14)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getFixedWidth(10)),
            ),
          ),
        ),*/
      ],
    );
  }

  /*void _showTaskSuggestions(BuildContext context, TodoProvider provider) {
    final suggestionService = TaskSuggestionService();
    final suggestions = suggestionService.generateSubTasks(task);

    if (suggestions.isEmpty) {
      MassengerService.info(S.of(context).noSuggestionsAvailable);
      return;
    }
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(S.of(context).taskSuggestions),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = suggestions[index];
                  return ListTile(
                    title: Text(suggestion.title),
                    subtitle:
                        suggestion.dueDate != null
                            ? Text(
                              DateFormat(
                                'yyyy/MM/dd',
                              ).format(suggestion.dueDate!),
                            )
                            : null,
                    trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        provider.addTodo(
                          suggestion.copyWith(
                            createdAt: DateTime.now(),
                            parentTaskId:
                                task.id, // نضيف هذا إذا كان لديك حقل للمهام الفرعية
                          ),
                        );
                        NavigationService.goBack();
                        MassengerService.success(
                          '${S.of(context).taskAdded}: ${suggestion.title}',
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => NavigationService.goBack(),
                child: Text(S.of(context).cancel),
              ),
            ],
          ),
    );
  }
*/
  void _confirmDelete(BuildContext context, TodoProvider provider) {
    final transalateText = S.of(context);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(transalateText.deleteTask, style: TextStyle(fontSize: getFixedWidth(18))),
            content: Text(transalateText.deleteConfirmation, style: TextStyle(fontSize: getFixedWidth(14))),
            actions: [
              TextButton(
                onPressed: () => NavigationService.goBack(),
                child: Text(transalateText.cancel, style: TextStyle(fontSize: getFixedWidth(14))),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  padding: EdgeInsets.symmetric(horizontal: getFixedWidth(16), vertical: getFixedHeight(10)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getFixedWidth(8))),
                ),
                onPressed: () {
                  provider.deleteTodo(task.id);
                  NavigationService.goBack(); // أغلق الدايلوج
                  NavigationService.goBack(); // أغلق صفحة التفاصيل
                  MassengerService.success(transalateText.taskDeleted);
                },
                child: Text(transalateText.delete, style: TextStyle(fontSize: getFixedWidth(14), color: Colors.white)),
              ),
            ],
          ),
    );
  }
}
