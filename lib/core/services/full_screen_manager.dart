import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FullScreenManager extends StatefulWidget {
  final Widget child;

  const FullScreenManager({super.key, required this.child});

  @override
  State<FullScreenManager> createState() => _FullScreenManagerState();
}

class _FullScreenManagerState extends State<FullScreenManager> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _enableVerticalScreenMode();
    _enableFullScreenMode();
  }

  void _enableFullScreenMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _enableVerticalScreenMode() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    bool isKeyboardOpen = WidgetsBinding.instance.platformDispatcher.views.first.viewInsets.bottom > 0;
    if (!isKeyboardOpen) {
      Future.delayed(Duration(milliseconds: 100), _enableFullScreenMode);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _enableFullScreenMode(); // إعادة إخفاء الأشرطة بعد تصغير التطبيق
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
