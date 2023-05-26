// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luden/utils/colors.dart';
import 'package:luden/utils/baseurl.dart';
import 'package:luden/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luden/screens/verify_otp_screen.dart';
import 'package:luden/models/forgot_password_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  ForgotPasswordModel forgotPasswordModel = ForgotPasswordModel();

  forgotPassword() async {
    // try {
    String apiUrl = "$baseUrl/forgot_password";
    print("api: $apiUrl");
    print("email: ${emailController.text}");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "email": emailController.text,
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

  @override
  void initState() {
    super.initState();
  }

  bool isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: isInAsyncCall,
      // opacity: 0.02,
      // blur: 0.5,
      color: Colors.transparent,
      progressIndicator: const CircularProgressIndicator(
        color: Color(0xFF4276EE),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
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
              key: forgotPasswordFormKey,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.01),
                  SvgPicture.asset('assets/images/logo.svg'),
                  SizedBox(height: size.height * 0.04),
                  Center(
                    child: Text(
                      'Forgot Password',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Center(
                    child: Text(
                      'Enter your registered email\nbelow to receive security code.',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email field is required!';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            color: Color(0xFF6B7280),
                            width: 1,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            color: Color(0xFF6B7280),
                            width: 1,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            color: Color(0xFF6B7280),
                            width: 1,
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        hintText: "tommyjason@gmail",
                        hintStyle: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 16,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.3,
                        ),
                        prefixIcon: SvgPicture.asset(
                          'assets/images/email-icon.svg',
                          width: 25,
                          height: 25,
                          fit: BoxFit.scaleDown,
                          // color: Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  GestureDetector(
                    onTap: () async {
                      if (forgotPasswordFormKey.currentState!.validate()) {
                        setState(() {
                          isInAsyncCall = true;
                        });
                        await forgotPassword();
                        if (forgotPasswordModel.status == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Color(0xFF4276EE),
                                  content:
                                      Text("OTP has been sent to your email")));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyOTPPage(
                                      email: emailController.text.toString(),
                                      verifyOTP:
                                          "${forgotPasswordModel.data!.otp}")));
                          setState(() {
                            isInAsyncCall = false;
                          });
                        }
                        if (forgotPasswordModel.status != 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: const Color(0xFF4276EE),
                              content: Text("${forgotPasswordModel.message}")));
                          setState(() {
                            isInAsyncCall = false;
                          });
                        }
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
      ),
    );
  }
}
