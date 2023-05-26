import 'package:flutter/material.dart';
import 'onboarding_screen_widgets.dart';
import 'package:luden/utils/colors.dart';
import 'package:luden/screens/login_screen.dart';

class OnBoardingScreen2 extends StatefulWidget {
  const OnBoardingScreen2({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen2> createState() => _OnBoardingScreen2State();
}

class _OnBoardingScreen2State extends State<OnBoardingScreen2> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.05),
            onBoardingImage("assets/images/intro-2.svg", context),
            SizedBox(height: size.height * 0.05),
            onBoardingTitle("Make It Yours", context),
            SizedBox(height: size.height * 0.03),
            onBoardingDescription(
                "No two cards are alike, and you\ncan enhance the uniqueness\nby adding athletes real\nautographs after you have\ncreated a new photo",
                context),
            SizedBox(height: size.height * 0.03),
            onBoardingIndicator(
                Colors.white.withOpacity(0.3), Colors.white, 25, 25, context),
            SizedBox(height: size.height * 0.12),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage()));
              },
              child: intoScreenButton('Next', context),
            ),
          ],
        ),
      ),
    );
  }
}
