import 'package:flutter/material.dart';
import 'package:mytodo_app/core/constants/app_routes.dart';
import 'package:mytodo_app/core/constants/opacity_levels.dart';
import 'package:mytodo_app/core/services/massenger_service.dart';
import 'package:mytodo_app/core/services/navigation_service.dart';
import 'package:mytodo_app/core/utils/date_helper.dart';
import 'package:mytodo_app/core/utils/priority_helper.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/models/todo_item.dart';

class TaskItem extends StatelessWidget {
  final TodoItem task;
  final VoidCallback onCompleted;

  const TaskItem({super.key, required this.task, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    final isLate =
        task.dueDate != null && task.dueDate!.isBefore(DateTime.now());
    final color = PriorityHelper.getPriorityColor(task.priority);
    final s = S.of(context);

    return GestureDetector(
      onTap:
          () => NavigationService.navigateTo(
            AppRoutes.taskDetails,
            arguments: {'id': task.id},
          ),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: getFixedHeight(8),
          horizontal: getFixedWidth(16),
        ),
        padding: EdgeInsets.all(getFixedWidth(16)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient:
              task.isCompleted
                  ? LinearGradient(
                    colors: [
                      OpacityLevels.apply(color, OpacityLevels.level10),
                      Colors.white,
                    ],
                  )
                  : null,
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
          color: task.isCompleted ? Colors.white : Colors.grey[50],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Interactive Checkbox
            GestureDetector(
              onTap: () {
                onCompleted();
                final message =
                    task.isCompleted ? s.turnUnchecked : s.turnChecked;
                MassengerService.info(
                  message,
                  duration: const Duration(seconds: 2),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: task.isCompleted ? color : Colors.transparent,
                  border: Border.all(color: color, width: 2),
                ),
                width: getFixedWidth(28),
                height: getFixedHeight(28),
                child:
                    task.isCompleted
                        ? const Icon(Icons.check, color: Colors.white, size: 18)
                        : null,
              ),
            ),
            SizedBox(width: getFixedWidth(16)),

            // Task Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Description
                  if (task.description?.isNotEmpty ?? false)
                    Padding(
                      padding: EdgeInsets.only(top: getFixedHeight(4)),
                      child: Text(
                        task.description!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                  // Date
                  if (task.dueDate != null)
                    Padding(
                      padding: EdgeInsets.only(top: getFixedHeight(6)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: isLate ? Colors.red : Colors.green,
                          ),
                          SizedBox(width: getFixedWidth(4)),
                          Text(
                            DateHelper.getRelativeDate(task.dueDate!),
                            style: TextStyle(
                              color: isLate ? Colors.red : Colors.green,
                              fontSize: getFixedWidth(13),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Priority icon
            Icon(
              PriorityHelper.getPriorityIcon(task.priority),
              color: color,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
