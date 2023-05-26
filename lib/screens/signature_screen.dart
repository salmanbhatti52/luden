// // ignore_for_file: avoid_print, use_build_context_synchronously

// // import 'dart:ui' as ui;
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:luden/utils/colors.dart';
// import 'package:luden/utils/baseurl.dart';
// import 'package:luden/screens/navbar.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

// class SignatureScreen extends StatefulWidget {
//   final String? image;
//   final String? name;
//   final String? deckId;
//   final Uint8List? signature;

//   const SignatureScreen(
//       {super.key, this.image, this.name, this.deckId, this.signature});

//   @override
//   State<SignatureScreen> createState() => _SignatureScreenState();
// }

// class _SignatureScreenState extends State<SignatureScreen> {

//   GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     print('${widget.image}');
//     print('${widget.name}');
//     print('${widget.deckId}');
//     // print('${widget.signatureImage}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return WillPopScope(
//       onWillPop: () async {
//         // Navigate to a different screen when the back button is pressed
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const NavBar()),
//         );
//         return false; // Return false to prevent the default behavior
//       },
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(80),
//           child: AppBar(
//             backgroundColor: topBarColor,
//             elevation: 0,
//             leading: GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
//                 const NavBar()), (Route<dynamic> route) => false);
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
//                 '${widget.name}',
//                 // 'Image Name',
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
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 25, 20, 0),
//                 child: Row(
//                   children: [
//                     Tooltip(
//                       message: 'Tap to clear signature',
//                       child: GestureDetector(
//                         onTap: () async {
//                           signaturePadKey.currentState!.clear();
//                         },
//                           child: const Icon(Icons.clear,
//                           // color: Colors.red,
//                           ),
//                       ),
//                     ),
//                     SizedBox(width: size.width * 0.02),
//                     Tooltip(
//                       message: 'Tap to save signature',
//                       child: GestureDetector(
//                         onTap: () async {
//                           // ui.Image image = await signaturePadKey.currentState!.toImage();
//                           // final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//                           // final Uint8List imageBytes = byteData!.buffer.asUint8List(
//                           //   byteData.offsetInBytes, byteData.lengthInBytes);
//                           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
//                           const NavBar()), (Route<dynamic> route) => false);
//                         },
//                         child: const Icon(Icons.check,
//                         // color: Colors.green,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         backgroundColor: topBarColor,
//         body: Container(
//           width: size.width,
//           height: size.height,
//           decoration: BoxDecoration(
//             color: secondaryColor,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30),
//             ),
//           ),
//           child: Stack(
//             children: [
//               Center(
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                   child: Image.network(
//                     '$imageUrl${widget.image}',
//                     loadingBuilder: (BuildContext context, Widget child,
//                         ImageChunkEvent? loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return Center(
//                         child: CircularProgressIndicator(
//                           value: loadingProgress.expectedTotalBytes != null
//                               ? loadingProgress.cumulativeBytesLoaded /
//                                   loadingProgress.expectedTotalBytes!
//                               : null,
//                         ),
//                       );
//                     },
//                     // 'assets/images/image-view.png',
//                     width: size.width,
//                     height: size.height,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 // left: 40,
//                 // right: 40,
//                 // bottom: 20,
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                   child: SizedBox(
//                     height: size.height,
//                     width: size.width,
//                     child: SfSignaturePad(
//                       key: signaturePadKey,
//                       backgroundColor: Colors.transparent,
//                       strokeColor: Colors.black,
//                       maximumStrokeWidth: 4.0,
//                       minimumStrokeWidth: 10.0,
//                     ),
//                   ),
//                 ),
//                 // Image.memory(widget.signature!),
//                 // Image.network('$imageUrl${widget.image}',
//                 //   loadingBuilder: (BuildContext context, Widget child,
//                 //       ImageChunkEvent? loadingProgress) {
//                 //     if (loadingProgress == null) return child;
//                 //     return Center(
//                 //       child: CircularProgressIndicator(
//                 //         value: loadingProgress.expectedTotalBytes != null
//                 //             ? loadingProgress.cumulativeBytesLoaded /
//                 //             loadingProgress.expectedTotalBytes!
//                 //             : null,
//                 //       ),
//                 //     );
//                 //   },
//                 // ),
//                 // SvgPicture.asset('assets/images/signature-icon.svg'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
