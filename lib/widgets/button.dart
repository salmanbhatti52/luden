import 'package:flutter/material.dart';
import 'package:luden/utils/colors.dart';

Widget button(buttonText, context) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
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

Widget buttonTransparent(buttonText, context) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: buttonColor, width: 2),
      ),
      child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: buttonColor,
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

Widget dialogButton(buttonText, context) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: dialogButtonColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
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

Widget dialogButtonTransparent(buttonText, context) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: dialogButtonColor, width: 2),
      ),
      child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: dialogButtonColor,
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

Widget dialogbuttonSmall(buttonText, context) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.30,
      decoration: BoxDecoration(
        color: dialogButtonColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
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

Widget dialogButtontransparentSmall(buttonText, context) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.30,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: dialogButtonColor, width: 2),
      ),
      child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: dialogButtonColor,
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


