// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:basalon/modal/home_data.dart';
import 'package:basalon/screens/activity/general_screen.dart';
import 'package:basalon/screens/profile/contact_us.dart';
import 'package:basalon/screens/profile/term_and_condition.dart';
import 'package:basalon/screens/profile/user_profile.dart';
import 'package:basalon/screens/sideDrawer/favorites/my_favorites_screen.dart';
import 'package:basalon/screens/splash/splash_screen.dart';
import 'package:basalon/services/constant.dart';
import 'package:basalon/services/my_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/application_bloc.dart';
import 'home_page.dart';

class ShowHeader extends ChangeNotifier {
  bool show = false;

  changeShow(bool show) {
    this.show = show;
    notifyListeners();
  }
}

final shRiverpod =
    riverpod.ChangeNotifierProvider<ShowHeader>((ref) => ShowHeader());

class HomeScreen extends StatefulWidget {
  static const String route = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? val;
  int? radiusVal = 50;
  bool showTopFilter = false;
  int index = 0;

  bool isSelected = false;
  bool showModal = false;
  int _selectedTabIndex = 3;
  int profileIndex = 10;

  AppsflyerSdk? _appsflyerSdk;
  Map? _deepLinkData;
  Map? _gcd;

  HomeData? homeData;

  Container dropDown() {
    return Container(
      width: double.infinity,
      height: 50,
      color: MyColors.dropdownColor,
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      //padding: EdgeInsets.only(top: 5, bottom: 0,),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            style: TextStyle(
              color: Colors.white,
            ),
            selectedItemBuilder: (BuildContext context) {
              return <String>['One', 'Two', 'Three', 'Four', 'Five']
                  .map<Widget>((String item) {
                return Container(
                    padding: EdgeInsets.only(right: 20.0),
                    alignment: Alignment.centerRight,
                    width: 180,
                    child: Text(
                      item,
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ));
              }).toList();
            },
            isExpanded: true,
            hint: Row(
              children: const [
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            items: <String>['One', 'Two', 'Three', 'Four', "Five"].map((item) {
              var backgroundColor =
                  (item == val) ? MyColors.topOrange : Colors.white;
              var textColor = (item == val) ? Colors.white : Colors.black;

              return DropdownMenuItem<String>(
                value: item,
                alignment: AlignmentDirectional.topEnd,
                child: Container(
                  height: 30,
                  padding: EdgeInsets.only(right: 5.0, top: 5.0),
                  width: double.infinity,
                  color: backgroundColor,
                  child: Text(
                    item,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                      color: textColor,
                      // backgroundColor: backgroundColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
            value: val,
            onChanged: (value) {
              setState(() {
                // print(value);
                val = value.toString();
              });
            },
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 30,
            iconEnabledColor: Colors.white,
            iconDisabledColor: Colors.blue,
            buttonHeight: 50,
            buttonElevation: 2,
            itemHeight: 40,
            dropdownMaxHeight: 200,
            dropdownPadding: EdgeInsets.all(0),
            itemPadding: EdgeInsets.all(0),
            dropdownDecoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            dropdownElevation: 8,
            // scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
            // offset: const Offset(-20, 0),
          ),
        ),
      ),
    );
  }

  Widget changeWidget() {
    if (_selectedTabIndex == 3) {
      return HomePage();
    } else if (_selectedTabIndex == 1) {
      return GeneralScreen();
    } else if (_selectedTabIndex == 2) {
      return MyFavorites();
    } else if (profileIndex == 5 && _selectedTabIndex == 0) {
      return UserProfile();
    } else if (profileIndex == 6 && _selectedTabIndex == 0) {
      return ContactUsScreen();
    } else if (profileIndex == 7 && _selectedTabIndex == 0) {
      return TermAndConditionScreen();
    } else if (_selectedTabIndex == 0) {
      return Center(
          child: Text(
        "In Progress",
        style: TextStyle(fontSize: 35),
      ));
    }
    return Container();
  }

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

  // Future getHomeData() async {
  //   try {
  //     Response response;
  //     var dio = Dio();
  //     response = await dio.post(
  //       'https://basalon.co.il/wp-json/wp/v2/get_events',
  //       data: FormData.fromMap({'paged': '1'}),
  //       options: Options(headers: {
  //         "Client-Service": "basalon-client-t1T83YHm60J8yNG5",
  //         "Auth-Key": "XkCRn9Y4PPmspuqYKolqbyhcDFhID7kl"
  //       }),
  //     );
  //     EasyLoading.dismiss();
  //     if (response.data['success'] == 401) {
  //       // print(response.data);
  //       errorAlertMessage('No Data Found!');
  //       setState(() {});
  //     } else {
  //       homeData = HomeData.fromJson(response.data);
  //       // print(homeData?.toJson());
  //       // print('asdasd');
  //       setState(() {});
  //     }
  //   } catch (error) {
  //     EasyLoading.dismiss();
  //     errorAlertMessage('Something went wrong!');
  //   }
  // }
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

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
  }

  @override
  void initState() {
    // showTopFilter =
    super.initState();
    getValidationData().whenComplete(() async {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => application.idFromLocalProvider == null
                  ? HomePage()
                  : HomePage()),
          (route) => false);

      // Navigator.push(
      // context,
      // MaterialPageRoute(
      //     builder: (context) =>
      //         finalEmail == null ? WelcomeScreen() : HomePage())));
    });
   
    final AppsFlyerOptions options = AppsFlyerOptions(
        afDevKey: 'hWwUS2NSsbHdzNzVUTEt4',
        appId: 'il.co.basalon',
        showDebug: true,
        timeToWaitForATTUserAuthorization: 15);
    _appsflyerSdk = AppsflyerSdk(options);
    _appsflyerSdk!.onAppOpenAttribution((res) {
      print("onAppOpenAttribution res: " + res.toString());
      setState(() {
        _deepLinkData = res;
      });
    });
    _appsflyerSdk!.onInstallConversionData((res) {
      print("onInstallConversionData res: " + res.toString());
      setState(() {
        _gcd = res;
      });
    });
    _appsflyerSdk!.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          print(dp.deepLink?.toString());
          print("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
          print("deep link not found");
          break;
        case Status.ERROR:
          print("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          print("deep link status parsing error");
          break;
      }
      print("onDeepLinking res: " + dp.toString());
      setState(() {
        _deepLinkData = dp.toJson();
      });
    });
    _appsflyerSdk!
        .initSdk(
            registerConversionDataCallback: true,
            registerOnAppOpenAttributionCallback: false,
            registerOnDeepLinkingCallback: true)
        .then((value) {
      print("value of appflyer");
      print(value);
    });
  }

  // changecal(BuildContext context) {
  //   riverpod.BuildContextX(context).read(shRiverpod).changeShow(true);
  //   showTopFilter = riverpod.BuildContextX(context).read(shRiverpod).show;
  //   // print(showTopFilter);
  //   // setState(() {
  //   //   showTopFilter = true;
  //   //   print('condition $showTopFilter');
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          extendBody: true,
          appBar: _selectedTabIndex == 2
              ? PreferredSize(
                  preferredSize: const Size(80, 40),
                  child: Align(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, top: 10),
                      child: Text('My Favorites',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                    ),
                    alignment: Alignment.topRight,
                  ),
                )
              : null,
          body: SizedBox(
              //color: MyColors.homeBackGroundColor,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: changeWidget()),
          // bottomNavigationBar: Theme(
          //   data: ThemeData(
          //     splashFactory: NoSplash.splashFactory,
          //     highlightColor: Colors.transparent,
          //     hoverColor: Colors.transparent,
          //   ),
          //   child: Container(
          //       height: 70,
          //       decoration: BoxDecoration(
          //         boxShadow: [
          //           BoxShadow(
          //               color: Colors.black45, blurRadius: 20, spreadRadius: 5)
          //         ],
          //         color: Colors.white,
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(30.0),
          //           topRight: Radius.circular(30.0),
          //         ),
          //       ),
          //       child: Row(
          //         children: [
          //           GestureDetector(
          //             onTap: () {
          //               showModalBottomSheet(
          //                 backgroundColor: Colors.transparent,
          //                 context: context,
          //                 builder: (BuildContext context) {
          //                   return Container(
          //                     height:
          //                         MediaQuery.of(context).copyWith().size.height *
          //                             0.3,
          //                     child: AccountModal(context),
          //                   );
          //                 },
          //               );
          //               setState(() {
          //                 showModal = !showModal;
          //               });
          //             },
          //             child: Container(
          //               margin: EdgeInsets.only(left: 10),
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Container(
          //                     width: 50.0,
          //                     height: 28.0,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(15),
          //                       color:
          //                           // showModal
          //                           //     ? MyColors.topOrange.withOpacity(0.3)
          //                           //     :
          //                           Colors.transparent,
          //                     ),
          //                     child: Center(
          //                       child: Padding(
          //                         padding:
          //                             const EdgeInsets.only(bottom: 3, top: 3),
          //                         child:
          //                             // SvgPicture.asset(
          //                             //     'assets/icons/account-hover.svg')
          //                             SvgPicture.asset('assets/icons/user.svg'),
          //                       ),
          //                     ),
          //                   ),
          //                   Text(
          //                     'Account',
          //                     style: TextStyle(
          //                       fontSize: 12,
          //                       // color:
          //                       //     showModal ? MyColors.topOrange : Colors.black,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //           Expanded(
          //             child: BottomNavigationBar(
          //               backgroundColor: Colors.transparent,
          //               currentIndex: _selectedTabIndex,
          //               onTap: _changeIndex,
          //               elevation: 0.0,
          //               type: BottomNavigationBarType.fixed,
          //               selectedFontSize: 13,
          //               unselectedFontSize: 13,
          //               selectedItemColor: MyColors.topOrange,
          //               unselectedItemColor: Colors.black,
          //               showUnselectedLabels: true,
          //               showSelectedLabels: true,
          //               items: [
          //                 BottomNavigationBarItem(
          //                   icon: Container(
          //                     width: 50.0,
          //                     height: 28.0,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(15),
          //                       color: _selectedTabIndex == 0
          //                           ? MyColors.topOrange.withOpacity(0.3)
          //                           : Colors.transparent,
          //                     ),
          //                     child: Center(
          //                       child: Padding(
          //                         padding:
          //                             const EdgeInsets.only(bottom: 3, top: 3),
          //                         child: _selectedTabIndex == 0
          //                             ? SvgPicture.asset(
          //                                 'assets/icons/orders-hover.svg')
          //                             : SvgPicture.asset(
          //                                 'assets/icons/orders.svg'),
          //                       ),
          //                     ),
          //                   ),
          //                   // label: 'Orders',
          //                   label: 'Orders',
          //                 ),
          //                 BottomNavigationBarItem(
          //                   icon: Container(
          //                     // padding: EdgeInsets.symmetric(horizontal: 5.0),
          //                     width: 50.0,
          //                     height: 28.0,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(15),
          //                       color: _selectedTabIndex == 1
          //                           ? MyColors.topOrange.withOpacity(0.3)
          //                           : Colors.transparent,
          //                     ),
          //                     child: Center(
          //                       child: Padding(
          //                         padding:
          //                             const EdgeInsets.only(bottom: 3, top: 3),
          //                         child: _selectedTabIndex == 1
          //                             ? SvgPicture.asset(
          //                                 'assets/icons/add-event-hover.svg')
          //                             : SvgPicture.asset(
          //                                 'assets/icons/add-event.svg'),
          //                       ),
          //                     ),
          //                   ),
          //                   label: 'Add Event',
          //                 ),
          //                 BottomNavigationBarItem(
          //                   icon: Container(
          //                     // padding: EdgeInsets.only(bottom: 20),
          //                     width: 50.0,
          //                     height: 28.0,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(15),
          //                       color: _selectedTabIndex == 2
          //                           ? MyColors.topOrange.withOpacity(0.3)
          //                           : Colors.transparent,
          //                     ),
          //                     child: Center(
          //                       child: Padding(
          //                         padding:
          //                             const EdgeInsets.only(bottom: 3, top: 3),
          //                         child: _selectedTabIndex == 2
          //                             ? SvgPicture.asset(
          //                                 'assets/icons/favorite-hover.svg')
          //                             : SvgPicture.asset(
          //                                 'assets/icons/favorite.svg'),
          //                       ),
          //                     ),
          //                   ),
          //                   label: 'Favorites',
          //                 ),
          //                 BottomNavigationBarItem(
          //                   // tooltip: '',
          //                   // backgroundColor: Colors.red,
          //                   icon: Container(
          //                     width: 50.0,
          //                     height: 28.0,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(15),
          //                       color: _selectedTabIndex == 3
          //                           ? MyColors.topOrange.withOpacity(0.3)
          //                           : Colors.transparent,
          //                     ),
          //                     child: Center(
          //                       child: Padding(
          //                         padding:
          //                             const EdgeInsets.only(bottom: 3, top: 3),
          //                         child: _selectedTabIndex == 3
          //                             ? SvgPicture.asset(
          //                                 'assets/icons/home-hover.svg')
          //                             : SvgPicture.asset('assets/icons/home.svg'),
          //                       ),
          //                     ),
          //                   ),
          //                   // label: 'HomePage',
          //                   label: 'HomePage',
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       )),
          // ),
          // bottomNavigationBar: Container(
          //   color: MyColors.dropdownColor.withOpacity(1),
          //   child: Row(
          //     // mainAxisSize: MainAxisSize.min,
          //     // mainAxisAlignment: MainAxisAlignment.center,
          //     // crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       DropButton(text1: 'איפה?', text2: 'בכל מקום'),
          //       DropButton(text1: 'מתי?', text2: 'בכל עת'),
          //       DropButton(text1: 'מה?', text2: 'כל החוויות')
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }

  Padding AccountModal(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          height: 165,
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.topOrange),
            color: MyColors.topOrange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _selectedTabIndex = 0;
                    profileIndex = 7;
                    isSelected = !isSelected;
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Term and Condition',
                    style: ktextStyleBold,
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                GestureDetector(
                  onTap: () {
                    _selectedTabIndex = 0;
                    profileIndex = 6;
                    isSelected = !isSelected;
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text('Contact Us', style: ktextStyleBold),
                ),
                Divider(
                  thickness: 2,
                ),
                GestureDetector(
                    onTap: () {
                      _selectedTabIndex = 0;
                      profileIndex = 5;
                      isSelected = !isSelected;
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text('User Profile', style: ktextStyleBold)),
                Divider(
                  thickness: 2,
                ),
                GestureDetector(
                  onTap: () {
                    _selectedTabIndex = 0;
                    profileIndex = 9;
                    isSelected = !isSelected;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SplashScreen()));
                    setState(() {});
                  },
                  child: Text(
                    'Logout',
                    style: ktextStyleBold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// BottomNavigationBarItem(
//   icon: Container(
//     width: 50.0,
//     height: 28.0,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(15),
//       color: _selectedTabIndex == 0
//           ? MyColors.topOrange.withOpacity(0.3)
//           : Colors.transparent,
//     ),
//     child: Center(
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 3, top: 3),
//         child: _selectedTabIndex == 0
//             ? SvgPicture.asset('assets/icons/account-hover.svg')
//             : SvgPicture.asset('assets/icons/user.svg'),
//       ),
//     ),
//   ),
//   label: 'Account',
// ),
