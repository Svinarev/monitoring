import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:monitoring/global/global.dart';
import 'package:monitoring/home/components/SideBar/side_bar_list.dart';
import '../../../my_icon_icons.dart';
import '../../home_page.dart';
import '../SideBar/side_bar_function.dart';
import '../map/map_global.dart';
import 'package:http/http.dart' as http;

///Кнопки иконки с права

///Цвет кнопки бокового нижнего меню при нажатии
int colorRideButton = 0;
///=============================================
///Цвет кнопки бокового верхнего меню при нажатии
bool colorRideButtonUp = false;
///==============================================


class RightSideMenu extends StatefulWidget {
  const RightSideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<RightSideMenu> createState() => _RightSideMenuState();
}

class _RightSideMenuState extends State<RightSideMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ///Слои карт
            ButtonIcons(
              icon: Icons.layers_outlined,
              press: () {},
              helpMessage: 'Выбрать вид карты',
            ),

            ///zoom +
            ButtonIcons(
              icon: Icons.add_circle_outline,
              press: () {
                controllerMap.add(true);
              },
              helpMessage: 'Приблизить',
            ),

            ///zoom -
            ButtonIcons(
              icon: Icons.remove_circle_outline_outlined,
              press: () {
                controllerMap.add(false);
              },
              helpMessage: 'Отдалить',
            ),

            ///Показать только карту на весь экран
            ButtonIcons(
                icon: Icons.zoom_out_map,
                press: () {
                ///
                  colorRideButtonUp = !colorRideButtonUp;
                  homeController.add('header');
              },
                helpMessage: 'Карта на весь экран',
                colorButton: colorRideButtonUp ? Colors.blue.shade300 : Colors.grey
            ),

            ///Скриншот экрана
            ButtonIcons(
              icon: Icons.camera_alt_outlined,
              press: () {},
              helpMessage: 'Снимок экрана',
            ),
          ],
        ),
        const SizedBox(height: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ///Уведомления
            Badge(
              position: BadgePosition.topEnd(top: -5, end: -1),
              badgeContent: Text('3', style: TextStyle(color: Colors.white),),
              badgeColor: Colors.red.shade300,
              animationType: BadgeAnimationType.scale,
              animationDuration: Duration(milliseconds: 250),
              child: ButtonIcons(
                icon: Icons.notifications_none,
                press: () {
                  colorRideButton =1;
                  setState(() {});
                },
                helpMessage: 'Уведомления',
                colorButton: colorRideButton == 1 ? Colors.blue.shade300 : Colors.grey,

              ),
            ),

            ///Маршрут по дате
            ButtonIcons(
              icon: MyIcon.route,
              press: () async {
                if(selectCar != null) {
                  if (bottomSide == false) {
                    allCarsMarker.clear();
                    timer!.cancel();
                    bottomSide = true;
                    colorRideButton = 2;
                    await getPathAuto();
                    if(pathAuto.isEmpty){
                      errorWindowPath = true;
                    }
                    controllerMap.add('pointTestPath');
                  } else {
                    errorWindowPath = false;
                    timerForCars();
                    getListAuto();
                    pointPathAuto.clear();
                    colorRideButton = 0;
                    bottomSide = false;
                    if (pointsObjectMap.isNotEmpty) pointsObjectMap.clear();
                    controllerMap.add('pointTestPath');
                  }
                  setState(() {});
                }
              },
              helpMessage: selectCar != null ? 'Маршрут машины' : 'Выберите машину',
              colorButton: colorRideButton == 2 ? Colors.blue.shade300 : Colors.grey,

            ),

            ///центровка всех точек
            ButtonIcons(
              icon: Icons.filter_center_focus,
              press: () {
                // colorRideButton = 3;
                controllerMap.add(allCarsCoordinates);
              },
              helpMessage: 'центровка всех точек',
              // colorButton: colorRideButton == 3 ? Colors.blue.shade300 : Colors.grey.shade300,
            ),

            ///выбрать определенный радиус и посмотреть манины
            ButtonIcons(
              icon: Icons.track_changes,
              press: () {
                colorRideButton = 4;
                setState(() {});
              },
              helpMessage: 'Вибрать радиус',
              colorButton: colorRideButton == 4 ? Colors.blue.shade300 : Colors.grey,
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

///Кнопка иконка
class ButtonIcons extends StatefulWidget {
  IconData icon;
  var press;
  String? helpMessage;
  Color colorButton;

  ButtonIcons(
      {Key? key,
      required this.icon,
      required this.press,
      this.helpMessage,
      this.colorButton = Colors.grey})
      : super(key: key);

  @override
  State<ButtonIcons> createState() => _ButtonIconsState();
}

class _ButtonIconsState extends State<ButtonIcons> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isHover && widget.helpMessage != null)
          Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: Colors.grey.shade800.withOpacity(0.8),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              widget.helpMessage!,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        InkWell(
          onTap: widget.press,
          onHover: (val) {
            setState(() {
              isHover = val;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: isHover ? Colors.blue[300] : widget.colorButton,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Icon(
                widget.icon,
                size: 18,
                color: Colors.white,
              )),
            ),
          ),
        ),
      ],
    );
  }
}
