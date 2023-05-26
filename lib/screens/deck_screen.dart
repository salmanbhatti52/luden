// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luden/utils/colors.dart';
import 'package:luden/utils/baseurl.dart';
import 'package:luden/screens/navbar.dart';
import 'package:luden/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luden/models/get_deck_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:luden/models/create_album_model.dart';
import 'package:luden/models/delete_album_model.dart';
import 'package:luden/screens/album_view_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeckScreen extends StatefulWidget {
  const DeckScreen({super.key});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  TextEditingController albumNameController = TextEditingController();
  final GlobalKey<FormState> createAlbumFormKey = GlobalKey<FormState>();
  GetDeckModel getDeckModel = GetDeckModel();
  CreateAlbumModel createAlbumModel = CreateAlbumModel();
  DeleteAlbumModel deleteAlbumModel = DeleteAlbumModel();

  String? userId;
  getUserDeck() async {
    // try {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userId = sharedPref.getString('userid');
    String apiUrl = "$baseUrl/all_users_customers_decks";
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
      getDeckModel = getDeckModelFromJson(responseString);
      setState(() {});
      print('getDeckModel status: ${getDeckModel.status}');
      print('getDeckModel data length: ${getDeckModel.data!.length}');
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  deleteAlbum(String? id) async {
    // try {
    String apiUrl = "$baseUrl/delete_users_customers_album";
    print("api: $apiUrl");
    print("users customers albums id: $id");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {"users_customers_albums_id": '$id'},
    );
    final responseString = response.body;
    print("responseSignIn $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      deleteAlbumModel = deleteAlbumModelFromJson(responseString);
      // setState(() {});
      print('deleteAlbumModel status: ${deleteAlbumModel.status}');
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

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

  @override
  void initState() {
    super.initState();
    getUserDeck();
  }

  bool isInAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
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
                'My Decks',
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
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => createNewAlbumDialog(),
                    );
                  },
                  child: SvgPicture.asset('assets/images/add-icon.svg'),
                ),
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
            child: getDeckModel.data != null
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1 / 1.2,
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 5, // Spacing between columns
                        mainAxisSpacing: 5, // Spacing between rows
                      ),
                      itemCount: getDeckModel.data?.length,
                      // deckNameList.length, // Number of items in the grid
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            print(
                                'deck name: ${getDeckModel.data?[index].name}');
                            print(
                                'deck length: ${getDeckModel.data?[index].deck!.length}');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AlbumViewScreen(
                                          name:
                                              '${getDeckModel.data?[index].name}',
                                          albumId: getDeckModel.data?[index]
                                              .usersCustomersAlbumsId
                                              .toString(),
                                          images:
                                              getDeckModel.data?[index].deck!,
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              // color: mainColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // for (int i = 0;
                                //     i < getDeckModel.data![index].deck!.length;
                                //     i++)
                                Container(
                                  width: size.width,
                                  height: size.height * 0.18,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    // color: mainColor,
                                  ),
                                  child: getDeckModel
                                          .data![index].deck!.isNotEmpty
                                      ? Stack(
                                          children: [
                                            Center(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Image.network(
                                                  '$imageUrl${getDeckModel.data?[index].deck![0].albumPicture}',
                                                  width: 140,
                                                  height: 140,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                  // albumNameList[index].imageUrl,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 20,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Dialog alert = Dialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                    child: SizedBox(
                                                      height:
                                                          size.height * 0.41,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 25,
                                                                vertical: 30),
                                                        child: Column(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: SvgPicture
                                                                    .asset(
                                                                        'assets/images/close-icon.svg'),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.02),
                                                            AutoSizeText(
                                                              'Are you sure you\nwant to delete “${getDeckModel.data![index].name}”?',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    'Poppins-Regular',
                                                                fontSize: 18,
                                                                color:
                                                                    secondaryColor,
                                                              ),
                                                              minFontSize: 18,
                                                              maxFontSize: 18,
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.03),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                await deleteAlbum(
                                                                    getDeckModel
                                                                        .data?[
                                                                            index]
                                                                        .usersCustomersAlbumsId
                                                                        .toString());
                                                                if (deleteAlbumModel
                                                                        .status ==
                                                                    'success') {
                                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xFF4276EE),
                                                                      content: Text(
                                                                          "Deck deleted successfully!")));
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (BuildContext context) =>
                                                                              const NavBar()));
                                                                }
                                                                if (deleteAlbumModel
                                                                        .status !=
                                                                    'success') {
                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                      backgroundColor:
                                                                          const Color(
                                                                              0xFF4276EE),
                                                                      content: Text(
                                                                          "${deleteAlbumModel.message}")));
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              },
                                                              child:
                                                                  dialogButton(
                                                                      'Yes',
                                                                      context),
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.02),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  dialogButtonTransparent(
                                                                      'No',
                                                                      context),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return alert;
                                                    },
                                                  );
                                                  print(
                                                      'uyrt ${getDeckModel.data?[index].usersCustomersAlbumsId}');
                                                },
                                                child: SvgPicture.asset(
                                                  'assets/images/delete-icon.svg',
                                                  // colorFilter: const ColorFilter.mode(
                                                  //     Colors.red, BlendMode.srcIn),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Stack(
                                          children: [
                                            Center(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                  'assets/images/placeholder-image.jpeg',
                                                  width: 140,
                                                  height: 140,
                                                  fit: BoxFit.contain,
                                                  // deckNameList[index].imageUrl,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 20,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Dialog alert = Dialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                    child: SizedBox(
                                                      height:
                                                          size.height * 0.41,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 25,
                                                                vertical: 30),
                                                        child: Column(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: SvgPicture
                                                                    .asset(
                                                                        'assets/images/close-icon.svg'),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.02),
                                                            AutoSizeText(
                                                              'Are you sure you\nwant to delete “${getDeckModel.data![index].name}”?',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    'Poppins-Regular',
                                                                fontSize: 18,
                                                                color:
                                                                    secondaryColor,
                                                              ),
                                                              minFontSize: 18,
                                                              maxFontSize: 18,
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.03),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                await deleteAlbum(
                                                                    getDeckModel
                                                                        .data?[
                                                                            index]
                                                                        .usersCustomersAlbumsId
                                                                        .toString());
                                                                if (deleteAlbumModel
                                                                        .status ==
                                                                    'success') {
                                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xFF4276EE),
                                                                      content: Text(
                                                                          "Deck deleted successfully!")));
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (BuildContext context) =>
                                                                              const NavBar()));
                                                                }
                                                                if (deleteAlbumModel
                                                                        .status !=
                                                                    'success') {
                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                      backgroundColor:
                                                                          const Color(
                                                                              0xFF4276EE),
                                                                      content: Text(
                                                                          "${deleteAlbumModel.message}")));
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              },
                                                              child:
                                                                  dialogButton(
                                                                      'Yes',
                                                                      context),
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.02),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  dialogButtonTransparent(
                                                                      'No',
                                                                      context),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return alert;
                                                    },
                                                  );
                                                  print(
                                                      'uyrt ${getDeckModel.data?[index].usersCustomersAlbumsId}');
                                                },
                                                child: SvgPicture.asset(
                                                  'assets/images/delete-icon.svg',
                                                  // colorFilter: const ColorFilter.mode(
                                                  //     Colors.red, BlendMode.srcIn),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: getDeckModel.data?[index].name != null
                                      ? AutoSizeText(
                                          '${getDeckModel.data![index].name}',
                                          // deckNameList[index].title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Poppins-Regular',
                                            fontWeight: FontWeight.w500,
                                          ),
                                          minFontSize: 18,
                                          maxFontSize: 18,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : const Text(''),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: getDeckModel.data?[index]
                                              .countAlbumPictures !=
                                          null
                                      ? Text(
                                          '${getDeckModel.data![index].countAlbumPictures}',
                                          // deckNameList[index].subtitle,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 10,
                                            fontFamily: 'Poppins-Regular',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      : const Text(''),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                :
                // : getDeckModel.data != null
                //     ?
                Center(
                    child: Text(
                      'No Deck Found',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
            // : const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            ),
      ),
    );
  }

  Widget createNewAlbumDialog() {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Color(0xFF4276EE),
                                  content:
                                      Text("Deck Name saved successfully!")));
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const NavBar()));
                        setState(() {});
                      }
                    },
                    child: dialogButton('Save', context),
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
