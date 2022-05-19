import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monitoring/global/global.dart';
import 'package:monitoring/home/components/map/map_global.dart';
import '../../../home_page.dart';
import '../../SideBar/side_bar_function.dart';
import '../../SideBar/side_bar_list.dart';
import '../../calendar/calendar.dart';
import 'container_Info.dart';
import 'package:latlong2/latlong.dart';
import 'dart:html' as html;


DateTime now = DateTime.now();
String myDateStart = DateFormat('dd-MM-yyyy 00:00').format(now);
String myDateEnd = DateFormat('dd-MM-yyyy HH:mm').format(now);

///Переменная для анимации
bool animationTrue = true;

///для теста
var myTest = 2;

///для переключения кнопок календаря
var colorsCalendar = 3;

ScrollController? scrollController;

///Выподающий блок с низу, инфо о машине
class DispensingContainer extends StatefulWidget {
  const DispensingContainer({Key? key}) : super(key: key);

  @override
  State<DispensingContainer> createState() => _DispensingContainerState();
}

class _DispensingContainerState extends State<DispensingContainer> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    colorsCalendar = 3;
    myCalendar.dispose();
    scrollController?.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: animationTrue
          ? Container(
              height: MediaQuery.of(context).size.height*0.40,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      animationTrue = !animationTrue;
                      setState(() {});
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
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
                        child: Icon(Icons.arrow_drop_down,
                            size: 22, color: Color(0xff618AEE)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: Color(0xff618AEE),
                            ),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                  10.0,
                                ),
                                topLeft: Radius.circular(
                                  10.0,
                                ))),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              ///Информация об Авто и кнопки
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ///Инфо об авто
                                  Container(
                                    width: 280,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.red, width: 2.0),
                                          ),
                                          height: 45.0,
                                          width: 45.0,
                                          child: Image.asset(
                                            'img/3.png',
                                            width: 30,
                                            height: 30,
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
                                                  Text(
                                                    selectCar![2],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 8.0,
                                                  ),
                                                  Text(selectCar![3],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .local_gas_station_outlined,
                                                        size: 18.0,
                                                        color:
                                                            Colors.orangeAccent,
                                                      ),
                                                      SizedBox(width: 5.0),
                                                      Text('${selectCar![5] != "-" ? selectCar![5] + ' л' : '-' } '),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.speed,
                                                        size: 18.0,
                                                        color: Colors.redAccent,
                                                      ),
                                                      SizedBox(width: 5.0),
                                                      Text('${selectCar![4]} км/ч',),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.access_time,
                                                        size: 18.0,
                                                        color: Colors
                                                            .lightBlueAccent,
                                                      ),
                                                      SizedBox(width: 5.0),
                                                      Text(selectCar![6].isNotEmpty ?  DateFormat('HH:mm').format(DateTime.parse(selectCar![6])) : '-'),
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

                                  ///Местоположение
                                  Container(
                                    width: 280,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.vpn_lock,
                                          size: 45,
                                        ),
                                        Column(
                                          children: [
                                            Text('Текущее местоположение:'),
                                            Container(
                                              width: 235.0,
                                              child: Text(
                                                '${selectCar![7]}', style: const TextStyle(overflow: TextOverflow.visible,), textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///Кнопки иконки календаря
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 155,
                                      child: Row(
                                        children: [
                                          ///Кнопка Календарь
                                          InkWell(
                                            onTap: () async {
                                              await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return MyCalendar(
                                                        press: () async{
                                                          if(myCalendar.selectedRange!.endDate == null && myCalendar.selectedRange!.startDate != null){
                                                            myDateStart = myCalendar.selectedRange!.startDate!.add(Duration(hours: int.parse(startHour.text), minutes: int.parse(startMinutes.text),)).toString();
                                                            myDateEnd = myCalendar.selectedRange!.startDate!.add(Duration(hours: int.parse(endHour.text), minutes: int.parse(endMinutes.text))).toString();
                                                          }else{
                                                            myDateStart = myCalendar.selectedRange!.startDate!.add(Duration(hours: int.parse(startHour.text), minutes: int.parse(startMinutes.text))).toString();
                                                            myDateEnd = myCalendar.selectedRange!.endDate!.add(Duration(hours: int.parse(endHour.text), minutes: int.parse(endMinutes.text))).toString();
                                                          }

                                                          await getPathAuto();
                                                          if(myTest == 3 || pointsObjectMap.isNotEmpty) await getVideoPoint();
                                                          Navigator.pop(context);
                                                          colorsCalendar = 1;
                                                          print(myDateStart);
                                                          print(myDateEnd);
                                                        });
                                                  });
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: 45.0,
                                              height: 45.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                border: Border.all(
                                                  width: 2,
                                                  color: Color(0xff618AEE),
                                                ),
                                                color: colorsCalendar == 1
                                                    ? Color(0xff618AEE)
                                                    .withOpacity(0.3)
                                                    : null,
                                              ),
                                              child: Icon(
                                                Icons.calendar_today_outlined,
                                                size: 20,
                                                color: Color(0xff618AEE),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          ///Кнопка Вчера
                                          InkWell(
                                            onTap: () async{
                                              var yesterday = DateTime.now().subtract(const Duration(days: 1));
                                              myDateStart = DateFormat('dd-MM-yyyy 00:00').format(DateTime.parse(yesterday.toString()));
                                              myDateEnd = DateFormat('dd-MM-yyyy 23:59').format(DateTime.parse(yesterday.toString()));
                                              await getPathAuto();
                                              if(pathAuto.isEmpty){
                                                errorWindowPath = true;
                                              }
                                              if(myTest == 3 || pointsObjectMap.isNotEmpty) await getVideoPoint();
                                              setState(() {
                                                colorsCalendar = 2;
                                              });
                                            },
                                            child: Container(
                                              width: 45.0,
                                              height: 45.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                border: Border.all(
                                                  width: 2,
                                                  color: Color(0xff618AEE),
                                                ),
                                                color: colorsCalendar == 2
                                                    ? Color(0xff618AEE)
                                                    .withOpacity(0.3)
                                                    : null,
                                              ),
                                              child: Center(
                                                  child: Text('Вчера',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                        Color(0xff618AEE),
                                                      ))),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          ///Кнопка Сегодня
                                          InkWell(
                                            onTap: () async{
                                              now = DateTime.now();
                                              myDateStart = DateFormat('dd.MM.yyyy 00:00').format(now);
                                              myDateEnd = DateFormat('dd.MM.yyyy HH:mm').format(now);
                                              await getPathAuto();
                                              if(pathAuto.isEmpty){
                                                errorWindowPath = true;
                                              }
                                              if(myTest == 3 || pointsObjectMap.isNotEmpty) await getVideoPoint();
                                              colorsCalendar = 3;
                                              print('3');
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: 45.0,
                                              height: 45.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                border: Border.all(
                                                  width: 2,
                                                  color: Color(0xff618AEE),
                                                ),
                                                color: colorsCalendar == 3
                                                    ? Color(0xff618AEE)
                                                    .withOpacity(0.3)
                                                    : null,
                                              ),
                                              child: Center(
                                                  child: Text('Сегодня',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                        Color(0xff618AEE),
                                                      ))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              ///Контейнеры с информацией
                              ContainerInformation(),
                              SizedBox(height: 10),
                              ///Кнопки 'График' 'События' 'Видео'
                              Row(
                                children: [
                                  ///График
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        myTest = 1;
                                        print(myTest);
                                        setState(() {

                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: myTest == 1 ? Color(0xff618AEE) :Colors.grey,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        height: 25,
                                        child: Center(
                                            child: Text(
                                          'График',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  ///Cобытия
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        print('vova');
                                        myTest = 2;
                                        print(myTest);
                                        setState(() {

                                        });
                                      },
                                      child: Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: (myTest == 2) ? Color(0xff618AEE) :Colors.grey,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                            child: Text(
                                          'Cобытия',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  ///Видео
                                  Expanded(
                                    child: InkWell(
                                      onTap: ()async{
                                        await getVideoPoint();
                                        myTest = 3;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: (myTest == 3) ? Color(0xff618AEE) :Colors.grey,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                            child: Text(
                                              'Видео',
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),

                              ///Онко графика и событий авто
                              if(myTest == 1)
                                Expanded(
                                child: Container(
                                  child: Center(child: Text('Нет графика')),
                                ),
                              ),
                              if(myTest == 2)
                                Expanded(
                                  child: Container(
                                    child: Center(child: Text('Нет событий')),
                                  ),
                                ),
                              if(myTest == 3)
                                ///Видео с датой и кнопкоми
                                videoPoint[1].isNotEmpty ?
                                Expanded(
                                  child: ListView.builder(
                                    controller: scrollController,
                                    itemCount: videoPoint[1].length,
                                      itemExtent: 43.0,
                                      itemBuilder: (context, index){
                                    return InkWell(
                                      onTap: (){
                                        controllerMap.add(['colorsIcon',videoPoint[1][index][1]]);
                                        controllerMap.add(LatLng(double.parse(videoPoint[1][index][0].split(', ').first),
                                            double.parse(videoPoint[1][index][0].split(', ').last)));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: colorsIcon == videoPoint[1][index][1] ? Colors.green[300] : Colors.blue[300],
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(videoPoint[1][index][3].split(' ').join('  '),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Colors.white),),
                                              Text(videoPoint[1][index][2] != null ?
                                              videoPoint[1][index][2].split(',').join('  ')
                                                  : '--',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      controllerMap.add(['colorsIcon',videoPoint[1][index][1]]);
                                                      buttonVideo = true;
                                                      homeController.add(videoPoint[1][index][1]);
                                                    },
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(5),
                                                        border: Border.all(
                                                            width: 2,
                                                            color: Colors.white
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons.play_circle_outline_sharp,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  InkWell(
                                                    onTap: (){
                                                      controllerMap.add(['colorsIcon',videoPoint[1][index][1]]);
                                                        html.window.open('http://192.168.6.75:9999/download/${videoPoint[1][index][1]}', 'PlaceholderName');
                                                    },
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(5),
                                                        border: Border.all(
                                                          width: 2,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons.save_alt,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })

                                ): Expanded(child: Center(child: Text('Нет видео'))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}


