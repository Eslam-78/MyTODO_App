import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:provider/provider.dart';
import 'package:mytodo_app/providers/settings_provider.dart';

class LanguageSelector extends StatelessWidget {
  final String languageTitle;
  final IconData languageIcon;

  const LanguageSelector({super.key, required this.languageTitle, required this.languageIcon});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<SettingsProvider>().preferences.locale;

    return ListTile(
      leading: Icon(languageIcon, size: getFixedWidth(22)),
      title: Text(languageTitle, style: TextStyle(fontSize: getFixedWidth(14))),
      trailing: DropdownButton<Locale>(
        value: locale,
        iconSize: getFixedWidth(20),
        style: TextStyle(fontSize: getFixedWidth(12)),
        items:
            S.delegate.supportedLocales.map((locale) {
              return DropdownMenuItem(
                value: locale,
                child: Text(
                  _getLanguageName(locale, context),
                  style: TextStyle(fontSize: getFixedWidth(12), color: Colors.black),
                ),
              );
            }).toList(),
        onChanged: (locale) {
          if (locale != null) {
            context.read<SettingsProvider>().updateLocale(locale);
          }
        },
      ),
    );
  }

  String _getLanguageName(Locale locale, BuildContext context) {
    final transalateText = S.of(context);
    switch (locale.languageCode) {
      case 'ar':
        return transalateText.arabic;
      case 'en':
        return transalateText.english;
      default:
        return locale.languageCode;
    }
  }
}
