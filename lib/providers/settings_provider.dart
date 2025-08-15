import 'package:flutter/material.dart';
import 'package:mytodo_app/core/services/notification_service.dart';
import 'package:mytodo_app/core/services/storage_service.dart';
import 'package:mytodo_app/models/user_preferences.dart';

class SettingsProvider with ChangeNotifier {
  UserPreferences _preferences = UserPreferences();
  final StorageService _storage;
  bool _isInitialized = false;

  SettingsProvider({required StorageService storage}) : _storage = storage {
    _initialize();
  }
  Future<void> _initialize() async {
    await loadPreferences();
    _isInitialized = true;
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await _initialize();
    }
  }

  UserPreferences get preferences => _preferences;

  Future<void> updateThemeMode(ThemeMode mode) async {
    await _ensureInitialized();
    _preferences = _preferences.copyWith(themeMode: mode);
    await _storage.savePreferences(_preferences.toJson());
    notifyListeners();
  }

  Future<void> updateLocale(Locale locale) async {
    await _ensureInitialized();
    _preferences = _preferences.copyWith(locale: locale);
    await _storage.savePreferences(_preferences.toJson());
    notifyListeners();
  }

  Future<void> toggleNotifications(bool enable) async {
    NotificationService.notificationsEnabled = enable;
    _preferences = _preferences.copyWith(receiveNotifications: enable);
    if (!enable) {
      await NotificationService.cancelAllNotifications();
    }
    await _storage.savePreferences(_preferences.toJson());
    notifyListeners();
  }

  Future<void> updateReminderTime(TimeOfDay time) async {
    _preferences = _preferences.copyWith(reminderTime: time);
    await _storage.savePreferences(_preferences.toJson());
    notifyListeners();
  }

  Future<void> updateAvatar(String path) async {
    _preferences = _preferences.copyWith(avatarPath: path);
    await _storage.savePreferences(_preferences.toJson());
    notifyListeners();
  }

  Future<void> loadPreferences() async {
    final json = await _storage.loadPreferences();
    if (json != null) {
      _preferences = UserPreferences.fromJson(json);
      notifyListeners();
    }
  }

  Future<void> toggleDailyReminders(bool enable) async {
    _preferences = _preferences.copyWith(dailyReminders: enable);
    await _storage.savePreferences(_preferences.toJson());
    notifyListeners();
  }

  Future<void> toggleNotificationVibration(bool enable) async {
    _preferences = _preferences.copyWith(notificationVibration: enable);
    await _storage.savePreferences(_preferences.toJson());
    notifyListeners();
  }

  Future<void> resetToDefaults() async {
    _preferences = UserPreferences();
    await _storage.savePreferences(_preferences.toJson());
    notifyListeners();
  }
}
