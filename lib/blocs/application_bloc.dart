import 'dart:async';

import 'package:basalon/modal/event_category_model.dart';
import 'package:basalon/modal/get_user_data.dart';
import 'package:basalon/network/geolocator.dart';
import 'package:basalon/network/google_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/get_activity_edit_detials.dart';
import '../modal/package_model.dart';

class ApplicationBloc with ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  int currentIndex = 6;

  dynamic filterCategoryProvider;
  dynamic filterTimeProvider;
  dynamic filterAnywhereProvider;

  final geoLocatorService = GeolocatorSerice();
  final placesService = PlacesService();
  Position? currentLocation;
  final StreamController selectedLocation = StreamController.broadcast();

  List<dynamic>? searchResult;
  dynamic markersssssss;

  bool showPreview = false;
  bool showOnline = false;

//GENERAL TAB
  dynamic previewContentProvider;
  dynamic previewTitleProvider;
  dynamic previewCategoryProvider;
  dynamic previewMapAddressProvider;
  dynamic previewImageProvider;
  List<Asset>? previewGalleryProvider;

//TICKET
  dynamic previewTicketProvider;

  //CALENDER
  dynamic previewDateProvider;

//AUTHOR DATA
  dynamic previewFirstnameProvider;
  dynamic previewLastnameProvider;
  dynamic previewAuthorDescriptionrovider;
  dynamic previewAuthorImagerovider;

  dynamic mapLat;
  dynamic mapLog;

  //EVENT LOCATION
  dynamic previewLatProvider;
  dynamic previewLngProvider;

  //PROFILE IMAGE FROM FACEBOOK LOGIN
  dynamic imageFromFacebook;
  dynamic emailFromFacebook;
  dynamic nameFromFacebook;
  dynamic contactDetailProvider;
  dynamic cardHolderProvider;
  dynamic cardNumberProvider;
  dynamic cardCvvProvider;
  dynamic cardMonthProvider;
  dynamic cardYearProvider;

  GetUserData? getUserDataProfileProvider;

  bool isUserLogin = false;
  List? myActivity;

  ApplicationBloc() {
    setCurrentLocation();

    Future.delayed(const Duration(seconds: 0), () async {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('isFirstTime', false);
    });
    // setLocation();
  }

  // Position? geoLoc;
  // static var coordinates;
  //
  // setLocation() async {
  //   geoLoc = await Geolocator.getCurrentPosition();
  //   print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
  //   coordinates = geoLoc;
  //   print(coordinates);
  //   print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
  //
  //   return coordinates;
  // }

  //LOCAL STORAGE
  int? idFromLocalProvider;
  GetUserActivityEditDetails? myActivityEditPage;
  //DROPDOWN TIME
  String? val;

  // String? val1 = 'ב-7 ימים הקרובים';
  PackageModel? packageModel;
  List<Datum> categoriesFromApiProvider = [];

  String realValueTime = 'ב-7 ימים הקרובים';

  // String realValueEveryWhere =
  //     coordinates != null ? 'בכל מקום' : 'קרוב אליי';

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResult = await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }

  setMarker() async {
    markersssssss = await placesService.filteredData;
    notifyListeners();
  }

  setSelectedLocation(String placeId, BuildContext context) async {
    var place = await placesService.getPlace(placeId, context);
    selectedLocation.add(place);
    searchResult = null;
    notifyListeners();
  }

  @override
  void dispose() {
    selectedLocation.close();
    super.dispose();
  }

  void validate() {
    currentIndex--;
    notifyListeners();
  }

  setFilter(value) {
    filterCategoryProvider = value;
    notifyListeners();
  }

  setFilterByTime(value) {
    filterTimeProvider = value;
    notifyListeners();
  }

  setFilterByAnywhere(value) {
    filterAnywhereProvider = value;
    showOnline = true;
    notifyListeners();
  }
}
