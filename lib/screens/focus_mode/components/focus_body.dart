import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/providers/focus_mode_provider.dart';
import 'package:mytodo_app/screens/focus_mode/components/focus_mode_controls.dart';
import 'package:mytodo_app/screens/focus_mode/components/session_stats.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/widgets/focus_timer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FocusBody extends StatefulWidget {
  const FocusBody({super.key});

  @override
  State<FocusBody> createState() => _FocusBodyState();
}

class _FocusBodyState extends State<FocusBody> {
  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);
    return Padding(
      padding: EdgeInsets.all(getFixedWidth(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // مؤقت التركيز
          const FocusTimerWidget(),
          SizedBox(height: getFixedHeight(30)),

          // إحصائيات الجلسات
          const SessionStatsWidget(),
          SizedBox(height: getFixedHeight(20)),

          // عناصر التحكم
          const FocusModeControls(),
          SizedBox(height: getFixedHeight(20)),

          // زر الخروج من وضع التركيز
          Consumer<FocusModeProvider>(
            builder: (context, provider, _) {
              if (provider.isFocusMode) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: getFixedWidth(24), vertical: getFixedHeight(12)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getFixedWidth(8))),
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('is_focus_time', false);
                    provider.toggleFocusMode();
                  },
                  child: Text(transalateText.endFocusMode, style: TextStyle(fontSize: getFixedWidth(14))),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
