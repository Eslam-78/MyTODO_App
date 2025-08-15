import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate(DateTime date, {String pattern = 'EEE, MMM d'}) {
    return DateFormat(pattern).format(date);
  }

  static String formatTime(DateTime time, {String pattern = 'h:mm a'}) {
    return DateFormat(pattern).format(time);
  }

  static String formatDateTime(DateTime dateTime) {
    return '${formatDate(dateTime)} at ${formatTime(dateTime)}';
  }

  static DateTime getStartOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime getEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return isSameDay(date, now);
  }

  static bool isPastDue(DateTime dueDate) {
    return dueDate.isBefore(DateTime.now());
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static String getRelativeDate(DateTime date) {
    final now = DateTime.now();
    final difference = daysBetween(date, now);

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference == -1) return 'Tomorrow';
    if (difference < -1 && difference > -7) return 'In ${-difference} days';
    if (difference > 1 && difference < 7) return '$difference days ago';

    return formatDate(date);
  }

  static String getTimePeriod({
    required String morning,
    required String evening,
  }) {
    final hour = DateTime.now().hour;
    return hour < 12 ? morning : evening;
  }
}
