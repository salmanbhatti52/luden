import 'package:flutter/material.dart';
import 'package:luden/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget onBoardingImage(image, BuildContext context) {
  return SvgPicture.asset(
    image,
  );
}

Widget onBoardingIndicator(
    color1, color2, double? width, double? width2, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: width,
        height: 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color1,
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      Container(
        width: width2,
        height: 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: color2,
        ),
      ),
    ],
  );
}

Widget onBoardingTitle(text, BuildContext context) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontFamily: 'Poppins-Regular',
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
    ),
  );
}

Widget onBoardingDescription(text, BuildContext context) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: 'Poppins-Regular',
      fontWeight: FontWeight.w400,
    ),
  );
}

Widget intoScreenButton(buttonText, context) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: mainColor,
            fontFamily: 'Poppins-Regular',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: 0.3,
          ),
        ),
      ),
    ),
  );
}
