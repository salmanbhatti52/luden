import 'package:flutter/material.dart';
import 'onboarding_screen_widgets.dart';
import 'package:luden/utils/colors.dart';
import 'package:luden/screens/onboarding_screens/onboarding_screen_2.dart';

class OnBoardingScreen1 extends StatefulWidget {
  const OnBoardingScreen1({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen1> createState() => _OnBoardingScreen1State();
}

class _OnBoardingScreen1State extends State<OnBoardingScreen1> {
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
            onBoardingImage("assets/images/intro-1.svg", context),
            SizedBox(height: size.height * 0.05),
            onBoardingTitle("Secure Digital\nCard Vault", context),
            SizedBox(height: size.height * 0.03),
            onBoardingDescription(
                "Create your own digital sports\ncards! Create unique cards to\nstore in your card vault, or buy,\nsell, or trade them",
                context),
            SizedBox(height: size.height * 0.03),
            onBoardingIndicator(
                Colors.white, Colors.white.withOpacity(0.3), 25, 25, context),
            SizedBox(height: size.height * 0.07),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const OnBoardingScreen2()));
              },
              child: intoScreenButton('Next', context),
            ),
          ],
        ),
      ),
    );
  }
}
