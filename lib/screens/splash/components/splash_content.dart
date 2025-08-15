import 'package:flutter/material.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({super.key, required this.text, required this.image});
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          'Todo App',
          style: TextStyle(fontSize: getFixedWidth(36), color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(text, textAlign: TextAlign.center),
        Spacer(flex: 2),
        Image.asset(image, height: getFixedHeight(350), width: getFixedWidth(250)),
      ],
    );
  }
}
