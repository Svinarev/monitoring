import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

centeringCoordinates(List<LatLng> coordinates){
  double max = 0.0;
  Path path = Path.from(coordinates);
  Distance distance = Distance();
  coordinates.forEach((element) {var km = distance.as(LengthUnit.Meter, path.center, element);
    if(max <km) max = km;
  });
  double zoom  = getZoomLevel(max);

  return{'latLng' : path.center, 'zoom': zoom};
}

double getZoomLevel(double radius){
  double zoomLevel = 11;
  if(radius>0){
    double radiusLevel = radius + radius / 2;
    double scale = radiusLevel / 500;
    zoomLevel = 16 - log(scale)/log(2);
  }
  zoomLevel = double.parse(zoomLevel.toStringAsFixed(2));
  return zoomLevel;
}
