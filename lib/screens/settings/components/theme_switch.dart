import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:provider/provider.dart';
import 'package:mytodo_app/providers/settings_provider.dart';

class ThemeSwitch extends StatelessWidget {
  final String themeTitle;
  final IconData themeIcon;

  const ThemeSwitch({super.key, required this.themeTitle, required this.themeIcon});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<SettingsProvider>().preferences.themeMode;

    return ListTile(
      leading: Icon(themeIcon, size: getFixedWidth(22)),
      title: Text(themeTitle, style: TextStyle(fontSize: getFixedWidth(14))),
      trailing: DropdownButton<ThemeMode>(
        value: themeMode,
        iconSize: getFixedWidth(20),
        style: TextStyle(fontSize: getFixedWidth(12)),
        items:
            ThemeMode.values.map((mode) {
              return DropdownMenuItem(
                value: mode,
                child: Text(
                  _getThemeModeName(mode, context),
                  style: TextStyle(color: Colors.black, fontSize: getFixedWidth(12)),
                ),
              );
            }).toList(),
        onChanged: (mode) {
          if (mode != null) {
            context.read<SettingsProvider>().updateThemeMode(mode);
          }
        },
      ),
    );
  }

  String _getThemeModeName(ThemeMode mode, BuildContext context) {
    switch (mode) {
      case ThemeMode.light:
        return S.of(context).lightTheme;
      case ThemeMode.dark:
        return S.of(context).darkTheme;
      case ThemeMode.system:
        return S.of(context).systemTheme;
    }
  }
}
