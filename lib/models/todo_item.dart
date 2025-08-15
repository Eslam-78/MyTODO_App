import 'package:mytodo_app/models/priority_level.dart';

class TodoItem {
  final String id;
  final String title;
  final String? description;
  final String? taskStatus;
  final bool isCompleted;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime? completedAt;
  final PriorityLevel priority;
  final List<String> tags;
  final String? category;
  final int? recurringDay;
  final String? parentTaskId; // ← الحقل الجديد
  final List<TodoItem> subTasks; // <== هذه الإضافة
  TodoItem({
    String? id,
    required this.title,
    this.description,
    this.isCompleted = false,
    this.taskStatus,
    this.dueDate,
    DateTime? createdAt,
    this.completedAt,
    this.priority = PriorityLevel.medium,
    this.tags = const [],
    this.category,
    this.recurringDay,
    this.parentTaskId, // ← هنا
    this.subTasks = const [], // <== هذه الإضافة
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
       createdAt = createdAt ?? DateTime.now();

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      isCompleted: json['isCompleted'] as bool? ?? false,
      taskStatus: json['taskStatus'] as String?,
      dueDate:
          json['dueDate'] != null
              ? DateTime.parse(json['dueDate'] as String)
              : null,
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'] as String)
              : null,
      completedAt:
          json['completedAt'] != null
              ? DateTime.parse(json['completedAt'] as String)
              : null,
      priority: PriorityLevel.fromValue(json['priority'] as int? ?? 2),
      tags: List<String>.from(json['tags'] as List<dynamic>? ?? []),
      category: json['category'] as String?,
      recurringDay: json['recurringDay'] as int?,
      parentTaskId: json['parentTaskId'] as String?, // ← هنا

      subTasks:
          (json['subTasks'] as List<dynamic>?)
              ?.map((item) => TodoItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'taskStatus': taskStatus,
      'dueDate': dueDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'priority': priority.value,
      'tags': tags,
      'category': category,
      'recurringDay': recurringDay,
      'parentTaskId': parentTaskId, // ← هنا

      'subTasks': subTasks.map((task) => task.toJson()).toList(),
    };
  }

  TodoItem copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? completedAt,
    String? taskStatus,
    PriorityLevel? priority,
    List<String>? tags,
    String? category,
    int? recurringDay,
    String? parentTaskId, // ← هنا

    List<TodoItem>? subTasks, // <== هذه الإضافة
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      taskStatus: taskStatus ?? this.taskStatus,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      priority: priority ?? this.priority,
      tags: tags ?? this.tags,
      category: category ?? this.category,
      recurringDay: recurringDay ?? this.recurringDay,
      parentTaskId: parentTaskId ?? this.parentTaskId, // ← هنا

      subTasks: subTasks ?? this.subTasks, // <== هذه الإضافة
    );
  }

  @override
  String toString() {
    return 'TodoItem(id: $id, title: $title, isCompleted: $isCompleted)';
  }
}
