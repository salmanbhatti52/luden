// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luden/screens/navbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luden/screens/save_image_screen.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  File? imagePath;
  String? base64img;
  Future pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.camera);
      if (xFile == null){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        const NavBar()), (Route<dynamic> route) => false);
      }
      else{
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
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }

  @override
  void initState() {
    super.initState();
    pickImage();
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Container();
    //   WillPopScope(
    //     onWillPop: () async {
    //   // Navigate to a different screen when the back button is pressed
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const NavBar()),
    //   );
    //   return false; // Return false to prevent the default behavior
    // },
    // child: Container(),
    // );
    // Stack(
    //   children: [
    // Image.asset(
    //   'assets/images/capture-preview.png',
    //   width: size.width,
    //   height: size.height,
    //   fit: BoxFit.cover,
    // ),
    // Positioned(
    //   left: 65,
    //   right: 65,
    //   bottom: 20,
    //   child: GestureDetector(
    //       onTap: () {
    //         pickImage();
    //         print('pickImage: $imagePath');
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (BuildContext context) => SaveImageScreen(
    //                       image: imagePath,
    //                       image64: "$base64img",
    //                     )));
    //       },
    //       child:
    //           SvgPicture.asset('assets/images/capture-picture-icon.svg')),
    // )
    //   ],
    // );
  }
}
