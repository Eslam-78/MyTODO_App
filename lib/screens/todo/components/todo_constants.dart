enum TaskFilterOption { all, completed, pending }

extension TaskFilterOptionExtension on TaskFilterOption {
  String get displayName {
    switch (this) {
      case TaskFilterOption.all:
        return "all";
      case TaskFilterOption.completed:
        return "completed";
      case TaskFilterOption.pending:
        return "pending";
    }
  }
}
