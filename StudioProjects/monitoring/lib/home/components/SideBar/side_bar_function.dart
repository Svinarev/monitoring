import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:monitoring/home/components/SideBar/side_bar.dart';
import 'package:monitoring/home/components/SideBar/side_bar_list.dart';
import 'package:monitoring/home/components/map/DispensingContainer/dispensing_container.dart';
import '../../../global/global.dart';
import '../../../global/global_function.dart';
import '../../home_page.dart';
import '../map/map_global.dart';

///Функции Side Bar

///Функция создание всех маркеров на карте ===============================
createAllMarkerCar(List allCars) {
  allCarsMarker.clear();
  allCarsCoordinates.clear();
  for (int i = 0; i < allCars.length; i++) {
    if (allCars[i].length > 5) {
      try {
        allCarsMarker.add(Marker(
            width: 100,
            height: 100,
            point: LatLng(double.parse(allCars[i][4].split(',').first),
                double.parse(allCars[i][4].split(',').last)),
            builder: (BuildContext context) {
              return MyPressIcon(
                id: allCars[i][0],
                numberCar: allCars[i][1],
                press: () {
                  pressAutoCell(
                    allCars[i][1].toString(),
                    allCars[i][2].toString(),
                    allCars[i][6] ?? '0',
                    allCars[i][5] ?? 0,
                    allCars[i][0],
                    allCars[i][7],
                    LatLng(double.parse(allCars[i][4].split(', ').first),
                        double.parse(allCars[i][4].split(', ').last)),
                  );
                },
              );
            }));
        allCarsCoordinates.add(LatLng(
            double.parse(allCars[i][4].split(', ').first),
            double.parse(allCars[i][4].split(', ').last)));
      } catch (e) {
        print(e);
      }
    }
    controllerMap.add(allCarsMarker);
  }
}

///Кнопка тест
class MyPressIcon extends StatefulWidget {
  var press;
  String? numberCar;
  int id;

  MyPressIcon(
      {Key? key,
      required this.numberCar,
      required this.press,
      required this.id})
      : super(key: key);

  @override
  State<MyPressIcon> createState() => _MyPressIconState();
}

class _MyPressIconState extends State<MyPressIcon> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.press,
          onHover: (val) {
            setState(() {
              onHover = val;
            });
          },
          child: Icon(
            Icons.directions_car_sharp,
            color: onHover
                ? Colors.blue.shade800
                : selectCar != null && selectCar![0] == widget.id
                    ? Colors.teal.shade700
                    : Colors.grey.shade700,
            size: onHover
                ? 32
                : selectCar != null && selectCar![0] == widget.id
                    ? 30
                    : 25,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: onHover
                ? Colors.blue.shade800
                : selectCar != null && selectCar![0] == widget.id
                    ? Colors.teal.shade700
                    : Colors.grey.shade700,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
            child: Text(
              '${widget.numberCar}',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}

///=======================================================================

///Функция получения списка всех машин ===================================
getListAuto() async {
  var response = await http.post(Uri.parse("http://$myId:$myPort/all_id_car"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {'id_car': "123"},
      ));
  var vovas = jsonDecode(response.body);
  source = vovas;
  await createAllMarkerCar(source!);
  controllerSideBar.add([source, 'cars']);
  homeController.add('stateCars');
}
///=======================================================================

///Функция получения списка точек с видео ================================
String colorsIcon = '';

getVideoPoint() async {
  var response =
      await http.post(Uri.parse("http://$myId:$myPort/video_on_date"),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: json.encode(
            {
              "id_car": "${selectCar![0]}",
              "date_start": myDateStart,
              "date_end": myDateEnd,
            },
          ));
  var vovas = jsonDecode(response.body);
  videoPoint = vovas;
  print(videoPoint);
  pointsObjectMap.clear();
  for (var i = 0; i < videoPoint[1].length; i++) {
    print(videoPoint[1][i][0]);
    if (RegExp(r"(_+)").firstMatch(videoPoint[1][i][0]) == null) {
      pointsObjectMap.add(Marker(
          point: LatLng(double.parse(videoPoint[1][i][0].split(', ').first),
              double.parse(videoPoint[1][i][0].split(', ').last)),
          builder: (BuildContext context) {
            return InkWell(
                onTap: () {
                  buttonVideo = true;
                  homeController.add(videoPoint[1][i][1]);
                  scrollController!.animateTo(43.0 * i,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                  colorsIcon = videoPoint[1][i][1];
                  controllerMap.add('pointTestPath');
                },
                child: colorsIcon == videoPoint[1][i][1]
                    ? Icon(
                        Icons.videocam,
                        size: 30,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.videocam,
                        size: 22,
                        color: Colors.blueGrey,
                      ));
          }));
    }
  }
  controllerMap.add(pointsObjectMap);
  print("${selectCar![0]}");
  print(myDateStart);
  print(myDateEnd);
}
///=======================================================================

///Функция получения точек для отображения пути на карте =================
var pathAuto;

List<LatLng> pointPathAuto = [];
/// Для отметки начало и конци пути на карте
List<Marker> startEndPath = [];

getPathAuto() async {
  var response = await http.post(Uri.parse("http://$myId:$myPort/way"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: json.encode(
        {
          "id_car": "${selectCar![0]}",
          "date_start": myDateStart,
          "date_end": myDateEnd,
        },
      ));
  var vovas = jsonDecode(response.body);
  pathAuto = vovas;
  print(pathAuto);
  pointPathAuto.clear();
  startEndPath.clear();
  if (pathAuto.isNotEmpty) {
    for (var i = 0; i < pathAuto!.length; i++) {
      if (RegExp(r"^[\[\]\'_]+").firstMatch(pathAuto![i][0]) == null) {
        pointPathAuto.add(
          LatLng(double.parse(pathAuto![i][0].split(', ').first),
              double.parse(pathAuto![i][0].split(', ').last)),
        );
      }
    }
    startEndPath.addAll([
      Marker(
          point: LatLng(double.parse(pathAuto![0][0].split(', ').first),
              double.parse(pathAuto![0][0].split(', ').last)),
          builder: (context) {
            return Icon(
              Icons.navigation,
              color: Colors.indigo.shade700,
            );
          }),
      Marker(
          point: LatLng(double.parse(pathAuto.last[0].split(', ').first),
              double.parse(pathAuto.last[0].split(', ').last)),
          builder: (context) {
            return Icon(
              Icons.flag,
              color: Colors.red,
            );
          }),
    ]);
  }

  controllerMap.add('pointTestPath');
}
///=======================================================================


