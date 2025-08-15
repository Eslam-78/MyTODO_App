import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytodo_app/core/utils/priority_helper.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/models/priority_level.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/providers/todo_provider.dart';

List<Widget> buildDialogFields(
  BuildContext context,
  S trans,
  TextEditingController titleController,
  TextEditingController descriptionController,
  PriorityLevel selectedPriority,
  ValueChanged<PriorityLevel?> onPriorityChanged,
  DateTime? selectedDueDate,
  ValueChanged<DateTime?> onDateChanged,
  int? selectedRecurringDay,
  ValueChanged<int?> onRecurringDayChanged,
  String? selectedCategory,
  ValueChanged<String?> onCategoryChanged, // أضفت هذا البارامت
) {
  return [
    TextField(
      controller: titleController,
      decoration: InputDecoration(
        labelText: trans.taskTitle,
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.all(getFixedWidth(12)),
      ),
    ),
    SizedBox(height: getFixedHeight(12)),
    TextField(
      controller: descriptionController,
      decoration: InputDecoration(
        labelText: trans.taskDescription,
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.all(getFixedWidth(12)),
      ),
    ),
    SizedBox(height: getFixedHeight(12)),
    DropdownButtonFormField<String>(
      value: selectedCategory,
      decoration: InputDecoration(labelText: trans.category),
      items:
          TodoProvider.getCategories(context)
              .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
              .toList(),
      onChanged: onCategoryChanged, // استخدمنا البارامتر الجديد هنا
      isExpanded: true,
      hint: Text(trans.selectCategory),
    ),
    SizedBox(height: getFixedHeight(12)),
    DropdownButtonFormField<PriorityLevel>(
      value: selectedPriority,
      items:
          PriorityLevel.values.map((priority) {
            return DropdownMenuItem(
              value: priority,
              child: Text(PriorityHelper.getTranslatedName(context, priority)),
            );
          }).toList(),
      onChanged: onPriorityChanged,
      decoration: InputDecoration(labelText: trans.priority),
    ),
    SizedBox(height: getFixedHeight(12)),
    ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        selectedDueDate == null
            ? trans.selectDueDate
            : DateFormat.yMMMd().format(selectedDueDate),
      ),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final now = DateTime.now();
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDueDate ?? now,
          firstDate: now,
          lastDate: now.add(const Duration(days: 365)),
        );
        if (pickedDate != null) {
          onDateChanged(pickedDate);
        }
      },
    ),
    SizedBox(height: getFixedHeight(12)),
    DropdownButtonFormField<int>(
      value: selectedRecurringDay,
      decoration: InputDecoration(labelText: trans.repeatWeeklyLabel),
      items: List.generate(7, (index) {
        final days = [
          trans.monday,
          trans.tuesday,
          trans.wednesday,
          trans.thursday,
          trans.friday,
          trans.saturday,
          trans.sunday,
        ];
        return DropdownMenuItem(value: index + 1, child: Text(days[index]));
      }),
      onChanged: onRecurringDayChanged,
      isExpanded: true,
      hint: Text(trans.repeatHint),
    ),
  ];
}
