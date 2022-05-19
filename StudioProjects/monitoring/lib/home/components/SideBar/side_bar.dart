import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:monitoring/home/components/SideBar/side_bar_list.dart';
import 'class_side_bar.dart';

///Левое меню Side Bar

///Контроллер для изменения сосояния SideBar от другтх классов ===========
StreamController controllerSideBar = StreamController.broadcast();
///=======================================================================


class SideBar extends StatefulWidget {
  const SideBar({
    Key? key, required this.stream,
  }) : super(key: key);

  final Stream stream;



  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {

  StreamSubscription? subscription;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription!.cancel();
  }

  @override
  void initState() {
    super.initState();
    subscription = widget.stream.listen((seconds) {
      if(seconds is List<dynamic> && seconds[1] == 'cars'){
        setState(() {
          filtrAuto = seconds[0];
          if(searchController.text.isNotEmpty)searchController.notifyListeners();
        });
      }
      setState(() {});
    });
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff618AEE),
      width: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:
        Column(
          children: [
            ///Список Авто
            if(listOpen == 1)
            Container(
                height: MediaQuery.of(context).size.height * 0.83,
                child: ListAuto()),
            ///Список Объектов
            if(listOpen == 2)
            Container(
                height: MediaQuery.of(context).size.height * 0.83,
                child: ListObject()),
          ],
        ),
      ),
    );
  }
}







