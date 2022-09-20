// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:async';

import 'package:basalon/modal/get_event_detail_data.dart';
import 'package:basalon/network/get_events_network.dart';
import 'package:basalon/network/place_order_network.dart';
import 'package:basalon/screens/activity/receiving_activity_screen.dart';
import 'package:basalon/screens/join_events/join.dart';
import 'package:basalon/services/my_color.dart';
import 'package:basalon/widgets/comment_card.dart';
import 'package:basalon/widgets/custom_buttons.dart';
import 'package:basalon/widgets/feedback_card.dart';
import 'package:basalon/widgets/image_previews.dart';
import 'package:basalon/widgets/profile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../blocs/application_bloc.dart';
import '../../services/constant.dart';

class PreviewEventDetailScreen extends StatefulWidget {
  static const String route = '/event_detail_screen';

  @override
  _PreviewEventDetailScreenState createState() =>
      _PreviewEventDetailScreenState();
}

class _PreviewEventDetailScreenState extends State<PreviewEventDetailScreen> {
  late ScrollController _scrollViewController = ScrollController();
  TextEditingController moreDetailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  // late List<String> imageList =
  //     _fetchEventData.eventData!.data!.gallery!.toList();
  //
  // List<String> imageCheck() {
  //   if (imageList.length == 0) {
  //     print(
  //         'imageimageimageimageimageimageimageimageimageimageimageimageimage');
  //     setState(() {
  //       imageList = ['assets/images/image_onboard1.png'];
  //     });
  //   }
  //   return [];
  // }

  @override
  void initState() {
    // TODO: implement initState
    // fetchEvents();
    super.initState();
    streamController.close();
  }

  String? _dropDownValue;
  List items = [''];
  final categoryList = kDateTimeList;
  final beginList = kbeginningTime;
  final noOfPeopleList = kparticipants;
  String? dateFilter;
  String? beginningTime;
  String? numOfPeople;
  final Completer<GoogleMapController> _mapController = Completer();
  StreamController streamController = StreamController();
  late final application = Provider.of<ApplicationBloc>(context);

