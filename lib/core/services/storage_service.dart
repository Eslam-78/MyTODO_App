import 'package:mytodo_app/models/todo_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

abstract class StorageService {
  Future<void> initialize();
  Future<List<TodoItem>> loadTodos();
  Future<void> saveTodos(List<TodoItem> todos);
  Future<void> clearStorage();
  // Gamification Methods
  Future<Map<String, dynamic>> loadGamificationData();
  Future<void> saveGamificationData(Map<String, dynamic> data);

  Future<List<Map<String, dynamic>>> loadBadges();
  Future<void> saveBadges(List<Map<String, dynamic>> badges);
  //Preferences Methods
  Future<Map<String, dynamic>?> loadPreferences();
  Future<void> savePreferences(Map<String, dynamic> preferences);
}

class SharedPrefsStorage implements StorageService {
  static const _todosKey = 'todos_list';
  static const _gamificationKey = 'gamification_data';
  static const _badgesKey = 'unlocked_badges';

  static const _preferencesKey = 'user_preferences';
  late SharedPreferences _prefs;

  @override
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<List<TodoItem>> loadTodos() async {
    final jsonString = _prefs.getString(_todosKey) ?? '[]';
    final jsonList = jsonDecode(jsonString) as List;
    return jsonList.map((e) => TodoItem.fromJson(e)).toList();
  }

  @override
  Future<void> saveTodos(List<TodoItem> todos) async {
    final jsonList = todos.map((e) => e.toJson()).toList();
    await _prefs.setString(_todosKey, jsonEncode(jsonList));
  }

  @override
  Future<void> clearStorage() async {
    await _prefs.clear();
  }

  // تنفيذ الوظائف الجديدة
  @override
  Future<Map<String, dynamic>?> loadPreferences() async {
    final jsonString = _prefs.getString(_preferencesKey);
    if (jsonString != null) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Future<void> saveGamificationData(Map<String, dynamic> data) async {
    await _prefs.setString(_gamificationKey, jsonEncode(data));
  }

  @override
  Future<Map<String, dynamic>> loadGamificationData() async {
    final jsonString = _prefs.getString(_gamificationKey) ?? '{}';
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  @override
  Future<void> saveBadges(List<Map<String, dynamic>> badges) async {
    await _prefs.setString(_badgesKey, jsonEncode(badges));
  }

  @override
  Future<List<Map<String, dynamic>>> loadBadges() async {
    final jsonString = _prefs.getString(_badgesKey) ?? '[]';
    final jsonList = jsonDecode(jsonString) as List;
    return jsonList.cast<Map<String, dynamic>>();
  }

  @override
  Future<void> savePreferences(Map<String, dynamic> preferences) async {
    await _prefs.setString(_preferencesKey, jsonEncode(preferences));
  }
}
