import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:monitoring/global/global.dart';
import '../../home_page.dart';
import '../SideBar/side_bar_function.dart';
import '../SideBar/side_bar_list.dart';
import 'centering_map_by_coordinates.dart';
import 'DispensingContainer/dispensing_container.dart';

///Карта

class MyMap extends StatefulWidget  {
  const MyMap({Key? key, this.steam}) : super(key: key);

  final Stream? steam;

  @override
  State<MyMap> createState() => _MyMapState();
}


class _MyMapState extends State<MyMap> {
  StreamSubscription? subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = widget.steam!.listen((seconds) {
      if (seconds is List<Marker>) {
        _updateMap();
      } else if (seconds is bool && seconds == true) {
        _zoomIn();
      } else if (seconds is bool && seconds == false) {
        _zoomOut();
      } else if (seconds is List<LatLng>) {
        centringZoomAllCars(seconds);
      } else if (seconds is LatLng) {
        centringOneCars(seconds);
      } else if(seconds[0] == 'colorsIcon'){
        colorsIcon = seconds[1];
        setState(() {

        });
      } else if(seconds == 'pointTestPath'){
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription!.cancel();
  }

  void _updateMap() {
    setState(() {});
  }

  MapController _mapController = MapController();

  double zoom = 11.0;

  void _zoomIn() {
    if (zoom == _mapController.zoom) {
      if (zoom != 18.0) {
        zoom = zoom + 0.5;
        print(zoom);
        _mapController.move(_mapController.center, zoom);
      }
    } else {
      zoom = _mapController.zoom + 0.5;
      print(zoom);
      _mapController.move(_mapController.center, zoom);
    }
  }

  void _zoomOut() {
    if (zoom == _mapController.zoom) {
      zoom = zoom - 0.5;
      print(zoom);
      _mapController.move(_mapController.center, zoom);
    } else {
      zoom = _mapController.zoom - 0.5;
      print(zoom);
      _mapController.move(_mapController.center, zoom);
    }
  }

  centringZoomAllCars(List<LatLng> allCar) {
    var centring = centeringCoordinates(allCar);
    _mapController.move(centring['latLng'], centring['zoom'] - 0.1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///Карта
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
              center: LatLng(45.46389,39.40785), zoom: 14.0, maxZoom: 18),
          layers: [
            TileLayerOptions(
              urlTemplate:
              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            PolylineLayerOptions(
                polylines: [
                  if(pointPathAuto.isNotEmpty)
                    Polyline(points: pointPathAuto,strokeWidth: 3, color: Colors.indigo.shade300)
                ]
            ),
            MarkerLayerOptions(
              markers:[
                if(allCarsMarker.isNotEmpty )
                  for(var i = 0; i< allCarsMarker.length; i++) allCarsMarker[i],
                if(pointsObject.isNotEmpty )
                  for(var i = 0; i< pointsObject.length; i++) pointsObject[i],
                if(pointsObjectMap.isNotEmpty )
                  for(var i = 0; i< pointsObjectMap.length; i++) pointsObjectMap[i],
                if(startEndPath.isNotEmpty )
                  for(var i = 0; i< startEndPath.length; i++) startEndPath[i],
              ],
            ),
          ],
        ),
        ///Кнопка вызова блока с низу
        if(bottomSide == true)
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {
              animationTrue = !animationTrue;
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    width: 2,
                    color: Color(0xff618AEE),
                  ),
                  left: BorderSide(
                    width: 2,
                    color: Color(0xff618AEE),
                  ),
                  right: BorderSide(
                    width: 2,
                    color: Color(0xff618AEE),
                  ),
                ),
              ),
              width: 200,
              height: 22,
              child: Icon(Icons.arrow_drop_up,
                  size: 22, color: Color(0xff618AEE)),
            ),
          ),
        ),
        ///Выподающее окно ============
        if(errorWindowPath == true)
          Positioned(
            top: 200,
            right: 200,
            child: AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 10.0),
                title: Center(child: Text('Внимание')),
                content: Text('Нет маршрута, выберите другую дату'),
                actions: [
                  TextButton(onPressed: (){
                    setState(() {
                      errorWindowPath = false;
                    });
                  }, child: Text('Закрыть'),)
                ]
            ),
          ),
        ///Выподающий блок с низу, инфо о машине
        if(bottomSide == true)
        DispensingContainer(),
      ],
    );
  }

  ///Функция показа местоположения одной машины
  centringOneCars(LatLng latLng) {
    _mapController.move(latLng, 16.0);
    print(latLng);
  }
}



