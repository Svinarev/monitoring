import 'dart:convert';
import 'package:intl/intl.dart';
import '../home/components/SideBar/side_bar_function.dart';
import '../home/components/SideBar/side_bar_list.dart';
import '../home/components/map/DispensingContainer/dispensing_container.dart';
import '../home/components/map/map_global.dart';
import '../home/home_page.dart';
import 'global.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;


///Функция переключения маршрутов и машин ========================================================================
pressAutoCell(String num, String model, String fuel, int km, int id, String time, LatLng? coordinates) async {
  /// idCarCheck Для переключения между маршрутами машин
  var idCarCheck = -1;
  if (selectCar != null) idCarCheck = selectCar![0];

  ///геокодированние адресса  ===========================
  var geoAdress;
  if (coordinates != null) {
    var res = await http.get(Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${coordinates.latitude}&lon=${coordinates.longitude}&zoom=17'));
    geoAdress = json.decode(res.body);
    print(geoAdress);
  }
  ///====================================================

  selectCar = [
    id,
    coordinates,
    model,
    num,
    km,
    fuel,
    time,
    coordinates != null
        ? '${geoAdress['display_name'].split(', ').take(2).join(', ')}'
        : 'нет данных'
  ]; print(selectCar![0]);
  if (coordinates != null) {
    controllerMap.add(coordinates);
  }
  if (bottomSide == true && idCarCheck != id) {
    buttonVideo = false;
    colorsIcon = '';
    myTest = 2;
    colorsCalendar = 3;
    now = DateTime.now();
    myDateStart = DateFormat('dd.MM.yyyy 00:00').format(now);
    myDateEnd = DateFormat('dd.MM.yyyy HH:mm').format(now);
    pointsObjectMap.clear();
    await getPathAuto();
  }
  homeController.add('stateCars');
}
///===============================================================================================================