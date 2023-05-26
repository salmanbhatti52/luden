// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luden/utils/colors.dart';
import 'package:luden/utils/baseurl.dart';
import 'package:luden/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luden/screens/login_screen.dart';
import 'package:luden/models/create_new_password_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreateNewPasswordPage extends StatefulWidget {
  final String? email, verifyOTP;
  const CreateNewPasswordPage({super.key, this.email, this.verifyOTP});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> createNewPasswordFormKey = GlobalKey<FormState>();
  CreateNewPasswordModel createNewPasswordModel = CreateNewPasswordModel();

  createNewPassword() async {
    // try {
    String apiUrl = "$baseUrl/modify_password";
    print("api: $apiUrl");
    print("password: ${passwordController.text}");
    print("confirm password: ${confirmPasswordController.text}");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "email": widget.email,
        "otp": widget.verifyOTP,
        "password": passwordController.text,
        "confirm_password": confirmPasswordController.text
      },
    );
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      createNewPasswordModel = createNewPasswordModelFromJson(responseString);
      // setState(() {});
      print('signInModel status: ${createNewPasswordModel.status}');
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  @override
  void initState() {
    super.initState();
    print("email: ${widget.email}");
    print("verifyOTP: ${widget.verifyOTP}");
  }

  bool _obscure = true;
  bool _obscure2 = true;
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
              key: createNewPasswordFormKey,
              child: Column(
                children: [
                  // SizedBox(height: size.height * 0.01),
                  // SvgPicture.asset('assets/images/safe.svg'),
                  SizedBox(height: size.height * 0.04),
                  Center(
                    child: Text(
                      'Create New Password',
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
                      'Please, enter a new password below\ndifferent from the previous password',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.08),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password field is required!';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                      obscureText: _obscure,
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
                        hintText: "Enter Password",
                        hintStyle: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 16,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: SvgPicture.asset(
                          'assets/images/password-icon.svg',
                          width: 25,
                          height: 25,
                          fit: BoxFit.scaleDown,
                          // color: Color(0xFF6B7280),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                          child: _obscure
                              ? SvgPicture.asset('assets/images/view-icon.svg',
                                  width: 25, height: 25, fit: BoxFit.scaleDown
                                  // color: Color(0xFF6B7280),
                                  )
                              : SvgPicture.asset(
                                  'assets/images/view-icon-2.svg',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.scaleDown,
                                  // color: Color(0xFF6B7280),
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm password field is required!';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                      obscureText: _obscure2,
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
                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 16,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.3,
                        ),
                        prefixIcon: SvgPicture.asset(
                          'assets/images/password-icon.svg',
                          width: 25,
                          height: 25,
                          fit: BoxFit.scaleDown,
                          // color: Color(0xFF6B7280),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscure2 = !_obscure2;
                            });
                          },
                          child: _obscure2
                              ? SvgPicture.asset('assets/images/view-icon.svg',
                                  width: 25, height: 25, fit: BoxFit.scaleDown
                                  // color: Color(0xFF6B7280),
                                  )
                              : SvgPicture.asset(
                                  'assets/images/view-icon-2.svg',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.scaleDown,
                                  // color: Color(0xFF6B7280),
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  GestureDetector(
                    onTap: () async {
                      if (createNewPasswordFormKey.currentState!.validate()) {
                        setState(() {
                          isInAsyncCall = true;
                        });
                        await createNewPassword();
                        if (createNewPasswordModel.status == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              backgroundColor: Color(0xFF4276EE),
                              content: Text(
                                  "Your password has been changed successfully!")));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                          setState(() {
                            isInAsyncCall = false;
                          });
                        }
                        if (createNewPasswordModel.status != 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: const Color(0xFF4276EE),
                              content:
                                  Text("${createNewPasswordModel.message}")));
                          setState(() {
                            isInAsyncCall = false;
                          });
                        }
                      }
                    },
                    child: button('Create new password', context),
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
