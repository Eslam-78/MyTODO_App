import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:provider/provider.dart';
import 'package:mytodo_app/providers/settings_provider.dart';

class ProfileSection extends StatelessWidget {
  final String profileName;
  final String profileImage;

  const ProfileSection({super.key, required this.profileName, required this.profileImage});

  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);
    final avatarPath = context.watch<SettingsProvider>().preferences.avatarPath;

    return Card(
      margin: EdgeInsets.all(getFixedWidth(12)),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getFixedWidth(12))),
      child: Padding(
        padding: EdgeInsets.all(getFixedWidth(16)),
        child: Row(
          children: [
            CircleAvatar(
              radius: getFixedWidth(45),
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: AspectRatio(aspectRatio: 1, child: Image.asset(avatarPath ?? profileImage, fit: BoxFit.cover)),
              ),
            ),
            SizedBox(width: getFixedWidth(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profileName, style: TextStyle(fontSize: getFixedWidth(16), fontWeight: FontWeight.bold)),
                  SizedBox(height: getFixedHeight(4)),
                  Text(
                    transalateText.profileSettings,
                    style: TextStyle(fontSize: getFixedWidth(12), color: Colors.grey[600]),
                  ),
                  SizedBox(height: getFixedHeight(8)),
                  TextButton(
                    onPressed: () {}, // يمكنك إضافة شاشة تعديل الملف الشخصي لاحقًا
                    child: Text(transalateText.editProfile, style: TextStyle(fontSize: getFixedWidth(12))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
