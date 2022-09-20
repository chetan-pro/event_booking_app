// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, import_of_legacy_library_into_null_safe, must_be_immutable

import 'dart:async';

import 'package:basalon/constant/login_user.dart';
import 'package:basalon/modal/get_event_detail_data.dart';
import 'package:basalon/network/get_events_network.dart';
import 'package:basalon/network/place_order_network.dart';
import 'package:basalon/screens/activity/receiving_activity_screen.dart';
import 'package:basalon/services/my_color.dart';
import 'package:basalon/widgets/custom_buttons.dart';
import 'package:basalon/widgets/side_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
// import 'package:flutter_social_content_share/flutter_social_content_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../blocs/application_bloc.dart';
import '../services/constant.dart';
import '../utils/utils.dart';
import '../widgets/date_helper.dart';
import '../widgets/feedback_card.dart';
import '../widgets/image_previews.dart';
import '../widgets/profile_card.dart';
import 'join_events/join.dart';

class EventDetailScreen extends StatefulWidget {
  static const String route = '/event_detail_screen';
  final int id;
  String? email;
  String? name;

  EventDetailScreen({Key? key, required this.id, this.email, this.name});

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  late FetchEventData _fetchEventData = FetchEventData(
    id: widget.id,
  );
  late ScrollController _scrollViewController = ScrollController();
  Welcome? eventData;
  String url = 'https://basalon.co.il/wp-json/wp/v2/get_event_detail';
  TextEditingController moreDetailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  DateTime now = DateTime.now();
  String date = intl.DateFormat("yyyy-MM-dd").format(DateTime.now());

  List<String>? imageList = [];
  bool checkBoxValue = true;

  addGallery() {
    for (int i = 0; i < _fetchEventData.eventData!.data!.gallery!.length; i++) {
      setState(() {
        imageList?.add(_fetchEventData.eventData!.data!.gallery![i].url!);
      });
      print('aaaaaaaaaaaaaaaaaaaaa');
      print(imageList);
    }
    return imageList;
  }

  // List<String> imageCheck() {
  //   if (imageList?.length == 0) {
  //
  //     setState(() {
  //       imageList = ['assets/images/image_onboard1.png'];
  //     });
  //   }
  //   return [];
  // }

  late final PlaceOrderNetwork _placeOrderNetwork = PlaceOrderNetwork(
    bookingDate: dateFilter,
    beginningTime: beginningTime,
    numOfParticipants: numOfPeople,
    mobNumber: mobileController.text,
    moreDetails: moreDetailController.text,
  );

  YoutubePlayerController? controller;

  @override
  void initState() {
    _fetchEventData.getEventDetailData();
    super.initState();
    streamController.close();
    print('print 1');
    Future.delayed(Duration(seconds: 3), () {
      bookingDates();
      if (_fetchEventData.eventData?.data?.gallery != null) {
        addGallery();
      }
      if (p!.linkVideo != null) {
        String url = p!.linkVideo!;
        controller = YoutubePlayerController(
          flags: YoutubePlayerFlags(
              autoPlay: false,
              disableDragSeek: false,
              useHybridComposition: false,
              hideThumbnail: true),
          initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        );
      }
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print('print 2');
  }

  List items = [];
  late final p = _fetchEventData.eventData?.data;
  final categoryList = kDateTimeList;
  final beginList = kbeginningTime;
  final noOfPeopleList = kparticipants;
  String? dateFilter;
  String? beginningTime;
  String? numOfPeople;
  final Completer<GoogleMapController> _mapController = Completer();
  StreamController streamController = StreamController.broadcast();
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

  bookingDates() async {
    for (int i = 0;
        i < (_fetchEventData.eventData?.data?.bookingDates?.length ?? 0);
        i++) {
      items.add(_fetchEventData.eventData!.data!.bookingDates?[i].option);
    }

    return;
  }

  dynamic youtubeHeight = 300.0;
  bool showFullScreenYoutube = false;
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  bool isSelected = true;
  int _selectedIndex = 0;

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        // linkUrl: 'https://basalon.co.il/event/סדנת-חקלאות-בסביבה-הביתית/',
        linkUrl: '${_fetchEventData.eventData?.data?.shareLink}',
        chooserTitle: 'Example Chooser Title');
  }

  late BookingDate? dynamicBookingDate =
      _fetchEventData.eventData!.data!.bookingDates![0];

