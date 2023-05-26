// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luden/utils/colors.dart';
import 'package:luden/utils/baseurl.dart';
import 'package:luden/screens/navbar.dart';
import 'package:luden/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luden/models/get_deck_model.dart';
import 'package:luden/models/get_album_model.dart';
import 'package:luden/screens/capture_screen.dart';
import 'package:luden/models/create_deck_model.dart';
import 'package:luden/models/create_album_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SaveImageScreen extends StatefulWidget {
  final File? image;
  final String? image64;
  final List<Deck>? images;
  const SaveImageScreen({super.key, this.image, this.image64, this.images});

  @override
  State<SaveImageScreen> createState() => _SaveImageScreenState();
}

class _SaveImageScreenState extends State<SaveImageScreen> {
  TextEditingController cardNameController = TextEditingController();
  TextEditingController albumNameController = TextEditingController();
  final GlobalKey<FormState> cardNameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> createAlbumFormKey = GlobalKey<FormState>();
  CreateAlbumModel createAlbumModel = CreateAlbumModel();
  GetAlbumModel getAlbumModel = GetAlbumModel();
  CreateDeckModel createDeckModel = CreateDeckModel();
  String? userId;
  String? hintValue;
  bool isValueSelected = false;
  String? isValueId;

  createAlbumName() async {
    // try {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userId = sharedPref.getString('userid');
    String apiUrl = "$baseUrl/create_users_customers_album";
    print("api: $apiUrl");
    print("used id: $userId");
    print("album name: ${albumNameController.text}");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {"users_customers_id": userId, "name": albumNameController.text},
    );
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      createAlbumModel = createAlbumModelFromJson(responseString);
      // setState(() {});
      print('signInModel status: ${createAlbumModel.status}');
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  getAlbumName() async {
    // try {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userId = sharedPref.getString('userid');
    String apiUrl = "$baseUrl/all_users_customers_albums";
    print("api: $apiUrl");
    print("used id: $userId");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {"users_customers_id": userId},
    );
    final responseString = response.body;
    print("responseSignIn $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      getAlbumModel = getAlbumModelFromJson(responseString);
      // setState(() {});
      print('getAlbumModel status: ${getAlbumModel.status}');
      for (int i = 0; i < getAlbumModel.data!.length; i++) {
        print(
            'getAlbumModel id: ${getAlbumModel.data![i].usersCustomersAlbumsId}');
        print('getAlbumModel name: ${getAlbumModel.data![i].name}');
        hintValue = getAlbumModel.data!.first.name;
        isValueId = getAlbumModel.data!.first.usersCustomersAlbumsId.toString();
        // print("value of drop ${hintValue}");
      }
      setState(() {});
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  int? id;

  createCardName() async {
    // try {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userId = sharedPref.getString('userid');
    String apiUrl = "$baseUrl/create_users_customers_deck";
    print("api: $apiUrl");
    print(
        "users customers albums id: ${isValueSelected == true ? isValueId : id}");
    // print("users customers albums id: $isValueId");
    print("card name: ${cardNameController.text}");
    print("album picture: ${widget.image64}");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "users_customers_albums_id":
            isValueSelected == true ? isValueId : '$id',
        "name": cardNameController.text,
        "album_picture": widget.image64,
      },
    );
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      createDeckModel = createDeckModelFromJson(responseString);
      // setState(() {});
      print('createDeckModel status: ${createDeckModel.status}');
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  @override
  void initState() {
    super.initState();
    getAlbumName();
  }

