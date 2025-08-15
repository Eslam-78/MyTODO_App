import 'package:flutter/material.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? action;

  const SectionHeader({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getFixedWidth(5),
        vertical: getFixedHeight(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: getFixedWidth(16),
            ),
          ),
          action ?? const SizedBox(),
        ],
      ),
    );
  }
}
