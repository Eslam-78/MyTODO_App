import 'package:flutter/material.dart';
import 'package:mytodo_app/components/custom_bottom_nav_bar.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/screens/settings/components/setting_body.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  /*@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AIBootService.saveCurrentScreen(
        context,
        AppRoutes.settings,
      ); // حفظ الشاشة عند الدخول
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    final transalateText = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(transalateText.settings, style: TextStyle(fontSize: getFixedWidth(18))),
        centerTitle: true,
      ),
      body: const SettingBody(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: NavBarMenu.settings),
    );
  }
}
