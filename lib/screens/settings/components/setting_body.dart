import 'package:flutter/material.dart';
import 'package:mytodo_app/core/services/navigation_service.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/providers/settings_provider.dart';
import 'package:mytodo_app/screens/settings/components/language_selector.dart';
import 'package:mytodo_app/screens/settings/components/notification_settings.dart';
import 'package:mytodo_app/screens/settings/components/profile_section.dart';
import 'package:mytodo_app/screens/settings/components/reminder_settings.dart';
import 'package:mytodo_app/screens/settings/components/theme_switch.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/screens/settings/components/vibration_settings.dart';
import 'package:provider/provider.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // قسم الملف الشخصي
          const ProfileSection(profileName: "Eslam Alejil", profileImage: "assets/images/myPic.png"),

          // إعدادات التطبيق
          _buildSettingsSection(
            title: transalateText.appSettings,
            children: [
              ThemeSwitch(themeTitle: transalateText.themeMode, themeIcon: Icons.brightness_6),
              LanguageSelector(languageTitle: transalateText.language, languageIcon: Icons.language),
              NotificationSettings(
                notificationTitle: transalateText.activeNotification,
                notificationIcon: Icons.notifications,
              ),
              VibrationSettings(vibrationTitle: transalateText.vibrationSettings, vibrationIcon: Icons.vibration),
              ReminderSettings(reminderTitle: transalateText.dailyReminders, reminderIcon: Icons.access_time),
              _buildResetButton(context),
            ],
          ),

          // معلومات التطبيق
          _buildSettingsSection(
            title: transalateText.appInfo,
            children: [
              _buildInfoItem(transalateText.version, '1.0.0'),
              _buildInfoItem(transalateText.builtWith, 'Flutter'),
              _buildInfoItem(transalateText.privacyPolicy, transalateText.pressToView, isClickable: true),
              _buildInfoItem(transalateText.termsOfUse, transalateText.pressToView, isClickable: true),
            ],
          ),
          SizedBox(height: getFixedHeight(20)),
        ],
      ),
    );
  }

  Widget _buildSettingsSection({required String title, required List<Widget> children}) {
    return Card(
      margin: EdgeInsets.all(getFixedWidth(12)),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getFixedWidth(10))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getFixedHeight(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getFixedWidth(16), vertical: getFixedHeight(8)),

              child: Text(title, style: TextStyle(fontSize: getFixedWidth(16), fontWeight: FontWeight.bold)),
            ),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value, {bool isClickable = false}) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: getFixedWidth(14))),
      trailing: Text(
        value,
        style: TextStyle(fontSize: getFixedWidth(14), color: isClickable ? Colors.blue : Colors.grey[600]),
      ),
      onTap: isClickable ? () {} : null,
    );
  }

  Widget _buildResetButton(BuildContext context) {
    final transalateText = S.of(context);
    return ListTile(
      leading: Icon(Icons.restart_alt, color: Colors.red, size: getFixedWidth(22)),

      title: Text(transalateText.resetApp, style: TextStyle(color: Colors.red, fontSize: getFixedWidth(14))),

      onTap: () => _showResetConfirmation(context),
    );
  }

  void _showResetConfirmation(BuildContext context) {
    final transalateText = S.of(context);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(transalateText.resetApp, style: TextStyle(fontSize: getFixedWidth(16))),
            content: Text(transalateText.resetConfirmation, style: TextStyle(fontSize: getFixedWidth(14))),
            actions: [
              TextButton(
                onPressed: () => NavigationService.goBack(),
                child: Text(transalateText.cancel, style: TextStyle(fontSize: getFixedWidth(14))),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: getFixedWidth(16), vertical: getFixedHeight(10)),
                ),
                onPressed: () {
                  context.read<SettingsProvider>().resetToDefaults();
                  NavigationService.goBack();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(transalateText.resetSuccess, style: TextStyle(fontSize: getFixedWidth(14)))),
                  );
                },
                child: Text(transalateText.confirm, style: TextStyle(fontSize: getFixedWidth(14))),
              ),
            ],
          ),
    );
  }
}
