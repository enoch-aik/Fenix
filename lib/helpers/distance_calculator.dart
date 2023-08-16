 import 'dart:math';

import 'package:get/get.dart';



double degreesToRadians(degrees) {
  return degrees * pi / 180;
}

 double distanceInKm(lat1, lon1, lat2, lon2) {
  var earthRadiusKm = 6371;

  var dLat = degreesToRadians(lat2-lat1);
  var dLon = degreesToRadians(lon2-lon1);

  lat1 = degreesToRadians(lat1);
  lat2 = degreesToRadians(lat2);

  var a = sin(dLat/2) * sin(dLat/2) +
      sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2);
  var c = 2 * atan2(sqrt(a), sqrt(1-a));
  return (lat1 != null && lat2 != null && lon1 != null && lon2 != null) ? (earthRadiusKm * c).toPrecision(1) : 0.0;
}