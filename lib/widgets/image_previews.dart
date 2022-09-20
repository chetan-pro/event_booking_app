// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:basalon/services/my_color.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';

import '../blocs/application_bloc.dart';

class ImagePreview extends StatefulWidget {
  final List<String>? imageList;
  dynamic galleryImageFromPreview;

  ImagePreview({
    this.imageList,
    this.galleryImageFromPreview,
  });

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  topImage(String url) {
    if (url != null) {
      return Image.network(
        url,
        width: MediaQuery.of(context).size.width / 1.5,
        height: 220,
      );
    } else {
      return Image.asset('assets/images/image_onboard1.png');
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3));
  }

  late final application = Provider.of<ApplicationBloc>(context);
  dynamic selectedImage;
  ScrollController _scrollController = ScrollController();

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _scrollUp() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_scrollController);
    print('oooooooooooooooo');
    print(application.previewGalleryProvider?.first);
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      padding: EdgeInsets.all(15.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // widget.imageList != null
          //     ? topImage(widget.imageList![0].toString())
          //     : SizedBox(),
          selectedImage != null
              ? topImage(selectedImage)
              : widget.imageList != null
                  ? topImage(widget.imageList![0].toString())
                  : Container(),

          SizedBox(
            height: 50,
          ),
          if (widget.imageList != null)
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.imageList?.length,
                        itemBuilder: (c, i) {
                          return GestureDetector(
                            onTap: () {
                              print('gallery');
                              print(widget.imageList?[i]);
                              print(i);
                              setState(() {
                                selectedImage = widget.imageList?[i];
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                widget.imageList![i],
                                // height: 100,
                                width: 150,
                                // fit: BoxFit.fill,
                                errorBuilder: (stackTrace, exception, error) {
                                  return Center(
                                    child: Text('Invalid Image'),
                                  );
                                },
                              ),
                            ),
                          );
                        }),
                  ),
                  Positioned(
                    top: 70,
                    left: 0,
                    child: IconButton(
                      onPressed: () {
                        _scrollDown();
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_left_rounded,
                        size: 50,
                        color: MyColors.topOrange,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        _scrollUp();
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 50,
                        color: MyColors.topOrange,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          if (widget.galleryImageFromPreview != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AssetThumb(
                  asset: widget.galleryImageFromPreview,
                  width: 300,
                  height: 300),
            )
        ],
      ),
    );
  }
}
