import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:mytodo_app/models/todo_item.dart';

class CalendarService {
  final CalendarApi? _calendarApi; // جعله nullable

  CalendarService({CalendarApi? calendarApi}) : _calendarApi = calendarApi;

  static Future<CalendarService> initialize() async {
    try {
      final authClient = await _authenticate();
      return CalendarService(calendarApi: CalendarApi(authClient));
    } catch (e) {
      print('Google Auth failed: $e');
      return CalendarService(); // يعيد نسخة بدون CalendarApi
    }
  }

  static Future<AuthClient> _authenticate() async {
    throw UnimplementedError('Google Auth not implemented yet');
  }

  // أضف تحققًا من null قبل استخدام _calendarApi
  Future<void> syncTodoWithCalendar(TodoItem todo) async {
    if (_calendarApi == null) return; // لا يفعل شيئًا إذا لم يكن هناك اتصال

    final event =
        Event()
          ..summary = todo.title
          ..description = 'Todo Task'
          ..start = EventDateTime(dateTime: DateTime.now())
          ..end = EventDateTime(dateTime: DateTime.now().add(Duration(hours: 1)));

    await _calendarApi.events.insert(event, 'primary');
  }
}
