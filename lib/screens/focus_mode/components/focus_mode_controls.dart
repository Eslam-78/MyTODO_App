import 'package:flutter/material.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:provider/provider.dart';
import 'package:mytodo_app/providers/focus_mode_provider.dart';

class FocusModeControls extends StatelessWidget {
  const FocusModeControls({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    final provider = context.watch<FocusModeProvider>();
    final isRunning = provider.isTimerRunning;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: 'focus_fab_1',
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
          elevation: 4,
          onPressed: () {
            if (isRunning) {
              provider.stopTimer();
            } else {
              provider.startTimer();
            }
          },
          child: Icon(isRunning ? Icons.pause : Icons.play_arrow, size: getFixedWidth(24)),
        ),
        SizedBox(width: getFixedWidth(20)),
        FloatingActionButton(
          heroTag: 'focus_fab_2',
          backgroundColor: Colors.green[600],
          foregroundColor: Colors.white,
          elevation: 4,
          onPressed: () {
            provider.completeSession();
            provider.stopTimer();
          },
          child: Icon(Icons.done, size: getFixedWidth(24)),
        ),
      ],
    );
  }
}
