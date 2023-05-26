// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:luden/utils/colors.dart';
// import 'package:luden/utils/baseurl.dart';
// import 'package:luden/screens/navbar.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SignatureScreen2 extends StatefulWidget {
//   final String? image;
//   final String? name;
//   final String? signatureImage;
//   const SignatureScreen2(
//       {super.key, this.image, this.name, this.signatureImage});

//   @override
//   State<SignatureScreen2> createState() => _SignatureScreen2State();
// }

// class _SignatureScreen2State extends State<SignatureScreen2> {
//   @override
//   void initState() {
//     super.initState();
//     print('${widget.image}');
//     print('${widget.name}');
//     print('${widget.signatureImage}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return WillPopScope(
//       onWillPop: () async {
//         // Navigate to a different screen when the back button is pressed
//         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
//         const NavBar()), (Route<dynamic> route) => false);
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
//                 left: 40,
//                 right: 40,
//                 bottom: 20,
//                 child: Image.network('$imageUrl${widget.signatureImage}',
//                   loadingBuilder: (BuildContext context, Widget child,
//                       ImageChunkEvent? loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Center(
//                       child: CircularProgressIndicator(
//                         value: loadingProgress.expectedTotalBytes != null
//                             ? loadingProgress.cumulativeBytesLoaded /
//                             loadingProgress.expectedTotalBytes!
//                             : null,
//                       ),
//                     );
//                   },
//                 ),
//                 // SvgPicture.asset('assets/images/signature-icon.svg'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
