import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

///Списка Обьектов
List? allObject = [];

bool openListObject = false;
///======================

///Полученте списка машин
List? source = [];

int listOpen = 1;
///======================

///Маршрут выбранной машины
List? getListTest = [];
///========================

///Список для отображения маршрута
List<LatLng> pathOnMap = [];
///===============================

///Полученте списка обьектов
List ? listObject = [];
///=========================

///Полученте точек обьектов ===
List<Marker> pointsObject = [];
///============================

///Полученте списка точек и видео
List videoPoint = [];
///==============================

///Полученте точек видео на карте
List<Marker> pointsObjectMap = [];
///===============================