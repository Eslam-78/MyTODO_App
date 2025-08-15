import 'package:flutter/material.dart';
import 'package:mytodo_app/core/constants/app_routes.dart';
import 'package:mytodo_app/components/default_button.dart';
import 'package:mytodo_app/core/services/navigation_service.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/screens/splash/components/splash_content.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    //Todo generate a new splash images for this application
    {'text': "Welcome to Todo Application,Lets`s shop!", 'image': "assets/images/splash_1.png"},
    {
      'text': "We help people originize their daily tasks \narround Republic of Yemen.",
      'image': "assets/images/splash_2.png",
    },
    {
      'text': "We give use the easiest way to do your Tasks. \nJust stay at home and use Todo Application!",
      'image': "assets/images/splash_3.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder:
                    (context, index) =>
                        SplashContent(text: splashData[index]['text']!, image: splashData[index]['image']!),
              ),
            ),
            SizedBox(height: getFixedHeight(50)),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getFixedWidth(20)),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(splashData.length, (index) => buildDot(index)),
                    ),
                    Spacer(flex: 2),
                    DefaultButton(
                      buttonText: 'Continue',
                      onButtonPress: () {
                        //Go to LoginScreen and take The route name from static variable
                        NavigationService.navigateTo(AppRoutes.home);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.grey : Colors.black,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
