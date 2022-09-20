import 'package:basalon/screens/home_screen.dart';
import 'package:basalon/services/my_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../blocs/application_bloc.dart';

// ignore: must_be_immutable
class DropButtonEverywhere extends StatefulWidget {
  String? text1;
  String? text2;
  dynamic onChanged;

  dynamic coordinates;

  DropButtonEverywhere({
    Key? key,
    required this.text1,
    required this.text2,
    this.onChanged,
    this.coordinates,
  }) : super(key: key);

  @override
  State<DropButtonEverywhere> createState() => _DropButtonEverywhereState();
}

class _DropButtonEverywhereState extends State<DropButtonEverywhere> {
  //  Position? geoLoc;
  // setLocation() async {
  //   geoLoc = await Geolocator.getCurrentPosition();
  //   print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
  //   coordinates = geoLoc;
  //   print(geoLoc);
  //   print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
  //
  //   return coordinates;
  // }

  // String? val;
  bool? showOnline = false;
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('drop down init state');
    Future.delayed(const Duration(seconds: 3), () {
      print('drop down init state delayed wali');
      print(widget.coordinates);
      setLocations();
    });
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   // Future.delayed(Duration(seconds: 2), () {
  //   //   setLocation();
  //   // });
  //   print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
  // }
  PermissionStatus? _permissionGranted;
  final Location location = Location();

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
          await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
      });
    }
  }

  var locationCoordinate;

  setLocations() async {
    locationCoordinate = widget.coordinates;
    setState(() {
      application.val = locationCoordinate == null ? 'בכל מקום' : 'קרוב אליי';
    });
    print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
    print(locationCoordinate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.dropdownColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            style: const TextStyle(
              color: Colors.white,
            ),
            selectedItemBuilder: (BuildContext context) {
              return <String>[
                'בכל מקום',
                'קרוב אליי',
                'עיר מסויימת',
                'אונליין / זום',
              ].map<Widget>(
                (String item) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.text1!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 0.0),
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Text(
                          item,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ).toList();
            },

            isExpanded: true,
            hint: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text1!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.text2!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),

            items: <String>[
              'בכל מקום',
              'קרוב אליי',
              'עיר מסויימת',
              'אונליין / זום',
            ].map((item) {
              var backgroundColor =
                  (item == application.val) ? MyColors.topOrange : Colors.white;
              var textColor =
                  (item == application.val) ? Colors.white : Colors.black;

              return DropdownMenuItem<String>(
                value: item,
                alignment: AlignmentDirectional.topEnd,
                child: Container(
                  height: 50,
                  padding: EdgeInsets.only(top: 5, right: 10),
                  margin: EdgeInsets.all(0),
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
            value: application.val,
            onChanged: (value) {
              setState(() {
                print(value);
                widget.onChanged(value);
                application.val = value.toString();
                // application.showOnline = true;
              });
              if (application.val == 'קרוב אליי') {
                print('location dedu kya !!!!!!!1');
                _permissionGranted == PermissionStatus.granted
                    ? null
                    : _requestPermission();
                print('location dedu kya !!!!!!!5555555');
              }
            },
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            // iconSize: 30,
            iconEnabledColor: Colors.white,

            itemHeight: 40,
            // dropdownMaxHeight: 200,
            dropdownPadding: const EdgeInsets.all(0),
            itemPadding: EdgeInsets.all(0),
          ),
        ),
      ),
    );
  }
}
