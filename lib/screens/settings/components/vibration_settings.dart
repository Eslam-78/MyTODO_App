import 'package:flutter/material.dart';
import 'package:mytodo_app/core/services/massenger_service.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class VibrationSettings extends StatelessWidget {
  final IconData vibrationIcon;
  final String vibrationTitle;

  const VibrationSettings({super.key, required this.vibrationIcon, required this.vibrationTitle});

  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);
    final prefs = context.watch<SettingsProvider>().preferences;

    return SwitchListTile(
      secondary: Icon(vibrationIcon, size: getFixedWidth(22)),
      title: Text(vibrationTitle, style: TextStyle(fontSize: getFixedWidth(14))),
      value: prefs.notificationVibration,
      onChanged: (value) {
        context.read<SettingsProvider>().toggleNotificationVibration(value);
        MassengerService.success(
          transalateText.vibrationToggleSuccess(
            value ? transalateText.vibrationEnabled : transalateText.vibrationDisabled,
          ),
          duration: const Duration(seconds: 2),
        );
      },
    );
  }
}
