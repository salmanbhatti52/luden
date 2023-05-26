// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luden/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luden/screens/deck_screen.dart';
import 'package:luden/screens/capture_screen.dart';
import 'package:luden/screens/profile_screen.dart';
import 'package:luden/screens/save_image_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  File? imagePath;
  String? base64img;
  Future pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.camera);
      if (xFile == null) return;

      Uint8List imageByte = await xFile.readAsBytes();
      base64img = base64.encode(imageByte);
      print("base64img $base64img");

      final imageTemporary = File(xFile.path);

      setState(() {
        imagePath = imageTemporary;
        print("newImage $imagePath");
        print("newImage64 $base64img");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SaveImageScreen(
                  image: imagePath,
                  image64: "$base64img",
                )));
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }
  int index = 0;
  final screens = const [
    DeckScreen(),
    CaptureScreen(),
    ProfileScreen(),
  ];

  Future<bool> showExitPopup() async {
    return (await
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            border: Border.all(color: const Color(0xFF1C1C1C), width: 1),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorShape: const CircleBorder(),
                indicatorColor: Colors.transparent,
                labelTextStyle: MaterialStateProperty.all(
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Poppins-Regular',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              child: NavigationBar(
                backgroundColor: secondaryColor,
                selectedIndex: index,
                onDestinationSelected: (index) => setState(() {
                  this.index = index;
                }),
                destinations: [
                  NavigationDestination(
                    icon: SvgPicture.asset('assets/images/card-icon.svg'),
                    selectedIcon:
                        SvgPicture.asset('assets/images/active-card-icon.svg'),
                    label: 'Decks',
                  ),
                  NavigationDestination(
                    icon: SvgPicture.asset('assets/images/capture-icon.svg'),
                    selectedIcon:
                        SvgPicture.asset('assets/images/active-capture-icon.svg'),
                    label: 'Capture',
                  ),
                  NavigationDestination(
                    icon: SvgPicture.asset('assets/images/profile-icon.svg'),
                    selectedIcon:
                        SvgPicture.asset('assets/images/active-profile-icon.svg'),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: screens[index],
      ),
    );
  }
}
