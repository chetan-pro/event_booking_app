import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'location_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final controller = PageController();

  List imgArray = [
    'assets/images/image_onboard1.png',
    'assets/images/image_onboard3.jpg'
  ];
  List titleArray = ['אז...מה עושים היום?', 'אנחנו על המפה!'];
  List subtitleArray = [
    'גלו הרצאות, סדנאות, הופעות וחוויות קולינריות',
    '- מצאו את החוויות שהכי קרובות אליכם בקלות'
  ];
  List nextLineText = ['בסלון הקרוב אליכם', 'גם בתצוגת מפה!'];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(42, 42, 75, 1),
        body: Stack(
          children: [
            PageView.builder(
                scrollDirection: Axis.horizontal,
                //physics: const NeverScrollableScrollPhysics(),
                physics: const PageScrollPhysics(),
                itemCount: 2,
                controller: controller,
                onPageChanged: (int page) {
                  currentIndex = page;
                  setState(() {});
                },
                itemBuilder: (_, index) {
                  return Align(
                    child: Image.asset(
                      imgArray[index],
                    ),
                    alignment: Alignment.topCenter,
                  );
                }),
            Positioned(
              bottom: 0,
              child: Container(
                color:  Color.fromRGBO(42, 42, 75, 1),
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      titleArray[currentIndex],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Color.fromRGBO(241, 241, 241, 1),
                          fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(subtitleArray[currentIndex],
                          textAlign: TextAlign.center,
                          // textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(241, 241, 241, 1),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(nextLineText[currentIndex],
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(241, 241, 241, 1),
                          )),
                    ),
                    // const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (controller.page == 1) {
                                controller.animateToPage(0,
                                    duration: const Duration(milliseconds: 350),
                                    curve: Curves.ease);
                                currentIndex = 0;
                                setState(() {});
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Color.fromRGBO(42, 42, 75, 1),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('הקודם',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: currentIndex == 0
                                          ? const Color.fromRGBO(42, 42, 75, 1)
                                          : const Color.fromRGBO(241, 241, 241, 1),
                                    )),
                              ),
                            ),
                          ),
                          SmoothPageIndicator(
                            controller: controller,
                            count: 2,
                            effect: const ExpandingDotsEffect(
                                dotWidth: 9,
                                dotHeight: 10,
                                activeDotColor: Color.fromRGBO(233, 108, 96, 1)),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (controller.page == 0) {
                                controller.animateToPage(1,
                                    duration: const Duration(milliseconds: 350),
                                    curve: Curves.ease);
                                currentIndex = 1;
                                setState(() {});
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LocationScreen()));
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Color.fromRGBO(42, 42, 75, 1),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  'הבא',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(233, 108, 96, 1),
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
