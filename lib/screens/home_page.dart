import 'dart:async';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:basalon/network/get_events_network.dart';
import 'package:basalon/network/package_network.dart';
import 'package:basalon/services/constant.dart';
import 'package:basalon/services/my_color.dart';
import 'package:basalon/widgets/event_card.dart';
import 'package:basalon/widgets/filter_card_widget.dart';
import 'package:basalon/widgets/google_map.dart';
import 'package:basalon/widgets/scroll_to_hide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:translator/translator.dart';
import '../blocs/application_bloc.dart';
import '../constant/login_user.dart';
import '../network/get_update_profile_network.dart';
import '../utils/utils.dart';
import '../widgets/date_helper.dart';
import '../widgets/side_drawer.dart';
import 'activity/receiving_activity_screen.dart';
import 'package:device_id/device_id.dart';

class HomePage extends StatefulWidget {
  var categoryFilter;
  var userIdLocal;
  HomePage({this.categoryFilter});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final FetchEventData _fetchEventData = FetchEventData();
  int numOfEvents = 10;
  final ScrollController _scrollViewController =
      ScrollController(keepScrollOffset: true);
  final StreamController<bool> _appBarController = StreamController.broadcast();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool showToolBar = false;
  bool showToolBarRow = false;

  int selectFilter = 2;
  int selectFilter1 = 1;
  int selectFilter2 = 0;

  bool loading = false;
  int? radiusVal = 0;
  int page = 1;
  late double width = MediaQuery.of(context).size.width;
  final GlobalKey _contentKey = GlobalKey();
  final GlobalKey _refresherKey = GlobalKey();
  dynamic category;
  bool toggleCheck = false;

  int countCat = 0;
  bool? value = false;

  // dynamic filterCategory;
  dynamic filterByTime;
  dynamic filterByAnywhere;
  late final application = Provider.of<ApplicationBloc>(context, listen: false);
  late final FetchEventData _fetchEventDataFilter = FetchEventData(
    filterByTime: application.realValueTime,
  );
  StreamSubscription? locationSubscription;
  final UpdateAndGetUserProfile _updateAndGetUserProfile =
      UpdateAndGetUserProfile();
  bool dataIsLoading = false;

  PackageNetwork packageNetwork = PackageNetwork();

  List<dynamic> filterData = [
    'היום',
    'ב-7 ימים הקרובים',
    ' בכל זמן ',
    'תאריך מסויים',
    'סוף השבוע',
    ' מחר  ',
  ];
  List<dynamic> filterData1 = [
    'בכל מקום',
    'קרוב אליי',
    'אונליין / זום',
    'עיר מסויימת',
  ];
  String? realvalue;
  String? realvalue1;

  AppsflyerSdk? _appsflyerSdk;
  Map? _deepLinkData;
  Map? _gcd;