  @override
  Widget build(BuildContext context) {
    print('gallery gallery gallery gallery gallery gallery');
    print('map location aayi ?????????');
    print(application.previewGalleryProvider);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          controller: _scrollViewController,
          physics: ClampingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return SizedBox(
                    height: 350,
                    child: application.previewImageProvider != null
                        ? Image.file(
                            application.previewImageProvider,
                            fit: BoxFit.cover,
                          )
                        : Image.asset('assets/event-detail.jpeg'),
                  );
                },
                childCount: 1, // 1000 list items
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '${application.previewTitleProvider}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${application.previewDateProvider}',
                                      style: ktextStyleBold,
                                    ),
                                    Icon(Icons.calendar_month)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${application.previewMapAddressProvider}',
                                        style: ktextStyleBold,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: MyColors.topOrange,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${application.previewTicketProvider}',
                                      style: ktextStyleBold,
                                    ),
                                    Icon(
                                      Icons.airplane_ticket,
                                      color: MyColors.topOrange,
                                    )
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 10),
                              //   child: Text(
                              //     ' בחרו מועד',
                              //     style: ktextStyleBold,
                              //   ),
                              // ),
                              // DropdownButtonHideUnderline(
                              //   child: ButtonTheme(
                              //     alignedDropdown: true,
                              //     child: DropdownButton(
                              //       isExpanded: true,
                              //       menuMaxHeight: 300,
                              //       hint: _dropDownValue == null
                              //           ? const Padding(
                              //               padding: EdgeInsets.symmetric(
                              //                   vertical: 8, horizontal: 20),
                              //               child: Text(
                              //                 'choose a date',
                              //                 style:
                              //                     TextStyle(color: Colors.grey),
                              //               ),
                              //             )
                              //           : Padding(
                              //               padding: const EdgeInsets.all(8.0),
                              //               child: Column(
                              //                 children: [
                              //                   Text(
                              //                     '${application.previewDateProvider}',
                              //                     style: const TextStyle(
                              //                         color: Colors.black),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //       iconSize: 30.0,
                              //       style: const TextStyle(color: Colors.black),
                              //       items: items.map(
                              //         (val) {
                              //           return DropdownMenuItem<String>(
                              //             value: val,
                              //             child: Text(
                              //                 '${application.previewDateProvider}'),
                              //           );
                              //         },
                              //       ).toList(),
                              //       onChanged: (val) {
                              //         setState(
                              //           () {
                              //             _dropDownValue = val as String?;
                              //           },
                              //         );
                              //       },
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                width: double.infinity,
//Button
                                child: ElevatedButton(
                                    onPressed: () {
                                      print('ליחצו booknow');
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         BookEventPage(
                                      //           id: _fetchEventData
                                      //               .eventData?.data?.id,
                                      //           noOfTicket: _fetchEventData
                                      //               .eventData
                                      //               ?.data
                                      //               ?.noOfTicket,
                                      //           thumbnailImage:
                                      //           _fetchEventData
                                      //               .eventData
                                      //               ?.data
                                      //               ?.thumbnailEvent,
                                      //           title:
                                      //           '${_fetchEventData
                                      //               .eventData?.data
                                      //               ?.title}',
                                      //           date: _fetchEventData
                                      //               .eventData?.data
                                      //               ?.date,
                                      //           mapAdress: _fetchEventData
                                      //               .eventData
                                      //               ?.data
                                      //               ?.mapAddress,
                                      //         ),
                                      //   ),
                                      // );
                                    },
                                    child: Text(
                                      ' ליחצו להזמנה ',
                                      style: ktextStyleWhiteBold,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: MyColors.topOrange,
                                        elevation: 0.0,
                                        splashFactory: NoSplash.splashFactory,
                                        minimumSize:
                                            Size(double.infinity, 50))),
                              ),
                              Container(
// alignment: Alignment.topRight,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.0, vertical: 6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          print('messenger clicked.');
                                        },
                                        icon: Image.asset(
                                          'assets/icons/messenger-icon.png',
                                          width: 55,
                                          height: 55,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          print('email clicked.');
                                        },
                                        icon: Image.asset(
                                            'assets/icons/email-icon.png')),
                                    IconButton(
                                        onPressed: () {
                                          print('whatsapp clicked.');
                                        },
                                        icon: Image.asset(
                                            'assets/icons/whatsapp-icon.png')),
                                    IconButton(
                                        onPressed: () {
                                          print('facebook clicked.');
                                        },
                                        icon: Image.asset(
                                            'assets/icons/fb-icon.png')),
                                    Text(
                                      'שתפו פעילות',
                                      style: ktextStyleBold,
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: CustomButton(
                                    icon: Icons.group,
                                    iconColor: MyColors.topOrange,
                                    onPressed: () {
                                      groupBookingModal();
                                    },
                                    outlineColor: MyColors.topOrange,
                                    text: ' הזמנת פעילות לקבוצה פרטית',
                                    height: 50,
                                    textStyle: TextStyle(
                                      color: MyColors.topOrange,
                                    ),
                                    width: 250,
                                    isOutlinedButton: true),
                              ),
                            ],
                          ))
                    ],
                  );
                },
                childCount: 1, // 1000 list items
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 50.0,
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    child: Text(
                      '${application.previewContentProvider}',
                      textAlign: TextAlign.end,
                    ),
                  );
