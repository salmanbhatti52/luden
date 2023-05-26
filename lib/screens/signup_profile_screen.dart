// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luden/utils/colors.dart';
import 'package:luden/utils/baseurl.dart';
import 'package:luden/screens/navbar.dart';
import 'package:luden/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luden/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpProfileScreen extends StatefulWidget {
  const SignUpProfileScreen({super.key});

  @override
  State<SignUpProfileScreen> createState() => _SignUpProfileScreenState();
}

class _SignUpProfileScreenState extends State<SignUpProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController favoriteSportsTeamController = TextEditingController();
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  ProfileModel profileModel = ProfileModel();
  
  String? userId;
  bool isSelect = true;

  userProfile() async {
    // try {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userId = sharedPref.getString('userid');
    String apiUrl = "$baseUrl/update_profile";
    print("api: $apiUrl");
    print("user id: $userId");
    print("name: ${nameController.text}");
    print("username: ${userNameController.text}");
    print("dob: $tempDate");
    print("favorite sports team: ${favoriteSportsTeamController.text}");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "users_customers_id": userId,
        "full_name": nameController.text,
        "username": userNameController.text,
        "favorite_sports_team": favoriteSportsTeamController.text.isEmpty ? "":favoriteSportsTeamController.text,
        "dob": tempDate
      },
    );
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      profileModel = profileModelFromJson(responseString);
      // setState(() {});
      print('signInModel status: ${profileModel.status}');
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  String? tempDate;
  DateTime? pickDate;
  String? valueDate;
  String? valueDay;

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      // firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != pickDate) {
      tempDate = DateFormat('yyyy-MM-dd').format(picked);
      valueDay = DateFormat('EEEE, dd MMMM').format(picked);
      setState(() {
        print("Selected Date is: $tempDate");
        print("Selected Day is: $valueDay");
      });
    }
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
                elevation: 0,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Profile',
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
                  key: profileFormKey,
                  child: Column(
                          children: [
                            SizedBox(height: size.height * 0.04),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name field is required!';
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
                                  hintText: "Name",
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.3,
                                  ),
                                  prefixIcon: SvgPicture.asset(
                                    'assets/images/name-icon.svg',
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                controller: userNameController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Username field is required!';
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
                                  hintText: "Username",
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.3,
                                  ),
                                  prefixIcon: SvgPicture.asset(
                                    'assets/images/username-icon.svg',
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                height: size.height * 0.06,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  border: Border.all(
                                    color: const Color(0xFF6B7280),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: size.width * 0.03),
                                    SvgPicture.asset(
                                      'assets/images/dob-icon.svg',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.scaleDown,
                                      // color: Color(0xFF6B7280),
                                    ),
                                    SizedBox(width: size.width * 0.03),
                                    tempDate != null
                                        ? Text(
                                            // DateFormat('yyyy-MM-dd').format(currentDate),
                                            '$tempDate',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 16,
                                              color: Color(0xFF6B7280),
                                            ),
                                          )
                                        : const Text(
                                            '0000-00-00',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 16,
                                              color: Color(0xFF6B7280),
                                            ),
                                          ),
                                    SizedBox(width: size.width * 0.37),
                                    GestureDetector(
                                      onTap: () {
                                        selectDate(context);
                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/date-picker-icon.svg',
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.scaleDown,
                                        // color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                controller: favoriteSportsTeamController,
                                keyboardType: TextInputType.text,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Favorite Sports Team field is required!';
                                //   }
                                //   return null;
                                // },
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
                                  hintText: "Favorite Sports Team",
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.3,
                                  ),
                                  prefixIcon: SvgPicture.asset(
                                    'assets/images/favorite-sports-team-icon.svg',
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
                                  if (profileFormKey.currentState!.validate()) {
                                    setState(() {
                                      isInAsyncCall = true;
                                    });
                                    await userProfile();
                                    if (profileModel.status == 'success') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor:
                                                  Color(0xFF4276EE),
                                              content: Text(
                                                  "Profile updated successfully!")));
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const NavBar()));
                                      setState(() {
                                        isInAsyncCall = false;
                                      });
                                    }
                                    if (profileModel.status != 'success') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  const Color(0xFF4276EE),
                                              content: Text(
                                                  "${profileModel.message}")));
                                      setState(() {
                                        isInAsyncCall = false;
                                      });
                                    }
                                  }
                                },
                                child: button('Save', context)),
                            SizedBox(height: size.height * 0.04),
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
}
