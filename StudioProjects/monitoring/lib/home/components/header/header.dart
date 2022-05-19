import 'package:flutter/material.dart';
import 'package:monitoring/home/home_page.dart';
import '../../../my_icon_icons.dart';
import '../SideBar/side_bar.dart';
import '../SideBar/side_bar_function.dart';
import '../SideBar/side_bar_list.dart';

///Header


///Проверить если что удалить?
bool vova = false;

///Убирать боковое меню
bool menuTest = true;

///Спрятать Header
bool addEndHeader = true;

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Color(0xff618AEE),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            ///Кнопка Меню
            IconButton(
                onPressed: () {
                  menuTest = !menuTest;
                  homeController.add(menuTest);
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                )),
            Spacer(),
            ///Кнопки: Транспорт, Объекты, Маршруты, Отчеты
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonHeader(
                  icon: MyIcon.truck_1,
                  text: 'Транспорт',
                  press: () {
                    listOpen = 1;
                    controllerSideBar.add(listOpen);
                    print(listOpen);
                    setState(() {});
                  },
                  onPressColor: 1,
                ),
                ButtonHeader(
                  icon: Icons.home_work_outlined,
                  text: 'Объекты',
                  press: () {
                    listOpen = 2;
                    print(listOpen);
                    controllerSideBar.add(listOpen);
                    setState(() {});
                  },
                  onPressColor: 2,
                ),
                ButtonHeader(
                  icon: Icons.map_outlined,
                  text: 'Маршруты',
                  press: () {
                    listOpen = 3;
                    print(listOpen);
                    // getTestPuth();
                    setState(() {

                    });
                  },
                  onPressColor: 3,
                ),
                ButtonHeader(
                  icon: Icons.add_chart,
                  text: 'Отчеты',
                  press: () {
                    setState(() {
                    if(listOpen != 4)  listOpen = 4; else listOpen = 0;
                      print(listOpen);
                      setState(() {
                      });
                      // vova = !vova;
                    });
                  },
                  onPressColor: 4,
                ),
              ],
            ),
            Spacer(),

            ///Кнопки настройка и выход
            Row(
              children: [
                ButtonHeader(
                  icon: Icons.settings_outlined,
                  text: 'Настройки',
                  press: () {
                    listOpen = 5;
                    setState(() {});
                  },
                  onPressColor: 5,
                ),
                ButtonHeader(
                  icon: Icons.exit_to_app,
                  text: 'Выход',
                  press: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                  onPressColor: 6,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

///Кнопка Картинка Текст ==================================

class ButtonHeader extends StatefulWidget {
  String text;
  var press;
  IconData icon;
  int onPressColor;

  ButtonHeader({
    Key? key,
    this.press,
    required this.icon,
    required this.text,
    this.onPressColor = 1,
  }) : super(key: key);

  @override
  State<ButtonHeader> createState() => _ButtonHeaderState();
}

class _ButtonHeaderState extends State<ButtonHeader> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return InkWell(
      onTap: widget.press,
      onHover: (val) {
        setState(() {
          isHover = val;
        });
      },
      child: _size.width > 550
          ? Container(
              color: widget.onPressColor == listOpen ? Color(0xffAEC6FF) : null,
              height: 60,
              width: 150,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: isHover ? Colors.blue[300] : Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  if (_size.width > 1050)
                    Text(
                      widget.text,
                      style:  TextStyle(
                        fontSize: isHover ? 15 : 14,
                        color: isHover ? Colors.blue[300] : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      widget.icon,
                      color: isHover ? Colors.green[300] : Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    if (_size.width > 1050)
                      Text(
                        widget.text,
                        style: TextStyle(
                          color: isHover ? Colors.green[200] : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}

///========================================================
