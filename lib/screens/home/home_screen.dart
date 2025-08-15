import 'package:flutter/material.dart';
import 'package:mytodo_app/components/custom_app_bar.dart';
import 'package:mytodo_app/components/custom_bottom_nav_bar.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/screens/home/components/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).homePage,
        centerTitle: true,
        leading: const SizedBox(),
      ),
      body: const HomeBody(),
      bottomNavigationBar: const CustomBottomNavBar(
        selectedMenu: NavBarMenu.home,
      ),
    );
  }
}