//Preview Images
                },
                childCount: 1, // 1000 list items
              ),
            ),
            if (application.previewGalleryProvider != null)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ImagePreview(
                      galleryImageFromPreview:
                          application.previewGalleryProvider![index],
                    );
                  },
                  childCount: application
                      .previewGalleryProvider?.length, // 1000 list items
                ),
              ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ProfileCard(
                    showCircleAvatar: false,
                    title:
                        '${application.previewFirstnameProvider} ${application.previewLastnameProvider}',
                    content: '${application.previewAuthorDescriptionrovider}',
                    image:
                        'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=',
                  );
                },
                childCount: 1, // 1000 list items
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25, bottom: 30, top: 30),
                        child: Container(
                          color: Colors.white,
                          height: 300,
                          width: 358,
                          padding: EdgeInsets.all(20),
                          child: GoogleMap(
                            mapToolbarEnabled: true,
                            gestureRecognizers: Set()
                              ..add(Factory<PanGestureRecognizer>(
                                  () => PanGestureRecognizer())),
                            markers: {
                              Marker(
                                markerId: MarkerId('someId'),
                                infoWindow:
                                    InfoWindow(title: 'google maps test2'),
                                icon: BitmapDescriptor.defaultMarker,
                                position: LatLng(
                                    application.previewLatProvider != null
                                        ? application.previewLatProvider
                                        : 36.4219983,
                                    application.previewLngProvider != null
                                        ? application.previewLngProvider
                                        : 121.084),
                              ),
                            },
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  application.previewLatProvider != null
                                      ? application.previewLatProvider
                                      : 36.4219983,
                                  application.previewLngProvider != null
                                      ? application.previewLngProvider
                                      : 121.084),
                              zoom: 14,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _mapController.complete(controller);
                              // print(GoogleMapController);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
                childCount: 1, // 1000 list items
              ),
            ),
          ],
        ),
      ),
    );
  }

  void groupBookingModal() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: SingleChildScrollView(
                child: Stack(
                  // overflow: Overflow.clip,
                  children: <Widget>[
                    Positioned(
                      right: -2.0,
                      top: -2.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          size: 18,
                        ),
                      ),
                    ),
                    Form(
                      // key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            child: Column(
                              textDirection: TextDirection.rtl,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "הזמינו פעילות לקבוצה פרטית",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                                Text(
                                  "מלאו את הפרטים על מנת שמעבירי הפעילות יחזרו אליכם",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomDropdown(
                            hintText: dateFilter == null
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'ביחרו מועד',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      dateFilter!,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                            dropdownItems: categoryList.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  dateFilter = val as String?;
                                },
                              );
                              print('kkkkkkkk$dateFilter');
                            },
                          ),
                          CustomDropdown(
                            hintText: beginningTime == null
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'שעת התחלה',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      beginningTime!,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                            dropdownItems: beginList.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  beginningTime = val as String?;
                                },
                              );
                              print('jjjjjjj$beginningTime');
                            },
                          ),
                          CustomDropdown(
                            hintText: numOfPeople == null
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'מספר משתתפים',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      numOfPeople!,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                            dropdownItems: noOfPeopleList.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(
                                    val,
                                    textAlign: TextAlign.right,
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  numOfPeople = val as String?;
                                },
                              );
                              print('iiiiiiiii$numOfPeople');
                            },
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: ReceivingPaymentFieldColumn(
                              controller: mobileController,
                              obscureText: false,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            height: 170,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: const Color.fromRGBO(
                                        216, 216, 216, 1))),
                            child: TextField(
                                controller: moreDetailController,
                                maxLines: 10,
                                textAlignVertical: TextAlignVertical.top,
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 10, right: 10),
                                  hintText: '',
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: CustomButton(
                              width: 150,
                              height: 50,
                              color: MyColors.topOrange,
                              text: 'שליחת בקשה',
                              onPressed: () {
                                Navigator.pop(context);
                                Future.delayed(Duration(seconds: 1), () {
                                  groupBookingModalSuccess();
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void groupBookingModalSuccess() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              // overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -15.0,
                  top: -15.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      radius: 12,
                      child: Icon(
                        Icons.close,
                        size: 18,
                      ),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  // key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset('assets/icons/Logo.png'),
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child:
                                Text('הפרטים נשלחו בהצלחה. ניצור קשר בקרוב!')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class CustomDropdown extends StatelessWidget {
  CustomDropdown({this.hintText, this.dropdownItems, this.onChanged});

  dynamic hintText;
  dynamic dropdownItems;
  dynamic onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      height: 40,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: const Color.fromRGBO(216, 216, 216, 1))),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            child: DropdownButton(
              isExpanded: true,
              menuMaxHeight: 300,
              hint: hintText,
              style: const TextStyle(color: Colors.black),
              items: dropdownItems,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
