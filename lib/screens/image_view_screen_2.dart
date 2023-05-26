// // ignore_for_file: avoid_print
//
// import 'package:flutter/material.dart';
// import 'package:luden/utils/colors.dart';
// import 'package:luden/utils/baseurl.dart';
// import 'package:luden/widgets/button.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:luden/screens/select_signature_screen_2.dart';
//
// class ImageViewScreen2 extends StatefulWidget {
//   final String? image;
//   final String? name;
//   final String? deckId;
//   const ImageViewScreen2({super.key, this.image, this.name, this.deckId});
//
//   @override
//   State<ImageViewScreen2> createState() => _ImageViewScreen2State();
// }
//
// class _ImageViewScreen2State extends State<ImageViewScreen2> {
//   @override
//   void initState() {
//     super.initState();
//     print('deck Id: ${widget.deckId}');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(80),
//         child: AppBar(
//           backgroundColor: topBarColor,
//           elevation: 0,
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(top: 20),
//               child: SvgPicture.asset(
//                 'assets/images/back-arrow.svg',
//                 width: 22,
//                 height: 22,
//                 fit: BoxFit.scaleDown,
//               ),
//             ),
//           ),
//           centerTitle: true,
//           title: Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: Text(
//               '${widget.name}',
//               // 'Image Name',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 textStyle: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       backgroundColor: topBarColor,
//       body: Container(
//         width: size.width,
//         height: size.height,
//         decoration: BoxDecoration(
//           color: secondaryColor,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         child: Stack(
//           children: [
//             Center(
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//                 child: Image.network(
//                   '$imageUrl${widget.image}',
//                   loadingBuilder: (BuildContext context, Widget child,
//                       ImageChunkEvent? loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Center(
//                       child: CircularProgressIndicator(
//                         value: loadingProgress.expectedTotalBytes != null
//                             ? loadingProgress.cumulativeBytesLoaded /
//                                 loadingProgress.expectedTotalBytes!
//                             : null,
//                       ),
//                     );
//                   },
//                   // 'assets/images/image-view.png',
//                   width: size.width,
//                   height: size.height,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 40,
//               right: 40,
//               bottom: 20,
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               SelectSignatureScreen2(
//                                 name: '${widget.name}',
//                                 image: '${widget.image}',
//                                 deckId: '${widget.deckId}',
//                               )));
//                 },
//                 child: button('Add Signature', context),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
