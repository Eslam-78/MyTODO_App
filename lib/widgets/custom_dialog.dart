/*import 'package:flutter/material.dart';
import 'package:mytodo_app/core/services/navigation_service.dart';
import 'package:mytodo_app/screen_config.dart';

class CustomDialog {
  static void show({
    required BuildContext context,
    required Widget title,
    required Widget content,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            elevation: 8,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getFixedWidth(16)),
            ),
            title: DefaultTextStyle(
              style: TextStyle(
                fontSize: getFixedWidth(20),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              child: title,
            ),
            content: SingleChildScrollView(child: content),
            actions: [
              Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  onPressed: () => NavigationService.goBack(),
                  child: Text(
                    'إغلاق',
                    style: TextStyle(
                      fontSize: getFixedWidth(14),
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
*/
