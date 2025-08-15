import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  /// هذه المتغيّر يتم التحكم به من SettingsProvider
  static bool notificationsEnabled = true;

  static Future<void> initialize() async {
    initializeTimeZones();
    // تهيئة المنطقة الزمنية
    // يجب تعيين المنطقة الزمنية المحلية
    try {
      final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
      setLocalLocation(getLocation(currentTimeZone));
    } catch (e) {
      setLocalLocation(getLocation('Asia/Aden'));
    }
    // تهيئة الإشعارات
    // يجب تهيئة الإشعارات قبل استخدامها
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _notificationsPlugin.initialize(initializationSettings);

    // تهيئة القناة (مهم جداً)
  }

  static Future<void> showInstantNotification({required int id, required String title, required String body}) async {
    if (!notificationsEnabled) return;
    // تأكد من أن الإشعارات مفعلة
    await _notificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_notification_channel_id',
          'Instant Notifications',
          channelDescription: 'Instant notifications channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  static Future<void> scheduleNotification({required int id, required String title, required String body}) async {
    if (!notificationsEnabled) return;
    // تأكد من أن الإشعارات مفعلة
    TZDateTime now = TZDateTime.now(local);
    TZDateTime scheduledDate = now.add(Duration(seconds: 3));
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'Daily_reminder_channel_id',
          'Daily Reminders',
          channelDescription: 'Reminders for daily tasks',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
