import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

///мой id
const myId =
    // '95.31.104.53'
    '192.168.6.75'
;
///мой порт
const myPort = '9999';


///Точки всех машин на карте
List<Marker> allCarsMarker = [];

///Показать все машины на карте
List<LatLng> allCarsCoordinates = [];

///Выбор и подсвет конкретной машины
List? selectCar;

///Для отчетов
List reportList = [];

bool bottomSide = false;

///Контроллеры отправки даты колендаря =========================
TextEditingController startHour = TextEditingController();
TextEditingController endHour = TextEditingController();
TextEditingController startMinutes = TextEditingController();
TextEditingController endMinutes = TextEditingController();
///=============================================================
