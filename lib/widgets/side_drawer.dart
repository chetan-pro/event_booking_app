import 'package:basalon/constant/login_user.dart';
import 'package:basalon/network/login_register_network.dart';
import 'package:basalon/screens/activity/general_screen.dart';
import 'package:basalon/screens/home_screen.dart';
import 'package:basalon/screens/login/signin_screen.dart';
import 'package:basalon/screens/package/package_screen.dart';
import 'package:basalon/screens/profile/contact_us.dart';
import 'package:basalon/screens/profile/user_profile.dart';
import 'package:basalon/screens/sideDrawer/myActivity/my_activity.dart';
import 'package:basalon/screens/sideDrawer/myOrders/my_orders_screen.dart';
import 'package:basalon/screens/terms_and_condition/privacy_policy.dart';
import 'package:basalon/screens/terms_and_condition/terms_and_condition_screen.dart';
import 'package:basalon/services/constant.dart';
import 'package:basalon/services/my_color.dart';
import 'package:basalon/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/application_bloc.dart';
import '../network/report_sales_network.dart';
import '../screens/login/registration_screen.dart';
import '../screens/sideDrawer/favorites/my_favorites_screen.dart';
import '../screens/sideDrawer/reportSales/report_sales.dart';
import '../utils/utils.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer({Key? key, this.packageID, this.profileData}) : super(key: key);

  dynamic packageID;
  dynamic profileData;

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  late final application = Provider.of<ApplicationBloc>(context, listen: false);
  ReportSalesNetwork reportSalesNetwork = ReportSalesNetwork();

  @override
  void initState() {
    super.initState();

    print(LoginUser.shared?.userId);
    print(LoginUser.shared?.userName);
    print(LoginUser.shared?.email);

    // LoginRegisterNetwork.deleteAddress(dataId: 2595);
    print(
        'navdrawer ki init state ${application.packageModel?.data?.userActivePackage?.iD}');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(LoginUser.shared?.userId);
    print('userrrrrrrrrrrr');
    print('userrrrrrrrrrrrsssssssssssssssssssss');

    return SizedBox(
      width: 250,
      child: Drawer(
        backgroundColor: MyColors.dropdownColor.withOpacity(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/4.png',
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        textStyle: ktextStyleWhite,
                        onPressed: () {
                          if ((application.packageModel?.data?.userActivePackage
                                          ?.iD !=
                                      "" &&
                                  application.packageModel?.data
                                          ?.userActivePackage?.iD !=
                                      null) &&
                              isUserLogin(application.isUserLogin)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GeneralScreen()));
                          } else if (isUserLogin(application.isUserLogin)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PackageScreen(
                                          packID: application.packageModel?.data
                                              ?.userActivePackage?.iD,
                                        )));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()));
                          }
                        },
                        width: 210,
                        color: Color.fromRGBO(233, 108, 96, 1),
                        text: 'יצירת פעילות'),
                    if (!isUserLogin(application.isUserLogin))
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrationScreen(
                                              isAppleLogin: false,
                                            )));
                              },
                              child: Text(
                                'הרשמה',
                                style: ktextStyleWhite,
                              ),
                              style: ButtonStyle(
                                //  backgroundColor: getMaterialColor(color: color),
                                side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(
                                        width: 2.0, color: Colors.white)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                application.isUserLogin = false;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInScreen()));
                              },
                              child: Text(
                                'התחברות',
                                style: ktextStyleWhite,
                              ),
                              style: ButtonStyle(
                                //  backgroundColor: getMaterialColor(color: color),
                                side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(
                                        width: 2.0, color: Colors.white)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),

                            // Expanded(
                            //   child: CustomButton(
                            //       isOutlinedButton: true,
                            //       text: ' התחברות',
                            //       textStyle: ktextStyleWhite,
                            //       onPressed: () {
                            //         application.isUserLogin = false;
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (context) =>
                            //                     SignInScreen()));
                            //       }),
                            // )
                          ],
                        ),
                      ),
                    if (!isUserLogin(application.isUserLogin))
                      Divider(
                        color: Colors.white,
                      )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: isUserLogin(application.isUserLogin) == true ? 5 : 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (isUserLogin(application.isUserLogin))
                    SidebarItems(
                        showLine: isUserLogin(application.isUserLogin),
                        pressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportSalesScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                        ),
                        textTile: 'כללי'),
                  if (isUserLogin(application.isUserLogin))
                    SidebarItems(
                        showLine: isUserLogin(application.isUserLogin),
                        pressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyActivityScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.list_alt_sharp,
                          color: Colors.white,
                        ),
                        textTile: 'הפעילויות שלי'),
                  if (isUserLogin(application.isUserLogin))
                    SidebarItems(
                        showLine: isUserLogin(application.isUserLogin),
                        pressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProfile(
                                        getUserData: widget.profileData,
                                      )));
                        },
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        textTile: 'הפרופיל שלי'),
                  SidebarItems(
                      showLine: isUserLogin(application.isUserLogin),
                      pressed: () async {
                        if (isUserLogin(application.isUserLogin)) {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyOrderScreen()));
                        } else {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        }
                      },
                      icon: Icon(
                        Icons.archive,
                        color: Colors.white,
                      ),
                      textTile: 'ההזמנות שלי'),
                  SidebarItems(
                      showLine: isUserLogin(application.isUserLogin),
                      pressed: () async {
                        if (isUserLogin(application.isUserLogin)) {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyFavorites()));
                        } else {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        }
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      textTile: 'המועדפים שלי'),
                  SidebarItems(
                      showLine: isUserLogin(application.isUserLogin),
                      pressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactUsScreen()));
                      },
                      icon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      textTile: 'יצירת קשר'),
                  if (isUserLogin(application.isUserLogin))
                    SidebarItems(
                      showLine: isUserLogin(application.isUserLogin),

                      pressed: () async {
                        final SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        await sharedPreferences.remove('email');
                        await sharedPreferences.remove('facebookName');
                        await sharedPreferences.remove('facebookImage');
                        await sharedPreferences.remove('loginId');
                        await sharedPreferences.remove('cardHolder');
                        await sharedPreferences.remove('cardNumber');
                        await sharedPreferences.clear();
                        setState(() {
                          application.isUserLogin = false;
                          application.emailFromFacebook = null;
                          application.nameFromFacebook = null;
                          application.imageFromFacebook = null;
                          application.idFromLocalProvider = null;
                          application.cardHolderProvider = null;
                          application.cardNumberProvider = null;
                          application.cardYearProvider = null;
                          application.cardMonthProvider = null;
                          application.cardCvvProvider = null;
                          application.getUserDataProfileProvider = null;
                          application.myActivity = null;
                        });
                        // await Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SplashScreen()));
                        await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false);
                        application.dispose();
                      },
                      icon: Icon(
                        Icons.lock_open_sharp,
                        color: Colors.white,
                      ),
                      // textTile: 'logout',
                      textTile: 'התנתקות',
                    ),
                  if (isUserLogin(application.isUserLogin))
                    SidebarItems(
                        showLine: isUserLogin(application.isUserLogin),
                        pressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    'Do you want delete Account ?',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  actionsAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('NO'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        print(LoginUser.shared?.userId);
                                        print('helllo');
                                        deleteUser(
                                            dataId: LoginUser.shared?.userId);
                                        final SharedPreferences
                                            sharedPreferences =
                                            await SharedPreferences
                                                .getInstance();

                                        await sharedPreferences
                                            .remove('loginId');

                                        setState(() {
                                          application.isUserLogin = false;
                                        });

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()),
                                            (route) => false);
                                        application.dispose();
                                      },
                                      child: const Text('YES'),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        textTile: 'יצירת קשר'),
                ],
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndCondition()));
                },
                child: Text(
                  'תנאי שימוש',
                  style: ktextStyleWhite,
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
                child: Text(
                  'מדיניות פרטיות',
                  style: ktextStyleWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SidebarItems extends StatelessWidget {
  SidebarItems(
      {required this.pressed,
      required this.icon,
      required this.textTile,
      this.showLine});

  final Icon icon;
  final String textTile;
  final Function() pressed;
  bool? showLine = true;

  @override
  Widget build(BuildContext context) {
    //use expanded here

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: showLine == true
                      ? Colors.grey.shade700
                      : Colors.transparent))),
      child: Center(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.lerp(
              VisualDensity.compact, VisualDensity.compact, 0.0),
          trailing: icon,
          title: Text(
            textTile,
            textDirection: TextDirection.rtl,
            style: ktextStyleWhiteBold,
          ),
          onTap: pressed,
        ),
      ),
    );
  }
}
