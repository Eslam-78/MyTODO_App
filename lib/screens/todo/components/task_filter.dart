import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/screens/home/components/section_header.dart';

class TaskFilter extends StatelessWidget {
  final List<String> taskStatuses;
  final String? selectedStatus;
  final Function(String?) onStatusChanged;

  const TaskFilter({
    super.key,
    required this.taskStatuses,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      children: [
        SectionHeader(title: s.taskStatus),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                taskStatuses.map((stat) {
                  final isSelected =
                      selectedStatus == stat; // هنا تأكدنا من null-safe
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      label: Text(stat),
                      selected: isSelected,
                      onSelected: (_) => onStatusChanged(stat),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
