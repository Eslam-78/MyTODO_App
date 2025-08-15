import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/models/todo_item.dart';
import 'package:mytodo_app/core/services/storage_service.dart';

class TodoProvider with ChangeNotifier {
  final StorageService _storage;
  List<TodoItem> _todos = [];
  String? _currentFilter;

  TodoProvider(this._storage) {
    _loadTodos();
  }

  List<TodoItem> get todos =>
      _currentFilter != null
          ? _todos.where((t) => t.category == _currentFilter).toList()
          : _todos;

  List<TodoItem> get completedTodos =>
      todos.where((t) => t.isCompleted).toList();
  List<TodoItem> get pendingTodos =>
      todos.where((t) => !t.isCompleted).toList();

  List<String> getTaskStatuses(BuildContext context) =>
      getTranslatedTaskStatuses(context);

  List<TodoItem> getFilteredTasks({String? categoryKey, String? statusKey}) {
    Iterable<TodoItem> filteredTasks = _todos;

    // فلترة حسب الفئة
    if (categoryKey != null && categoryKey != 'all') {
      filteredTasks = filteredTasks.where((t) => t.category == categoryKey);
    }

    // فلترة حسب الحالة
    if (statusKey != null && statusKey != 'all') {
      filteredTasks = filteredTasks.where(
        (t) =>
            (statusKey == 'completed' && t.isCompleted) ||
            (statusKey == 'pending' && !t.isCompleted),
      );
    }

    return filteredTasks.toList();
  }

  // خريطة المفاتيح الثابتة للفئات
  static const Map<String, String> _categoryKeys = {
    'all': 'all',
    'work': 'work',
    'personal': 'personal',
    'shopping': 'shopping',
    'fitness': 'fitness',
    'study': 'study',
    'health': 'health',
    'finance': 'finance',
  };
  // خريطة المفاتيح الثابتة للحالات
  static const Map<String, String> _statusKeys = {
    'all': 'all',
    'pending': 'pending',
    'completed': 'completed',
  };

  // الحصول على الفئات مترجمة للعرض
  static List<String> getCategories(BuildContext context) {
    final s = S.of(context);
    return _categoryKeys.values
        .map((key) => _getCategoryDisplayName(key, s))
        .toList();
  }

  // الحصول على الحالات مترجمة للعرض
  static List<String> getTranslatedTaskStatuses(BuildContext context) {
    final s = S.of(context);
    return _statusKeys.values
        .map((key) => _getStatusDisplayName(key, s))
        .toList();
  }

  // تحويل الاسم المعروض إلى مفتاح
  String? getCategoryKey(String? displayedCategory, BuildContext context) {
    if (displayedCategory == null) return null;
    final s = S.of(context);
    for (final entry in _categoryKeys.entries) {
      if (_getCategoryDisplayName(entry.value, s) == displayedCategory) {
        return entry.value;
      }
    }
    return null;
  }

  // تحويل الاسم المعروض إلى مفتاح
  String? getStatusKey(String? displayedStatus, BuildContext context) {
    if (displayedStatus == null) return null;
    final s = S.of(context);
    for (final entry in _statusKeys.entries) {
      if (_getStatusDisplayName(entry.value, s) == displayedStatus) {
        return entry.value;
      }
    }
    return null;
  }

  // تحويل المفتاح إلى اسم معروض
  String getCategoryDisplayName(String key, BuildContext context) {
    return _getCategoryDisplayName(key, S.of(context));
  }

  // تحويل المفتاح إلى اسم معروض
  String getStatusDisplayName(String key, BuildContext context) {
    return _getStatusDisplayName(key, S.of(context));
  }

  // دالة مساعدة لترجمة المفتاح
  static String _getCategoryDisplayName(String key, S s) {
    switch (key) {
      case 'all':
        return s.all;
      case 'work':
        return s.work;
      case 'personal':
        return s.personal;
      case 'shopping':
        return s.shopping;
      case 'fitness':
        return s.fitness;
      case 'study':
        return s.study;
      case 'health':
        return s.health;
      case 'finance':
        return s.finance;
      default:
        return key;
    }
  }

  // دالة مساعدة لترجمة المفتاح
  static String _getStatusDisplayName(String key, S s) {
    switch (key) {
      case 'all':
        return s.all;
      case 'pending':
        return s.pending;
      case 'completed':
        return s.completed;
      default:
        return key;
    }
  }

  Future<void> _loadTodos() async {
    _todos = await _storage.loadTodos();
    notifyListeners();
  }

  Future<void> _saveTodos() async {
    await _storage.saveTodos(_todos);
  }

  void addTodo(TodoItem todo) {
    _todos.add(todo);
    _saveTodos();
    notifyListeners();
  }

  void updateTodo(String id, TodoItem newTodo) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      _todos[index] = newTodo;
      _saveTodos();
      notifyListeners();
    }
  }

  void toggleComplete(String id) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      final isNowCompleted = !_todos[index].isCompleted;
      final updatedTask = _todos[index].copyWith(
        isCompleted: isNowCompleted,
        completedAt: isNowCompleted ? DateTime.now() : null,
      );
      _todos[index] = updatedTask;

      _saveTodos();
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    _saveTodos();
    notifyListeners();
  }

  void applyFilter(String? category) {
    _currentFilter = category;
    notifyListeners();
  }

  void clearCompleted() {
    _todos = _todos.where((t) => !t.isCompleted).toList();
    _saveTodos();
    notifyListeners();
  }

  Future<void> reorderTodos(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) newIndex--;
    final item = _todos.removeAt(oldIndex);
    _todos.insert(newIndex, item);
    _saveTodos();
    notifyListeners();
  }
}
