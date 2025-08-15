import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:mytodo_app/core/constants/app_routes.dart';
import 'package:mytodo_app/core/services/navigation_service.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';

enum NavBarMenu { home, achievements, focus, settings }

class CustomBottomNavBar extends StatefulWidget {
  final NavBarMenu selectedMenu;
  const CustomBottomNavBar({super.key, required this.selectedMenu});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _selectedIndex;
  final List<NavBarMenu> _menuItems = NavBarMenu.values;

  @override
  void initState() {
    super.initState();
    _selectedIndex = _menuItems.indexOf(widget.selectedMenu);
  }

  @override
  Widget build(BuildContext context) {
    final transalatedText = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ConvexAppBar.badge(
      // ✅ شارات مخصصة للأيقونات
      const {
        0: '', // مثلاً عدد الإنجازات الجديدة
        2: '', // تركه فارغ لوضع دائرة فقط بدون نص
      },
      style: TabStyle.reactCircle,
      curveSize: getFixedHeight(70),
      backgroundColor: colorScheme.primary,
      activeColor: Colors.white,
      color: colorScheme.onPrimary.withOpacity(0.8),
      height: getFixedHeight(56),
      initialActiveIndex: _selectedIndex,
      items: [
        TabItem(icon: Icons.home, title: transalatedText.homePage),
        TabItem(icon: Icons.emoji_events, title: transalatedText.navAchievments),
        TabItem(icon: Icons.timer, title: transalatedText.focusMode),
        TabItem(icon: Icons.settings, title: transalatedText.settings),
      ],
      onTap: (index) {
        setState(() => _selectedIndex = index);
        _navigateToMenu(context, _menuItems[index]);
      },
    );
  }

  void _navigateToMenu(BuildContext context, NavBarMenu menu) {
    switch (menu) {
      case NavBarMenu.home:
        NavigationService.navigateTo(AppRoutes.home);
        break;
      case NavBarMenu.achievements:
        NavigationService.navigateTo(AppRoutes.achievements);
        break;
      case NavBarMenu.focus:
        NavigationService.navigateTo(AppRoutes.focusMode);
        break;
      case NavBarMenu.settings:
        NavigationService.navigateTo(AppRoutes.settings);
        break;
    }
  }
}
