// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luden/utils/colors.dart';
import 'package:luden/utils/baseurl.dart';
import 'package:luden/widgets/button.dart';
import 'package:luden/screens/navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luden/models/get_deck_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:luden/models/delete_deck_model.dart';
import 'package:luden/screens/image_view_screen.dart';
import 'package:luden/models/get_deck_by_id_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlbumViewScreen extends StatefulWidget {
  final String? name;
  final String? albumId;
  final List<Deck>? images;
  const AlbumViewScreen({super.key, this.name, this.albumId, this.images});

  @override
  State<AlbumViewScreen> createState() => _AlbumViewScreenState();
}

class _AlbumViewScreenState extends State<AlbumViewScreen> {
  GetDeckModel getDeckModel = GetDeckModel();
  GetDecksByIdModel getDeckByIdModel = GetDecksByIdModel();
  DeleteDeckModel deleteDeckModel = DeleteDeckModel();

  String? userId;
  String? signatureImage;

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
    print("responseAllUsersCustomersDecks $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      getDeckModel = getDeckModelFromJson(responseString);
      setState(() {});
      print('getDeckModel status: ${getDeckModel.status}');
      // for (int i = 0; i < getDeckModel.data!.length; i++) {
      //   for (int j = 0; j < getDeckModel.data![i].deck!.length; j++) {
      //     // if (getDeckModel.data![i].deck![j].signature != null)
      //       print('signature image: ${getDeckModel.data![i].deck![j].signature
      //           ?.signatureDetail?.signatureImage}');
      //     // print('new: ${getDeckModel.data![i].usersCustomersAlbumsId ==
      //     //     widget.signatureId}');
      //   }
      // }
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  getUserDeckById() async {
    // try {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userId = sharedPref.getString('userid');
    String apiUrl = "$baseUrl/get_decks_by_id";
    print("api: $apiUrl");
    print("used id: $userId");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "users_customers_id": userId,
        "users_customers_albums_id": widget.albumId
      },
    );
    final responseString = response.body;
    print("responseGetDecksById $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      getDeckByIdModel = getDecksByIdModelFromJson(responseString);
      setState(() {});
      print('${widget.albumId}');
      print('getDeckModel status: ${getDeckByIdModel.status}');
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  String? deckId;

  deleteDeck(String? id) async {
    // try {
    String apiUrl = "$baseUrl/delete_users_customers_deck";
    print("api: $apiUrl");
    print("users customers decks id: $id");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {"users_customers_decks_id": '$id'},
    );
    final responseString = response.body;
    print("responseSignIn $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      deleteDeckModel = deleteDeckModelFromJson(responseString);
      // setState(() {});
      print('deleteAlbumModel status: ${deleteDeckModel.status}');
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  navigate() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => const NavBar()));
  }

  @override
  void initState() {
    super.initState();
    getUserDeck();
    getUserDeckById();
  }

  int index = 0;

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
            backgroundColor: topBarColor,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const NavBar()));
                // Navigator.pop(context);
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
                widget.name!,
                // 'Album Name',
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
            actions: const [
              Padding(padding: EdgeInsets.symmetric(horizontal: 20))
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
            child: getDeckByIdModel.data != null
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.2 / 1.2,
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 5, // Spacing between columns
                        mainAxisSpacing: 5, // Spacing between rows
                      ),
                      itemCount: getDeckByIdModel.data!.length,
                      // albumNameList.length, // Number of items in the grid
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // for (int i = 0; i < getDeckModel.data!.length; i++) {
                            //   for (int j = 0; j < getDeckModel.data![i].deck!.length; j++) {
                            //     if(getDeckModel.data![i].deck![j].usersCustomersDecksId == getDeckByIdModel.data![index].usersCustomersDecksId) {
                            //       signatureImage = '${getDeckModel.data![i].deck![j].signature
                            //           ?.signatureDetail?.signatureImage}';
                            //       print(' hi: ${getDeckModel.data![i].deck![j].signature
                            //           ?.signatureDetail?.signatureImage}');
                            //     }
                            //   }
                            // }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ImageViewScreen(
                                          name:
                                              '${getDeckByIdModel.data![index].name}',
                                          image:
                                              '${getDeckByIdModel.data![index].albumPicture}',
                                          deckId:
                                              '${getDeckByIdModel.data![index].usersCustomersDecksId}',
                                          signature: getDeckByIdModel
                                                      .data![index].signature !=
                                                  null
                                              ? '${getDeckByIdModel.data![index].signature!}'
                                              : "",
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              // color: secondaryColor,
                            ),
                            child: Stack(
                              children: [
                                getDeckByIdModel.data != null
                                    ? getDeckByIdModel
                                                .data![index].albumPicture !=
                                            null
                                        ? Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                '$imageUrl${getDeckByIdModel.data![index].albumPicture}',
                                                width: 140,
                                                height: 140,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
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
                                          )
                                        : Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.asset(
                                                'assets/images/placeholder-image.jpeg',
                                                width: 140,
                                                height: 140,
                                                fit: BoxFit.contain,
                                                // deckNameList[index].imageUrl,
                                              ),
                                            ),
                                          )
                                    : const CircularProgressIndicator(),
                                Positioned(
                                  top: 20,
                                  right: 18,
                                  child: GestureDetector(
                                    onTap: () {
                                      Dialog alert = Dialog(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: SizedBox(
                                          height: size.height * 0.41,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 30),
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: SvgPicture.asset(
                                                        'assets/images/close-icon.svg'),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: size.height * 0.02),
                                                AutoSizeText(
                                                  'Are you sure you\nwant to delete “${getDeckByIdModel.data![index].name}”?',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily:
                                                        'Poppins-Regular',
                                                    fontSize: 18,
                                                    color: secondaryColor,
                                                  ),
                                                  minFontSize: 18,
                                                  maxFontSize: 18,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                    height: size.height * 0.03),
                                                GestureDetector(
                                                  onTap: () async {
                                                    await deleteDeck(
                                                        getDeckByIdModel
                                                            .data![index]
                                                            .usersCustomersDecksId
                                                            .toString());
                                                    if (deleteDeckModel
                                                            .status ==
                                                        'success') {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(const SnackBar(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFF4276EE),
                                                              content: Text(
                                                                  "Card deleted successfully!")));
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        getUserDeckById();
                                                      });
                                                      // Future.delayed(const Duration(seconds: 1), navigate());
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (BuildContext
                                                      //                 context) =>
                                                      //             AlbumViewScreen(
                                                      //               name:
                                                      //               '${widget.name}',
                                                      //               images: widget.images,
                                                      //             )));
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (BuildContext
                                                      //         context) => const NavBar()));
                                                    }
                                                    if (deleteDeckModel
                                                            .status !=
                                                        'success') {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xFF4276EE),
                                                              content: Text(
                                                                  "${deleteDeckModel.message}")));
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: dialogButton(
                                                      'Yes', context),
                                                ),
                                                SizedBox(
                                                    height: size.height * 0.02),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child:
                                                      dialogButtonTransparent(
                                                          'No', context),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
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
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text(
                      'No Cards Found',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )),
      ),
    );
  }
}
