import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:provider/provider.dart';
import 'package:mytodo_app/providers/settings_provider.dart';

class ReminderSettings extends StatefulWidget {
  final String reminderTitle;
  final IconData reminderIcon;

  const ReminderSettings({super.key, required this.reminderTitle, required this.reminderIcon});

  @override
  State<ReminderSettings> createState() => _ReminderSettingsState();
}

class _ReminderSettingsState extends State<ReminderSettings> {
  late TimeOfDay _reminderTime;

  @override
  void initState() {
    super.initState();
    _reminderTime = context.read<SettingsProvider>().preferences.reminderTime;
  }

  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);
    final prefs = context.watch<SettingsProvider>().preferences;

    return Column(
      children: [
        SwitchListTile(
          secondary: Icon(Icons.alarm, size: getFixedWidth(22)),
          title: Text(widget.reminderTitle, style: TextStyle(fontSize: getFixedWidth(14))),
          value: prefs.dailyReminders,
          onChanged: (value) {
            context.read<SettingsProvider>().toggleDailyReminders(value);
          },
        ),
        if (prefs.dailyReminders) ...[
          ListTile(
            leading: Icon(widget.reminderIcon, size: getFixedWidth(22)),
            title: Text(transalateText.reminderTime, style: TextStyle(fontSize: getFixedWidth(14))),
            trailing: Text(_reminderTime.format(context), style: TextStyle(fontSize: getFixedWidth(14))),
            onTap: () => _selectTime(context),
          ),
        ],
      ],
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(context: context, initialTime: _reminderTime);

    if (pickedTime != null) {
      setState(() => _reminderTime = pickedTime);
      if (context.mounted) {
        context.read<SettingsProvider>().updateReminderTime(pickedTime);
      }
    }
  }
}
