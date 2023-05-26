// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luden/utils/colors.dart';
import 'package:luden/utils/baseurl.dart';
import 'package:luden/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luden/models/reset_password_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confimPasswordController = TextEditingController();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  ResetPasswordModel resetPasswordModel = ResetPasswordModel();
  String? userEmail;

  resetPassword() async {
    // try {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userEmail = sharedPref.getString('user_email');
    String apiUrl = "$baseUrl/change_password";
    print("api: $apiUrl");
    print("email: $userEmail");
    print("old password: ${oldPasswordController.text}");
    print("new password: ${newPasswordController.text}");
    print("confirm password: ${confimPasswordController.text}");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "email": userEmail,
        "old_password": oldPasswordController.text,
        "password": newPasswordController.text,
        "confirm_password": confimPasswordController.text
      },
    );
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      resetPasswordModel = resetPasswordModelFromJson(responseString);
      // setState(() {});
      print('signInModel status: ${resetPasswordModel.status}');
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

  bool _obscure = true;
  bool _obscure2 = true;
  bool _obscure3 = true;
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
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.clamp,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.5, 0.5],
              colors: [topBarColor, secondaryColor],
            ),
          ),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SvgPicture.asset(
                      'assets/images/back-arrow.svg',
                      width: 22,
                      height: 22,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: resetPasswordFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.04),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: oldPasswordController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Old password field is required!';
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(
                                color: Color(0xFF6B7280),
                                width: 1,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(
                                color: Color(0xFF6B7280),
                                width: 1,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(
                                color: Color(0xFF6B7280),
                                width: 1,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            hintText: "Old Password",
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
                                  ? SvgPicture.asset(
                                      'assets/images/view-icon.svg',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.scaleDown
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
                          controller: newPasswordController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'New password field is required!';
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(
                                color: Color(0xFF6B7280),
                                width: 1,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(
                                color: Color(0xFF6B7280),
                                width: 1,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(
                                color: Color(0xFF6B7280),
                                width: 1,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            hintText: "New Password",
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
                                  _obscure2 = !_obscure2;
                                });
                              },
                              child: _obscure2
                                  ? SvgPicture.asset(
                                      'assets/images/view-icon.svg',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.scaleDown
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
                          controller: confimPasswordController,
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
                          obscureText: _obscure3,
                          decoration: InputDecoration(
                            filled: false,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 2,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(
                                color: Color(0xFF6B7280),
                                width: 1,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(
                                color: Color(0xFF6B7280),
                                width: 1,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(
                                color: Color(0xFF6B7280),
                                width: 1,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
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
                                  _obscure3 = !_obscure3;
                                });
                              },
                              child: _obscure3
                                  ? SvgPicture.asset(
                                      'assets/images/view-icon.svg',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.scaleDown
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
                      SizedBox(height: size.height * 0.03),
                      GestureDetector(
                        onTap: () async {
                          if (resetPasswordFormKey.currentState!.validate()) {
                            setState(() {
                              isInAsyncCall = true;
                            });
                            await resetPassword();
                            if (resetPasswordModel.status == 'success') {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => confirmDialog(),
                              );
                              setState(() {
                                isInAsyncCall = false;
                              });
                            }
                            if (resetPasswordModel.status != 'success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: const Color(0xFF4276EE),
                                      content: Text(
                                          "${resetPasswordModel.message}")));
                              setState(() {
                                isInAsyncCall = false;
                              });
                            }
                          }
                        },
                        child: button('Update', context),
                      ),
                      SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget confirmDialog() {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: SizedBox(
          height: size.height * 0.31,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset('assets/images/close-icon.svg'),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  'password updated\nSuccessfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins-Regular',
                    fontSize: 18,
                    color: secondaryColor,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: dialogButton('OK', context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
