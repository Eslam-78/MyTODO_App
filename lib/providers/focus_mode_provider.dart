import 'dart:async';
import 'package:flutter/material.dart';

class FocusModeProvider with ChangeNotifier {
  bool _isFocusMode = true;
  int _focusDuration = 25; // دقائق
  int _shortBreakDuration = 5;
  int _longBreakDuration = 15;
  int _completedSessions = 0;
  bool _isTimerRunning = false;
  int _remainingSeconds = 25 * 60; // 25 دقيقة بالثواني
  Timer? _timer;
  int _sessionCount = 0;

  bool get isFocusMode => _isFocusMode;
  int get focusDuration => _focusDuration;
  int get shortBreakDuration => _shortBreakDuration;
  int get longBreakDuration => _longBreakDuration;
  int get completedSessions => _completedSessions;
  bool get isTimerRunning => _isTimerRunning;
  int get remainingSeconds => _remainingSeconds;
  int get sessionCount => _sessionCount;

  double get progress {
    final totalSeconds =
        _isFocusMode ? _focusDuration * 60 : (_sessionCount % 4 == 0 ? _longBreakDuration : _shortBreakDuration) * 60;
    return 1 - (_remainingSeconds / totalSeconds);
  }

  void toggleFocusMode() {
    _isFocusMode = !_isFocusMode;
    _resetTimer();
    notifyListeners();
  }

  void startTimer() {
    if (_timer != null && _timer!.isActive) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        _handleTimerCompletion();
      }
    });

    _isTimerRunning = true;
    notifyListeners();
  }

  void stopTimer() {
    _timer?.cancel();
    _isTimerRunning = false;
    notifyListeners();
  }

  void completeSession() {
    _completedSessions++;
    _sessionCount++;
    _switchMode();
    notifyListeners();
  }

  void resetSessions() {
    _completedSessions = 0;
    _sessionCount = 0;
    _isFocusMode = true;
    _resetTimer();
    notifyListeners();
  }

  void updateDurations({int? focus, int? shortBreak, int? longBreak}) {
    _focusDuration = focus ?? _focusDuration;
    _shortBreakDuration = shortBreak ?? _shortBreakDuration;
    _longBreakDuration = longBreak ?? _longBreakDuration;

    // إعادة تعيين المؤقت بالقيم الجديدة
    _resetTimer();
    notifyListeners();
  }

  void _handleTimerCompletion() {
    stopTimer();
    if (_isFocusMode) {
      completeSession();
    } else {
      _switchMode();
    }
  }

  void _switchMode() {
    _isFocusMode = !_isFocusMode;
    _resetTimer();
    notifyListeners();
  }

  void _resetTimer() {
    stopTimer();
    _remainingSeconds =
        _isFocusMode ? _focusDuration * 60 : (_sessionCount % 4 == 0 ? _longBreakDuration : _shortBreakDuration) * 60;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
