import 'package:basalon/modal/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerService {
  LatLngBounds bounds(Set<Marker> markers) {
    // if (markers == null || markers.isEmpty) return ;
    return createBound(markers.map((e) => e.position).toList());
  }

  LatLngBounds createBound(List<LatLng> positions) {
    final southwestLat = positions
        .map((e) => e.latitude)
        .reduce((value, element) => value < element ? value : element);
    final southwestLon = positions
        .map((e) => e.longitude)
        .reduce((value, element) => value < element ? value : element);
    final northEastLat = positions
        .map((e) => e.latitude)
        .reduce((value, element) => value < element ? value : element);
    final northEastLon = positions
        .map((e) => e.longitude)
        .reduce((value, element) => value < element ? value : element);

    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northEastLat, northEastLon));
  }

  Marker createMarkerFromPlace(Place place) {
    var markerId = place.name;
    return Marker(
      markerId: MarkerId(markerId.toString()),
      draggable: false,
      infoWindow: InfoWindow(
        title: place.name,
        snippet: place.vicinity,
      ),
      position: LatLng(
        place.geometry!.location!.lat!,
        place.geometry!.location!.lng!,
      ),
    );
  }
}
