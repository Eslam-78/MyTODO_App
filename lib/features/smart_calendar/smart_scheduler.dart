/*import 'package:flutter/material.dart';
import 'package:mytodo_app/models/todo_item.dart';
import 'package:mytodo_app/core/services/calendar_service.dart';
import 'package:mytodo_app/core/utils/date_helper.dart';
import 'package:timezone/timezone.dart' as tz;

class SmartScheduler {
  final CalendarService _calendarService;

  SmartScheduler(this._calendarService);

  Future<void> scheduleTaskAutomatically(TodoItem task) async {
    if (task.dueDate == null) {
      // إذا لم يكن هناك تاريخ استحقاق، نضيفه إلى التقويم اليوم
      await _scheduleForToday(task);
    } else {
      // إذا كان هناك تاريخ استحقاق، نضيفه قبل يومين كتذكير
      await _scheduleWithReminder(task);
    }
  }

  Future<void> _scheduleForToday(TodoItem task) async {
    final startTime = tz.TZDateTime.now(tz.local);
    final endTime = startTime.add(const Duration(hours: 1));

    await _calendarService.syncTodoWithCalendar(
      task.copyWith(dueDate: startTime),
    );
  }

  Future<void> _scheduleWithReminder(TodoItem task) async {
    final reminderDate = task.dueDate!.subtract(const Duration(days: 2));

    await _calendarService.syncTodoWithCalendar(
      task.copyWith(dueDate: reminderDate),
    );
  }

  Future<List<TodoItem>> rescheduleOverdueTasks(List<TodoItem> tasks) async {
    final now = DateTime.now();
    final rescheduledTasks = <TodoItem>[];

    for (final task in tasks) {
      if (task.dueDate != null && task.dueDate!.isBefore(now)) {
        final newDueDate = _calculateNewDueDate(task.dueDate!);
        final rescheduledTask = task.copyWith(dueDate: newDueDate);

        await _calendarService.syncTodoWithCalendar(rescheduledTask);
        rescheduledTasks.add(rescheduledTask);
      }
    }

    return rescheduledTasks;
  }

  DateTime _calculateNewDueDate(DateTime oldDueDate) {
    // إعادة جدولة المهمة المتأخرة لتصبح بعد 3 أيام من اليوم
    return DateTime.now().add(const Duration(days: 3));
  }

  /* Future<List<DateTime>> findAvailableSlots(
    DateTime date,
    Duration duration,
  ) async {
    final events = await _calendarService.getUpcomingEvents();
    final busySlots =
        events
            .map(
              (e) => DateTimeRange(
                start: e.start?.dateTime ?? DateTime.now(),
                end: e.end?.dateTime ?? DateTime.now(),
              ),
            )
            .toList();

    return _findFreeTimeSlots(date, duration, busySlots);
  }*/

  List<DateTime> findFreeTimeSlots(
    DateTime date,
    Duration duration,
    List<DateTimeRange> busySlots,
  ) {
    // خوارزمية لإيجاد أوقات فارغة في التقويم
    final freeSlots = <DateTime>[];
    final dayStart = DateHelper.getStartOfDay(date);
    final dayEnd = DateHelper.getEndOfDay(date);

    DateTime currentSlot = dayStart;

    while (currentSlot.add(duration).isBefore(dayEnd)) {
      bool isBusy = busySlots.any(
        (slot) =>
            currentSlot.isAfter(slot.start) && currentSlot.isBefore(slot.end),
      );

      if (!isBusy) {
        freeSlots.add(currentSlot);
      }

      currentSlot = currentSlot.add(const Duration(minutes: 30));
    }

    return freeSlots;
  }
}
*/