  @override
  Widget build(BuildContext context) {
    print(LoginUser.shared?.userId!);
    print('gggggggggggggggggggggggggggg');
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: MyColors.homeBackGroundColor,
        resizeToAvoidBottomInset: false,
        endDrawer: NavDrawer(),
        body: showFullScreenYoutube == true
            ? YoutubePlayerBuilder(
                onEnterFullScreen: () {
                  setState(() {
                    showFullScreenYoutube = true;
                  });
                },
                onExitFullScreen: () {
                  setState(() {
                    showFullScreenYoutube = false;
                    streamController.close();
                  });
                },
                player: YoutubePlayer(
                  controller: controller!,
                  aspectRatio: 16 / 9,
                ),
                builder: (context, player) {
                  Container(
                    // height: 150,
                    child: player,
                  );
                  return Container();
                })
            : FutureBuilder(
                future: _fetchEventData.getEventDetailData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (_fetchEventData.eventData != null) {
                    return CustomScrollView(
                      controller: _scrollViewController,
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        image: DecorationImage(
                                            opacity: 0.9,
                                            fit: BoxFit.cover,
                                            image: Image.network(
                                              '${_fetchEventData.eventData?.data?.thumbnailEvent}',
                                            ).image)),
                                    // child: Image.network(
                                    //   '${_fetchEventData.eventData?.data?.thumbnailEvent}',
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                  AppBar(
                                    toolbarHeight: 70,
                                    centerTitle: true,
                                    elevation: 0,
                                    leading: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios_new_outlined,
                                        )),

                                    // (isUserLogin(
                                    //             application.isUserLogin) &&
                                    //         application
                                    //                 .getUserDataProfileProvider
                                    //                 ?.data
                                    //                 ?.authorImage !=
                                    //             null)
                                    //     ? Padding(
                                    //         padding: const EdgeInsets.all(8.0),
                                    //         child: CircleAvatar(
                                    //           backgroundImage:
                                    //               // AssetImage(
                                    //               //     'assets/images/dummy_user.png'),

                                    //               NetworkImage(
                                    //             application
                                    //                         .getUserDataProfileProvider
                                    //                         ?.data
                                    //                         ?.authorImage !=
                                    //                     ''
                                    //                 ? application
                                    //                     .getUserDataProfileProvider
                                    //                     ?.data
                                    //                     ?.authorImage
                                    //                 : application
                                    //                         .imageFromFacebook ??
                                    //                     'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                                    //           ),
                                    //           backgroundColor:
                                    //               Colors.grey.shade600,
                                    //         ),
                                    //       )
                                    //     : SizedBox(),
                                    backgroundColor: Colors.transparent,

                                    title: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 100.0,
                                            // soften the shadow
                                            spreadRadius: 10.0,
                                            //extend the shadow
                                            offset: Offset(
                                              0.0, // Move to right 10  horizontally
                                              -30.0, // Move to bottom 10 Vertically
                                            ),
                                            blurStyle: BlurStyle.normal,
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        kLogoImage,
                                        fit: BoxFit.fill,
                                      ),
                                    ),

