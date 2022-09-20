import 'package:basalon/services/constant.dart';
import 'package:basalon/widgets/RegistrationTextField.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../blocs/application_bloc.dart';
import '../../constant/login_user.dart';
import '../../modal/login_data.dart';
import '../../network/login_register_network.dart';
import '../../utils/utils.dart';
import '../home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  bool isAppleLogin;
  int? userId;
  RegistrationScreen({Key? key, required this.isAppleLogin, this.userId})
      : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _secureText = true;
  bool _secureText1 = true;
  bool isChecked = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  int currentIndex = 5;
  Map? userData;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  late LoginRegisterNetwork _loginRegisterNetwork = LoginRegisterNetwork();
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

  void errorAlertMessage(String errorMessage) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void validate() {
    if (formkey.currentState!.validate()) {
      print('VALIDATED');
      setState(() {
        currentIndex == currentIndex--;
      });
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => TicketScreen()));
    } else {
      print('Not Valid');
    }
  }

  LoginData? getLoginData;

  void registerData() async {
    try {
      Response response;
      var dio = Dio();
      var data = {
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        if (isChecked) 'newsletter': isChecked,
      };
      if (widget.isAppleLogin) {
        data['user_id'] = widget.userId!;
      }
      String registerUrl =
          widget.isAppleLogin ? "ios_user_update_profile" : "user_register";
      response = await dio.post(
        'https://basalon.co.il/wp-json/wp/v2/$registerUrl',
        data: FormData.fromMap(data),
        options: Options(headers: {
          "Client-Service": "basalon-client-t1T83YHm60J8yNG5",
          "Auth-Key": "XkCRn9Y4PPmspuqYKolqbyhcDFhID7kl"
        }),
      );
      print('response');
      print(response);
      print('''
      'first_name': ${firstNameController.text},
            'last_name': ${lastNameController.text},
            'email': ${emailController.text},
            'password': ${passwordController.text},
            'newsletter': $isChecked,
      ''');
      EasyLoading.dismiss();

      if (response.data['success'] == 200) {
        // ignore: avoid_print
        int id = int.parse((widget.isAppleLogin
                ? response.data['data'][0]['ID']
                : response.data['data']['user_id'])
            .toString());
        print(id);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt('loginId', id);
        isUserLogin(true);

        LoginUser.shared?.userId = sharedPreferences.getInt('loginId');
        // LoginUser.shared?.userId = sharedPreferences.getInt(loginId);
        print('pppppppppppppppppppppppppppppppppppppppppppp');
        print(LoginUser.shared?.userId);
        application.isUserLogin = true;
        print(sharedPreferences.getInt('loginId'));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
      } else {
        errorAlertMessage('Invalid Credential!');
      }
    } catch (error) {
      print(error);
      EasyLoading.dismiss();
      errorAlertMessage('Something went wrong! ${error}');
      print("chetan sable bhai");
    }
  }

  sendUserId(response) {
    // ignore: unrelated_type_equality_checks
    if (response['body']['data'].runtimeType == String) {
      print("send user id chali");
      print(response['body']['data']);
      return response['body']['data'];
    } else if (response['body']['data'].runtimeType == int) {
      print("send user id chali");
      print(response['body']['data']);
      return response['body']['data'];
    } else {
      print("first time user send id ");
      return response['body']['data']['user_id'];
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(80, 40),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Align(
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 15),
                child: Image.asset("assets/images/Back_button.png"),
              ),
              alignment: Alignment.topLeft,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const Text(
                  'הרשמה',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                // const SizedBox(height: 5),
                // const Text('ברוך הבא, אנא התחבר כדי להמשיך', textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: Color.fromRGBO(92, 92, 92, 1),
                //     fontSize: 15,
                //   ),
                // ),
                // const SizedBox(height: 10),
                // const Text('דלג על שלב זה', textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: Color.fromRGBO(233, 108, 96, 1),
                //     fontSize: 16,
                //   ),
                // ),

                const SizedBox(height: 25),
                // if (!widget.isAppleLogin)
                //   Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 18.0),
                //     child: SignInWithAppleButton(
                //       text: "היכנס עם אפל",
                //       onPressed: () async {
                //         final credential =
                //             await SignInWithApple.getAppleIDCredential(
                //           scopes: [
                //             AppleIDAuthorizationScopes.email,
                //             AppleIDAuthorizationScopes.fullName,
                //           ],
                //           webAuthenticationOptions: WebAuthenticationOptions(
                //             clientId:
                //                 'de.lunaone.flutter.signinwithappleexample.service',

                //             redirectUri:
                //                 // For web your redirect URI needs to be the host of the "current page",
                //                 // while for Android you will be using the API server that redirects back into your app via a deep link
                //                 // kIsWeb
                //                 // ? Uri.parse('https://${window.location.host}/')
                //                 Uri.parse(
                //               'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
                //             ),
                //           ),
                //         );

                //         var response =
                //             await _loginRegisterNetwork.registerAppleData(
                //                 credential.identityToken,
                //                 credential.userIdentifier);
                //         print(response);
                //         print(response['status'] == 200);
                //         print(
                //             response['body']['data'][0]['user_nicename'] == '');
                //         print(response['body']['data'][0]['user_nicename']);
                //         print(response['body']['data'][0]['user_nicename'] ==
                //             null);
                //         print(response['status'] == 200 &&
                //             (response['body']['data'][0]['user_nicename'] ==
                //                     '' ||
                //                 response['body']['data'][0]['user_nicename'] ==
                //                     null));
                //         if (response['status'] == 200) {
                //           if ((response['body']['data'][0]['user_nicename'] ==
                //                   '' ||
                //               response['body']['data'][0]['user_nicename'] ==
                //                   null)) {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => RegistrationScreen(
                //                           isAppleLogin: true,
                //                           userId: int.parse(response['body']
                //                                   ['data'][0]['ID']
                //                               .toString()),
                //                         )));
                //             return;
                //           }

                //           var id = int.parse(
                //               response['body']['data'][0]['ID'].toString());
                //           //  user_email
                //           //display_name
                //           LoginUser(
                //             userName: response['body']['data'][0]
                //                 ['display_name'],
                //             email: response['body']['data'][0]['user_email'],
                //             userId: id,
                //           );
                //           SharedPreferences sharedPreferences =
                //               await SharedPreferences.getInstance();
                //           sharedPreferences.setInt('loginId', id);
                //           LoginUser.shared?.userId =
                //               sharedPreferences.getInt('loginId');
                //           application.isUserLogin = true;
                //           Navigator.of(context).pushAndRemoveUntil(
                //               MaterialPageRoute(
                //                   builder: (context) => HomeScreen()),
                //               (Route<dynamic> route) => false);
                //         }
                //       },
                //     ),
                //   ),

                const SizedBox(height: 25),
                if (!widget.isAppleLogin)
                  SizedBox(
                    height: 50,
                    width: width - 30,
                    child: ElevatedButton(
                      onPressed: () async {
                        print('facebook login,,,,,,,,,,,');
                        final result = await FacebookAuth.i.login(permissions: [
                          "public_profile",
                          "email",
                        ]);
                        if (result.status == LoginStatus.success) {
                          final requestData = await FacebookAuth.i.getUserData(
                              fields:
                                  "email, name, picture.height(200).width(200)");

                          setState(() {
                            userData = requestData;
                            LoginUser(
                              userName: userData!['name'],
                              email: userData!['email'] != null
                                  ? userData!['email']
                                  : userData!['name'],
                              userId: int.parse(userData!['id']),
                            );
                            LoginUser.shared?.userId =
                                int.parse(userData!['id']);
                          });

                          setState(() {
                            application.imageFromFacebook =
                                userData!['picture']['data']['url'];
                            application.emailFromFacebook = userData!['email'];
                            application.nameFromFacebook = userData!['name'];
                            application.isUserLogin = true;
                          });
                          print(int.parse(userData!['id']));
                          print(result.accessToken?.token);
                          print(result.status);
                          print(result.message);
                          print('-------------------FACEBOOK----------------');
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString(
                              'email',
                              userData!['email'] != null
                                  ? userData!['email']
                                  : userData!['name']);
                          sharedPreferences.setString(
                              'facebookName',
                              userData!['name'] != null
                                  ? userData!['name']
                                  : '');
                          sharedPreferences.setString(
                              'facebookImage',
                              userData!['picture']['data']['url'] != null
                                  ? userData!['picture']['data']['url']
                                  : 'no image found ---------');
                          sharedPreferences.setInt(
                              'loginId', int.parse(userData!['id']));
                          await _loginRegisterNetwork.registerFbData(
                              result.accessToken?.token,
                              int.parse(userData!['id']));

                          //Navigator.pushNamed(context, HomeScreen.route);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(25, 119, 243, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        shadowColor: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Image.asset("assets/images/facebook.png"),
                          ),
                          const Text('המשיכו עם פייסבוק',
                              style: TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'או',
                  style: ktextStyleBoldMedium,
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key: formkey,
                    child: Column(
                      children: [
                        RegistrationTextInput(
                          controller: firstNameController,
                          hintText: 'שם פרטי',
                          obscureText: false,
                        ),
                        RegistrationTextInput(
                          obscureText: false,
                          controller: lastNameController,
                          hintText: 'שם משפחה',
                        ),
                        RegistrationTextInput(
                          obscureText: false,
                          hintText: 'יישוב ',
                        ),
                        RegistrationTextInput(
                          obscureText: false,
                          controller: emailController,
                          hintText: 'אימייל',
                        ),
                        RegistrationTextInput(
                          hintText: 'סיסמה',
                          obscureText: _secureText,
                          controller: passwordController,
                          prefixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _secureText = !_secureText;
                              });
                            },
                            icon: Icon(
                              _secureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color.fromRGBO(144, 144, 144, 1),
                            ),
                          ),
                        ),
                        RegistrationTextInput(
                          obscureText: _secureText1,
                          controller: confirmPasswordController,
                          hintText: 'אשר סיסמה',
                          prefixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _secureText1 = !_secureText1;
                              });
                            },
                            icon: Icon(
                              _secureText1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color.fromRGBO(144, 144, 144, 1),
                            ),
                          ),
                        ),
                      ],
                    )),

                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Checkbox(
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                        value: isChecked,
                        checkColor: Colors.white,
                        activeColor: Colors.black,
                        side: const BorderSide(
                            color: Color.fromRGBO(216, 216, 216, 1), width: 1),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              'אני מעוניינ/ת לקבל הטבות, הנחות ומידע על פעילויות חדשות',
                              maxLines: 2,
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: width - 30,
                  child: ElevatedButton(
                    onPressed: () {
                      validate();
                      if (firstNameController.text.isEmpty) {
                        errorAlertMessage("Please enter name!");
                        validate();
                      } else if (lastNameController.text.isEmpty) {
                        errorAlertMessage('Please enter last name!');
                      } else if (emailController.text.isEmpty) {
                        errorAlertMessage("Please enter email!");
                      } else if (passwordController.text.isEmpty) {
                        errorAlertMessage('Please enter password!');
                      } else if (confirmPasswordController.text.isEmpty) {
                        errorAlertMessage('Please enter confirm password!');
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        errorAlertMessage('Both password should be same!');
                      } else {
                        //EasyLoading.show();
                        registerData();
                      }
                    },
                    child: const Text('הרשמה',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(116, 101, 255, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: RichText(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'יצירת חשבון, כניסה לאתר ושימוש באתר מהווה הסכמה ל ',
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      children: [
                        TextSpan(
                            text: 'תנאי שימוש ',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                //Navigator.pop(context);
                              },
                            style: const TextStyle(
                                color: Color.fromRGBO(116, 101, 255, 1),
                                fontSize: 10)),
                        const TextSpan(text: 'ו '),
                        TextSpan(
                            text: 'מדיניות פרטיות',
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: const TextStyle(
                                color: Color.fromRGBO(116, 101, 255, 1),
                                fontSize: 10)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
