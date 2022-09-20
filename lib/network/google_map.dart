import 'package:basalon/blocs/application_bloc.dart';
import 'package:basalon/modal/google_map_search.dart';
import 'package:basalon/modal/location.dart';
import 'package:basalon/services/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PlacesService {
  List? searchResult = [];
  dynamic filteredData;

  getAutoComplete(String placeName) async {
    print(placeName);

    Dio dio = Dio();
    if (placeName.length > 1) {
      var url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&language=iw&key=$kgoogleMapKey";
      var res = await dio.get(url);

      var json = res.data;
      // print('${res.data}');
      print(
          'place name place name place name place name place name place nameplace nameplace nameplace name');
      print(placeName);
      final jsonResult = PlaceSearch.fromJson(json);
      searchResult = jsonResult.predictions;
    }
    return searchResult;
  }

  getPlace(String placeId, BuildContext context) async {
    late final application =
        Provider.of<ApplicationBloc>(context, listen: false);

    Dio dio = Dio();

    var url =
        "https://maps.googleapis.com/maps/api/place/details/json?&key=$kgoogleMapKey&place_id=$placeId";
    var res = await dio.get(url);
    var json = res.data as Map<String, dynamic>;
    final jsonResult = Location.fromJson(json);
    print('eren eren eren eren eren eren eren');
    print(jsonResult.result?.geometry?.location?.lat);
    filteredData = jsonResult.result?.geometry?.location;
    print("sndsds");
    print(filteredData);
    application.mapLat = jsonResult.result?.geometry?.location?.lat;
    application.mapLog = jsonResult.result?.geometry?.location?.lng;
    return filteredData;
  }
}
