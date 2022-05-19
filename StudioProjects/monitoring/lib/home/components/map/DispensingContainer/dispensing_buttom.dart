import 'package:flutter/material.dart';

///Кнопки Выподающегово контайнера с инфо

///Разноцветный контейнер с инфо ================
class ContainerInfo extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color colors;

  const ContainerInfo({
    Key? key,
    required this.text,
    required this.icon,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: 25,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          color: colors,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 14,
            ),
            SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
///==============================================
