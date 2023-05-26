import 'dart:io';
import 'package:flutter/material.dart';
import 'package:luden/screens/splash_screen.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

void main() async {
  runApp(const MyApp());
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    if(Platform.isAndroid) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  });
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sportograph',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF4276EE),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
