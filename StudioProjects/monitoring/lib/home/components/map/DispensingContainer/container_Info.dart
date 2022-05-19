import 'package:flutter/material.dart';
import 'dispensing_buttom.dart';


///Контейнеры с информацией
class ContainerInformation extends StatelessWidget {
  const ContainerInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        ContainerInfo(
          icon: Icons.access_time,
          text: 'Время пути: 2 ч',
          colors: Color(0xff333333),
        ),
        ContainerInfo(
          icon: Icons.add_road,
          text: 'Растояние: 24 км',
          colors: Color(0xff85BC7A),
        ),
        ContainerInfo(
          icon: Icons.local_gas_station_outlined,
          text: 'Заправки: 60 л',
          colors: Color(0xffE8A200),
        ),
        ContainerInfo(
          icon: Icons.whatshot_rounded,
          text: 'Слив: нет',
          colors: Color(0xffDC0606),
        ),
        ContainerInfo(
          icon: Icons.local_parking,
          text: 'Стоянки: 20 ч',
          colors: Color(0xff06597E),
        ),
        ContainerInfo(
          icon: Icons.speed,
          text: 'Макс.скор: 87 км',
          colors: Color(0xffFA6E22),
        ),
        ContainerInfo(
          icon: Icons.bus_alert,
          text: 'Моточасы: 20 ч',
          colors: Color(0xff03BEE9),
        ),
        ContainerInfo(
          icon: Icons.battery_unknown_outlined,
          text: 'Расход: 20 л',
          colors: Color(0xfffdbf62),
        ),
      ],
    );
  }
}