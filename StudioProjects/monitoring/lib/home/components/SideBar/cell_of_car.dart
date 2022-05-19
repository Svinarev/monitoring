import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monitoring/home/components/SideBar/side_bar_function.dart';
import 'package:monitoring/home/components/SideBar/side_bar_list.dart';
import 'package:monitoring/home/components/map/DispensingContainer/dispensing_container.dart';
import 'package:monitoring/home/components/map/map_global.dart';
import 'package:monitoring/home/home_page.dart';
import '../../../global/global.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

///Ячейка с данными о машине

class CellCar extends StatefulWidget {
  CellCar({
    Key? key,
    required this.num,
    required this.model,
    required this.id,
    this.checkBox = false,
    this.coordinates,
    this.km = 0,
    this.time = '',
    this.fuel = '-',
    required this.backgroundColorsOn,
  }) : super(key: key);
  String num;
  String model;
  String fuel;
  int km;
  int id;
  bool checkBox;
  String time;
  LatLng? coordinates;
  Color backgroundColorsOn;

  @override
  State<CellCar> createState() => _CellCarState();
}

class _CellCarState extends State<CellCar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        ///Временное решение
        var id = -1;
        if(selectCar != null) id = selectCar![0];
        ///геокодированние адресса  ===========================
        var geoAdress;
        if(widget.coordinates != null) {
          var res = await http.get(Uri.parse(
              'https://nominatim.openstreetmap.org/reverse?format=json&lat=${widget.coordinates!.latitude}&lon=${widget.coordinates!.longitude}&zoom=17'));
          geoAdress = json.decode(res.body);
          print(geoAdress);
        }
        ///====================================================

        selectCar = [
          widget.id,
          widget.coordinates,
          widget.model,
          widget.num,
          widget.km,
          widget.fuel,
          widget.time,
          widget.coordinates != null ? '${geoAdress['display_name'].split(', ').take(2).join(', ')}' : 'нет данных'
        ];
        print("нажата: ${widget.model} ${widget.num}");
        print("${widget.id}");
        if (widget.coordinates != null) {
          controllerMap.add(widget.coordinates);
        }
        if(bottomSide == true && id != widget.id) {
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
      },
      child: Container(
        height: 70.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: selectCar != null && selectCar![0] == widget.id
              ? widget.backgroundColorsOn
              : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 2.0),
                ),
                height: 50.0,
                width: 50.0,
                child: Image.asset(
                  'img/3.png',
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 12,
                            child: Text(
                              widget.model + "  " + widget.num,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                        const Spacer(),
                        Transform.scale(
                          scale: 0.85,
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                                value: widget.checkBox,
                                onChanged: (val) {
                                  widget.checkBox = val!;
                                  setState(() {});
                                  widget.checkBox
                                      ? reportList.add(widget.id)
                                      : reportList.remove(widget.id);
                                  print(reportList);
                                }),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.local_gas_station_outlined,
                              size: 16.0,
                              color: Colors.orangeAccent,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              widget.fuel,
                              style: const TextStyle(fontSize: 13.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.speed,
                              size: 16.0,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              '${widget.km} км/ч',
                              style: const TextStyle(fontSize: 13.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 16.0,
                              color: Colors.lightBlueAccent,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              widget.time.isNotEmpty
                                  ? DateFormat('HH:mm')
                                      .format(DateTime.parse(widget.time))
                                  : '-',
                              style: const TextStyle(fontSize: 13.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
