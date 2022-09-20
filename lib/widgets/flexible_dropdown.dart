import 'dart:async';

import 'package:basalon/widgets/dropDownButton.dart';
import 'package:basalon/widgets/dropDownButton1.dart';
import 'package:flutter/material.dart';

class FlexibleDropdown extends StatelessWidget {
  const FlexibleDropdown({
    Key? key,
    required StreamController<bool> appBarController,
    required ScrollController scrollViewController,
  })  : _appBarController = appBarController,
        _scrollViewController = scrollViewController,
        super(key: key);

  final StreamController<bool> _appBarController;
  final ScrollController _scrollViewController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        return FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          titlePadding: const EdgeInsets.only(top: 10),
          title: StreamBuilder<bool>(
            stream: _appBarController.stream,
            initialData: false,
            builder: (context, snapshot) {
              return _scrollViewController.offset > 270
                  ? Row(
                      // mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DropButton(text1: 'איפה?', text2: 'בכל מקום'),
                        DropButton(text1: 'מתי?', text2: 'בכל עת'),
                        DropButton(text1: 'מה?', text2: 'כל החוויות')
                      ],
                    )
                  : Container();
            },
          ),
          background: Container(
            // height: 450,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: 0.7,
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/homeAppBar.webp',
                    ).image)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 25),
                Text(
                  'אז... מה עושים היום?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'גלו הרצאות, סדנאות וחוויות קולינריות',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'בסלון הקרוב אליכם',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 30),
                DropButton1(
                  text1: 'איפה?',
                  text2: 'בכל מקום',
                ),
                SizedBox(height: 10),
                DropButton1(
                  text1: 'מתי?',
                  text2: 'בכל עת',
                ),
                SizedBox(height: 10),
                DropButton1(
                  text1: 'מה?',
                  text2: 'כל החוויות',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
