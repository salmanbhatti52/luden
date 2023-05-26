// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luden/utils/colors.dart';
import 'package:luden/utils/baseurl.dart';
import 'package:luden/widgets/button.dart';
import 'package:luden/screens/navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:luden/models/add_signature_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ImagePainter extends StatefulWidget {
  final String? image;
  final String? name;
  final String? deckId;

  const ImagePainter({Key? key, this.image, this.name, this.deckId})
      : super(key: key);

  @override
  _ImagePainterState createState() => _ImagePainterState();
}

class _ImagePainterState extends State<ImagePainter> {
  static const Color red = Color(0xFFFF0000);
  FocusNode textFocusNode = FocusNode();
  late PainterController controller;
  ui.Image? backgroundImage;
  Paint shapePaint = Paint()
    ..strokeWidth = 5
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  // static const List<String> imageLinks = [
  //   "https://i.imgur.com/btoI5OX.png",
  //   "https://i.imgur.com/EXTQFt7.png",
  //   "https://i.imgur.com/EDNjJYL.png",
  //   "https://i.imgur.com/uQKD6NL.png",
  //   "https://i.imgur.com/cMqVRbl.png",
  //   "https://i.imgur.com/1cJBAfI.png",
  //   "https://i.imgur.com/eNYfHKL.png",
  //   "https://i.imgur.com/c4Ag5yt.png",
  //   "https://i.imgur.com/GhpCJuf.png",
  //   "https://i.imgur.com/XVMeluF.png",
  //   "https://i.imgur.com/mt2yO6Z.png",
  //   "https://i.imgur.com/rw9XP1X.png",
  //   "https://i.imgur.com/pD7foZ8.png",
  //   "https://i.imgur.com/13Y3vp2.png",
  //   "https://i.imgur.com/ojv3yw1.png",
  //   "https://i.imgur.com/f8ZNJJ7.png",
  //   "https://i.imgur.com/BiYkHzw.png",
  //   "https://i.imgur.com/snJOcEz.png",
  //   "https://i.imgur.com/b61cnhi.png",
  //   "https://i.imgur.com/FkDFzYe.png",
  //   "https://i.imgur.com/P310x7d.png",
  //   "https://i.imgur.com/5AHZpua.png",
  //   "https://i.imgur.com/tmvJY4r.png",
  //   "https://i.imgur.com/PdVfGkV.png",
  //   "https://i.imgur.com/1PRzwBf.png",
  //   "https://i.imgur.com/VeeMfBS.png",
  // ];

