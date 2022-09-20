import 'package:basalon/screens/login/login_screen.dart';
import 'package:basalon/services/constant.dart';
import 'package:basalon/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

//225 85 78

class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Location location = Location();

  PermissionStatus? _permissionGranted;


  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
          await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false);
      });
    }
  }

// final Location location = Location();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

// Future<void> _requestLocationPermissions(BuildContext context) async {
//     Map<per.Permission, per.PermissionStatus> statuses = await [
//      per.Permission.location,
//       //  Permission.locationAlways,
//     Permission.locationWhenInUse,
//     ].request();
// }

// Future<void> _showInfoDialog() {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Demo Application'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 const Text('Created by Guillaume Bernos'),
//                 InkWell(
//                   // child: const Text(
//                   //  // 'https://github.com/Lyokone/flutterlocation',
//                   //   style: TextStyle(
//                   //     decoration: TextDecoration.underline,
//                   //   ),
//                   // ),
//                 //   onTap: () =>
//                 //       launch('https://github.com/Lyokone/flutterlocation'),
//                 // ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Ok'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(42, 42, 75, 1),
        body: SizedBox(
            height: height,
            width: width,
            child: SizedBox(
              child: Stack(
                children: [
                  SizedBox(
                    child: Image.asset("assets/images/image_onboard3.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'נוכל לקבל גישה',
                            style: TextStyle(
                                fontSize: 36,
                                color: Color.fromRGBO(241, 241, 241, 1),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '?למיקומך הנוכחי',
                          style: TextStyle(
                              fontSize: 36,
                              color: Color.fromRGBO(241, 241, 241, 1),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'אנחנו רוצים להראות לך פעילויות שקרובות אליך',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(241, 241, 241, 1),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                      child: Image.asset(
                    "assets/images/location_icon_1@3x.png",
                    height: 110,
                    width: 110,
                  )),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          color: Color.fromRGBO(233, 108, 96, 1),
                          text: 'מתן גישה',
                          textStyle: ktextStyleWhite,
                          height: 50,
                          width: width - 30,
                          onPressed:
                              _permissionGranted == PermissionStatus.granted
                                  ? null
                                  : _requestPermission,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                                (Route<dynamic> route) => false);
                            //  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                          },
                          child: const Text(
                            'לא תודה',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(225, 85, 78, 1)),
                          ),
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
