import 'package:flutter/material.dart';
import 'package:mytodo_app/components/custom_bottom_nav_bar.dart';
import 'package:mytodo_app/core/services/navigation_service.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/screens/focus_mode/components/focus_body.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:provider/provider.dart';
import 'package:mytodo_app/providers/focus_mode_provider.dart';

class FocusModeScreen extends StatefulWidget {
  const FocusModeScreen({super.key});

  @override
  State<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends State<FocusModeScreen> {
  /* @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AIBootService.saveCurrentScreen(
        context,
        AppRoutes.focusMode,
      ); // حفظ الشاشة عند الدخول
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(transalateText.focusMode, style: TextStyle(fontSize: getFixedWidth(18))),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, size: getFixedWidth(24)),
            onPressed: () => _showSettingsDialog(context),
          ),
        ],
      ),
      body: const FocusBody(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: NavBarMenu.focus),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    final transalateText = S.of(context);
    final provider = Provider.of<FocusModeProvider>(context, listen: false);

    // حفظ القيم الحالية مؤقتاً
    int newFocus = provider.focusDuration;
    int newShortBreak = provider.shortBreakDuration;
    int newLongBreak = provider.longBreakDuration;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(transalateText.focusSettings, style: TextStyle(fontSize: getFixedWidth(16))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDurationSetting(context, transalateText.focusDuration, newFocus, (value) {
                    setState(() => newFocus = value);
                  }),
                  _buildDurationSetting(context, transalateText.shortBreak, newShortBreak, (value) {
                    setState(() => newShortBreak = value);
                  }),
                  _buildDurationSetting(context, transalateText.longBreak, newLongBreak, (value) {
                    setState(() => newLongBreak = value);
                  }),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => NavigationService.goBack(),
                  child: Text(transalateText.cancel, style: TextStyle(fontSize: getFixedWidth(14))),
                ),
                ElevatedButton(
                  onPressed: () {
                    provider.updateDurations(focus: newFocus, shortBreak: newShortBreak, longBreak: newLongBreak);
                    NavigationService.goBack();
                  },
                  child: Text(transalateText.save, style: TextStyle(fontSize: getFixedWidth(14))),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDurationSetting(BuildContext context, String label, int value, Function(int) onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getFixedHeight(8)),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontSize: getFixedWidth(14))),
          const Spacer(),
          DropdownButton<int>(
            value: value,
            style: TextStyle(fontSize: getFixedWidth(14), color: Colors.black),
            items: [5, 10, 15, 20, 25, 30, 45, 60].map((e) => DropdownMenuItem(value: e, child: Text('$e'))).toList(),
            onChanged: (v) => onChanged(v!),
          ),
        ],
      ),
    );
  }
}