  String? dropdownValue;
  bool isInAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
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
        child: WillPopScope(
          onWillPop: () async {
            // Navigate to a different screen when the back button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavBar()),
            );
            return false; // Return false to prevent the default behavior
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: AppBar(
                backgroundColor: topBarColor,
                elevation: 0,
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const NavBar()),
                        (Route<dynamic> route) => false);
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
                title: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Save Image',
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
            body: ModalProgressHUD(
              inAsyncCall: isInAsyncCall,
              // opacity: 0.02,
              // blur: 0.5,
              color: Colors.transparent,
              progressIndicator: const CircularProgressIndicator(
                color: Color(0xFF4276EE),
              ),
              child: Container(
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
                    key: cardNameFormKey,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.04),
                        // if (widget.image != null)
                        Container(
                          width: size.width * 0.85,
                          height: size.height * 0.33,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              widget.image!,
                              // 'assets/images/save-image-preview.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: cardNameController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Card name field is required!';
                              }
                              return null;
                            },
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins-Regular',
                              fontSize: 16,
                              color: Color(0xFF6B7280),
                            ),
                            decoration: const InputDecoration(
                              filled: false,
                              errorStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                wordSpacing: 2,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                borderSide: BorderSide(
                                  color: Color(0xFF6B7280),
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                borderSide: BorderSide(
                                  color: Color(0xFF6B7280),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                borderSide: BorderSide(
                                  color: Color(0xFF6B7280),
                                  width: 1,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              hintText: "Enter card name here",
                              hintStyle: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 16,
                                fontFamily: 'Poppins-Regular',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(30),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF6B7280), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF6B7280), width: 1),
                                  ),
                                  filled: false,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  hintText: isValueSelected == true
                                      ? "$hintValue"
                                      : "Select Deck",
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xFF6B7280),
                                ),
                                dropdownColor: const Color(0xFF1A1A1A),
                                value: dropdownValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                    //  isValueSelected==true? dropdownValue=hintValue: dropdownValue=newValue;
                                    id = int.parse(dropdownValue!);
                                    print('id: $id');
                                  });
                                },
                                items: [
                                  if (getAlbumModel.data != null)
                                    for (int i = 0;
                                        i < getAlbumModel.data!.length;
                                        i++)
                                      DropdownMenuItem(
                                        value:
                                            '${getAlbumModel.data?[i].usersCustomersAlbumsId}',
                                        child: Text(
                                          '${getAlbumModel.data?[i].name}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF6B7280),
                                            fontFamily: 'Poppins-Regular',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => createNewAlbumDialog(),
                            );
                          },
                          child: Text(
                            'Create New Deck',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins-Regular',
                              fontSize: 16,
                              letterSpacing: 0.3,
                              color: buttonColor,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.065),
                        GestureDetector(
                          onTap: () async {
                            if (cardNameFormKey.currentState!.validate()) {
                              setState(() {
                                isInAsyncCall = true;
                              });
                              await createCardName();
                              if (createDeckModel.status == 'success') {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => cardNameDialog(),
                                );
                              }
                              setState(() {
                                isInAsyncCall = false;
                              });
                              if (createDeckModel.status != 'success') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor:
                                            const Color(0xFF4276EE),
                                        content: Text(
                                            "${createDeckModel.message}")));
                                setState(() {
                                  isInAsyncCall = false;
                                });
                              }
                            }
                          },
                          child: button('Save', context),
                        ),
                        SizedBox(height: size.height * 0.02),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const CaptureScreen()));
                            },
                            child: buttonTransparent('Retake', context))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget createNewAlbumDialog() {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: SizedBox(
            height: size.height * 0.38,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Form(
                key: createAlbumFormKey,
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
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Create Deck',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 18,
                        color: secondaryColor,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      controller: albumNameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Deck name field is required!';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                      decoration: const InputDecoration(
                        filled: false,
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            color: Color(0xFF6B7280),
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            color: Color(0xFF6B7280),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            color: Color(0xFF6B7280),
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        hintText: "Enter deck name here",
                        hintStyle: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 16,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    GestureDetector(
                      onTap: () async {
                        if (createAlbumFormKey.currentState!.validate()) {
                          await createAlbumName();
                          if (createAlbumModel.status == 'success') {
                            isValueSelected = true;
                            // dropdownValue==hintValue;
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Color(0xFF4276EE),
                                    content:
                                        Text("Deck Name saved successfully!")));
                          }
                          Navigator.pop(context);
                          getAlbumName();
                          setState(() {});
                        }
                        // if (createAlbumModel.status != 'success') {
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //       backgroundColor: const Color(0xFF4276EE),
                        //       content: Text("${createAlbumModel.message}")));
                        // }
                      },
                      child: dialogButton('Save', context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cardNameDialog() {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: SizedBox(
            height: size.height * 0.28, // previous 0.37
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Card Saved\nSuccessfully.',
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
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const NavBar()),
                          (Route<dynamic> route) => false);
                    },
                    child: dialogButton('OK', context),
                  ),
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (BuildContext context) =>
                  //                 ImageViewScreen2(
                  //                   name: '${createDeckModel.data!.name}',
                  //                   image: '${createDeckModel.data!.albumPicture}',
                  //                   deckId: '${createDeckModel.data!.usersCustomersDecksId}',
                  //                   // name:
                  //                   // '${widget.images[].name}',
                  //                   // image:
                  //                   // '${widget.images?[].albumPicture}',
                  //                 )));
                  //   },
                  //   child: dialogButtonTransparent('Add Signature', context),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
