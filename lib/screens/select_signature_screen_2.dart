// // ignore_for_file: avoid_print, use_build_context_synchronously
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:luden/utils/colors.dart';
// import 'package:luden/utils/baseurl.dart';
// import 'package:luden/widgets/button.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:searchfield/searchfield.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:luden/models/get_all_signatures.dart';
// import 'package:luden/screens/signature_screen_2.dart';
// import 'package:luden/models/add_signature_deck_2.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
//
// class SelectSignatureScreen2 extends StatefulWidget {
//   final String? image;
//   final String? name;
//   final String? deckId;
//   const SelectSignatureScreen2({super.key, this.image, this.name, this.deckId});
//
//   @override
//   State<SelectSignatureScreen2> createState() => _SelectSignatureScreen2State();
// }
//
// class _SelectSignatureScreen2State extends State<SelectSignatureScreen2> {
//   TextEditingController searchController = TextEditingController();
//   final GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();
//   GetAllSignatures getAllSignaturesModel = GetAllSignatures();
//   AddSignatureDeck2 addSignatureDeckModel = AddSignatureDeck2();
//
//   getAllSignatures() async {
//     // try {
//     String apiUrl = "$baseUrl/all_signature";
//     print("api: $apiUrl");
//     final response = await http.get(
//       Uri.parse(apiUrl),
//       headers: {
//         'Accept': 'application/json',
//       },
//     );
//     final responseString = response.body;
//     print("responseSignIn $responseString");
//     print("status Code SignIn: ${response.statusCode}");
//     print("in 200 signIn");
//     if (response.statusCode == 200) {
//       getAllSignaturesModel = getAllSignaturesFromJson(responseString);
//       setState(() {});
//       print('getAllSignaturesModel status: ${getAllSignaturesModel.status}');
//       print(
//           'getAllSignaturesModel length: ${getAllSignaturesModel.data!.length}');
//       for (int i = 0; i < getAllSignaturesModel.data!.length; i++) {
//         print('name : ${getAllSignaturesModel.data?[i].name}');
//         suggestions2.add("${getAllSignaturesModel.data?[i].name}");
//       }
//     }
//     // } catch (e) {
//     //   print('Something went wrong = ${e.toString()}');
//     //   return null;
//     // }
//   }
//
//   String? userId;
//   int? signatureId;
//   String? image;
//
//   addSignatureDeck() async {
//     // try {
//     for (int i = 0; i < getAllSignaturesModel.data!.length; i++) {
//       print('name : ${getAllSignaturesModel.data?[i].signaturesId}');
//       suggestions2.add("${getAllSignaturesModel.data?[i].name}");
//       if (getAllSignaturesModel.data?[i].name == searchController.text) {
//         signatureId = getAllSignaturesModel.data?[i].signaturesId;
//         image = getAllSignaturesModel.data?[i].signatureImage;
//         print("signature Image: $image");
//       }
//     }
//
//     SharedPreferences sharedPref = await SharedPreferences.getInstance();
//     userId = sharedPref.getString('userid');
//     String apiUrl = "$baseUrl/add_signature_deck";
//     print("signatureId: $signatureId");
//     print("user Id: $userId");
//     print("users_customers_decks_id: ${widget.deckId}");
//     print("signatures_id: signatureId");
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Accept': 'application/json',
//       },
//       body: {
//         "users_customers_id": userId,
//         "users_customers_decks_id": widget.deckId,
//         "signatures_id": signatureId.toString()
//       },
//     );
//     final responseString = response.body;
//     print("responseSignInApi: $responseString");
//     print("status Code SignIn: ${response.statusCode}");
//     print("in 200 signIn");
//     if (response.statusCode == 200) {
//       addSignatureDeckModel = addSignatureDeck2FromJson(responseString);
//       // setState(() {});
//       print('addSignatureDeck status: ${addSignatureDeckModel.status}');
//     }
//     // } catch (e) {
//     //   print('Something went wrong = ${e.toString()}');
//     //   return null;
//     // }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getAllSignatures();
//     print('${widget.image}');
//     print('${widget.name}');
//     print('deck Id: ${widget.deckId}');
//   }
//
//   List<String> suggestions2 = [];
//   String? selectedVal;
//   bool isInAsyncCall = false;
//   bool isSelected = false;
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(80),
//           child: AppBar(
//             backgroundColor: topBarColor,
//             elevation: 0,
//             leading: GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: SvgPicture.asset(
//                   'assets/images/back-arrow.svg',
//                   width: 22,
//                   height: 22,
//                   fit: BoxFit.scaleDown,
//                 ),
//               ),
//             ),
//             centerTitle: true,
//             title: Padding(
//               padding: const EdgeInsets.only(top: 20),
//               child: Text(
//                 'Select Signatures',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                   textStyle: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         backgroundColor: topBarColor,
//         body: ModalProgressHUD(
//           inAsyncCall: isInAsyncCall,
//           // opacity: 0.02,
//           // blur: 0.5,
//           color: Colors.transparent,
//           progressIndicator: const CircularProgressIndicator(
//             color: Color(0xFF4276EE),
//           ),
//           child: ClipRRect(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30),
//             ),
//             child: Container(
//               width: size.width,
//               height: size.height,
//               decoration: BoxDecoration(
//                 color: secondaryColor,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Form(
//                   key: searchFormKey,
//                   child: Column(
//                     children: [
//                       SizedBox(height: size.height * 0.04),
//                       Padding(
//                         padding:
//                             const EdgeInsets.symmetric(horizontal: 20),
//                         child: GestureDetector(
//                           onTap: () {
//                             isSelected = true;
//                             setState(() {});
//                           },
//                           child: Container(
//                             width: size.width,
//                             height: size.height * 0.065,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 width: 1,
//                                 color: const Color(0xFF6B7280),
//                               ),
//                               borderRadius: BorderRadius.circular(100),
//                               // color: Colors.blue,
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 10),
//                               child: Row(
//                                 children: const [
//                                   Text(
//                                     "Select Signature",
//                                     style: TextStyle(
//                                       color: Color(0xFF6B7280),
//                                       fontSize: 16,
//                                       fontFamily: 'Poppins-Regular',
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                   Spacer(),
//                                   Icon(
//                                     Icons.keyboard_arrow_down,
//                                     color: Color(0xFF6B7280),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.02),
//                       if(isSelected)
//                       Stack(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Container(
//                               height: size.height * 0.3,
//                               decoration: BoxDecoration(
//                                 // color: Colors.blue,
//                                 border: Border.all(
//                                   width: 1,
//                                   color: const Color(0xFF6B7280),
//                                 ),
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                             const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                             child: ButtonTheme(
//                               alignedDropdown: true,
//                               child: SearchField(
//                                 controller: searchController,
//                                 inputType: TextInputType.text,
//                                 marginColor: secondaryColor,
//                                 searchInputDecoration: InputDecoration(
//                                   suffixIcon: GestureDetector(
//                                     onTap: () {
//                                       searchController.clear();
//                                       setState(() {});
//                                     },
//                                     child: const Icon(
//                                       Icons.close,
//                                       size: 20,
//                                       color: Color(0xFF6B7280),
//                                     ),
//                                   ),
//                                   hintText: "Search",
//                                   hintStyle: const TextStyle(
//                                     color: Color(0xFF6B7280),
//                                     // Colors.black.withOpacity(0.6),
//                                     fontSize: 16,
//                                     fontFamily: 'Poppins-Regular',
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 20),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Color(0xFF6B7280),
//                                     ),
//                                     borderRadius: BorderRadius.circular(100),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Color(0xFF6B7280),
//                                     ),
//                                     borderRadius: BorderRadius.circular(100),
//                                   ),
//                                   errorBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Colors.red,
//                                     ),
//                                     borderRadius: BorderRadius.circular(100),
//                                   ),
//                                   focusedErrorBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Color(0xFF6B7280),
//                                     ),
//                                     borderRadius: BorderRadius.circular(100),
//                                   ),
//                                 ),
//                                 itemHeight: 40,
//                                 maxSuggestionsInViewPort: 4,
//                                 suggestionItemDecoration: BoxDecoration(
//                                   color: secondaryColor,
//                                 ),
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Please enter a search term';
//                                   }
//                                   return null;
//                                 },
//                                 suggestions: suggestions2
//                                     .map((e) => SearchFieldListItem<String>(e))
//                                     .toList(),
//                                 suggestionStyle: const TextStyle(
//                                   color: Color(0xFF6B7280),
//                                   fontSize: 16,
//                                   fontFamily: 'Poppins-Regular',
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                                 searchStyle: const TextStyle(
//                                   color: Color(0xFF6B7280),
//                                   fontSize: 16,
//                                   fontFamily: 'Poppins-Regular',
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: size.height * 0.35),
//                       if(isSelected)
//                       GestureDetector(
//                         onTap: () async {
//                           if (searchFormKey.currentState!.validate()) {
//                             setState(() {
//                               isInAsyncCall = true;
//                             });
//                             await addSignatureDeck();
//                             if (getAllSignaturesModel.status == 'success') {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       backgroundColor: Color(0xFF4276EE),
//                                       content:
//                                           Text("Signature has been added!")));
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (BuildContext context) =>
//                                           SignatureScreen2(
//                                             name: '${widget.name}',
//                                             image: '${widget.image}',
//                                             signatureImage: '$image',
//                                           )));
//                               setState(() {
//                                 isInAsyncCall = false;
//                               });
//                             }
//                             if (getAllSignaturesModel.status != 'success') {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       backgroundColor: const Color(0xFF4276EE),
//                                       content: Text(
//                                           "${getAllSignaturesModel.message}")));
//                               setState(() {
//                                 isInAsyncCall = false;
//                               });
//                             }
//                           }
//                         },
//                         child: button('OK', context),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
