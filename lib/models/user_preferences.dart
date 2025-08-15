import 'package:flutter/material.dart';

class UserPreferences {
  final ThemeMode themeMode;
  final Locale locale;
  final bool receiveNotifications;
  final bool dailyReminders;
  final TimeOfDay reminderTime;
  final bool notificationVibration;
  final String? avatarPath;

  UserPreferences({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('ar'),
    this.receiveNotifications = true,
    this.dailyReminders = true,
    TimeOfDay? reminderTime,
    this.notificationVibration = true,
    this.avatarPath,
  }) : reminderTime = reminderTime ?? const TimeOfDay(hour: 9, minute: 0);

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      themeMode: ThemeMode.values[json['themeMode'] as int? ?? 0],
      locale: Locale(json['locale'] as String? ?? 'ar'),
      receiveNotifications: json['receiveNotifications'] as bool? ?? true,
      dailyReminders: json['dailyReminders'] as bool? ?? true,
      reminderTime:
          json['reminderTime'] != null
              ? TimeOfDay(hour: json['reminderTime']['hour'] as int, minute: json['reminderTime']['minute'] as int)
              : null,
      notificationVibration: json['notificationVibration'] as bool? ?? true,
      avatarPath: json['avatarPath'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.index,
      'locale': locale.languageCode,
      'receiveNotifications': receiveNotifications,
      'dailyReminders': dailyReminders,
      'reminderTime': {'hour': reminderTime.hour, 'minute': reminderTime.minute},
      'notificationVibration': notificationVibration,
      'avatarPath': avatarPath,
    };
  }

  UserPreferences copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool? receiveNotifications,
    bool? dailyReminders,
    TimeOfDay? reminderTime,
    bool? notificationVibration,
    String? avatarPath,
  }) {
    return UserPreferences(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      receiveNotifications: receiveNotifications ?? this.receiveNotifications,
      dailyReminders: dailyReminders ?? this.dailyReminders,
      reminderTime: reminderTime ?? this.reminderTime,
      notificationVibration: notificationVibration ?? this.notificationVibration,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }

  @override
  String toString() {
    return 'UserPreferences(themeMode: $themeMode, locale: $locale)';
  }
}
