import 'package:flutter/material.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;

  const CustomAppBar({super.key, required this.title, this.centerTitle = true, this.actions, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Text(title, style: TextStyle(fontSize: getFixedWidth(20), fontWeight: FontWeight.bold)),
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
