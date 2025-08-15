import 'package:flutter/material.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  const CustomAlertDialog({super.key, required this.title, required this.content, required this.actions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(fontSize: getFixedWidth(18))),
      content: SingleChildScrollView(child: content),
      actions: actions,
    );
  }
}
