import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';

class TaskSearchField extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;

  const TaskSearchField({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: transalateText.searchTasks,
        border: const OutlineInputBorder(),
      ),
      onChanged: onSearchChanged,
    );
  }
}
