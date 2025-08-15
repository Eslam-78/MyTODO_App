import 'package:flutter/material.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/generated/l10n.dart';

class SearchField extends StatelessWidget {
  final void Function(String)? onSearchChanged;

  const SearchField({super.key, this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getFixedWidth(16)),
      child: TextField(
        decoration: InputDecoration(
          hintText: S.of(context).searchTasks,
          prefixIcon: Icon(Icons.search, size: getFixedWidth(20)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(getFixedWidth(12)),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: getFixedHeight(12),
            horizontal: getFixedWidth(16),
          ),
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
