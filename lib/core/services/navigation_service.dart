import 'package:flutter/material.dart';

class NavigationService {
  //مفتاح يمكن ربطه بـ MaterialApp للتحكم الكامل في التنقل عبر التطبيق.
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  //يمكنك استخدامه للوصول إلى سياق التنقل الحالي.
  //هذا السياق يمكن استخدامه للوصول إلى عناصر واجهة المستخدم الحالية.
  static BuildContext? get context => navigatorKey.currentContext;

  //يعادل: Navigator.pushNamed(context, routeName)
  //يمكنك إرسال arguments لتمرير بيانات.
  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    if (navigatorKey.currentState == null) {
      throw Exception('Navigator key not attached to widget tree');
    }
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  // يعادل: Navigator.pushReplacementNamed(context, routeName)
  //يمسح الشاشة الحالية ويستبدلها بالجديدة.
  static Future<dynamic> replaceWith(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  //يعادل: Navigator.pop(context, result)
  static void goBack([dynamic result]) {
    navigatorKey.currentState!.pop(result);
  }

  //يعادل: Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false)
  //يمسح كل الشاشات السابقة ويبدأ من الشاشة الجديدة.
  static Future<dynamic> clearStackAndNavigate(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }
}