  @override
  void initState() {
    super.initState();
    print('deck Id: ${widget.deckId}');
    print('name: ${widget.name}');
    print('image: ${widget.image}');
    controller = PainterController(
        settings: PainterSettings(
            text: TextSettings(
              focusNode: textFocusNode,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: red, fontSize: 18),
            ),
            freeStyle: const FreeStyleSettings(
              color: red,
              strokeWidth: 5,
            ),
            shape: ShapeSettings(
              paint: shapePaint,
            ),
            scale: const ScaleSettings(
              enabled: true,
              minScale: 1,
              maxScale: 5,
            )));
    // Listen to focus events of the text field
    textFocusNode.addListener(onFocus);
    // Initialize background
    initBackground();
  }

  /// Fetches image from an [ImageProvider] (in this example, [NetworkImage])
  /// to use it as a background
  void initBackground() async {
    // Extension getter (.image) to get [ui.Image] from [ImageProvider]
    final image = await NetworkImage('$imageUrl${widget.image}').image;

    setState(() {
      backgroundImage = image;
      controller.background = image.backgroundDrawable;
    });
  }

  /// Updates UI when the focus changes
  void onFocus() {
    setState(() {});
  }

  Widget buildDefault(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        // Listen to the controller and update the UI when it updates.
        child: ValueListenableBuilder<PainterControllerValue>(
            valueListenable: controller,
            child: const Text("Add Signature"),
            builder: (context, _, child) {
              return AppBar(
                backgroundColor: topBarColor,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    'assets/images/back-arrow.svg',
                    width: 22,
                    height: 22,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                centerTitle: true,
                title: child,
                actions: [
                  // Delete the selected drawable
                  // IconButton(
                  //   icon: Icon(
                  //     PhosphorIcons.regular.trash,
                  //   ),
                  //   onPressed: controller.selectedObjectDrawable == null
                  //       ? null
                  //       : removeSelectedDrawable,
                  // ),
                  // Delete the selected drawable
                  // IconButton(
                  //   icon: const Icon(
                  //     Icons.flip,
                  //   ),
                  //   onPressed: controller.selectedObjectDrawable != null &&
                  //       controller.selectedObjectDrawable is ImageDrawable
                  //       ? flipSelectedImageDrawable
                  //       : null,
                  // ),
                  // Redo action
                  // IconButton(
                  //   icon: Icon(
                  //     PhosphorIcons.regular.arrowClockwise,
                  //   ),
                  //   onPressed: controller.canRedo ? redo : null,
                  // ),
                  // Undo action
                  Tooltip(
                    message: 'Tap to undo changes',
                    child: IconButton(
                      icon: const Icon(
                        Icons.undo,
                      ),
                      onPressed: controller.canUndo ? undo : null,
                    ),
                  ),
                  Tooltip(
                    message: 'Tap to save signature',
                    child: IconButton(
                      icon: const Icon(
                        Icons.check,
                      ),
                      onPressed: renderAndDisplayImage,
                    ),
                  ),
                ],
              );
            }),
      ),
      // Generate image
      // floatingActionButton: FloatingActionButton(
      //   onPressed: renderAndDisplayImage,
      //   child: Icon(
      //     PhosphorIcons.regular.image,
      //   ),
      // ),
      body: Stack(
        children: [
          if (backgroundImage != null)
            // Enforces constraints
            Positioned.fill(
              child: Center(
                child: AspectRatio(
                  aspectRatio: backgroundImage!.width / backgroundImage!.height,
                  child: FlutterPainter(
                    controller: controller,
                  ),
                ),
              ),
            ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, _, __) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20)),
                        color: Colors.white54,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (controller.freeStyleMode !=
                              FreeStyleMode.draw) ...[
                            const Divider(color: Colors.transparent),
                            const Text("Stroke Settings"),
                            // Control free style stroke width
                            Row(
                              children: [
                                const Expanded(
                                    flex: 1, child: Text("Stroke Width")),
                                Expanded(
                                  flex: 3,
                                  child: Slider.adaptive(
                                      min: 2,
                                      max: 25,
                                      value: controller.freeStyleStrokeWidth,
                                      onChanged: setFreeStyleStrokeWidth),
                                ),
                              ],
                            ),
                            if (controller.freeStyleMode == FreeStyleMode.none)
                              Row(
                                children: [
                                  const Expanded(
                                      flex: 1, child: Text("Stroke Color")),
                                  // Control free style color hue
                                  Expanded(
                                    flex: 3,
                                    child: Slider.adaptive(
                                        min: 0,
                                        max: 359.99,
                                        value: HSVColor.fromColor(
                                                controller.freeStyleColor)
                                            .hue,
                                        activeColor: controller.freeStyleColor,
                                        onChanged: setFreeStyleColor),
                                  ),
                                ],
                              ),
                            // ],
                            // if (textFocusNode.hasFocus) ...[
                            //   const Divider(),
                            //   const Text("Text settings"),
                            //   // Control text font size
                            //   Row(
                            //     children: [
                            //       const Expanded(
                            //           flex: 1, child: Text("Font Size")),
                            //       Expanded(
                            //         flex: 3,
                            //         child: Slider.adaptive(
                            //             min: 8,
                            //             max: 96,
                            //             value:
                            //             controller.textStyle.fontSize ?? 14,
                            //             onChanged: setTextFontSize),
                            //       ),
                            //     ],
                            //   ),
                            //
                            //   // Control text color hue
                            //   Row(
                            //     children: [
                            //       const Expanded(flex: 1, child: Text("Color")),
                            //       Expanded(
                            //         flex: 3,
                            //         child: Slider.adaptive(
                            //             min: 0,
                            //             max: 359.99,
                            //             value: HSVColor.fromColor(
                            //                 controller.textStyle.color ??
                            //                     red)
                            //                 .hue,
                            //             activeColor: controller.textStyle.color,
                            //             onChanged: setTextColor),
                            //       ),
                            //     ],
                            //   ),
                            // ],
                            // if (controller.shapeFactory != null) ...[
                            //   const Divider(),
                            //   const Text("Shape Settings"),

                            // Control text color hue
                            // Row(
                            //   children: [
                            //     const Expanded(
                            //         flex: 1, child: Text("Stroke Width")),
                            //     Expanded(
                            //       flex: 3,
                            //       child: Slider.adaptive(
                            //           min: 2,
                            //           max: 25,
                            //           value: controller
                            //               .shapePaint?.strokeWidth ??
                            //               shapePaint.strokeWidth,
                            //           onChanged: (value) =>
                            //               setShapeFactoryPaint(
                            //                   (controller.shapePaint ??
                            //                       shapePaint)
                            //                       .copyWith(
                            //                     strokeWidth: value,
                            //                   ))),
                            //     ),
                            //   ],
                            // ),

                            // Control shape color hue
                            // Row(
                            //   children: [
                            //     const Expanded(flex: 1, child: Text("Color")),
                            //     Expanded(
                            //       flex: 3,
                            //       child: Slider.adaptive(
                            //           min: 0,
                            //           max: 359.99,
                            //           value: HSVColor.fromColor(
                            //               (controller.shapePaint ??
                            //                   shapePaint)
                            //                   .color)
                            //               .hue,
                            //           activeColor: (controller.shapePaint ??
                            //               shapePaint)
                            //               .color,
                            //           onChanged: (hue) =>
                            //               setShapeFactoryPaint(
                            //                   (controller.shapePaint ??
                            //                       shapePaint)
                            //                       .copyWith(
                            //                     color: HSVColor.fromAHSV(
                            //                         1, hue, 1, 1)
                            //                         .toColor(),
                            //                   ))),
                            //     ),
                            //   ],
                            // ),

                            // Row(
                            //   children: [
                            //     const Expanded(
                            //         flex: 1, child: Text("Fill shape")),
                            //     Expanded(
                            //       flex: 3,
                            //       child: Center(
                            //         child: Switch(
                            //             value: (controller.shapePaint ??
                            //                 shapePaint)
                            //                 .style ==
                            //                 PaintingStyle.fill,
                            //             onChanged: (value) =>
                            //                 setShapeFactoryPaint(
                            //                     (controller.shapePaint ??
                            //                         shapePaint)
                            //                         .copyWith(
                            //                       style: value
                            //                           ? PaintingStyle.fill
                            //                           : PaintingStyle.stroke,
                            //                     ))),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, _, __) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Free-style eraser
            // IconButton(
            //   icon: Icon(
            //     PhosphorIcons.regular.eraser,
            //     color: controller.freeStyleMode == FreeStyleMode.erase
            //         ? topBarColor
            //         : Colors.white,
            //   ),
            //   onPressed: toggleFreeStyleErase,
            // ),
            // Free-style drawing
            Tooltip(
              message: 'Tap to draw signature',
              child: IconButton(
                icon: Icon(
                  Icons.draw_rounded,
                  size: 40,
                  color: controller.freeStyleMode == FreeStyleMode.draw
                      ? topBarColor
                      : Colors.white,
                ),
                onPressed: toggleFreeStyleDraw,
              ),
            ),
            // Add text
            // IconButton(
            //   icon: Icon(
            //     PhosphorIcons.regular.textT,
            //     color: textFocusNode.hasFocus
            //         ? Theme.of(context).accentColor
            //         : null,
            //   ),
            //   onPressed: addText,
            // ),
            // Add sticker image
            // IconButton(
            //   icon: Icon(
            //     PhosphorIcons.regular.sticker,
            //   ),
            //   onPressed: addSticker,
            // ),
            // Add shapes
            // if (controller.shapeFactory == null)
            //   PopupMenuButton<ShapeFactory?>(
            //     tooltip: "Add shape",
            //     itemBuilder: (context) => <ShapeFactory, String>{
            //       LineFactory(): "Line",
            //       ArrowFactory(): "Arrow",
            //       DoubleArrowFactory(): "Double Arrow",
            //       RectangleFactory(): "Rectangle",
            //       OvalFactory(): "Oval",
            //     }
            //         .entries
            //         .map((e) => PopupMenuItem(
            //         value: e.key,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Icon(
            //               getShapeIcon(e.key),
            //               color: Colors.black,
            //             ),
            //             Text(" ${e.value}")
            //           ],
            //         )))
            //         .toList(),
            //     onSelected: selectShape,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Icon(
            //         getShapeIcon(controller.shapeFactory),
            //         color: controller.shapeFactory != null
            //             ? Theme.of(context).accentColor
            //             : null,
            //       ),
            //     ),
            //   )
            // else
            //   IconButton(
            //     icon: Icon(
            //       getShapeIcon(controller.shapeFactory),
            //       color: Theme.of(context).accentColor,
            //     ),
            //     onPressed: () => selectShape(null),
            //   ),
          ],
        ),
      ),
      backgroundColor: secondaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildDefault(context);
  }

  // static IconData getShapeIcon(ShapeFactory? shapeFactory) {
  //   if (shapeFactory is LineFactory) return  PhosphorIcons.regular.lineSegment;
  //   if (shapeFactory is ArrowFactory) return  PhosphorIcons.regular.arrowUpRight;
  //   if (shapeFactory is DoubleArrowFactory) {
  //     return  PhosphorIcons.regular.arrowsHorizontal;
  //   }
  //   if (shapeFactory is RectangleFactory) return  PhosphorIcons.regular.rectangle;
  //   if (shapeFactory is OvalFactory) return  PhosphorIcons.regular.circle;
  //   return  PhosphorIcons.regular.polygon;
  // }

  // void redo() {
  //   controller.redo();
  // }

  void undo() {
    controller.undo();
  }

  void toggleFreeStyleDraw() {
    print('object');
    controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.draw
        ? FreeStyleMode.draw
        : FreeStyleMode.none;
  }

  // void toggleFreeStyleErase() {
  //   controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.erase
  //       ? FreeStyleMode.erase
  //       : FreeStyleMode.none;
  // }

  // void addText() {
  //   if (controller.freeStyleMode != FreeStyleMode.none) {
  //     controller.freeStyleMode = FreeStyleMode.none;
  //   }
  //   controller.addText();
  // }

  // void addSticker() async {
  //   final imageLink = await showDialog<String>(
  //       context: context,
  //       builder: (context) => const SelectStickerImageDialog(
  //         imagesLinks: imageLinks,
  //       ));
  //   if (imageLink == null) return;
  //   controller.addImage(
  //       await NetworkImage(imageLink).image, const Size(100, 100));
  // }

  void setFreeStyleStrokeWidth(double value) {
    controller.freeStyleStrokeWidth = value;
  }

  void setFreeStyleColor(double hue) {
    controller.freeStyleColor = HSVColor.fromAHSV(1, hue, 1, 1).toColor();
  }

  // void setTextFontSize(double size) {
  //   // Set state is just to update the current UI, the [FlutterPainter] UI updates without it
  //   setState(() {
  //     controller.textSettings = controller.textSettings.copyWith(
  //         textStyle:
  //         controller.textSettings.textStyle.copyWith(fontSize: size));
  //   });
  // }

  // void setShapeFactoryPaint(Paint paint) {
  //   // Set state is just to update the current UI, the [FlutterPainter] UI updates without it
  //   setState(() {
  //     controller.shapePaint = paint;
  //   });
  // }

  // void setTextColor(double hue) {
  //   controller.textStyle = controller.textStyle
  //       .copyWith(color: HSVColor.fromAHSV(1, hue, 1, 1).toColor());
  // }

  // void selectShape(ShapeFactory? factory) {
  //   controller.shapeFactory = factory;
  // }

  // void removeSelectedDrawable() {
  //   final selectedDrawable = controller.selectedObjectDrawable;
  //   if (selectedDrawable != null) controller.removeDrawable(selectedDrawable);
  // }

  // void flipSelectedImageDrawable() {
  //   final imageDrawable = controller.selectedObjectDrawable;
  //   if (imageDrawable is! ImageDrawable) return;
  //
  //   controller.replaceDrawable(
  //       imageDrawable, imageDrawable.copyWith(flipped: !imageDrawable.flipped));
  // }

  void renderAndDisplayImage() {
    if (backgroundImage == null) return;
    final backgroundImageSize = Size(
        backgroundImage!.width.toDouble(), backgroundImage!.height.toDouble());

    // Render the image
    // Returns a [ui.Image] object, convert to to byte data and then to Uint8List
    final imageFuture = controller
        .renderImage(backgroundImageSize)
        .then<Uint8List?>((ui.Image image) => image.pngBytes);

    // From here, you can write the PNG image data a file or do whatever you want with it
    // For example:
    // ```dart
    // final file = File('${(await getTemporaryDirectory()).path}/img.png');
    // await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    // ```
    // I am going to display it using Image.memory

    // Show a dialog with the image
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: RenderedImageDialog(
                  imageFuture: imageFuture, deckId: '${widget.deckId}'),
            ));
  }
}

