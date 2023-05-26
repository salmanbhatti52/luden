// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:luden/utils/colors.dart';
import 'package:luden/screens/navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luden/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:luden/screens/onboarding_screens/onboarding_screen_1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userId, fullName, userEmail;
  sharedPrefs() async {
    print('in LoginPage shared prefs');
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userId = (sharedPref.getString('userid'));
    fullName = (sharedPref.getString('fullname'));
    userEmail = (sharedPref.getString('user_email'));
    print("userId in LoginPrefs is = $userId");
    print("fullName in LoginPrefs is = $fullName");
    print("userEmail in LoginPrefs is = $userEmail");

    if (userId != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const NavBar()));
    } else {
      _showIntro=true;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginPage()));
      print("userId value is = $userId");
    }
  }

  bool _showIntro = true;

  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 3), () {
    //   Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: (context) => const LoginPage(),
    //   ));
    // });
    SharedPreferences.getInstance().then((prefs) {
      bool hasSeenIntro = prefs.getBool('hasSeenIntro') ?? false;
      setState(() {
        _showIntro = !hasSeenIntro;
      });
    });
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('hasSeenIntro', true);
    });
    Future.delayed(const Duration(seconds: 3), () {
      sharedPrefs();
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => _showIntro == false
              ? const OnBoardingScreen1()
              : const LoginPage()
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: SvgPicture.asset('assets/images/splash-icon.svg'),
      ),
    );
  }
}
