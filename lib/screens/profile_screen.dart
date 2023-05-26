// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luden/utils/colors.dart';
import 'package:luden/utils/baseurl.dart';
import 'package:luden/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luden/screens/login_screen.dart';
import 'package:luden/models/profile_model.dart';
import 'package:luden/models/all_count_model.dart';
import 'package:luden/screens/delete_account.dart';
import 'package:luden/models/get_profile_model.dart';
import 'package:luden/screens/reset_password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController favoriteSportsTeamController = TextEditingController();
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  ProfileModel profileModel = ProfileModel();
  GetProfileModel getProfileModel = GetProfileModel();
  GetAllCountModel getAllCountModel = GetAllCountModel();
  String? userId;

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
        "favorite_sports_team": favoriteSportsTeamController.text,
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

  getUserProfile() async {
    setState(() {
      loading = true;
    });
    // try {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userId = sharedPref.getString('userid');
    String apiUrl = "$baseUrl/users_customers_profile_by_id";
    print("api: $apiUrl");
    print("used id: $userId");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "users_customers_id": userId,
      },
    );
    final responseString = response.body;
    print("responseSignInApi profile: $responseString");
    print("status Code SignIn: ${response.body}");
    if (response.statusCode == 200) {
      print("in 200 signIn ${response.body}");

      getProfileModel = getProfileModelFromJson(responseString);
      print('email: ${getProfileModel.data!.email}');

      // setState(() {});
      print('getProfileModel status: ${getProfileModel.status}');
      setState(() {
        loading = false;
        setData();
      });
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  String? tempDate;

  setData() {
    if(getProfileModel.data!.fullName !=null && getProfileModel.data!.username !=null && getProfileModel.data!.dob !=null){
    nameController.text = "${getProfileModel.data!.fullName}";
    userNameController.text = "${getProfileModel.data!.username}";
    DateTime inputDate = DateTime.parse('${getProfileModel.data!.dob}');
    tempDate = DateFormat('yyyy-MM-dd').format(inputDate);
    valueDate = "${getProfileModel.data!.dob}";
    getProfileModel.data!.favoriteSportsTeam != null ?
    favoriteSportsTeamController.text =
        "${getProfileModel.data!.favoriteSportsTeam}"
    : favoriteSportsTeamController.text =
    "";

    print("nameController ${nameController.text}");
    print("userNameController ${userNameController.text}");
    print("tempDate $tempDate");
    print("favoriteSportsTeamController ${favoriteSportsTeamController.text}");
  }}

  getAllCount() async {
    setState(() {
      loading = true;
    });
    // try {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userId = sharedPref.getString('userid');
    String apiUrl = "$baseUrl/count_albums_decks_signatured_images";
    print("api: $apiUrl");
    print("used id: $userId");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "users_customers_id": userId,
      },
    );
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      getAllCountModel = getAllCountModelFromJson(responseString);
      // setState(() {});
      print('getAllCountModel status: ${getAllCountModel.status}');
      print('totalAlbums: ${getAllCountModel.data!.totalAlbums}');
      setState(() {
        loading = false;
      });
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

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

  removeDataFormSharedPreferences() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
    getAllCount();
  }

  bool isInAsyncCall = false;
  bool loading = true;

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
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => logoutDialog());
                        },
                        child:
                            SvgPicture.asset('assets/images/logout-icon.svg')),
                  ),
                ],
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
                  child: loading
                      ? Column(
                          children: [
                            SizedBox(height: size.height * 0.36),
                            Center(
                                child: CircularProgressIndicator(
                                    color: mainColor)),
                          ],
                        )
                      : Column(
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
                                                  "Profile settings changed successfully!")));

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
                            Container(
                              width: size.width * 0.9,
                              height: size.height * 0.12,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: size.height * 0.02),
                                    const Text(
                                      'Email',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    getProfileModel.data?.email != null
                                        ? Text(
                                            '${getProfileModel.data!.email}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text(''),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Container(
                              width: size.width * 0.9,
                              height: size.height * 0.12,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: size.height * 0.02),
                                    const Text(
                                      'Total Decks',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    getAllCountModel.data?.totalAlbums != null
                                        ? Text(
                                            '${getAllCountModel.data!.totalAlbums}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text(''),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Container(
                              width: size.width * 0.9,
                              height: size.height * 0.12,
                              decoration: BoxDecoration(
                                // color: mainColor,
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: size.height * 0.02),
                                    const Text(
                                      'Total Cards in Vault',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    getAllCountModel.data?.totalImagesDecks !=
                                            null
                                        ? Text(
                                            '${getAllCountModel.data!.totalImagesDecks}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text(''),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Container(
                              width: size.width * 0.9,
                              height: size.height * 0.12,
                              decoration: BoxDecoration(
                                // color: mainColor,
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: size.height * 0.02),
                                    const Text(
                                      'Signatures Added',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    getAllCountModel
                                                .data?.totalSignatureImages !=
                                            null
                                        ? Text(
                                            '${getAllCountModel.data!.totalSignatureImages}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text(''),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.04),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const ResetPasswordScreen()));
                              },
                              child: button('Reset Password', context),
                            ),
                            SizedBox(height: size.height * 0.02),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                        const DeleteAccount()));
                              },
                              child: button('Delete Account', context),
                            ),
                            SizedBox(height: size.height * 0.03),
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

  Widget logoutDialog() {
    var size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SizedBox(
        height: size.height * 0.26,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            children: [
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.pop(context);
              //     },
              //     child: SvgPicture.asset('assets/images/close-icon.svg'),
              //   ),
              // ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Are you Sure?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 18,
                  color: secondaryColor,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Do you want to logout',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 14,
                  color: secondaryColor,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: dialogbuttonSmall('No', context),
                  ),
                  SizedBox(width: size.width * 0.02),
                  GestureDetector(
                    onTap: () {
                      removeDataFormSharedPreferences();
                      setState(() {});
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      const LoginPage()), (Route<dynamic> route) => false);
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             const LoginPage()));
                    },
                    child: dialogButtontransparentSmall('Yes', context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
