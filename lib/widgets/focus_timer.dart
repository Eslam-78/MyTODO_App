import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:provider/provider.dart';
import 'package:mytodo_app/providers/focus_mode_provider.dart';

class FocusTimerWidget extends StatelessWidget {
  const FocusTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final transalatedText = S.of(context);
    final provider = context.watch<FocusModeProvider>();
    final isRunning = provider.isTimerRunning;
    final remainingTime = provider.remainingSeconds;
    final progress = provider.progress;
    final totalSeconds =
        provider.isFocusMode
            ? provider.focusDuration * 60
            : (provider.sessionCount % 4 == 0 ? provider.longBreakDuration : provider.shortBreakDuration) * 60;

    String formatTime(int seconds) {
      final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
      final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
      return '$minutes:$remainingSeconds';
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getFixedWidth(20))),
      child: Padding(
        padding: EdgeInsets.all(getFixedWidth(15)),
        child: Column(
          children: [
            Text(
              provider.isFocusMode
                  ? '${transalatedText.focusDurationTime}(${provider.focusDuration} ${transalatedText.minutes})'
                  : provider.sessionCount % 4 == 0
                  ? '${transalatedText.longBreakTime}(${provider.longBreakDuration}  ${transalatedText.minutes})'
                  : '${transalatedText.shortBreakTime} (${provider.shortBreakDuration}  ${transalatedText.minutes})',
              style: TextStyle(fontSize: getFixedWidth(18), fontWeight: FontWeight.w500),
            ),
            SizedBox(height: getFixedHeight(20)),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: getFixedWidth(200),
                  height: getFixedWidth(200),
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: getFixedWidth(10),
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      provider.isFocusMode ? Colors.blue[600]! : Colors.green[600]!,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      formatTime(remainingTime),
                      style: TextStyle(fontSize: getFixedWidth(36), fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: getFixedHeight(8)),
                    Text(
                      isRunning
                          ? provider.isFocusMode
                              ? transalatedText.runTimeProgress
                              : transalatedText.breakTimeProgress
                          : transalatedText.startConfirm,
                      style: TextStyle(fontSize: getFixedWidth(14), color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
