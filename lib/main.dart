import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mytodo_app/core/and_version.dart';
import 'package:mytodo_app/core/routing/app_router.dart';
import 'package:mytodo_app/core/constants/app_routes.dart';
import 'package:mytodo_app/core/services/calendar_service.dart';
import 'package:mytodo_app/core/services/massenger_service.dart';
import 'package:mytodo_app/core/services/navigation_service.dart';
import 'package:mytodo_app/core/services/notification_service.dart';
import 'package:mytodo_app/core/services/storage_service.dart';
import 'package:mytodo_app/core/services/full_screen_manager.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/providers/focus_mode_provider.dart';
import 'package:mytodo_app/providers/gamification_provider.dart';
import 'package:mytodo_app/providers/settings_provider.dart';
import 'package:mytodo_app/providers/todo_provider.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /* final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('is_focus_time', true); // ✅ التفعيل اليدوي
*/
  await NotificationService.initialize();

  final calendarService = await CalendarService.initialize();
  final storage = SharedPrefsStorage();
  await storage.initialize();
  await printAndroidVersion(); // هنا تطبع الإصدار

  runApp(
    FullScreenManager(
      child: MultiProvider(
        providers: [
          Provider<CalendarService>(create: (_) => calendarService),
          Provider<StorageService>(create: (_) => storage),
          ChangeNotifierProvider(create: (_) => TodoProvider(storage)),
          ChangeNotifierProvider(create: (_) => SettingsProvider(storage: storage)),
          ChangeNotifierProvider(create: (_) => GamificationProvider(storage)),
          ChangeNotifierProvider(create: (_) => FocusModeProvider()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // يجب تنفيذ AIBoot بعد بناء الشجرة

    ScreenConfig().init(context);

    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return MaterialApp(
          scaffoldMessengerKey: MassengerService.scaffoldMessengerKey,
          navigatorKey: NavigationService.navigatorKey,
          title: 'Todo App',
          locale: settings.preferences.locale,
          theme: AppTheme.lightTheme(settings.preferences.locale),
          darkTheme: AppTheme.darkTheme(settings.preferences.locale),
          themeMode: settings.preferences.themeMode,
          debugShowCheckedModeBanner: false,
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: AppRoutes.home,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
