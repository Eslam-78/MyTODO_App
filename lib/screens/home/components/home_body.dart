import 'package:flutter/material.dart';
import 'package:mytodo_app/components/task_filter_utils.dart';
import 'package:mytodo_app/screens/home/components/search_field.dart';
import 'package:mytodo_app/screens/home/components/task_list_section.dart';
import 'package:mytodo_app/screens/todo/components/task_filter.dart';
import 'package:provider/provider.dart';
import 'package:mytodo_app/core/services/ai_boot_service.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/providers/gamification_provider.dart';
import 'package:mytodo_app/providers/todo_provider.dart';
import 'package:mytodo_app/screens/home/components/category_filter.dart';
import 'package:mytodo_app/screens/home/components/greeting_with_time_header.dart';
import 'package:mytodo_app/screens/home/components/progress_summary.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String? _selectedCategoryKey;
  String _searchQuery = '';
  String? _selectedStatusKey; // أضفنا فلتر الحالة

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => AIBootService.smartStartup(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();
    final gamificationProvider = context.watch<GamificationProvider>();
    final tasks = TaskFilterUtils.filterTasks(
      context: context,
      tasks: todoProvider.todos,
      selectedStatus:
          _selectedStatusKey != null
              ? todoProvider.getStatusDisplayName(_selectedStatusKey!, context)
              : null,
      searchQuery: _searchQuery,
      selectedCategory:
          _selectedCategoryKey != null
              ? todoProvider.getCategoryDisplayName(
                _selectedCategoryKey!,
                context,
              )
              : null,
    );

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getFixedWidth(10)),
                child: Column(
                  children: [
                    const GreetingWithTimeHeader(),
                    ProgressSummary(
                      completedTasks: todoProvider.completedTodos.length,
                      totalTasks: todoProvider.todos.length,
                      dayStreak: gamificationProvider.currentStreak,
                      weeklyStats: gamificationProvider.weeklyTotal,
                    ),
                    SizedBox(height: getFixedHeight(12)),
                    CategoryFilter(
                      categories: TodoProvider.getCategories(context),
                      selectedCategory:
                          _selectedCategoryKey != null
                              ? todoProvider.getCategoryDisplayName(
                                _selectedCategoryKey!,
                                context,
                              )
                              : null,
                      onCategorySelected: (category) {
                        final key = todoProvider.getCategoryKey(
                          category,
                          context,
                        );
                        setState(() => _selectedCategoryKey = key);
                      },
                    ),
                    SizedBox(height: getFixedHeight(12)),
                    TaskFilter(
                      taskStatuses: todoProvider.getTaskStatuses(context),
                      selectedStatus:
                          _selectedStatusKey != null
                              ? todoProvider.getStatusDisplayName(
                                _selectedStatusKey!,
                                context,
                              )
                              : null,

                      onStatusChanged: (status) {
                        final key = todoProvider.getStatusKey(status, context);
                        setState(() => _selectedStatusKey = key);
                      },
                    ),
                    SizedBox(height: getFixedHeight(16)),
                    SearchField(
                      onSearchChanged:
                          (value) => setState(() => _searchQuery = value),
                    ),

                    TaskListSection(
                      tasks: tasks,
                      onTaskCompleted: (taskId) {
                        todoProvider.toggleComplete(taskId);
                        gamificationProvider
                          ..updateStreaks(todoProvider.completedTodos, context)
                          ..updateWeeklyStats(todoProvider.todos)
                          ..calculateDynamicXp(
                            todoProvider.todos.firstWhere(
                              (t) => t.id == taskId,
                            ),
                            context,
                          );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
