// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:luden/utils/colors.dart';
import 'package:luden/utils/baseurl.dart';
import 'package:luden/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luden/screens/image_painter.dart';

class ImageViewScreen extends StatefulWidget {
  final String? image;
  final String? name;
  final String? deckId;
  final String? signature;

  const ImageViewScreen(
      {super.key, this.image, this.name, this.deckId, this.signature});

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  void initState() {
    super.initState();
    print('deck Id: ${widget.deckId}');
    print('name: ${widget.name}');
    print('image: ${widget.image}');
    print('signature: ${widget.signature}');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: topBarColor,
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
              '${widget.name}',
              // 'Image Name',
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
      backgroundColor: topBarColor,
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
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Image.network(
                  '$imageUrl${widget.image}',
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  // 'assets/images/image-view.png',
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // if (widget.signatureId != 'null')
            //   Positioned(
            //     left: 40,
            //     right: 40,
            //     bottom: 20,
            //     child: Image.network(
            //       '$imageUrl${widget.signatureId}',
            //       loadingBuilder: (BuildContext context, Widget child,
            //           ImageChunkEvent? loadingProgress) {
            //         if (loadingProgress == null) return child;
            //         return Center(
            //           child: CircularProgressIndicator(
            //             value: loadingProgress.expectedTotalBytes != null
            //                 ? loadingProgress.cumulativeBytesLoaded /
            //                     loadingProgress.expectedTotalBytes!
            //                 : null,
            //           ),
            //         );
            //       },
            //     ),
            //     // SvgPicture.asset('assets/images/signature-icon.svg'),
            //   )
            // else
            if (widget.signature!.isEmpty)
              Positioned(
                left: 40,
                right: 40,
                bottom: 20,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => HomePage(
                    //           name: '${widget.name}',
                    //           image: '${widget.image}',
                    //           deckId: '${widget.deckId}',
                    //         )));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) =>
                    //             SignatureScreen(
                    //               name: '${widget.name}',
                    //               image: '${widget.image}',
                    //               deckId: '${widget.deckId}',
                    //             )));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ImagePainter(
                                name: '${widget.name}',
                                image: '${widget.image}',
                                deckId: '${widget.deckId}')));
                  },
                  child: button('Add Signature', context),
                ),
              )
          ],
        ),
      ),
    );
  }
}
