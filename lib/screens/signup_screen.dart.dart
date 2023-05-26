// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:luden/utils/colors.dart';
import 'package:luden/utils/baseurl.dart';
import 'package:luden/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luden/models/signup_model.dart';
import 'package:luden/screens/login_screen.dart';
import 'package:luden/screens/signup_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confimPasswordController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  SignUpModel signUpModel = SignUpModel();

  userSignUp() async {
    // try {
    String apiUrl = "$baseUrl/signup";
    print("api: $apiUrl");
    print("email: ${emailController.text}");
    print("password: ${passwordController.text}");
    print("confirmpassword: ${confimPasswordController.text}");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "email": emailController.text,
        "password": passwordController.text,
        "confirm_password": confimPasswordController.text,
        "account_type": "SignupWithApp",
        "one_signal_id": "123456",
      },
    );
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      signUpModel = signUpModelFromJson(responseString);
      // setState(() {});
      print('signUpModel status: ${signUpModel.status}');
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
          automaticallyImplyLeading: false,
        ),
        backgroundColor: secondaryColor,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: signUpFormKey,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.01),
                  SvgPicture.asset('assets/images/logo.svg'),
                  SizedBox(height: size.height * 0.04),
                  Center(
                    child: Text(
                      'Create New Account',
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
                      'Welcome back, Sign in to your account',
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
                        hintText: "Email",
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
                  SizedBox(height: size.height * 0.02),
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
                      controller: confimPasswordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password field is required!';
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
                      if (signUpFormKey.currentState!.validate()) {
                        setState(() {
                          isInAsyncCall = true;
                        });
                        await userSignUp();
                        if (signUpModel.status == 'success') {
                          SharedPreferences sharedPref =
                              await SharedPreferences.getInstance();
                          await sharedPref.setString('userid',
                              "${signUpModel.data?.usersCustomersId.toString()}");
                          await sharedPref.setString('user_email',
                              "${signUpModel.data?.email.toString()}");
                          print(
                              "userId: ${signUpModel.data!.usersCustomersId.toString()}");
                          print("userEmail: ${signUpModel.data!.email}");
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              backgroundColor: Color(0xFF4276EE),
                              content: Text(
                                  "Your account has been created successfully!")));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SignUpProfileScreen()));
                          setState(() {
                            isInAsyncCall = false;
                          });
                        }
                        if (signUpModel.status != 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: const Color(0xFF4276EE),
                              content: Text("${signUpModel.message}")));
                          setState(() {
                            isInAsyncCall = false;
                          });
                        }
                      }
                    },
                    child: button('Signup', context),
                  ),
                  SizedBox(height: size.height * 0.133),
                  RichText(
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Already have an account?",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.3,
                        ),
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle the tap event, e.g., navigate to a new screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                          text: ' Sign In',
                          style: const TextStyle(
                            color: Color(0xFF2B65EC),
                            fontFamily: 'Poppins-Regular',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
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