class RenderedImageDialog extends StatefulWidget {
  final Future<Uint8List?> imageFuture;
  final String? deckId;

  const RenderedImageDialog({Key? key, required this.imageFuture, this.deckId})
      : super(key: key);

  @override
  State<RenderedImageDialog> createState() => _RenderedImageDialogState();
}

class _RenderedImageDialogState extends State<RenderedImageDialog> {
  AddSignatureModel addSignatureModel = AddSignatureModel();
  String? userId;
  Uint8List? apiImage;

  addSignature(Uint8List? image) async {
    // try {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    userId = sharedPref.getString('userid');
    String base64String = base64Encode(image!);
    String apiUrl = "$baseUrl/add_signature_deck";
    print("api: $apiUrl");
    print("users customers id: $userId");
    print("users customers decks id: ${widget.deckId}");
    print("signatured image: $base64String");

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "users_customers_id": userId,
        "users_customers_decks_id": widget.deckId,
        "signatured_image": base64String,
      },
    );
    final responseString = response.body;
    print("responseAddSignatureApi: $responseString");
    print("status Code Add Signature: ${response.statusCode}");
    print("in 200 signIn");
    if (response.statusCode == 200) {
      addSignatureModel = addSignatureModelFromJson(responseString);
      // setState(() {});
      print('addSignatureModel status: ${addSignatureModel.status}');
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  final GlobalKey<FormState> dialogFormKey = GlobalKey<FormState>();
  bool isInAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    Uint8List? newImage;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: ModalProgressHUD(
        inAsyncCall: isInAsyncCall,
        // opacity: 0.02,
        // blur: 0.5,
        color: Colors.transparent,
        progressIndicator: const CircularProgressIndicator(
          color: Color(0xFF4276EE),
        ),
        child: Form(
          key: dialogFormKey,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            content: FutureBuilder<Uint8List?>(
              future: widget.imageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const SizedBox(
                    height: 50,
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox();
                }
                newImage = snapshot.data!;
                return InteractiveViewer(
                    maxScale: 10, child: Image.memory(snapshot.data!));
              },
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (dialogFormKey.currentState!.validate()) {
                        setState(() {
                          isInAsyncCall = true;
                        });
                        await addSignature(newImage);
                        if (addSignatureModel.status == 'success') {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const NavBar()),
                              (Route<dynamic> route) => false);
                          setState(() {
                            isInAsyncCall = false;
                          });
                        }
                        if (addSignatureModel.status != 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: const Color(0xFF4276EE),
                              content: Text("${addSignatureModel.message}")));
                          setState(() {
                            isInAsyncCall = false;
                          });
                        }
                      }
                    },
                    child: dialogbuttonSmall('Save', context),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: dialogButtontransparentSmall('Back', context)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SelectStickerImageDialog extends StatelessWidget {
//   final List<String> imagesLinks;
//
//   const SelectStickerImageDialog({Key? key, this.imagesLinks = const []})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text("Select sticker"),
//       content: imagesLinks.isEmpty
//           ? const Text("No images")
//           : FractionallySizedBox(
//         heightFactor: 0.5,
//         child: SingleChildScrollView(
//           child: Wrap(
//             children: [
//               for (final imageLink in imagesLinks)
//                 InkWell(
//                   onTap: () => Navigator.pop(context, imageLink),
//                   child: FractionallySizedBox(
//                     widthFactor: 1 / 4,
//                     child: Image.network(imageLink),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           child: const Text("Cancel"),
//           onPressed: () => Navigator.pop(context),
//         )
//       ],
//     );
//   }
// }
