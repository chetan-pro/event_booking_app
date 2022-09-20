import 'dart:async';
import 'dart:math' as math;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/application_bloc.dart';
import '../../notificationService/local_notification_service.dart';
import '../home_page.dart';
import '../introduction/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  var selected = false;
  double height = 140.0;
  var _first = false;
  late Animation animation;
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  String? finalEmail;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        print("New Notification");
        // if (message.data['_id'] != null) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => DemoScreen(
        //         id: message.data['_id'],
        //       ),
        //     ),
        //   );
        // }
      }
    });
    //This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );

    animation = Tween(begin: 0.0, end: 0.5).animate(_controller);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selected = true;
      setState(() {});
    });
    //

    getValidationData().whenComplete(() async {
      print(
          'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk${application.idFromLocalProvider}');
      print(
          'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk${application.cardNumberProvider}');
      print(
          'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk${application.cardHolderProvider}');
      Timer(
          Duration(seconds: 4),
          () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => application.idFromLocalProvider == null
                      ? WelcomeScreen()
                      : HomePage()),
              (route) => false));

      // Navigator.push(
      // context,
      // MaterialPageRoute(
      //     builder: (context) =>
      //         finalEmail == null ? WelcomeScreen() : HomePage())));
    });

    if (finalEmail != null) {
      Future.delayed(const Duration(milliseconds: 5500), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()));
      });
    }
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    var obtainedId = sharedPreferences.getInt('loginId');
    var obtainedFacebookImg = sharedPreferences.getString('facebookImage');
    var obtainedFacebookName = sharedPreferences.getString('facebookName');
    var obtainedCardHolder = sharedPreferences.getString('cardHolder');
    var obtainedCardNumber = sharedPreferences.getString('cardNumber');
    var obtainedCardMonth = sharedPreferences.getString('cardMonth');
    var obtainedCardYear = sharedPreferences.getString('cardYear');
    var obtainedCardCvv = sharedPreferences.getString('cardCvv');
    if (obtainedId != null) {
      setState(() {
        finalEmail = obtainedEmail;
        application.idFromLocalProvider = obtainedId;
        application.imageFromFacebook = obtainedFacebookImg;
        application.emailFromFacebook = obtainedEmail;
        application.nameFromFacebook = obtainedFacebookName;
        application.cardHolderProvider = obtainedCardHolder;
        application.cardNumberProvider = obtainedCardNumber;
        application.cardMonthProvider = obtainedCardMonth;
        application.cardYearProvider = obtainedCardYear;
        application.cardCvvProvider = obtainedCardCvv;
        application.isUserLogin = true;
      });
    }

    print(
        'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk${application.idFromLocalProvider}');
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _controller.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(42, 42, 75, 1),
        body: Stack(
          children: [
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 500),
              firstChild: Container(
                height: 0,
              ),
              secondChild: AnimatedBuilder(
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: animation.value * 2.0 * math.pi,
                      child: child,
                    );
                  },
                  animation: animation,
                  child: Image.asset('assets/images/splash_3x.png',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height)),
              crossFadeState: !_first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            Center(
              child: SizedBox(
                height: height * 4,
                child: Stack(
                  children: [
                    SizedBox(
                        height: height * 2.3,
                        child: AnimatedAlign(
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.easeIn,
                          alignment: selected
                              ? Alignment.bottomCenter
                              : Alignment.topCenter,
                          child: Image.asset(
                            'assets/splash.png',
                            height: 90,
                            width: 150,
                          ),
                          onEnd: showBackground,
                        )),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     SizedBox(
                    //         height: height * 2,
                    //         child: AnimatedAlign(
                    //           duration: const Duration(milliseconds: 1200),
                    //           curve: Curves.easeIn,
                    //           alignment: selected
                    //               ? Alignment.bottomCenter
                    //               : Alignment.topCenter,
                    //           child: Image.asset(
                    //             'assets/NewIconCrop.png',
                    //             height: 70,
                    //             width: 120,
                    //           ),
                    //           onEnd: showBackground,
                    //         )
                    //         ),
                    //     SizedBox(
                    //       height: height * 2,
                    //       child: AnimatedAlign(
                    //         duration: const Duration(milliseconds: 1200),
                    //         curve: Curves.easeIn,
                    //         alignment: !selected
                    //             ? Alignment.bottomCenter
                    //             : Alignment.topCenter,
                    //         child: Image.asset(
                    //           'assets/4.png',
                    //           // height: 90,
                    //           width: 140,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height + 40,
                          color: !_first
                              ? const Color.fromRGBO(42, 42, 75, 1)
                              : null,
                          //color: Colors.red,
                        ),
                        Container(
                          height: height + 40,
                          color: !_first
                              ? const Color.fromRGBO(42, 42, 75, 1)
                              : null,
                          //color: Colors.red,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBackground() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _first = !_first;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        _controller.forward();
      });
    });
  }
}