  @override
  void initState() {
    super.initState();
    getId();
    Future.delayed(Duration(milliseconds: 100), () {
      setLocation();
    });
    getEventData();
    LoginUser.shared?.userId != null
        ? packageNetwork.getPackage(
            LoginUser.shared?.userId! ?? application.idFromLocalProvider,
            context)
        : "";
    _scrollViewController.addListener;
    _fetchEventData.getEventCategories();
    locationSubscription = application.selectedLocation.stream.listen((place) {
      if (place != null) {
        _goToPlace(place);
      }
    });

    _updateAndGetUserProfile.getProfileData(
        LoginUser.shared?.userId! ?? application.idFromLocalProvider,
        context: context);
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

  getId() async {
    var id = await DeviceId.getID;
    print("DeviceId.getID");
    print(id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LoginUser.shared?.userId != null
        ? _updateAndGetUserProfile.getProfileData(
            LoginUser.shared?.userId! ?? application.idFromLocalProvider,
            context: context)
        : "";
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  void dispose() {
    _scrollViewController.removeListener;
    _appBarController.close();
    _scrollViewController.dispose();
    _refreshController.dispose();
    categorySearchController.dispose();
    locationController.dispose();
    // locationController.clear();
    startDateController.dispose();
    endDateController.dispose();
    // categorySearchController.dispose();
    // locationController.dispose();
    super.dispose();
  }

  void _onLoading({bool isIncrease = false}) {
    page += 1;
    getEventData();
    // if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    page = 1;
    getEventData();
    _refreshController.refreshCompleted();
  }

  Stream streamController() => Stream.fromFuture(_fetchEventData.getEventData(
      page,
      application.filterCategoryProvider,
      application.filterTimeProvider,
      application.filterAnywhereProvider,
      klatitude,
      klongitude,
      categorySearchController.text,
      startDateController.text,
      endDateController.text,
      context));
  bool showMap = false;
  bool showOnline = false;

  List dropItems = kCategoryList;
  List<bool> dropItemsHandler = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  // List dropItemsss = [];

  // List dropItems = [];
  List selectedDropItems = [];

  String? dropText;
  bool? dropTextColorHandler;
  Position? geoLoc;
  final Location location = Location();

  setLocation() async {
    PermissionStatus permissionRequestedResult =
        await location.requestPermission();
    if (permissionRequestedResult == PermissionStatus.granted) {
      geoLoc = await Geolocator.getCurrentPosition();
      klatitude = geoLoc!.latitude;
      klongitude = geoLoc!.longitude;
      application.filterAnywhereProvider = filterData1[1];
      if (mounted) {
        getEventData();
      }
    }
  }

  List snapshot = [];

  getEventData() async {
    dataIsLoading = true;
    setState(() {});
    snapshot = await _fetchEventData.getEventData(
        page,
        application.filterCategoryProvider,
        application.filterTimeProvider,
        application.filterAnywhereProvider,
        klatitude,
        klongitude,
        categorySearchController.text,
        startDateController.text,
        endDateController.text,
        context);
    dataIsLoading = false;
    setState(() {});
  }

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController categorySearchController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final translator = GoogleTranslator();
  Translation? translatedData;
  dynamic increaseHeight = 20.0;

  DateTime timeBackPressed = DateTime.now();
  String? val;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: MyColors.homeBackGroundColor,
        endDrawer: NavDrawer(
          packageID: packageNetwork.packageModel?.data?.userActivePackage?.iD,
          profileData: _updateAndGetUserProfile.getUserData,
        ),
        body: SmartRefresher(
          key: _refresherKey,
          controller: _refreshController,
          enablePullUp: true,
          enablePullDown: false,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height),
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height),
                    child: Text("No more Data"));
              } else if (mode == LoadStatus.loading) {
                body = Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height),
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height),
                    child: CupertinoActivityIndicator());
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("release to load more");
              } else {
                body = Text("No more Data");
              }
              return SizedBox(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          child: CustomScrollView(
            key: _contentKey,
            controller: _scrollViewController,
            // physics: snapshot.connectionState == ConnectionState.waiting
            //     ? NeverScrollableScrollPhysics()
            //     : null,
            slivers: [
              SliverAppBar(
                collapsedHeight: 50,
                toolbarHeight: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black,
                pinned: false,
                //expandedHeight: MediaQuery.of(context).size.height * 0.6,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    padding: EdgeInsets.only(bottom: 20),
                    // height: 450,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment(-0.1, 0.0),
                            scale: 1.0,
                            fit: BoxFit.cover,
                            image: Image.asset(
                              'assets/homePageBannerNew.jpg',
                            ).image)),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        AppBar(
                          leading: (isUserLogin(application.isUserLogin) &&
                                  application.getUserDataProfileProvider?.data
                                          ?.authorImage !=
                                      null)
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        // AssetImage(
                                        //     'assets/images/dummy_user.png'),
                                        NetworkImage(
                                      application.getUserDataProfileProvider
                                                  ?.data?.authorImage !=
                                              ''
                                          ? application
                                              .getUserDataProfileProvider
                                              ?.data
                                              ?.authorImage
                                          : application.imageFromFacebook ??
                                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                                    ),
                                    backgroundColor: Colors.grey.shade600,
                                  ),
                                )
                              : SizedBox(),
                          elevation: 0,
                          // backgroundColor: Colors.transparent,
                          backgroundColor: Colors.black.withOpacity(0),

                          title: Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 100.0,
                                    // soften the shadow
                                    spreadRadius: 10.0,
                                    //extend the shadow
                                    offset: Offset(
                                      -20.0,
                                      // Move to right 10  horizontally
                                      -30.0, // Move to bottom 10 Vertically
                                    ),
                                    blurStyle: BlurStyle.normal),
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
                                margin: const EdgeInsets.only(right: 15),
                                padding: EdgeInsets.zero,
                                child: GestureDetector(
                                    onTap: () =>
                                        Scaffold.of(context).openEndDrawer(),
                                    child: const Icon(
                                      Icons.menu,
                                      size: 40,
                                    )),
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 60),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                    children: [
                                      const Text(
                                        '?אז מה עושים היום',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(2.0, 2.0),
                                              blurRadius: 3.0,
                                            )
                                          ],
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 33.0,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'גלו סדנאות, הרצאות, הופעות,',
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.rtl,
                                        style: ktextStyleWhiteLarge.copyWith(
                                            fontSize: 19),
                                        // maxLines: 1,
                                      ),
                                      Text(
                                        ' אירוחים קולינריים ומפגשים חברתיים',
                                        textAlign: TextAlign.center,
                                        style: ktextStyleWhiteLarge.copyWith(
                                            fontSize: 19),
                                      ),
                                      Text(
                                        'בסלונים ומרחבים מסביבכם',
                                        textAlign: TextAlign.center,
                                        style: ktextStyleWhiteLarge.copyWith(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w900),
                                        // maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                // application.filterAnywhereProvider ==
                                //         'עיר מסויימת'
                                //     ? Padding(
                                //         padding: const EdgeInsets.symmetric(
                                //             horizontal: 18),
                                //         child: Directionality(
                                //           textDirection: TextDirection.rtl,
                                //           child: ReceivingPaymentFields(
                                //             isFocus: true,
                                //             textColorPrimary: Colors.white,
                                //             maxLine: 1,
                                //             showRequired: false,
                                //             showLabel: false,
                                //             controller: locationController,
                                //             onChange: (v) {
                                //               application.searchPlaces(v);
                                //               print('eeeeeeeeeeeeeeee$v');
                                //               setState(() {});
                                //             },
                                //             onFieldSubmit: (v) {
                                //               application.searchPlaces(v);
                                //               print('eeeeeeeeeeeeeeee$v');
                                //             },
                                //             textColor: Colors.white,
                                //             colors: MyColors.dropdownColor,
                                //             obscureText: false,
                                //             hintText: 'הקלד/י עיר',
                                //             suffixIcon: IconButton(
                                //               icon: const Icon(
                                //                 Icons.close,
                                //                 color: Colors.white,
                                //               ),
                                //               onPressed: () {
                                //                 setState(() {
                                //                   application
                                //                           .filterAnywhereProvider =
                                //                       null;
                                //                   locationController
                                //                       .clear();
                                //                 });
                                //               },
                                //             ),
                                //           ),
                                //         ),
                                //       )
                                //     : DropButtonEverywhere(
                                //         coordinates: geoLoc,
                                //         text1: 'איפה?',
                                //         text2: 'בכל מקום',
                                //         onChanged: (value) {
                                //           print(
                                //               'value from value from value from value from ');
                                //           print(value);
                                //           setState(() {
                                //             application
                                //                     .filterAnywhereProvider =
                                //                 value.toString().replaceAll(
                                //                     'אונליין / זום',
                                //                     'online');
                                //             application.showOnline =
                                //                 !showOnline;
                                //             page = 1;
                                //           });
                                //           if (value == 'בכל מקום') {
                                //             print(
                                //                 'chli kya condition ??????????/');
                                //             setState(() {
                                //               application
                                //                   .filterCategoryProvider = '';
                                //               // application.filterTimeProvider =
                                //               //     '';
                                //               application
                                //                       .filterAnywhereProvider =
                                //                   'בכל מקום';
                                //               categorySearchController
                                //                   .text = '';
                                //               endDateController.text = '';
                                //               startDateController.text = '';
                                //               klatitude = null;
                                //               klongitude = null;
                                //               page = 1;
                                //             });
                                //           }
                                //           if (value == 'קרוב אליי') {
                                //             klatitude = null;
                                //             klongitude = null;
                                //           }
                                //           if (value == "עיר מסויימת") {
                                //             // application.filterAnywhereProvider = "start-date";
                                //             //
                                //           }
                                //         },
                                //       ),

                                // SizedBox(height: increaseHeight),
                                // DropButton1(
                                //   text1: 'מתי?',
                                //   text2: 'ב-7 ימים הקרובים',
                                //   onChanged: (v) {
                                //     print(v);
                                //     print(
                                //         'ffffffffffffffffffffffffffffffffff');

                                //     setState(() {
                                //       application.filterTimeProvider = v;
                                //       page = 1;
                                //     });
                                //     print(
                                //         'filterByTime filterByTime filterByTime filterByTime');
                                //     print(v);
                                //   },
                                // ),
                                // SizedBox(height: 10),
                                // if (application.filterTimeProvider ==
                                //     'specific_date')
                                //   Directionality(
                                //     textDirection: TextDirection.rtl,
                                //     child: Padding(
                                //       padding:
                                //           const EdgeInsets.only(right: 18),
                                //       child: Row(
                                //         children: [
                                //           ReceivingPaymentFields(
                                //             hintText: 'החל מתאריך...',
                                //             textColor: Colors.white,
                                //             width: 130,
                                //             textColorPrimary: Colors.white,
                                //             colors: MyColors.dropdownColor,
                                //             obscureText: false,
                                //             controller: startDateController,
                                //             onTap: () async {
                                //               var date = await selectDate(
                                //                   isDob: true,
                                //                   context: context);
                                //               if (date != "null") {
                                //                 setState(() {
                                //                   startDateController.text =
                                //                       convertSingleDate(
                                //                           date);
                                //                 });
                                //               }
                                //             },
                                //           ),
                                //           SizedBox(width: 10),
                                //           ReceivingPaymentFields(
                                //             textColor: Colors.white,
                                //             hintText: 'עד תאריך...',
                                //             width: 130,
                                //             textColorPrimary: Colors.white,
                                //             colors: MyColors.dropdownColor,
                                //             obscureText: false,
                                //             controller: endDateController,
                                //             onTap: () async {
                                //               var date = await selectDate(
                                //                   isDob: true,
                                //                   context: context);
                                //               if (date != "null") {
                                //                 setState(() {
                                //                   endDateController.text =
                                //                       convertSingleDate(
                                //                           date);
                                //                 });
                                //               }
                                //             },
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // SizedBox(height: 10),
                                // DropdownCategories(
                                //   categories: _fetchEventData
                                //       .filterCategoryModel?.data,
                                //   text1: 'מה?',
                                //   text2: 'כל החוויות',
                                //   onChanged: (value) {
                                //     setState(() {
                                //       application.filterCategoryProvider =
                                //           value;
                                //     });
                                //   },
                                // ),
                                // GestureDetector(
                                //   onTap: () {
                                //     setState(() {
                                //       showToolBar = !showToolBar;
                                //     });
                                //   },
                                //   child: Container(
                                //     alignment: Alignment.centerLeft,
                                //     margin: const EdgeInsets.symmetric(
                                //         horizontal: 20),
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: 10),
                                //     color: MyColors.dropdownColor,
                                //     height: 50,
                                //     width: double.infinity,
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Icon(
                                //           Icons.arrow_drop_down,
                                //           color: Colors.white,
                                //         ),
                                //         // Text(
                                //         //   'מה? \n ${dropText != null ? dropText : '${selectedDropItems.length != 0 ? selectedDropItems.length : ''} כל החוויות'} ',
                                //         //   textDirection: TextDirection.rtl,
                                //         //   style: ktextStyleSmallWhite,
                                //         // ),
                                //         RichText(
                                //           textDirection: TextDirection.rtl,
                                //           text: TextSpan(
                                //             text: 'מה?\n',
                                //             style: ktextStyleSmallWhite,
                                //             children: [
                                //               TextSpan(
                                //                   text:
                                //                       '${selectedDropItems.isNotEmpty ? selectedDropItems.length : ''} ',
                                //                   style: ktextStyleWhite),
                                //               TextSpan(
                                //                 text: selectedDropItems
                                //                         .isEmpty
                                //                     ? 'כל החוויות'
                                //                     : 'נבחרו',
                                //                 style: ktextStyleWhite,
                                //               ),
                                //             ],
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ],
                        ),
                        if (application.searchResult != null &&
                            application.searchResult?.length != 0 &&
                            application.filterAnywhereProvider ==
                                'עיר מסויימת' &&
                            locationController.text.isNotEmpty)
                          Positioned(
                            top: 250,
                            right: 0,
                            left: 0,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey,
                                //     blurRadius: 15.0,
                                //     // soften the shadow
                                //     spreadRadius: 0.1,
                                //     //extend the shadow
                                ///     offset: Offset(
                                //       15.icon
                                //       // Move to right 10  horizontally
                                //       15.0, // Move to bottom 10 Vertically
                                //     ),
                                //   )
                                // ],
                              ),
                              height: 190,
                              // width: double.infinity,
                              child: ListView.separated(
                                  padding: const EdgeInsets.all(0),
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                        color: Colors.grey,
                                      ),
                                  itemCount: application.searchResult!.length,
                                  itemBuilder: (context, index) {
                                    // translator
                                    //     .translate(
                                    //     application.searchResult?[index]
                                    //         .description,
                                    //     to: 'iw')
                                    //     .then((value) {
                                    //   translatedData = value;
                                    // });
                                    return ListTile(
                                      visualDensity: VisualDensity.compact,
                                      dense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                      trailing: Icon(Icons.location_on),
                                      onTap: () async {
                                        locationController.text =
                                            // translatedData!.text;
                                            application.searchResult?[index]
                                                .description;
                                        application.setSelectedLocation(
                                            application
                                                .searchResult![index].placeId,
                                            context);
                                        getEventData();
                                      },
                                      title: application.searchResult?[index]
                                                  .description ==
                                              null
                                          ? CupertinoActivityIndicator()
                                          : Text(
                                              "${application.searchResult?[index].description}",
                                              // "${translatedData?.text}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 11),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.start,
                                            ),
                                    );
                                  }),
                            ),
                          ),
                        // if (showToolBar)
                        //   Positioned(
                        //       top: 80,
                        //       right: 0,
                        //       left: 0,
                        //       child: Container(
                        //         margin: const EdgeInsets.symmetric(
                        //           horizontal: 20,
                        //         ),
                        //         padding: EdgeInsets.only(top: 10),
                        //         width: MediaQuery.of(context).size.width,
                        //         color: Colors.white,
                        //         child: Column(
                        //           children: [
                        //             Container(
                        //               margin: EdgeInsets.all(10),
                        //               padding: EdgeInsets.zero,
                        //               child: const Text(
                        //                 'ניתן לבחור יותר מקטגוריה אחת',
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //             ),
                        //             Container(
                        //               height: 330,
                        //               child: ListView.builder(
                        //                 padding: EdgeInsets.zero,
                        //                 shrinkWrap: true,
                        //                 physics:
                        //                     NeverScrollableScrollPhysics(),
                        //                 itemBuilder: (context, index) {
                        //                   return Container(
                        //                     color:
                        //                         dropItemsHandler[index] ==
                        //                                 true
                        //                             ? MyColors.topOrange
                        //                             : Colors.white,
                        //                     child: CheckboxListTile(
                        //                       selectedTileColor: Colors.red,
                        //                       selected:
                        //                           dropItemsHandler[index],
                        //                       side: BorderSide(
                        //                         width: 0.5,
                        //                         color: Colors.grey,
                        //                       ),
                        //                       visualDensity:
                        //                           VisualDensity.lerp(
                        //                               VisualDensity.compact,
                        //                               VisualDensity.compact,
                        //                               0.0),
                        //                       contentPadding:
                        //                           EdgeInsets.zero,
                        //                       dense: true,
                        //                       activeColor:
                        //                           MyColors.topOrange,
                        //                       value: selectedDropItems
                        //                           .toString()
                        //                           .toLowerCase()
                        //                           .contains(
                        //                               '${dropItems[index].toString().toLowerCase()}'),
                        //                       onChanged: (value) {
                        //                         dropTextColorHandler =
                        //                             value;
                        //                         dropItemsHandler[index] =
                        //                             value!;
                        //                         print(value);
                        //                         setState(() {
                        //                           if (value == true) {
                        //                             selectedDropItems.add(
                        //                                 dropItems[index]);
                        //                             String realValue = selectedDropItems
                        //                                 .toString()
                        //                                 .replaceAll('[', '')
                        //                                 .replaceAll(']', '')
                        //                                 .replaceAll(
                        //                                     ', ', ',')
                        //                                 .replaceAll(
                        //                                     'הרצאה', 'lecture')
                        //                                 .replaceAll(
                        //                                     'אירוח קולינרי',
                        //                                     'meals')
                        //                                 .replaceAll(
                        //                                     'הופעה/מופע', 'show')
                        //                                 .replaceAll(
                        //                                     'מפגש חברתי',
                        //                                     'group')
                        //                                 .replaceAll(
                        //                                     'סדנת בישול/אפיה', 'food')
                        //                                 .replaceAll(
                        //                                     'סדנת גוף/נפש',
                        //                                     'body-mind')
                        //                                 .replaceAll(
                        //                                     'סדנת יצירה',
                        //                                     'workshop')
                        //                                 .replaceAll(
                        //                                     'פעילות לילדים',
                        //                                     'kids');
                        //                             application
                        //                                     .filterCategoryProvider =
                        //                                 realValue;

                        //                             print(
                        //                                 '----------------------------------------');
                        //                             print(selectedDropItems
                        //                                 .length);
                        //                             print(selectedDropItems
                        //                                 .toString()
                        //                                 .replaceAll('[', '')
                        //                                 .replaceAll(']', '')
                        //                                 .replaceAll(
                        //                                     ', ', ','));
                        //                           } else {
                        //                             print(
                        //                                 'elseeeeeeeeeeeeeee');
                        //                             // print(e);
                        //                             selectedDropItems
                        //                                 .remove(dropItems[
                        //                                     index]);
                        //                             print(selectedDropItems
                        //                                 .length);
                        //                             String realValue = selectedDropItems
                        //                                 .toString()
                        //                                 .replaceAll('[', '')
                        //                                 .replaceAll(']', '')
                        //                                 .replaceAll(
                        //                                     ', ', ',')
                        //                                 .replaceAll(
                        //                                     'הרצאה', 'lecture')
                        //                                 .replaceAll(
                        //                                     'אירוח קולינרי',
                        //                                     'meals')
                        //                                 .replaceAll(
                        //                                     'הופעה/מופע', 'show')
                        //                                 .replaceAll(
                        //                                     'מפגש חברתי',
                        //                                     'group')
                        //                                 .replaceAll(
                        //                                     'סדנת בישול/אפיה', 'food')
                        //                                 .replaceAll(
                        //                                     'סדנת גוף/נפש',
                        //                                     'body-mind')
                        //                                 .replaceAll(
                        //                                     'סדנת יצירה',
                        //                                     'workshop')
                        //                                 .replaceAll(
                        //                                     'פעילות לילדים',
                        //                                     'kids');
                        //                             print(
                        //                                 'realValue realValue realValue realValue');
                        //                             print(realValue);
                        //                             application
                        //                                     .filterCategoryProvider =
                        //                                 realValue;
                        //                           }
                        //                         });
                        //                       },
                        //                       title: Transform.translate(
                        //                         offset: Offset(20, 0),
                        //                         child: Text(
                        //                           '${dropItems[index]}',
                        //                           textDirection:
                        //                               TextDirection.rtl,
                        //                           style: dropItemsHandler[
                        //                                       index] ==
                        //                                   true
                        //                               ? ktextStyleWhite
                        //                               : ktextStyle,

                        //                           // TextStyle(
                        //                           //     color: textColor,
                        //                           //     fontSize: 16),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   );
                        //                 },
                        //                 itemCount: dropItems.length,
                        //               ),
                        //             ),
                        //             Directionality(
                        //               textDirection: TextDirection.rtl,
                        //               child: Align(
                        //                 alignment: Alignment.centerRight,
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.only(
                        //                       right: 30),
                        //                   child: ReceivingPaymentFields(
                        //                     controller:
                        //                         categorySearchController,
                        //                     obscureText: false,`
                        //                     width: width / 2,
                        //                     hintText: 'חיפוש חופשי',
                        //                     textColor: Colors.grey,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             SizedBox(
                        //               height: 10,
                        //             ),
                        //             CustomButton(
                        //                 text: 'סיימתי, תראו לי מה יש לכם',
                        //                 onPressed: () {
                        //                   setState(() {
                        //                     showToolBar = !showToolBar;
                        //                     page = 1;
                        //                     filterByAnywhere = "";
                        //                   });
                        //                 },
                        //                 color: MyColors.dropdownColor),
                        //             SizedBox(
                        //               height: 10,
                        //             )
                        //           ],
                        //         ),
                        //       )),
                        if (application.searchResult != null &&
                            application.searchResult?.length != 0 &&
                            application.filterAnywhereProvider ==
                                'עיר מסויימת' &&
                            locationController.text.isNotEmpty)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 15.0,
                                  // soften the shadow
                                  spreadRadius: 1.0,
                                  //extend the shadow
                                  offset: Offset(
                                    15.0,
                                    // Move to right 10  horizontally
                                    15.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                            height: 150,
                            // width: double.infinity,

                            child: ListView.separated(
                                padding: const EdgeInsets.all(0),
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                itemCount: application.searchResult!.length,
                                itemBuilder: (context, index) {
                                  translator
                                      .translate(
                                          application
                                              .searchResult?[index].description,
                                          to: 'iw')
                                      .then((value) {
                                    translatedData = value;
                                  });

                                  return ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    trailing: Icon(Icons.location_on),
                                    onTap: () async {
                                      locationController.text = application
                                          .searchResult?[index].description;
                                      application.setSelectedLocation(
                                          application
                                              .searchResult![index].placeId,
                                          context);
                                      getEventData();
                                    },
                                    title: translatedData == null
                                        ? CupertinoActivityIndicator()
                                        : Text(
                                            "${application.searchResult?[index].description}",
                                            // "$translatedData",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 11),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.start,
                                          ),
                                  );
                                }),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(0.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 15,
                      ),
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                ' 1. איפה תרצו',
                                style: TextStyle(
                                  fontFamily: "Helvetica",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          GridView.builder(
                              physics: ScrollPhysics(),
                              itemCount: filterData1.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5,
                                      // mainAxisSpacing: 5,
                                      mainAxisExtent: 50,
                                      childAspectRatio: 1),
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    debugPrint("filter 1.0");

                                    selectFilter1 = index;
                                    application.filterAnywhereProvider =
                                        filterData1[index].replaceAll(
                                            'אונליין / זום', 'online');
                                    application.showOnline = !showOnline;
                                    page = 1;

                                    if (filterData1[index] == 'בכל מקום') {
                                      debugPrint("filter 1.1");
                                      application.filterCategoryProvider = '';
                                      // application.filterTimeProvider =
                                      //     '';
                                      application.filterAnywhereProvider =
                                          'בכל מקום';

                                      categorySearchController.text = '';
                                      endDateController.text = '';
                                      startDateController.text = '';
                                      klatitude = null;
                                      klongitude = null;
                                      page = 1;
                                    }
                                    if (filterData1[index] == 'קרוב אליי') {
                                      application.filterAnywhereProvider =
                                          'קרוב אליי';
                                      debugPrint("filter 1.2");
                                      debugPrint("print location near");
                                      debugPrint("${geoLoc}");
                                      debugPrint("${geoLoc!.latitude}");
                                      debugPrint("${geoLoc!.longitude}");
                                      debugPrint("location near");
                                      klatitude = geoLoc!.latitude;
                                      klongitude = geoLoc!.longitude;
                                    }
                                    setState(() {});
                                    getEventData();
                                  },
                                  child: filterData1[index] == 'עיר מסויימת'
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 00),
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: ReceivingPaymentFields(
                                              fillcolor: MyColors.lightBlue,
                                              isFocus: true,
                                              textColorPrimary: Colors.white,
                                              maxLine: 1,
                                              showRequired: false,
                                              isBorder: true,
                                              showLabel: false,
                                              controller: locationController,
                                              onChange: (v) {
                                                application.searchPlaces(
                                                    locationController.text);
                                                getEventData();
                                              },
                                              onTap: () {
                                                application
                                                        .filterAnywhereProvider =
                                                    'עיר מסויימת';
                                                getEventData();
                                              },
                                              // onChange: (v) {
                                              //   locationController.text = v;
                                              //   application.searchPlaces(v);
                                              //   print('eeeeeeeeeeeeeeee$v');
                                              //   setState(() {});
                                              // },
                                              // onFieldSubmit: (v) {
                                              //   locationController.text = v;

                                              //   application.searchPlaces(v);
                                              //   print('eeeeeeeeeeeeeeee$v');
                                              // },
                                              textColor: Colors.white,
                                              obscureText: false,
                                              hintText: 'הקלד/י עיר',
                                              // suffixIcon: IconButton(
                                              //   icon: const Icon(
                                              //     Icons.close,
                                              //     color: Colors.white,
                                              //   ),
                                              //   onPressed: () {
                                              //     setState(() {
                                              //       application
                                              //               .filterAnywhereProvider =
                                              //           null;
                                              //       locationController
                                              //           .clear();
                                              //     });
                                              //   },
                                              // ),
                                            ),
                                          ),
                                        )
                                      : Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: FilterCardWidget(
                                            fontsize: 15,
                                            text: filterData1[index],
                                            color: selectFilter1 == index
                                                ? MyColors.lightRed
                                                : MyColors.lightBlue,
                                          ),
                                        ),
                                );
                              }),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                '2. מתי זה קורה?',
                                style: TextStyle(
                                  fontFamily: "Helvetica",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 5,
                            runSpacing: 8,
                            children: List.generate(
                              filterData.length,
                              (index) => InkWell(
                                onTap: () {
                                  selectFilter = index;
                                  application.filterTimeProvider =
                                      filterData[index];

                                  realvalue = application.filterTimeProvider!
                                      .replaceAll(
                                          'ב-7 ימים הקרובים', 'this_week')
                                      .replaceAll('היום', 'today')
                                      .replaceAll('מחר', 'tomorrow')
                                      .replaceAll('בכל זמן', 'this_week_end')
                                      .replaceAll('בשבוע הבא', 'next_week')
                                      .replaceFirst(
                                          'תאריך מסויים', 'specific_date');

                                  page = 1;
                                  application.filterTimeProvider = realvalue;
                                  setState(() {});
                                  getEventData();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: selectFilter == index
                                        ? MyColors.lightRed
                                        : MyColors.lightBlue,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Text(
                                    filterData[index].toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Helvetica",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // GridView.builder(
                          //   physics: ScrollPhysics(),
                          //   itemCount: filterData.length,
                          //   itemBuilder: (BuildContext context, int index) {
                          //     return InkWell(
                          //       onTap: () {
                          //         print(filterData[index]);
                          //         print('filterData');
                          //         setState(() {
                          //           selectFilter = index;
                          //           application.filterTimeProvider =
                          //               filterData[index];

                          //           print(application.filterTimeProvider);
                          //           print('application');

                          //           realvalue = application
                          //               .filterTimeProvider!
                          //               .replaceAll(
                          //                   'ב-7 ימים הקרובים', 'this_week')
                          //               .replaceAll('היום', 'today')
                          //               .replaceAll('מחר', 'tomorrow')
                          //               .replaceAll(
                          //                   'סוף השבוע', 'this_week_end')
                          //               .replaceAll(
                          //                   'בשבוע הבא', 'next_week')
                          //               .replaceFirst('תאריך מסויים',
                          //                   'specific_date');

                          //           page = 1;
                          //         });

                          //         application.filterTimeProvider =
                          //             realvalue;

                          //         _fetchEventDataFilter.getEventData(
                          //             1,
                          //             '',
                          //             realvalue,
                          //             '',
                          //             '',
                          //             '',
                          //             '',
                          //             '',
                          //             '',
                          //             context);

                          //         print(application.filterTimeProvider);

                          //         print("qwerty$realvalue");

                          //         // application.filterTimeProvider = realvalue;

                          //         print(realvalue);
                          //       },
                          //       child: Directionality(
                          //         textDirection: TextDirection.rtl,
                          //         child: FilterCardWidget(
                          //           fontsize: 15,
                          //           text: filterData[index],
                          //           color: selectFilter == index
                          //               ? MyColors.lightRed
                          //               : MyColors.lightBlue,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   gridDelegate:
                          //       SliverGridDelegateWithFixedCrossAxisCount(
                          //           crossAxisCount: 3,
                          //           crossAxisSpacing: 5,
                          //           // mainAxisSpacing: 5,
                          //           mainAxisExtent: 50,
                          //           childAspectRatio: 1),
                          //   padding: EdgeInsets.symmetric(horizontal: 10),
                          //   shrinkWrap: true,
                          // ),

                          if (application.filterTimeProvider == 'specific_date')
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 18, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ReceivingPaymentFields(
                                      fillcolor: MyColors.lightBlue,
                                      hintText: 'החל מתאריך...',
                                      textColor: Colors.white,
                                      width: 130,
                                      textColorPrimary: Colors.white,
                                      obscureText: false,
                                      controller: startDateController,
                                      onTap: () async {
                                        var date = await selectDate(
                                            isDob: true, context: context);
                                        if (date != "null") {
                                          startDateController.text =
                                              convertSingleDate(date);
                                          getEventData();
                                        }
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    ReceivingPaymentFields(
                                      fillcolor: MyColors.lightBlue,
                                      textColor: Colors.white,
                                      hintText: 'עד תאריך...',
                                      width: 130,
                                      textColorPrimary: Colors.white,
                                      obscureText: false,
                                      controller: endDateController,
                                      onTap: () async {
                                        var date = await selectDate(
                                            isDob: true, context: context);
                                        if (date != "null") {
                                          endDateController.text =
                                              convertSingleDate(date);
                                          getEventData();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Column(
                                children: [
                                  Text(
                                    '3. מה בתכנון?',
                                    style: TextStyle(
                                      fontFamily: "Helvetica",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    '(ניתן לבחור ביותר מקטגורייה אחת)',
                                    style: TextStyle(
                                      fontFamily: "Helvetica",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // if (showToolBar)
                          GridView.builder(
                            physics: ScrollPhysics(),
                            itemCount: dropItems.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    // mainAxisSpacing: 5,
                                    mainAxisExtent: 50,
                                    childAspectRatio: 1),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  // setState(() {
                                  //   value = !value!;
                                  //   dropItemsHandler[index] = value!;
                                  // });
                                  page = 1;

                                  value = !value!;
                                  dropItemsHandler[index] = value!;
                                  if (!selectedDropItems
                                      .contains(dropItems[index])) {
                                    selectedDropItems.insert(
                                        0, dropItems[index]);
                                    setState(() {});

                                    String realValue = selectedDropItems
                                        .toString()
                                        .replaceAll('[', '')
                                        .replaceAll(']', '')
                                        .replaceAll(', ', ',')
                                        .replaceAll('הרצאה', 'lecture')
                                        .replaceAll('אירוח קולינרי', 'meals')
                                        .replaceAll('הופעה/מופע', 'show')
                                        .replaceAll('הופעה', 'show')
                                        .replaceAll('מפגש חברתי', 'group')
                                        .replaceAll('סדנת בישול/אפיה', 'food')
                                        .replaceAll('סדנת בישול', 'food')
                                        .replaceAll('סדנת גוף/נפש', 'body-mind')
                                        .replaceAll('סדנת יצירה', 'workshop')
                                        .replaceAll('פעילות לילדים', 'kids');

                                    application.filterCategoryProvider =
                                        realValue;
                                    // await _fetchEventDataFilter
                                    //     .getEventData(1, realValue, '', '',
                                    //         '', '', '', '', '', context);
                                  } else {
                                    selectedDropItems.remove(dropItems[index]);
                                    String realValue = selectedDropItems
                                        .toString()
                                        .replaceAll('[', '')
                                        .replaceAll(']', '')
                                        .replaceAll(', ', ',')
                                        .replaceAll('הרצאה', 'lecture')
                                        .replaceAll('אירוח קולינרי', 'meals')
                                        .replaceAll('הופעה/מופע', 'show')
                                        .replaceAll('הופעה', 'show')
                                        .replaceAll('מפגש חברתי', 'group')
                                        .replaceAll('סדנת בישול/אפיה', 'food')
                                        .replaceAll('סדנת בישול', 'food')
                                        .replaceAll('סדנת גוף/נפש', 'body-mind')
                                        .replaceAll('סדנת יצירה', 'workshop')
                                        .replaceAll('פעילות לילדים', 'kids');

                                    application.filterCategoryProvider =
                                        realValue;
                                    // await _fetchEventDataFilter
                                    //     .getEventData(1, realValue, '', '',
                                    //         '', '', '', '', '', context);
                                  }
                                  setState(() {});
                                  getEventData();
                                  // print(value);
                                  // setState(() {
                                  //   selectFilter2 = index;

                                  //   application.filterCategoryProvider =
                                  //       dropItems[index];
                                  //   String realValue = application
                                  //       .filterCategoryProvider
                                  //       .replaceAll('[', '')
                                  //       .replaceAll(']', '')
                                  //       .replaceAll(', ', ',')
                                  //       .replaceAll('הרצאה', 'lecture')
                                  //       .replaceAll(
                                  //           'אירוח קולינרי', 'meals')
                                  //       .replaceAll('הופעה/מופע', 'show')
                                  //       .replaceAll('מפגש חברתי', 'group')
                                  //       .replaceAll(
                                  //           'סדנת בישול/אפיה', 'food')
                                  //       .replaceAll(
                                  //           'סדנת גוף/נפש', 'body-mind')
                                  //       .replaceAll(
                                  //           'סדנת יצירה', 'workshop')
                                  //       .replaceAll(
                                  //           'פעילות לילדים', 'kids');

                                  //   page = 1;

                                  //   application.filterCategoryProvider =
                                  //       realValue;

                                  //   print(
                                  //       '----------------------------------------');
                                  //   print(selectedDropItems.length);
                                  //   print(selectedDropItems
                                  //       .toString()
                                  //       .replaceAll('[', '')
                                  //       .replaceAll(']', '')
                                  //       .replaceAll(', ', ','));

                                  //   _fetchEventDataFilter.getEventData(
                                  //       1,
                                  //       '',
                                  //       '',
                                  //       realvalue,
                                  //       '',
                                  //       '',
                                  //       '',
                                  //       '',
                                  //       '',
                                  //       context);

                                  //   // } else {
                                  //   //   print('elseeeeeeeeeeeeeee');
                                  //   //   // print(e);
                                  //   //   selectedDropItems
                                  //   //       .remove(dropItems[index]);
                                  //   //   print(selectedDropItems.length);
                                  //   //   String realValue = selectedDropItems
                                  //   //       .toString()
                                  //   //       .replaceAll('[', '')
                                  //   //       .replaceAll(']', '')
                                  //   //       .replaceAll(', ', ',')
                                  //   //       .replaceAll('הרצאה', 'lecture')
                                  //   //       .replaceAll(
                                  //   //           'אירוח קולינרי', 'meals')
                                  //   //       .replaceAll('הופעה/מופע', 'show')
                                  //   //       .replaceAll('מפגש חברתי', 'group')
                                  //   //       .replaceAll(
                                  //   //           'סדנת בישול/אפיה', 'food')
                                  //   //       .replaceAll(
                                  //   //           'סדנת גוף/נפש', 'body-mind')
                                  //   //       .replaceAll(
                                  //   //           'סדנת יצירה', 'workshop')
                                  //   //       .replaceAll(
                                  //   //           'פעילות לילדים', 'kids');
                                  //   //   print(
                                  //   //       'realValue realValue realValue realValue');
                                  //   //   print(realValue);
                                  //   //   application.filterCategoryProvider =
                                  //   //       realValue;
                                  //   // }
                                  // });
                                },
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: dropItems[index] == 'חיפוש חופשי'
                                      ? Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              child: ReceivingPaymentFields(
                                                onTap: () {},
                                                fillcolor: MyColors.lightBlue,
                                                controller:
                                                    categorySearchController,
                                                obscureText: false,
                                                width: width / 2,
                                                hintText: 'חיפוש חופשי',
                                                textColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: FilterCardWidget(
                                            fontsize: 15,
                                            text: dropItems[index],
                                            color: selectedDropItems
                                                    .contains(dropItems[index])
                                                ? MyColors.lightRed
                                                : MyColors.lightBlue,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),

              // SliverList(
              //   delegate: SliverChildBuilderDelegate(
              //     (BuildContext context, int index) {
              //       print('ttttttttttttttttttttttttttttttttttttt');
              //       return InkWell(
              //           onTap: () {
              //             setState(() {
              //               application.filterTimeProvider =
              //                   filterData[index];

              //               realvalue = application.filterTimeProvider;
              //               realvalue!
              //                   .replaceAll('ב-7 ימים הקרובים', 'this_week')
              //                   .replaceAll('היום', 'today')
              //                   .replaceAll('מחר', 'tomorrow')
              //                   .replaceAll('סוף השבוע', 'this_week_end')
              //                   .replaceAll('בשבוע הבא', 'next_week')
              //                   .replaceFirst(
              //                       'תאריך מסויים', 'specific_date');
              //               _fetchEventDataFilter.getEventData(1, '',
              //                   realvalue, '', '', '', '', '', '', context);

              //               print("qwerty$realvalue");

              //               application.filterTimeProvider = realvalue;

              //               // page = 1;
              //             });
              //           },
              //           child: GridView(
              //             gridDelegate:
              //                 SliverGridDelegateWithMaxCrossAxisExtent(
              //               // crossAxisCount: 2,
              //               maxCrossAxisExtent: 150,
              //               mainAxisExtent: 50,
              //               // crossAxisSpacing: 5,
              //               // mainAxisSpacing: 5,
              //             ),
              //             children: [
              //               Container(
              //                 // width: 150,
              //                 // margin: EdgeInsets.symmetric(
              //                 //     horizontal: 10, vertical: 4),
              //                 child: Text(
              //                   filterData[index],
              //                 ),
              //                 decoration: BoxDecoration(
              //                   color: countCat == index
              //                       ? Colors.blue
              //                       : Colors.amber,
              //                   borderRadius: BorderRadius.circular(12),
              //                 ),
              //                 padding: EdgeInsets.symmetric(
              //                     horizontal: 15, vertical: 5),
              //               ),
              //             ],
              //             // padding: EdgeInsets.all(10),
              //             shrinkWrap: true,
              //           ));
              //     },
              //     childCount: filterData.length, // 1000 list items
              //   ),
              // ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SizedBox(
                      height: 20,
                    );
                  },
                  childCount: 1, // 1000 list items
                ),
              ),
              // SliverList(
              //   delegate: SliverChildBuilderDelegate(
              //     (BuildContext context, int index) {
              //       return Container(
              //         margin: const EdgeInsets.symmetric(horizontal: 30.0),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           children: [
              //             Text(
              //               'רדיוס: ${radiusVal} ק"מ',
              //               // 'Radius: ${radiusVal}km',
              //               style: const TextStyle(
              //                 fontSize: 15,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             AdvancedSeekBar(
              //               Colors.grey,
              //               15,
              //               MyColors.topOrange,
              //               lineHeight: 3,
              //               defaultProgress: 50,
              //               scaleWhileDrag: true,
              //               // percentSplit: 10,
              //               percentSplitColor: MyColors.homeBackGroundColor,
              //               percentSplitWidth: 1,
              //               seekBarStarted: () {},
              //               seekBarProgress: (v) {},
              //               seekBarFinished: (v) {
              //                 print(v);
              //                 setState(() {
              //                   radiusVal = v;
              //                 });
              //               },
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //     childCount: 1, // 1000 list items
              //   ),
              // ),
              if (dataIsLoading)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Center(
                        child: Image.asset(
                          'assets/loader/loaderNew.gif',
                          height: 50,
                          width: 50,
                        ),
                      );
                    },
                    childCount: 1,
                  ),
                ),
              if (snapshot.length != 0 && page >= 1)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      // final items = _fetchEventData.data;
                      if (snapshot.length == 0) {
                        return Text('data');
                      } else {
                        return EventCard(
                          datum: snapshot[index],
                          email: _updateAndGetUserProfile
                              .getUserData?.data?.authorEmail,
                          name: _updateAndGetUserProfile
                              .getUserData?.data?.displayName,
                        );
                      }
                    },
                    childCount: snapshot.length,
                  ),
                ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  childCount: 1, // 1000 list items
                ),
              ),
            ],
          ),
        ),

        // return Center(child: Text('Loading...'));
        // },
        // ),
        // bottomNavigationBar: Stack(
        //   alignment: Alignment.bottomLeft,
        //   // mainAxisAlignment: MainAxisAlignment.end,
        //   // crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     if (showToolBarRow)
        //       Container(
        //         // height: 350,
        //         margin: EdgeInsets.only(bottom: 60),
        //         padding: EdgeInsets.only(top: 15),
        //         width: 250,
        //         color: Colors.white,
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Text(
        //               'ניתן לבחור יותר מקטגוריה אחת',
        //               style:
        //                   TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        //             ),
        //             Column(children: [
        //               ListView.builder(
        //                 itemBuilder: (context, index) {
        //                   return Container(
        //                     color: dropItemsHandler[index] == true
        //                         ? MyColors.topOrange
        //                         : Colors.white,
        //                     margin: EdgeInsets.only(bottom: 2),
        //                     child: CheckboxListTile(
        //                       selectedTileColor: Colors.red,
        //                       selected: dropItemsHandler[index],
        //                       side: BorderSide(
        //                         width: 0.5,
        //                         color: Colors.grey,
        //                       ),
        //                       visualDensity: VisualDensity.lerp(
        //                           VisualDensity.compact,
        //                           VisualDensity.compact,
        //                           0.0),
        //                       contentPadding: EdgeInsets.zero,
        //                       dense: true,
        //                       activeColor: MyColors.topOrange,
        //                       value: selectedDropItems
        //                           .toString()
        //                           .toLowerCase()
        //                           .contains(
        //                               '${dropItems[index].toString().toLowerCase()}'),
        //                       onChanged: (value) {
        //                         dropTextColorHandler = value;
        //                         dropItemsHandler[index] = value!;
        //                         print(value);
        //                         setState(() {
        //                           if (value == true) {
        //                             print('iffffffffffffff');
        //                             // print(selectedDropItems
        //                             //     .indexOf(e));

        //                             // print(e);
        //                             // dropText = e;

        //                             selectedDropItems.add(dropItems[index]);
        //                             String realValue = selectedDropItems
        //                                 .toString()
        //                                 .replaceAll('[', '')
        //                                 .replaceAll(']', '')
        //                                 .replaceAll(', ', ',')
        //                                 .replaceAll('הרצאה', 'lecture')
        //                                 .replaceAll('אירוח קולינרי', 'meals')
        //                                 .replaceAll('הופעה/מופע', 'show')
        //                                 .replaceAll('מפגש חברתי', 'group')
        //                                 .replaceAll('סדנת בישול/אפיה', 'food')
        //                                 .replaceAll('סדנת גוף/נפש', 'body-mind')
        //                                 .replaceAll('סדנת יצירה', 'workshop')
        //                                 .replaceAll('פעילות לילדים', 'kids');
        //                             application.filterCategoryProvider =
        //                                 realValue;
        //                             print(selectedDropItems);
        //                             print(selectedDropItems
        //                                 .toString()
        //                                 .replaceAll('[', '')
        //                                 .replaceAll(']', '')
        //                                 .replaceAll(', ', ','));
        //                           } else {
        //                             print('elseeeeeeeeeeeeeee');
        //                             // print(e);
        //                             selectedDropItems.remove(dropItems[index]);
        //                             print(selectedDropItems);
        //                             String realValue = selectedDropItems
        //                                 .toString()
        //                                 .replaceAll('[', '')
        //                                 .replaceAll(']', '')
        //                                 .replaceAll(', ', ',')
        //                                 .replaceAll('הרצאה', 'lecture')
        //                                 .replaceAll('אירוח קולינרי', 'meals')
        //                                 .replaceAll('הופעה/מופע', 'show')
        //                                 .replaceAll('מפגש חברתי', 'group')
        //                                 .replaceAll('סדנת בישול/אפיה', 'food')
        //                                 .replaceAll('סדנת גוף/נפש', 'body-mind')
        //                                 .replaceAll('סדנת יצירה', 'workshop')
        //                                 .replaceAll('פעילות לילדים', 'kids');
        //                             print(
        //                                 'realValue realValue realValue realValue');
        //                             print(realValue);
        //                             application.filterCategoryProvider =
        //                                 realValue;
        //                           }
        //                         });
        //                       },
        //                       title: Transform.translate(
        //                         offset: Offset(20, 0),
        //                         child: Text(
        //                           '${dropItems[index]}',
        //                           textDirection: TextDirection.rtl,
        //                           style: dropItemsHandler[index] == true
        //                               ? ktextStyleWhite
        //                               : ktextStyle,

        //                           // TextStyle(
        //                           //     color: textColor,
        //                           //     fontSize: 16),
        //                         ),
        //                       ),
        //                     ),
        //                   );
        //                 },
        //                 itemCount: dropItems.length,
        //                 shrinkWrap: true,
        //               ),
        //             ]),
        //             Directionality(
        //               textDirection: TextDirection.rtl,
        //               child: Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 10),
        //                 child: ReceivingPaymentFields(
        //                   controller: categorySearchController,
        //                   obscureText: false,
        //                   // width: 130,
        //                   height: 40,
        //                   hintText: 'חיפוש חופשי',
        //                   textColor: Colors.grey,
        //                 ),
        //               ),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal: 10, vertical: 10),
        //               child: CustomButton(
        //                   width: width,
        //                   text: 'סיימתי, תראו לי מה יש לכם',
        //                   textStyle:
        //                       TextStyle(fontSize: 14, color: Colors.white),
        //                   onPressed: () {
        //                     setState(() {
        //                       showToolBarRow = !showToolBarRow;
        //                       page = 1;
        //                     });
        //                   },
        //                   color: MyColors.dropdownColor),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ScrollToHide(
        //       scrollViewController: _scrollViewController,
        //       child: Column(
        //         children: [
        //           if (application.filterTimeProvider == 'specific_date')
        //             // application.filterTimeProvider = 'this_week',
        //             Directionality(
        //               textDirection: TextDirection.rtl,
        //               child: Container(
        //                 // height: 170,
        //                 margin: EdgeInsets.only(right: 10),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     ReceivingPaymentFields(
        //                       hintText: 'החל מתאריך...',
        //                       textColor: Colors.white,
        //                       width: 130,
        //                       colors: MyColors.dropdownColor,
        //                       obscureText: false,
        //                       controller: startDateController,
        //                       textColorPrimary: Colors.white,
        //                       onTap: () async {
        //                         var date = await selectDate(
        //                             isDob: true, context: context);
        //                         if (date != "null") {
        //                           setState(() {
        //                             startDateController.text =
        //                                 convertSingleDate(date);
        //                           });
        //                         }
        //                       },
        //                     ),
        //                     SizedBox(width: 10),
        //                     ReceivingPaymentFields(
        //                       hintText: 'עד תאריך...',
        //                       textColor: Colors.white,
        //                       textColorPrimary: Colors.white,
        //                       width: 130,
        //                       colors: MyColors.dropdownColor,
        //                       obscureText: false,
        //                       controller: endDateController,
        //                       onTap: () async {
        //                         var date = await selectDate(
        //                             isDob: true, context: context);
        //                         if (date != "null") {
        //                           setState(() {
        //                             endDateController.text =
        //                                 convertSingleDate(date);
        //                           });
        //                         }
        //                       },
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           Container(
        //             color: MyColors.dropdownColor.withOpacity(1),
        //             child: Row(
        //               children: [
        //                 GestureDetector(
        //                   onTap: () {
        //                     setState(() {
        //                       showToolBarRow = !showToolBarRow;
        //                     });
        //                   },
        //                   child: Container(
        //                     alignment: Alignment.center,
        //                     margin: const EdgeInsets.only(left: 5),
        //                     padding: EdgeInsets.symmetric(horizontal: 10),
        //                     color: MyColors.dropdownColor,
        //                     // height: 50,
        //                     // width: double.infinity,
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [
        //                         Icon(
        //                           Icons.arrow_drop_down,
        //                           color: Colors.white,
        //                         ),
        //                         Column(
        //                           children: [
        //                             Text(
        //                               'מה?',
        //                               textDirection: TextDirection.rtl,
        //                               textAlign: TextAlign.center,
        //                               style: TextStyle(
        //                                 fontSize: 12,
        //                                 color: Colors.white,
        //                               ),
        //                             ),
        //                             SizedBox(
        //                               height: 5,
        //                             ),
        //                             RichText(
        //                               textDirection: TextDirection.rtl,
        //                               text: TextSpan(
        //                                 text:
        //                                     '${selectedDropItems.isNotEmpty ? selectedDropItems.length : ''} ',
        //                                 style: ktextStyleSmallWhite,
        //                                 children: [
        //                                   TextSpan(
        //                                       text: selectedDropItems.isEmpty
        //                                           ? 'כל החוויות'
        //                                           : 'נבחרו',
        //                                       style: ktextStyleSmallWhite),
        //                                 ],
        //                               ),
        //                             )
        //                           ],
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   width: 130,
        //                   child: DropButtonByTime(
        //                     text1: 'מתי?',
        //                     text2: 'בכל עת',
        //                     onChanged: (value) {
        //                       setState(() {
        //                         filterByTime = value;
        //                         application.filterTimeProvider = value;
        //                         page = 1;
        //                         showToolBarRow = false;
        //                       });
        //                     },
        //                   ),
        //                 ),
        //                 DropButtonByAnywhere(
        //                   text1: 'איפה?',
        //                   text2: 'כל החוויות',
        //                   onChanged: (value) {
        //                     print(
        //                         'value from value from value from value from ');
        //                     print(value);
        //                     setState(() {
        //                       application.filterAnywhereProvider = value
        //                           .toString()
        //                           .replaceAll('אונליין / זום', 'online');
        //                       application.showOnline = !showOnline;
        //                       page = 1;
        //                     });
        //                     if (value == 'בכל מקום') {
        //                       print('chli kya condition ??????????/');
        //                       setState(() {
        //                         application.filterCategoryProvider = '';
        //                         // application.filterTimeProvider =
        //                         //     '';
        //                         application.filterAnywhereProvider = 'בכל מקום';
        //                         categorySearchController.text = '';
        //                         endDateController.text = '';
        //                         startDateController.text = '';
        //                         klatitude = null;
        //                         klongitude = null;
        //                         page = 1;
        //                       });
        //                     }
        //                     if (value == 'קרוב אליי') {
        //                       klatitude = null;
        //                       klongitude = null;
        //                     }
        //                     if (value == 'עיר מסויימת') {
        //                       _scrollViewController.position.restoreOffset(0.0);
        //                     }
        //                   },
        //                 )
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        floatingActionButton: showToolBarRow != true
            ? Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: ScrollToHide(
                  scrollViewController: _scrollViewController,
                  child: Container(
                    height: 80,
                    width: 80,
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      onPressed: () async {
                        if (_fetchEventData.data.isNotEmpty) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapSample(
                                lat: application.mapLat,
                                lng: application.mapLog,
                                eventCoordinates: _fetchEventData.data,
                                currentLocation: geoLoc,
                                emailFromHome: _updateAndGetUserProfile
                                    .getUserData?.data?.authorEmail,
                              ),
                            ),
                          );
                        }
                      },
                      child: Image.asset(
                        'assets/icons/map.png',
                        fit: BoxFit.fill,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartDocked,
      ),
    );
  }

  final Completer<GoogleMapController> _mapController = Completer();
  dynamic klatitude;
  dynamic klongitude;

  Future<void> _goToPlace(place) async {
    setState(() {
      klatitude = place.lat;
      klongitude = place.lng;
    });
    Future.delayed(Duration(seconds: 1), () {
      getEventData();
    });
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(place.lat, place.lng), zoom: 15),
      ),
    );
  }
}
