// import 'dart:async';
// import 'dart:io';
//
// import 'package:basalon/blocs/application_bloc.dart';
// import 'package:basalon/network/create_event_network.dart';
// import 'package:basalon/services/constant.dart';
// import 'package:basalon/widgets/file_picker_helper.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:multi_image_picker2/multi_image_picker2.dart';
// import 'package:provider/provider.dart';
//
// class PicturesScreen extends StatefulWidget {
//   const PicturesScreen({Key? key}) : super(key: key);
//
//
//
//   @override
//   State<PicturesScreen> createState() => _PicturesScreenState();
// }
//
// class _PicturesScreenState extends State<PicturesScreen> {
//   late final CreateEventNetwork _createEventNetwork = CreateEventNetwork(
//     nameEventController: application.previewTitleProvider,
//     categoryController: application.previewCategoryProvider,
//     eventContentController: application.previewContentProvider,
//     addressController: application.previewMapAddressProvider,
//     videoController: videoController.text,
//     imagePath: imgfile?.path,
//     filename: imgData,
//     galleryImages: multipartImageList,
//   );
//
// @override
//   void initState(){
//     super.initState();
//     print('picture initstate');
//   }
//
//   TextEditingController videoController = TextEditingController();
//
//   List<Asset> imagesList = <Asset>[];
//   List<MultipartFile> multipartImageList = <MultipartFile>[];
//
//   Future<void> loadAssets() async {
//     List<Asset> resultList = <Asset>[];
//     String error = 'No Error Detected';
//
//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 300,
//         enableCamera: true,
//         selectedAssets: imagesList,
//         cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
//         materialOptions: const MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "Example App",
//           allViewTitle: "All Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//     } on Exception catch (e) {
//       error = e.toString();
//     }
//
//     if (!mounted) return;
//
//     setState(() {
//       imagesList = resultList;
//     });
//
//     for (Asset asset in imagesList) {
//       ByteData byteData = await asset.getByteData();
//       List<int> imageData = byteData.buffer.asUint8List();
//       MultipartFile multipartFile = MultipartFile.fromBytes(
//         imageData,
//         filename: asset.name,
//       );
//       multipartImageList.add(multipartFile);
//       print('----------------------');
//       print(imageData);
//       print(asset.name);
//     }
//     print('reiner yha h');
//     print(resultList[0].getByteData());
//     print('wwwwwwwwwwwwwwwwwwwwwwwwwwwwooo');
//   }
//
//   File? imgfile;
//   String? imgData;
//   bool showText = false;
//   late double width = MediaQuery.of(context).size.width;
//
//   Widget buildGridView() {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: GridView.count(
//         crossAxisCount: 3,
//
//         children: List.generate(imagesList.length, (index) {
//           Asset asset = imagesList[index];
//           return Stack(children: [
//             AssetThumb(
//               asset: asset,
//               width: 300,
//               height: 300,
//             ),
//             Positioned(
//                 right: 0,
//                 left: 110,
//                 child: IconButton(
//                     onPressed: () {
//                       setState(() => imagesList.removeAt(index));
//                     },
//                     icon: const Icon(
//                       Icons.delete,
//                       color: Color.fromRGBO(233, 108, 96, 1),
//                     )))
//           ]);
//         }),
//       ),
//     );
//   }
//
//   late final application = Provider.of<ApplicationBloc>(context, listen: false);
//   final ScrollController _scrollController = ScrollController(
//     initialScrollOffset: 1050.0,
//     keepScrollOffset: false,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SingleChildScrollView(
//         reverse: true,
//         controller: _scrollController,
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 250),
//           child: Column(
//             children: [
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 15),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'תמונה ראשית',
//                         style: ktextStyleBoldMedium,
//                         textDirection: TextDirection.rtl,
//                       ),
//                       Text(
//                         '(התמונה צריכה להיות מלבנית לרוחב, מומלץ ביחס של 600X400)',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w500),
//                         textDirection: TextDirection.rtl,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               if (imgfile != null)
//                 Container(
//                     alignment: Alignment.centerRight,
//                     child: Image.file(
//                       imgfile!,
//                       height: 150,
//                       width: 150,
//                       fit: BoxFit.contain,
//                     )),
//
//               const SizedBox(
//                 height: 10,
//               ),
//               //  (filetextEditingController.text.isEmpty)
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 15),
//                   child: Container(
//                     width: 140,
//                     child: MaterialButton(
//                       height: 50,
//                       onPressed: () async {
//                         var fileList =
//                             await pickPicture(context: context).then((value) {
//                           if (value.isNotEmpty) {
//                             setState(() {
//                               imgfile = value[0];
//                               imgData = value[1];
//                             });
//                           }
//                         });
//                         print('uuuuuuuuuuuuuuuuuuuuuuuuuuuu');
//                         print(imgfile);
//                         print(imgData);
//                       },
//                       color: const Color.fromRGBO(112, 168, 49, 1),
//                       child: const Center(
//                           child: Text(
//                         'הוספת תמונה',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.white, fontSize: 17),
//                       )),
//                     ),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 30),
//               const Align(
//                 alignment: Alignment.topRight,
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 15),
//                   child: Text('תמונות נוספות',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               Column(
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 15),
//                       child: Container(
//                         width: 140,
//                         child: MaterialButton(
//                           height: 50,
//                           onPressed: loadAssets,
//                           color: const Color.fromRGBO(112, 168, 49, 1),
//                           child: const Center(
//                               child: Text(
//                             'הוספת תמונות',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(color: Colors.white, fontSize: 17),
//                           )),
//                         ),
//                       ),
//                     ),
//                   ),
//                   if (imagesList.isNotEmpty)
//                     Container(
//                         height: 100,
//                         //  alignment: Alignment.centerRight,
//                         child: buildGridView())
//                 ],
//               ),
//
//               const Align(
//                 alignment: Alignment.topRight,
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 15),
//                   child: Text('סרטון וידאו',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(5)),
//                           border: Border.all(
//                               color: const Color.fromRGBO(216, 216, 216, 1))),
//                       child: TextField(
//                           onTap: () {
//                             setState(() {
//                               showText = true;
//                             });
//                             print(showText);
//                           },
//                           controller: videoController,
//                           maxLines: 1,
//                           textAlignVertical: TextAlignVertical.top,
//                           // textAlign: TextAlign.end,
//                           style: TextStyle(fontSize: 15),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             contentPadding:
//                                 EdgeInsets.only(left: 10, right: 10),
//                             hintText: 'https://',
//                           )),
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       'הוספת לינק לסרטון וידאו למשל: https://www.youtube.com/watch?v=5wZ9LcEbulg\nאו: https://player.vimeo.com/video/23534361',
//                       textAlign: TextAlign.start,
//                       textDirection: TextDirection.rtl,
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     bottom: MediaQuery.of(context).viewInsets.bottom / 1.5),
//                 child: GestureDetector(
//                   onTap: () {
//                     application.previewImageProvider = imgfile;
//                     application.previewGalleryProvider = imagesList;
//                     _createEventNetwork.postCreateEventsGeneral(context);
//                     application.validate();
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(top: 20),
//                     height: 50,
//                     width: width / 2.5,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: const Color.fromRGBO(112, 168, 49, 1)),
//                     child: const Center(
//                         child: Text('שמירה והמשך',
//                             textAlign: TextAlign.center,
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 17))),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