                                    actions: [
                                      Builder(
                                        builder: (context) => Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: IconButton(
                                              onPressed: () =>
                                                  Scaffold.of(context)
                                                      .openEndDrawer(),
                                              icon: Icon(
                                                Icons.menu,
                                                size: 40,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            },
                            childCount: 1, // 1000 list items
                          ),
                        ),
                        // SliverList(
                        //   delegate: SliverChildBuilderDelegate(
                        //     (BuildContext context, int index) {
                        //       return Container(
                        //         width: double.infinity,
                        //         height: MediaQuery.of(context).size.height / 3,
                        //         decoration: BoxDecoration(
                        //             color: Colors.black,
                        //             image: DecorationImage(
                        //                 opacity: 0.6,
                        //                 fit: BoxFit.cover,
                        //                 image: Image.network(
                        //                   '${_fetchEventData.eventData?.data?.thumbnailEvent}',
                        //                 ).image)),
                        //         // child: Image.network(
                        //         //   '${_fetchEventData.eventData?.data?.thumbnailEvent}',
                        //         //   fit: BoxFit.cover,
                        //         // ),
                        //       );
                        //     },
                        //     childCount: 1, // 1000 list items
                        //   ),
                        // ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              '${_fetchEventData.eventData?.data?.title}',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ),
                                          if (p?.numberComment != 0 &&
                                              p?.averageRating != 0)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '( ${_fetchEventData.eventData?.data?.numberComment} מדרגים )',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                    textDirection:
                                                        TextDirection.rtl,
                                                  ),
                                                  RatingBar.builder(
                                                    ignoreGestures: true,
                                                    initialRating:
                                                        _fetchEventData
                                                            .eventData!
                                                            .data!
                                                            .averageRating!
                                                            .toDouble(),
                                                    minRating: 1,
                                                    itemSize: 20,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color:
                                                          Colors.amber.shade700,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),

                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          if (_fetchEventData.eventData!.data
                                                  ?.customView !=
                                              null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text('אנשים השתתפו'),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    _fetchEventData.eventData!
                                                        .data!.customView
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      // fontFamily: 'Alef',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Icon(
                                                    Icons.groups,
                                                    size: 30,
                                                    color: Colors.red[300],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment: _fetchEventData
                                                          .eventData
                                                          ?.data
                                                          ?.ticketRest ==
                                                      ''
                                                  ? MainAxisAlignment.end
                                                  : MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                if (_fetchEventData.eventData
                                                        ?.data?.ticketRest !=
                                                    '')
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        border: Border.all(
                                                            color: Colors.red)),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    padding: EdgeInsets.all(6),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          '${_fetchEventData.eventData?.data?.ticketRest ?? 0}',
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '${_fetchEventData.eventData?.data?.mapAddress?.contains('New York, NY, USA') == false ? _fetchEventData.eventData?.data?.mapAddress : 'online'}',
                                                      style: ktextStyle,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: MyColors.topOrange,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${_fetchEventData.eventData?.data?.markerPrice}'
                                                      .replaceAll(' ', ''),
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                ),
                                                SizedBox(
                                                  width: 8.0,
                                                ),
                                                Transform.rotate(
                                                    angle: 180,
                                                    child: FaIcon(
                                                      FontAwesomeIcons.ticket,
                                                      color: MyColors.topOrange,
                                                      size: 18,
                                                    ))
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10, bottom: 15),
                                            child: Text(
                                              ':בחרו מועד',
                                              style: ktextStyle,
                                            ),
                                          ),
                                          // Container(
                                          //   margin: const EdgeInsets.symmetric(
                                          //       horizontal: 10),
                                          //   decoration: BoxDecoration(
                                          //       border:
                                          //           Border.all(color: Colors.grey)),
                                          //   child: DropdownButtonHideUnderline(
                                          //     child: ButtonTheme(
                                          //       // alignedDropdown: true,
                                          //       child: DropdownButton(
                                          //         isExpanded: true,
                                          //         menuMaxHeight: 300,
                                          //         iconSize: 30.0,
                                          //         style: const TextStyle(
                                          //           color: Colors.black,
                                          //         ),
                                          //         hint: _dropDownValue == null
                                          //             ? Align(
                                          //                 alignment:
                                          //                     Alignment.centerRight,
                                          //                 child: Padding(
                                          //                   padding:
                                          //                       EdgeInsets.all(8.0),
                                          //                   child: Text(
                                          //                     '${_fetchEventData.eventData?.data?.bookingDates?[0].option}',
                                          //                     style: TextStyle(
                                          //                         color: Colors.grey),
                                          //                   ),
                                          //                 ),
                                          //               )
                                          //             : Align(
                                          //                 alignment:
                                          //                     Alignment.centerRight,
                                          //                 child: Padding(
                                          //                   padding:
                                          //                       const EdgeInsets.all(
                                          //                           8.0),
                                          //                   child: Text(
                                          //                     _dropDownValue!,
                                          //                     style: const TextStyle(
                                          //                         color:
                                          //                             Colors.black),
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //         items: _fetchEventData
                                          //             .eventData?.data?.bookingDates
                                          //             ?.map(
                                          //           (val) {
                                          //             return DropdownMenuItem<String>(
                                          //               value: val.option,
                                          //               alignment:
                                          //                   Alignment.centerRight,
                                          //               child: Text(
                                          //                 '${val.option}',
                                          //                 style: TextStyle(
                                          //                     color: Colors.black),
                                          //                 textDirection:
                                          //                     TextDirection.rtl,
                                          //               ),
                                          //             );
                                          //           },
                                          //         ).toList(),
                                          //         onChanged: (val) {
                                          //           setState(
                                          //             () {
                                          //               _dropDownValue =
                                          //                   val as String?;
                                          //             },
                                          //           );
                                          //         },
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),

                                          Row(
                                            textDirection: TextDirection.rtl,
                                            children: [
                                              // for (var item in _fetchEventData
                                              //     .eventData!.data!.bookingDates!)
                                              for (int i = 0;
                                                  i <
                                                      _fetchEventData
                                                          .eventData!
                                                          .data!
                                                          .bookingDates!
                                                          .length;
                                                  i++)
                                                GestureDetector(
                                                  onTap: () {
                                                    print('opopopop');

                                                    print(i);
                                                    setState(() {
                                                      if (_selectedIndex == i) {
                                                        _selectedIndex = 0;
                                                      } else {
                                                        _selectedIndex = i;
                                                      }
                                                      isSelected = true;

                                                      dynamicBookingDate =
                                                          _fetchEventData
                                                              .eventData!
                                                              .data!
                                                              .bookingDates![i];
                                                    });
                                                    print(
                                                        'booking card $isSelected');
                                                    print(
                                                        'booking card $_selectedIndex');
                                                    print('booking card $i');
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: (i ==
                                                                    _selectedIndex)
                                                                ? Colors.red
                                                                : Colors.grey
                                                                    .shade300)),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    padding: EdgeInsets.all(6),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          '${_fetchEventData.eventData!.data!.bookingDates![i].date1}',
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          textAlign:
                                                              TextAlign.center,
                                                          // style: TextStyle(fontSize: 20),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          '${_fetchEventData.eventData!.data!.bookingDates![i].date2}',
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: ktextStyleBold,
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          '${_fetchEventData.eventData!.data!.bookingDates![i].endTime} - ${_fetchEventData.eventData!.data!.bookingDates![i].startTime}',
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            width: double.infinity,
//Button
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  print('ליחצו booknow');
                                                  if (_fetchEventData
                                                          .eventData!
                                                          .data!
                                                          .noOfTicket!
                                                          .isNotEmpty &&
                                                      isSelected) {
                                                    print("hjgdj");
                                                    print(_fetchEventData
                                                        .eventData?.data!.id);
                                                    print(_fetchEventData
                                                        .eventData
                                                        ?.data!
                                                        .noOfTicket);
                                                    print(_fetchEventData
                                                        .eventData
                                                        ?.data
                                                        ?.thumbnailEvent);
                                                    print(_fetchEventData
                                                        .eventData
                                                        ?.data
                                                        ?.title);
                                                    print(dynamicBookingDate);
                                                    print(_fetchEventData
                                                        .eventData
                                                        ?.data
                                                        ?.mapAddress);

                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookEventPage(
                                                          id: _fetchEventData
                                                              .eventData
                                                              ?.data
                                                              ?.id,
                                                          noOfTicket:
                                                              _fetchEventData
                                                                  .eventData
                                                                  ?.data
                                                                  ?.noOfTicket,
                                                          thumbnailImage:
                                                              _fetchEventData
                                                                  .eventData
                                                                  ?.data
                                                                  ?.thumbnailEvent,
                                                          title:
                                                              '${_fetchEventData.eventData?.data?.title}',
                                                          date:
                                                              dynamicBookingDate,
                                                          mapAdress: _fetchEventData
                                                                  .eventData
                                                                  ?.data
                                                                  ?.mapAddress ??
                                                              '',
                                                        ),
                                                      ),
                                                    );
                                                  } else if (isSelected ==
                                                      false) {}
                                                },
                                                child: Text(
                                                  'הזמינו כאן',
                                                  style: ktextStyleWhiteBold,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    primary: MyColors.topOrange,
                                                    elevation: 0.0,
                                                    splashFactory:
                                                        NoSplash.splashFactory,
                                                    minimumSize: Size(
                                                        double.infinity, 50))),
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                  onTap: () async {
                                                    var whatsapp =
                                                        "+972 050-6871111";
                                                    var whatsappAndroid = Uri.parse(
                                                        "whatsapp://send?phone=$whatsapp");
                                                    if (await canLaunchUrl(
                                                        whatsappAndroid)) {
                                                      await launchUrl(
                                                          whatsappAndroid);
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              "WhatsApp is not installed on the device"),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                      bottom:
                                                          3, // This can be the space you need between text and underline
                                                    ),
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                      color: Color(0xFF277BC0),
                                                      width:
                                                          1.0, // This would be the width of the underline
                                                    ))),
                                                    child: Text(
                                                        "צרו קשר בוואטסאפ",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xFF277BC0),
                                                        )),
                                                  )),
                                              Text(" | ",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blueGrey,
                                                  )),
                                              GestureDetector(
                                                onTap: () async {
                                                  await FlutterPhoneDirectCaller
                                                      .callNumber(
                                                          '050-6871111');
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    bottom:
                                                        3, // This can be the space you need between text and underline
                                                  ),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                    color: Color(0xFF277BC0),
                                                    width:
                                                        1.0, // This would be the width of the underline
                                                  ))),
                                                  child: Text(
                                                      "או בטלפון 050-6871111 ",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            Color(0xFF277BC0),
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Center(
                                            child: CustomButton(
                                                icon: Icons.group,
                                                iconColor: MyColors.topOrange,
                                                onPressed: () {
                                                  groupBookingModal();
                                                },
                                                radius: 0,
                                                outlineColor:
                                                    MyColors.topOrange,
                                                text:
                                                    ' הזמנת פעילות לקבוצה פרטית',
                                                height: 50,
                                                textStyle: TextStyle(
                                                  color: MyColors.topOrange,
                                                ),
                                                width: 250,
                                                isOutlinedButton: true),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.0, vertical: 6.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      print(
                                                          'messenger clicked.');
                                                      share();
                                                    },
                                                    icon: Image.asset(
                                                      'assets/icons/messenger-icon.png',
                                                      width: 55,
                                                      height: 55,
                                                    )),
                                                // IconButton(
                                                //     onPressed: () {
                                                //       print('email clicked.');
                                                //       share();
                                                //     },
                                                //     icon: Image.asset(
                                                //         'assets/icons/email-icon.png')),

                                                Link(
                                                  uri: Uri.parse(
                                                      'mailto:${widget.email}?body=${_fetchEventData.eventData?.data?.shareLink}'),
                                                  target:
                                                      LinkTarget.defaultTarget,
                                                  builder: (BuildContext
                                                              context,
                                                          Future<void>
                                                                  Function()?
                                                              followLink) =>
                                                      IconButton(
                                                    onPressed: followLink,
                                                    icon: Image.asset(
                                                        'assets/icons/email-icon.png'),
                                                  ),
                                                ),
                                                Link(
                                                  uri: Uri.parse(
                                                      'https://api.whatsapp.com/send/?text=${_fetchEventData.eventData?.data?.shareLink}&app_absent=0'),
                                                  target:
                                                      LinkTarget.defaultTarget,
                                                  builder: (BuildContext
                                                              context,
                                                          Future<void>
                                                                  Function()?
                                                              followLink) =>
                                                      IconButton(
                                                          onPressed: followLink,
                                                          icon: Image.asset(
                                                              'assets/icons/whatsapp-icon.png')),
                                                ),

                                                // Link(
                                                //   uri: Uri.parse(
                                                //       'fb://facewebmodal/f?href=${_fetchEventData.eventData?.data?.shareLink}'),
                                                //   target:
                                                //       LinkTarget.defaultTarget,
                                                //   builder: (BuildContext
                                                //               context,
                                                //           Future<void>
                                                //                   Function()?
                                                //               followLink) =>
                                                //       IconButton(
                                                //           onPressed: followLink,
                                                //           icon: Image.asset(
                                                //               'assets/icons/fb-icon.png')),
                                                // ),
                                                Link(
                                                  uri: Uri.parse(
                                                      'https://www.facebook.com/sharer/sharer.php?u=${_fetchEventData.eventData?.data?.shareLink}'),
                                                  target:
                                                      LinkTarget.defaultTarget,
                                                  builder: (BuildContext
                                                              context,
                                                          Future<void>
                                                                  Function()?
                                                              followLink) =>
                                                      GestureDetector(
                                                          onTap: () async {
                                                            // try {
                                                            //   var succeeded = await FacebookShare.shareContent(url: "https://www.facebook.com/sharer/sharer.php?u=${widget.datum.shareLink}", quote: "Dapatkan Promo");
                                                            //
                                                            //   if (succeeded) {
                                                            //     succeeded = await FacebookShare.sendMessage(
                                                            //         urlActionTitle: "Visit",
                                                            //         url: "https://www.facebook.com/sharer/sharer.php?u=${widget.datum.shareLink}",
                                                            //         title: "Promotion",
                                                            //         subtitle: "Get your promotion now!",
                                                            //         imageUrl:
                                                            //         "https://www.facebook.com/sharer/sharer.php?u=${widget.datum.shareLink}");
                                                            //     if (succeeded) {
                                                            //       var message = "Shared successfully";
                                                            //     } else {
                                                            //       var message = "Failed to share";
                                                            //     }
                                                            //   } else {
                                                            //     var message = "Failed to share";
                                                            //   }
                                                            // } on PlatformException catch (e) {
                                                            //   print(e);
                                                            // }
                                                            // FlutterSocialContentShare.share(
                                                            //     type: ShareType
                                                            //         .facebookWithoutImage,
                                                            //     url:
                                                            //         "${_fetchEventData.eventData?.data?.shareLink}",
                                                            //     quote:
                                                            //         "Basalon");
                                                          },
                                                          child: Image.asset(
                                                            'assets/icons/fb-icon.png',
                                                            width: 30,
                                                            height: 30,
                                                          )),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                // IconButton(
                                                //     onPressed: () {
                                                //       print('whatsapp clicked.');
                                                //       share();
                                                //     },
                                                //     icon: Image.asset(
                                                //         'assets/icons/whatsapp-icon.png')),
                                                // IconButton(
                                                //     onPressed: () {
                                                //       print('facebook clicked.');
                                                //       share();
                                                //     },
                                                //     icon: Image.asset(
                                                //         'assets/icons/fb-icon.png')),
                                                Text(
                                                  'שתפו פעילות',
                                                  style: ktextStyleBold,
                                                ),
                                                SizedBox(width: 10)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              );
                            },
                            childCount: 1, // 1000 list items
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Container(
                                  alignment: Alignment.centerRight,
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 16),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 8.0),
                                  child: Html(
                                    data: _fetchEventData
                                        .eventData?.data?.content,
                                    defaultTextStyle: TextStyle(
                                      fontSize: 16,
                                    ),
                                    customTextAlign: (_) => TextAlign.right,
                                  ),
                                  // Text(
                                  //   '${_fetchEventData.eventData?.data?.content}',
                                  //   // textAlign: TextAlign.end,
                                  //   textDirection: TextDirection.rtl,
                                  //   style: TextStyle(height: 2, fontSize: 16),
                                  // ),
                                );
