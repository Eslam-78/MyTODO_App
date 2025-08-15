import 'package:flutter/material.dart';
import 'package:mytodo_app/components/custom_bottom_nav_bar.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/screens/achievements/components/achievement_body.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  /* @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AIBootService.saveCurrentScreen(
        context,
        AppRoutes.achievements,
      ); // حفظ الشاشة عند الدخول
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final translatedText = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(translatedText.achievements), centerTitle: true),
      body: AchievementBody(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: NavBarMenu.achievements),
    );
  }
}
