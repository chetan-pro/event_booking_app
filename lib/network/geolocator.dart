import 'package:geolocator/geolocator.dart';

class GeolocatorSerice {
  dynamic coordinates;
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
