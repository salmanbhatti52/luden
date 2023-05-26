// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luden/utils/colors.dart';
import 'package:luden/utils/baseurl.dart';
import 'package:luden/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luden/models/delete_account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  DeleteAccountModel deleteAccountModel = DeleteAccountModel();
  String? userEmail;

  deleteAccount() async {
    // try {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userEmail = sharedPref.getString('user_email');
    String apiUrl = "$baseUrl/delete_account";
    print("api: $apiUrl");
    print("user email: $userEmail");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "user_email": userEmail,
        "delete_reason": "test delete",
        "comments": "Hello"
      },
    );
    final responseString = response.body;
    print("responseDeleteAccountApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      deleteAccountModel = deleteAccountModelFromJson(responseString);
      // setState(() {});
      print('deleteAccountModel status: ${deleteAccountModel.status}');
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
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
                  'Delete Account',
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
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.08),
                  Text(
                    'Confirm to delete account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.08),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: SvgPicture.asset('assets/images/delete-account.svg'),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Text(
                    'Are you sure you want\nto delete your account?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.12),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isInAsyncCall = true;
                      });
                      await deleteAccount();
                      if (deleteAccountModel.status == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: const Color(0xFF4276EE),
                            content: Text("${deleteAccountModel.message}")));
                        setState(() {
                          isInAsyncCall = false;
                        });
                      }
                      if (deleteAccountModel.status != 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: const Color(0xFF4276EE),
                            content: Text("${deleteAccountModel.message}")));
                        setState(() {
                          isInAsyncCall = false;
                        });
                      }
                    },
                    child: button('Yes', context),
                  ),
                  SizedBox(height: size.height * 0.02),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: buttonTransparent('No', context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
