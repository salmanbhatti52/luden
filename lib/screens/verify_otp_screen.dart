// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luden/utils/colors.dart';
import 'package:luden/utils/baseurl.dart';
import 'package:luden/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luden/screens/create_new_password.dart';
import 'package:luden/models/forgot_password_model.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class VerifyOTPPage extends StatefulWidget {
  final String? email, verifyOTP;
  const VerifyOTPPage({super.key, this.email, this.verifyOTP});

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  int seconds = 60;
  Timer? timer;
  FocusNode focusNode = FocusNode();
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  ForgotPasswordModel forgotPasswordModel = ForgotPasswordModel();

  forgotPassword() async {
    // try {
    String apiUrl = "$baseUrl/forgot_password";
    print("api: $apiUrl");
    print("email: ${widget.email}");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "email": widget.email,
      },
    );
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      forgotPasswordModel = forgotPasswordModelFromJson(responseString);
      // setState(() {});
      print('signUpModel status: ${forgotPasswordModel.status}');
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    print("email: ${widget.email}");
    print("verifyOTP: ${widget.verifyOTP}");
  }

  // @override
// void dispose() {
//   otpController.dispose();
//   focusNode.dispose();
// }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            stopTimer();
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            'assets/images/back-arrow.svg',
            width: 22,
            height: 22,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      backgroundColor: secondaryColor,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: otpFormKey,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.04),
                Center(
                  child: Text(
                    "Verify it’s you",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Center(
                  child: Text(
                    'We send a code to ( *****@mail.com ).\nEnter it here to verify your identity',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Center(
                  child: RichText(
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "$seconds",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                      children: [
                        TextSpan(
                          text: '  sec',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "$seconds",
                //       // "03:00",
                //       style: GoogleFonts.poppins(
                //         textStyle: const TextStyle(
                //           color: Color(0xFF6B7280),
                //           fontSize: 36,
                //           fontWeight: FontWeight.w700,
                //           letterSpacing: 0.3,
                //         ),
                //       ),
                //     ),
                //     Text(
                //       "  sec",
                //       style: GoogleFonts.poppins(
                //         textStyle: const TextStyle(
                //           color: Color(0xFF6B7280),
                //           fontSize: 28,
                //           fontWeight: FontWeight.w700,
                //           letterSpacing: 0.3,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: size.height * 0.015),
                seconds == 0
                    ? GestureDetector(
                        onTap: () async {
                          seconds = 60;
                          await startTimer();
                          forgotPassword();
                          if (forgotPasswordModel.status == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Color(0xFF4276EE),
                                    content: Text(
                                        "OTP has been sent to your email")));
                          }
                          if (forgotPasswordModel.status != 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: const Color(0xFF4276EE),
                                content:
                                    Text("${forgotPasswordModel.message}")));
                          }
                          setState(() {});
                        },
                        child: Center(
                          child: Text(
                            "Send again",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          "Send again",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.grey.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PinCodeFields(
                    controller: otpController,
                    length: 4,
                    fieldBorderStyle: FieldBorderStyle.square,
                    responsive: false,
                    animation: Animations.rotateRight,
                    animationDuration: const Duration(milliseconds: 250),
                    animationCurve: Curves.bounceInOut,
                    switchInAnimationCurve: Curves.bounceIn,
                    switchOutAnimationCurve: Curves.bounceOut,
                    fieldHeight: 48,
                    fieldWidth: 48,
                    borderWidth: 1,
                    activeBorderColor: mainColor,
                    activeBackgroundColor: secondaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                    keyboardType: TextInputType.number,
                    autoHideKeyboard: false,
                    fieldBackgroundColor: secondaryColor,
                    borderColor: const Color(0xFF6B7280),
                    textStyle: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.3,
                        fontFamily: 'Inter-Regular'),
                    onComplete: (output) {
                      // Your logic with pin code
                      // print(output);
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.08),
                GestureDetector(
                  onTap: () {
                    if (otpController.text == widget.verifyOTP) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreateNewPasswordPage(
                                    email: "${widget.email}",
                                    verifyOTP: "${widget.verifyOTP}",
                                  )));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Color(0xFF4276EE),
                          content: Text("Invalid OTP")));
                    }
                  },
                  child: button('Confirm', context),
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
