import 'package:flutter/material.dart';
import 'package:luden/screens/onboarding_screens/onboarding_screen_1.dart';
import 'package:luden/screens/onboarding_screens/onboarding_screen_2.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final List<Widget> pages = [
    const OnBoardingScreen1(),
    const OnBoardingScreen2(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: pages,
      ),
    );
  }
}
