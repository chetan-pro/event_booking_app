// ignore_for_file: avoid_print

import 'package:basalon/screens/home_screen.dart';
import 'package:basalon/screens/login/registration_screen.dart';
import 'package:basalon/screens/login/signin_screen.dart';
import 'package:basalon/services/constant.dart';
import 'package:basalon/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/application_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(42, 42, 75, 1),
        body: SizedBox(
            height: height,
            width: width,
            child: SizedBox(
              width: width,
              child: Stack(
                children: [
                  SizedBox(
                    child: Image.asset("assets/images/image_onboard_4.png"),
                  ),
                  SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          kLogoImage,
                          width: width / 1.3,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'הרשמה לאפליקציה',
                              style: ktextStyleWhiteLarge,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                'ההרשמה מאפשרת לכם לנהל את ההזמנות',
                                style: ktextStyleWhite,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                '!שלכם, גישה למועדפים ויצירת פעילות משלכם',
                                style: ktextStyleWhite,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomButton(
                          height: 50,
                          width: width - 30,
                          onPressed: () {
                            print('top clicked');
                            //Navigator.pushNamed(context, HomeScreen.route);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrationScreen(
                                          isAppleLogin: false,
                                        )));
                          },
                          text: 'הרשמה',
                          textStyle: TextStyle(fontSize: 20),
                          color: Color.fromRGBO(233, 108, 96, 1),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomButton(
                          height: 50,
                          width: width - 30,
                          onPressed: () {
                            print('second clicked');
                            //Navigator.pushNamed(context, HomeScreen.route);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()));
                          },
                          text: 'התחברות',
                          // 'להירשם',
                          textStyle: TextStyle(fontSize: 20),
                          color: Color.fromRGBO(116, 101, 255, 1),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              application.isUserLogin = false;
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                            // Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (context) => const SignInScreen()),
                            //  (Route<dynamic> route) => false
                            // );
                          },
                          child: const Text(
                            'לדלג',
                            style: ktextStyleWhite,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
