import 'dart:async';

import 'package:ccnust/mgdbHelper/constant.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<List?> getMyEmail() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenData = prefs.getStringList('token');
  if(tokenData==null) {
    return null;
  }
  final jwt = JWT.verify(tokenData.first, SecretKey(JSONWEBTOKEN_SECRET));
  return [jwt.payload["email"],tokenData.last];
}
Future<LocationData> getMyPosition() async {
  /// For android
  // var serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // if (!serviceEnabled) {
  //   Geolocator.openLocationSettings();
  // }
  // var permission = await Geolocator.checkPermission();
  // if (permission == LocationPermission.denied) {
  //   permission = await Geolocator.requestPermission();
  //   if (permission == LocationPermission.deniedForever) {
  //     /// Permissions are denied forever, handle appropriately.
  //     Geolocator.openAppSettings();
  //   }
  // }
  Location location = new Location();
  LocationData _locationData;
  _locationData = await location.getLocation();
  // Position position = await Geolocator.getCurrentPosition();
  if (kDebugMode) {
    print("My location get");
  }
  // return position;
  return _locationData;
}
Future<Position> getMyPosition2() async {
  /// For windows
  var serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Geolocator.openLocationSettings();
  }
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      /// Permissions are denied forever, handle appropriately.
      Geolocator.openAppSettings();
    }
  }
  // Location location = new Location();
  // LocationData _locationData;
  // _locationData = await location.getLocation();
  Position position = await Geolocator.getCurrentPosition();
  if (kDebugMode) {
    print("My location get");
  }
  return position;
  // return _locationData;
}