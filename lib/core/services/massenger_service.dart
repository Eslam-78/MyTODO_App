import 'package:flutter/material.dart';
import 'package:mytodo_app/core/constants/color_constants.dart';
import 'package:mytodo_app/core/constants/massenger_constants.dart';

/// Centralized notification service for managing app-wide notifications
/// Supports multiple notification types and custom actions
class MassengerService {
  //هذا GlobalKey يتم ربطه بـ ScaffoldMessenger الرئيسي في التطبيق ليسمح بعرض SnackBar من أي مكان (حتى بدون وجود BuildContext مباشر).
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  /// Displays a customizable snackbar notification
  ///
  /// [message] : The text content to display (required)
  /// [type] : Predefined notification type (default: success)
  /// [duration] : How long to display the notification
  /// [action] : Optional action button
  /// [customColor] : Override default type colors
  static void showSnackBar({
    required String message,
    MassengerType type = MassengerType.success,
    Duration duration = MassengerDuration.medium,
    SnackBarAction? action,
    Color? customColor,
  }) {
    final color = _getMassengerColor(type, customColor);
    final icon = _getMassengerIcon(type);

    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[Icon(icon, color: Colors.white), const SizedBox(width: 8)],
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Hides currently displayed snackbar
  static void hideCurrent() {
    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  }

  // Helper method to get color based on notification type
  static Color _getMassengerColor(MassengerType type, Color? customColor) {
    if (customColor != null) return customColor;

    return switch (type) {
      MassengerType.success => AppColors.greenTransparentAlt,
      MassengerType.error => AppColors.redTransparentAlt,
      MassengerType.warning => AppColors.orangeTransparentAlt,
      MassengerType.info => AppColors.blueTransparentAlt,
    };
  }

  // Helper method to get icon based on notification type
  static IconData? _getMassengerIcon(MassengerType type) {
    return switch (type) {
      MassengerType.success => Icons.check_circle,
      MassengerType.error => Icons.error,
      MassengerType.warning => Icons.warning,
      MassengerType.info => Icons.info,
    };
  }

  /// Quick access methods for common notification types
  static void success(String message, {Duration? duration}) =>
      showSnackBar(message: message, type: MassengerType.success, duration: duration ?? MassengerDuration.short);

  static void error(String message, {Duration? duration}) =>
      showSnackBar(message: message, type: MassengerType.error, duration: duration ?? MassengerDuration.medium);

  static void warning(String message, {Duration? duration}) =>
      showSnackBar(message: message, type: MassengerType.warning, duration: duration ?? MassengerDuration.medium);

  static void info(String message, {Duration? duration}) =>
      showSnackBar(message: message, type: MassengerType.info, duration: duration ?? MassengerDuration.short);
}