//Preview Images
                              },
                              childCount: 1, // 1000 list items
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              if (imageList != null || imageList!.isNotEmpty) {
                                return ImagePreview(imageList: imageList);
                              } else {
                                return SizedBox();
                              }
                            },
                            childCount: imageList!.isNotEmpty
                                ? 1
                                : 0, // 1000 list items
                          ),
                        ),
                        if (controller != null)
                          SliverToBoxAdapter(
                            child: OrientationBuilder(builder:
                                (BuildContext context,
                                    Orientation orientation) {
                              return SizedBox(
                                height: 300,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: YoutubePlayerBuilder(
                                      onEnterFullScreen: () {
                                        setState(() {
                                          showFullScreenYoutube = true;
                                        });
                                        setState(() {
                                          showFullScreenYoutube = true;
                                        });
                                      },
                                      onExitFullScreen: () {
                                        setState(() {
                                          youtubeHeight = 300.0;
                                          showFullScreenYoutube = false;
                                        });
                                      },
                                      player: YoutubePlayer(
                                          controller: controller!,
                                          aspectRatio: 16 / 9,
                                          bottomActions: [
                                            RemainingDuration(),
                                            const PlaybackSpeedButton(),
                                          ]),
                                      builder: (context, player) {
                                        Container(
                                          height: 300,
                                          child: player,
                                        );
                                        return Container();
                                      }),
                                ),
                              );
                            }),
                          ),
                        // if (p?.linkVideo != null ||
                        //     p!.linkVideo!.isNotEmpty ||
                        //     controller != null)
                        //   SliverList(
                        //     delegate: SliverChildBuilderDelegate(
                        //       (BuildContext context, int index) {
                        //         return SizedBox(
                        //           height: controller != null ? youtubeHeight : 0,
                        //           child: controller != null
                        //               ? YoutubePlayerBuilder(
                        //                   onEnterFullScreen: () {
                        //                     setState(() {
                        //                       youtubeHeight = 300.0;
                        //                       // controller?.fitHeight(
                        //                       //     Size(width, height/1.1));
                        //                       // showFullScreenYoutube = true;
                        //                     });
                        //                   },
                        //                   onExitFullScreen: () {
                        //                     setState(() {
                        //                       youtubeHeight = 200.0;
                        //                       // showFullScreenYoutube = false;
                        //                     });
                        //                   },
                        //                   player: YoutubePlayer(
                        //                     controller: controller!,
                        //                   ),
                        //                   builder: (context, player) {
                        //                     Container(
                        //                       // height: 150,
                        //                       child: player,
                        //                     );
                        //                     return Container();
                        //                   })
                        //               : Container(),
                        //         );
                        //       },
                        //       childCount: 1, // 1000 list items
                        //     ),
                        //   ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              print(p?.authorData?.authorImg);
                              print('hhhhhhhhhhhhhh');

                              return p?.authorData != null
                                  ? ProfileCard(
                                      showCircleAvatar: true,
                                      title:
                                          '${p?.authorData?.firstName} ${p?.authorData?.lastName}',
                                      content: '${p?.authorData?.description}',
                                      image: '${p?.authorData?.authorImg}',
                                      eventId: p?.id,
                                    )
                                  : SizedBox();
                            },
                            childCount: 1, // 1000 list items
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return SizedBox(
                                height: 10,
                              );
                            },
                            childCount: 1, // 1000 list items
                          ),
                        ),
                        // SliverList(
                        //   delegate: SliverChildBuilderDelegate(
                        //     (BuildContext context, int index) {
                        //       return Container(
                        //         color: Colors.white,
                        //         padding:
                        //             const EdgeInsets.only(right: 20, top: 20),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.end,
                        //           children: [
                        //             Text(
                        //               'משתתפים מספרים',
                        //               textAlign: TextAlign.right,
                        //               style: TextStyle(
                        //                 fontSize: 22,
                        //                 color: Colors.black,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //             SizedBox(
                        //               width: 20,
                        //               child: Divider(
                        //                 thickness: 1,
                        //                 color: Colors.red,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     },
                        //     childCount: 1, // 1000 list items
                        //   ),
                        // ),

                        // StreamBuilder(
                        //   stream: streamController.stream,
                        //   builder: (BuildContext context,
                        //       AsyncSnapshot<dynamic> snapshot) {
                        //     return SliverList(
                        //       delegate: SliverChildBuilderDelegate(
                        //         (context, index) {
                        //           return _fetchEventData
                        //                       .eventData!.data!.comments !=
                        //                   null
                        //               ? CommentCard(
                        //                   image: _fetchEventData
                        //                       .eventData!
                        //                       .data!
                        //                       .comments![index]
                        //                       .commentImageAuthor,
                        //                   commentContent: _fetchEventData
                        //                       .eventData!
                        //                       .data!
                        //                       .comments![index]
                        //                       .commentContent!,
                        //                   commentDate: intl.DateFormat(
                        //                           _fetchEventData
                        //                               .eventData!
                        //                               .data!
                        //                               .comments![index]
                        //                               .commentDate)
                        //                       .format(DateTime.now()),
                        //                   commentRating: _fetchEventData
                        //                       .eventData!
                        //                       .data!
                        //                       .comments![index]
                        //                       .averageRating!,
                        //                   userEmail: widget.name,
                        //                 )
                        //               : SizedBox();
                        //         },
                        //         childCount: _fetchEventData
                        //             .eventData!.data!.comments?.length,
                        //       ),
                        //     );
                        //   },
                        // ),

                        if (isUserLogin(application.isUserLogin))
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return p?.authorData != null
                                    ? FeedbackCard(
                                        eventId: p?.id,
                                        function: () {
                                          setState(() {});
                                        },
                                      )
                                    : SizedBox();
                              },
                              childCount: 1, // 1000 list items
                            ),
                          ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return p?.authorData != null
                                  ? Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            color: Colors.white,
                                            height: 400,
                                            padding: EdgeInsets.all(10),
                                            child: GoogleMap(
                                              mapToolbarEnabled: true,
                                              gestureRecognizers: Set()
                                                ..add(Factory<
                                                        PanGestureRecognizer>(
                                                    () =>
                                                        PanGestureRecognizer())),
                                              markers: {
                                                Marker(
                                                  markerId: MarkerId('someId'),
                                                  infoWindow: InfoWindow(
                                                      title:
                                                          'google maps test2'),
                                                  icon: BitmapDescriptor
                                                      .defaultMarker,
                                                  position: LatLng(
                                                      _fetchEventData
                                                                  .eventData
                                                                  ?.data
                                                                  ?.latEvent !=
                                                              null
                                                          ? double.parse(
                                                              _fetchEventData
                                                                  .eventData!
                                                                  .data!
                                                                  .latEvent!)
                                                          : 36.4219983,
                                                      _fetchEventData
                                                                  .eventData
                                                                  ?.data
                                                                  ?.lngEvent !=
                                                              null
                                                          ? double.parse(
                                                              _fetchEventData
                                                                  .eventData!
                                                                  .data!
                                                                  .lngEvent!)
                                                          : -122.084),
                                                ),
                                              },
                                              mapType: MapType.normal,
                                              myLocationEnabled: true,
                                              initialCameraPosition:
                                                  CameraPosition(
                                                target: LatLng(
                                                    _fetchEventData
                                                                .eventData
                                                                ?.data
                                                                ?.latEvent !=
                                                            null
                                                        ? double.parse(
                                                            _fetchEventData
                                                                .eventData!
                                                                .data!
                                                                .latEvent!)
                                                        : 36.4219983,
                                                    _fetchEventData
                                                                .eventData
                                                                ?.data
                                                                ?.lngEvent !=
                                                            null
                                                        ? double.parse(
                                                            _fetchEventData
                                                                .eventData!
                                                                .data!
                                                                .lngEvent!)
                                                        : -122.084),
                                                zoom: 14,
                                              ),
                                              onMapCreated: (GoogleMapController
                                                  controller) {
                                                _mapController
                                                    .complete(controller);
                                                // print(GoogleMapController);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox();
                            },
                            childCount: 1, // 1000 list items
                          ),
                        ),
                      ],
                    );
                  } else {
                    Text('loading...');
                  }
                  return Center(
                    child: Image.asset(
                      'assets/loader/loaderNew.gif',
                      height: 45,
                      width: 45,
                    ),
                  );
                },
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
              insetPadding: EdgeInsets.zero,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Form(
                        // key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "הזמינו פעילות לקבוצה פרטית",
                                    style: ktextStyleBoldMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "מלאו את הפרטים על מנת שמעבירי הפעילות יחזרו אליכם",
                                    style: ktextStyleSmall,
                                  ),
                                ],
                              ),
                            ),
                            if (!isUserLogin(application.isUserLogin))
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: ReceivingPaymentFields(
                                  controller: fullnameController,
                                  obscureText: false,
                                  showRequired: false,
                                  hintText: 'שם מלא',
                                  textColor: Colors.grey,
                                ),
                              ),
                            if (!isUserLogin(application.isUserLogin))
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: ReceivingPaymentFields(
                                  controller: emailController,
                                  obscureText: false,
                                  showRequired: false,
                                  hintText: 'דואר אלקטרוני',
                                  textColor: Colors.grey,
                                ),
                              ),
                            CustomDropdown(
                              hintText: dateFilter == null
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'ביחרו מועד',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        dateFilter!,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                              dropdownItems: categoryList.map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                    alignment: Alignment.centerRight,
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(() {
                                  dateFilter = val as String?;
                                });
                                print('----------------$val');
                              },
                            ),
                            if (dateFilter == 'תאריך ספציפי')
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ReceivingPaymentFields(
                                  hintText: 'בחירו תאריך ספציפי',
                                  textColor: Colors.grey,
                                  obscureText: false,
                                  controller: startDateController,
                                  onTap: () async {
                                    var date = await selectDate(
                                        isDob: true, context: context);
                                    if (date != "null") {
                                      setState(() {
                                        startDateController.text =
                                            convertSingleDate(date);
                                      });
                                    }
                                  },
                                ),
                              ),
                            CustomDropdown(
                              hintText: beginningTime == null
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'שעת התחלה',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        beginningTime!,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                              dropdownItems: beginList.map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerRight,
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
                              },
                            ),
                            CustomDropdown(
                              hintText: numOfPeople == null
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'מספר משתתפים',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        numOfPeople!,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                              dropdownItems: noOfPeopleList.map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerRight,
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
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: ReceivingPaymentFields(
                                controller: mobileController,
                                obscureText: false,
                                showRequired: false,
                                hintText: 'מספר טלפון נייד',
                                textColor: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: ReceivingPaymentFields(
                                obscureText: false,
                                controller: moreDetailController,
                                showRequired: false,
                                maxLine: 4,
                                hintText: 'פרטים נוספים',
                                textColor: Colors.grey,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomButton(
                                width: 150,
                                height: 50,
                                color: MyColors.topOrange,
                                text: 'שליחת בקשה',
                                onPressed: () {
                                  _placeOrderNetwork.groupBooking(
                                      userID: LoginUser.shared?.userId! ??
                                          application.idFromLocalProvider,
                                      eventTitle: _fetchEventData
                                          .eventData?.data?.title,
                                      eventURl: _fetchEventData
                                          .eventData?.data?.shareLink,
                                      fullName: fullnameController.text,
                                      email: emailController.text,
                                      specificDate: startDateController.text);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(kLogoImage),
                      Text(
                        'הפרטים נשלחו בהצלחה. ניצור קשר בקרוב!',
                        textDirection: TextDirection.rtl,
                        style: ktextStyle,
                      ),
                    ],
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
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: const Color.fromRGBO(216, 216, 216, 1))),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            child: DropdownButton(
              alignment: Alignment.centerRight,
              isExpanded: true,
              menuMaxHeight: 300,
              hint: hintText,
              style: ktextStyle,
              items: dropdownItems,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
