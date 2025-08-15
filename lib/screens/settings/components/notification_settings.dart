import 'package:flutter/material.dart';
import 'package:mytodo_app/core/services/massenger_service.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:provider/provider.dart';
import 'package:mytodo_app/providers/settings_provider.dart';

class NotificationSettings extends StatefulWidget {
  final IconData notificationIcon;
  final String notificationTitle;

  const NotificationSettings({super.key, required this.notificationIcon, required this.notificationTitle});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);
    final prefs = context.watch<SettingsProvider>().preferences;

    return SwitchListTile(
      secondary: Icon(widget.notificationIcon, size: getFixedWidth(22)),
      title: Text(widget.notificationTitle, style: TextStyle(fontSize: getFixedWidth(14))),
      value: prefs.receiveNotifications,
      onChanged: (value) async {
        await context.read<SettingsProvider>().toggleNotifications(value);
        MassengerService.success(
          transalateText.notificationToggleSuccess(
            value ? transalateText.notificationEnabled : transalateText.notificationDisabled,
          ),
          duration: const Duration(seconds: 2),
        );
      },
    );
  }
}
