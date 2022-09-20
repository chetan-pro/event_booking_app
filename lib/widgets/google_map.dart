import 'dart:async';
import 'package:basalon/widgets/dropdown_anywhere.dart';
import 'package:basalon/widgets/dropdown_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker_updates.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../blocs/application_bloc.dart';
import '../network/get_events_network.dart';
import '../screens/activity/receiving_activity_screen.dart';
import '../services/constant.dart';
import '../services/my_color.dart';
import 'custom_buttons.dart';
import 'info_window_hijack.dart';
import 'marker_event_card.dart';

class MapSample extends StatefulWidget {
  MapSample({
    this.onMapController,
    this.lng,
    this.lat,
    this.eventCoordinates,
    this.onChanged,
    this.currentLocation,
    this.emailFromHome,
  });

  dynamic onMapController;
  dynamic lat;
  dynamic lng;
  dynamic eventCoordinates;
  dynamic onChanged;
  dynamic currentLocation;
  String? emailFromHome;

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  late final application = Provider.of<ApplicationBloc>(context, listen: false);
  FetchEventData _fetchEventData = FetchEventData();
  TextEditingController categorySearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateMarker(widget.eventCoordinates);
  }

  @override
  void didUpdateWidget(covariant MapSample oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _customInfoWindowsController.dispose();
  }

  // setCustomMarker(BuildContext context) async {
  //   BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
  //     ImageConfiguration(size: Size(50, 50), devicePixelRatio: 2.5),
  //     'assets/icons/MapSmall.png',
  //   );
  //   for (int i = 0; i < widget.eventCoordinates.length; i++)
  //     _markers.add(
  //       Marker(
  //         icon: customIcon,
  //         onTap: () {
  //           _customInfoWindowsController.addInfoWindow!(
  //             MarkerEventCard(
  //               datum: widget.eventCoordinates[i],
  //             ),
  //             LatLng(
  //               double.parse(widget.eventCoordinates[i].latEvent),
  //               double.parse(widget.eventCoordinates[i].lngEvent),
  //             ),
  //           );
  //           // setCustomMarker();
  //         },
  //         markerId: MarkerId('${widget.eventCoordinates[i].id}'),
  //         position: LatLng(
  //           double.parse(widget.eventCoordinates[i].latEvent),
  //           double.parse(widget.eventCoordinates[i].lngEvent),
  //         ),
  //       ),
  //     );
  //
  //   setState(() {});
  // }

  updateMarker(data) async {
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(50, 50), devicePixelRatio: 2.0),
      'assets/LatestMapMarker4.png',
    );
    _markers.clear();
    for (int i = 0; i < data.length; i++) {
      _markers.add(
        Marker(
          icon: customIcon,
    
          onTap: () {
            print("map datra");
            // print(data[1].mapAddress);
            _customInfoWindowsController.addInfoWindow!(
              MarkerEventCard(
                datum: data[i],
                email: widget.emailFromHome,
              ),
              LatLng(
                double.parse(data[i].latEvent),
                double.parse(data[i].lngEvent),
              ),
            );
            // setCustomMarker();
          },
          markerId: MarkerId('${data[i].id}'),
          position: LatLng(
            double.parse(data[i].latEvent),
            double.parse(data[i].lngEvent),
          ),
        ),
      );
    }

    setState(() {});

    print('update marker ----------------------');
  }

  final CustomInfoWindowsController _customInfoWindowsController =
      CustomInfoWindowsController();

  List<Marker> _markers = [];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List dropItems = kCategoryList;
  List selectedDropItems = [];
  bool showToolBar = false;

  @override
  Widget build(BuildContext context) {
    print('map sample map sample map sample map sample map sample');
    // print();
    print(widget.currentLocation);
    return Consumer(
      builder: (BuildContext context, value, Widget? child) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  onTap: (position) {
                    _customInfoWindowsController.hideInfoWindow!();
                  },
                  onCameraMove: (position) {
                    _customInfoWindowsController.addInfoWindow;
                  },
                  mapToolbarEnabled: false,
                  // gestureRecognizers: Set()
                  //   ..add(
                  //     Factory<PanGestureRecognizer>(
                  //       () => PanGestureRecognizer(),
                  //     ),
                  //   ),
                  markers: Set<Marker>.of(_markers),
                  
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      widget.lat != null
                          ? widget.lat
                          : widget.currentLocation != null
                              ? widget.currentLocation.latitude
                              : 32.4390389,
                      widget.lng != null
                          ? widget.lng
                          : widget.currentLocation != null
                              ? widget.currentLocation.longitude
                              : 34.8780611,
                    ),
                    zoom: 14,
                  ),
                  onMapCreated: (GoogleMapController controller) async {
                    _customInfoWindowsController.googleMapController =
                        controller;
                  },
                ),
                // CustomInfoWindow(
                //   controller: _customInfoWindowsController,
                //   height: 200,
                //   width: MediaQuery.of(context).size.width,
                //   offset: MediaQuery.of(context).size.height/2,
                // ),
                Center(
                  heightFactor: 1,
                  child: CustomInfoWindows(
                    controller: _customInfoWindowsController,
                    // height: MediaQuery.of(context).size.height / 5,
                    // height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    offset: MediaQuery.of(context).size.height / 2,
                  ),
                ),

                if (showToolBar)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      // height: 300,
                      width: MediaQuery.of(context).size.width / 2,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Column(
                            children: List.from(
                              dropItems
                                  .map(
                                    (e) => CheckboxListTile(
                                      activeColor: MyColors.topOrange,
                                      value: selectedDropItems
                                          .toString()
                                          .toLowerCase()
                                          .contains(
                                              '${e.toString().toLowerCase()}'),
                                      onChanged: (value) async {
                                        print(value);
                                        setState(() {
                                          if (value == true) {
                                            print('iffffffffffffff');
                                            print(e);
                                            selectedDropItems.add(e);
                                            String realValue = selectedDropItems
                                                .toString()
                                                .replaceAll('[', '')
                                                .replaceAll(']', '')
                                                .replaceAll(', ', ',')
                                                .replaceAll('הרצאה', 'lecture')
                                                .replaceAll(
                                                    'אירוח קולינרי', 'meals')
                                                .replaceAll(
                                                    'הופעה/מופע', 'show')
                                                .replaceAll(
                                                    'מפגש חברתי', 'group')
                                                .replaceAll(
                                                    'סדנת בישול/אפיה', 'food')
                                                .replaceAll(
                                                    'סדנת גוף/נפש', 'body-mind')
                                                .replaceAll(
                                                    'סדנת יצירה', 'workshop')
                                                .replaceAll(
                                                    'פעילות לילדים', 'kids');
                                            application.filterCategoryProvider =
                                                realValue;

                                            application.setFilter(realValue);
                                            MarkerUpdates.from(Set.of(_markers),
                                                Set.of(_markers));

                                            Future.delayed(
                                                const Duration(seconds: 1), () {
                                              application.setFilter(realValue);
                                            });
                                          } else {
                                            print('elseeeeeeeeeeeeeee');
                                            print(e);
                                            selectedDropItems.remove(e);
                                            print(selectedDropItems);
                                          }
                                        });
                                        var data =
                                            await _fetchEventData.getEventData(
                                                1,
                                                application
                                                    .filterCategoryProvider,
                                                application.filterTimeProvider,
                                                application
                                                    .filterAnywhereProvider,
                                                '',
                                                '',
                                                categorySearchController.text,
                                                '',
                                                '',
                                                context);
                                        updateMarker(data);
                                        setState(() {});
                                      },
                                      title: Text(
                                        '$e',
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ReceivingPaymentFields(
                                onChange: (v) {
                                  setState(() {
                                    categorySearchController.text =
                                        categorySearchController.text;
                                    application.setFilter(
                                        categorySearchController.text);
                                  });
                                },
                                controller: categorySearchController,
                                obscureText: false,
                                // width: 130,
                                height: 40,
                                hintText: 'חיפוש חופשי',
                              ),
                            ),
                          ),
                          CustomButton(
                              text: 'סיימתי לבחור',
                              onPressed: () async {
                                setState(() {
                                  showToolBar = !showToolBar;
                                  categorySearchController.text =
                                      categorySearchController.text;
                                  application
                                      .setFilter(categorySearchController.text);
                                });
                                // var data = await _fetchEventData.getEventData(
                                //     1,
                                //     application.filterCategoryProvider,
                                //     application.filterTimeProvider,
                                //     'בכל מקום',
                                //     '',
                                //     '',
                                //     categorySearchController.text,
                                //     '',
                                //     '',
                                //     context);
                                // updateMarker(data);
                                setState(() {});
                              },
                              color: MyColors.dropdownColor),
                        ],
                      ),
                    ),
                  )
              ],
            ),
            floatingActionButton: Container(
              width: 80,
              height: 80,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  'assets/images/MapBackButton.svg',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),

                //     Image.asset(
                //   'assets/icons/Circle-New-1.png',
                //   fit: BoxFit.fill,
                //   height: 100,
                //   width: 100,
                // ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniStartFloat,
            bottomNavigationBar: Container(
              height: 60,
              color: MyColors.dropdownColor.withOpacity(1),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showToolBar = !showToolBar;
                      });
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: MyColors.dropdownColor,
                      height: 50,
                      // width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          Text(
                            'מה? \n כל החוויות',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: DropButtonByTime(
                      text1: 'מתי?',
                      text2: 'בכל עת',
                      onChanged: (value) async {
                        print(
                            'value realValue realValue realValue realValue realValue');
                        print(value);
                        setState(() {
                          application.filterTimeProvider = value;
                        });
                        var data = await _fetchEventData.getEventData(
                            1,
                            application.filterCategoryProvider,
                            application.filterTimeProvider,
                            application.filterAnywhereProvider,
                            '',
                            '',
                            '',
                            '',
                            '',
                            context);
                        // MarkerUpdates.from(Set.of(_markers), Set.of(_markers));

                        setState(() {});
                        Future.delayed(const Duration(seconds: 1), () {
                          application.setFilterByTime(value);
                          updateMarker(data);
                        });
                      },
                    ),
                  ),
                  DropButtonByAnywhere(
                    text1: 'מה?',
                    text2: 'כל החוויות',
                    onChanged: (value) async {
                      print('value value value value value value value');
                      print(value
                          .toString()
                          .replaceAll('אונליין / זום', 'online'));
                      if (value == 'בכל מקום') {
                        print('chli kya condition ??????????/');
                        setState(() {
                          application.filterCategoryProvider = '';
                          application.filterTimeProvider = '';
                          application.filterAnywhereProvider =
                              'בכל מקום'; // categorySearchController.text =
                          // '';
                          // klatitude = null;
                          // klongitude = null;
                        });
                      } else if (value == 'אונליין / זום') {
                        setState(() {
                          application.filterAnywhereProvider = 'online';
                        });
                      }
                      var data = await _fetchEventData.getEventData(
                          1,
                          '',
                          '',
                          application.filterAnywhereProvider,
                          '',
                          '',
                          '',
                          '',
                          '',
                          context);
                      MarkerUpdates.from(Set.of(_markers), Set.of(_markers));

                      setState(() {});
                      Future.delayed(Duration(seconds: 1), () {
                        application.setFilterByAnywhere(value);
                        updateMarker(data);
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
