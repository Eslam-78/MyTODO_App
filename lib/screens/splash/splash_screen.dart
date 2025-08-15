import 'package:flutter/material.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/screens/splash/components/splash_body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //You have to call it on your starting screen
    ScreenConfig().init(context);
    return Scaffold(body: SplashBody());
  }
}
