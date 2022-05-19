import 'package:flutter/material.dart';
import 'package:monitoring/home/components/SideBar/side_bar_list.dart';
import 'package:latlong2/latlong.dart';
import '../../../global/global.dart';
import 'cell_of_car.dart';


///Кнопка иконка

class ButtonIconsTwo extends StatefulWidget {
  IconData icon;
  var press;

  ButtonIconsTwo({
    Key? key,
    required this.icon,
    required this.press,
  }) : super(key: key);

  @override
  State<ButtonIconsTwo> createState() => _ButtonIconsTwoState();
}

class _ButtonIconsTwoState extends State<ButtonIconsTwo> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      onHover: (val){
        setState(() {
          isHover = val;
        });
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: isHover ? Colors.blue[200] : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Icon(
              widget.icon,
              size: 18,
              color: isHover ? Colors.white : Color(0xff618AEE),
            )),
      ),
    );
  }
}

///Список поиска авто по номеру
var filtrAuto = [];
TextEditingController searchController = TextEditingController();

///Список Авто
class ListAuto extends StatefulWidget {
  const ListAuto({Key? key}) : super(key: key);

  @override
  State<ListAuto> createState() => _ListAutoState();
}

class _ListAutoState extends State<ListAuto> {
  ///Функция поиска авто по номеру
  void _searchAuto(){
    filtrAuto = source!;
    final query =  searchController.text;
    if(query.isNotEmpty){
      filtrAuto = source!.where((listAuto){
        return listAuto[1].toLowerCase().contains(query.toLowerCase());
      }).toList();
    }else {
      filtrAuto = source!;
    }
    setState(() {
      print(filtrAuto);
    });
  }
 ///==============================

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filtrAuto = source!;
    searchController.addListener(() { _searchAuto();});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Кнопки Иконки
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonIconsTwo(
              icon: Icons.add_circle_outline,
              press: () {},
            ),
            ButtonIconsTwo(
              icon: Icons.edit_outlined,
              press: () {},
            ),
            ButtonIconsTwo(
              icon: Icons.delete_outline,
              press: () {},
            ),
            ButtonIconsTwo(
              icon: Icons.filter_alt_outlined,
              press: () {},
            ),
            ButtonIconsTwo(
              icon: Icons.emoji_objects_outlined,
              press: () {},
            ),
            ButtonIconsTwo(
              icon: Icons.settings_outlined,
              press: () {},
            ),
          ],
        ),
        SizedBox(height: 20.0),
        ///Поиск авто
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            onTap: (){
              _searchAuto();
              setState(() {});},
            controller: searchController,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        SizedBox(height: 10),
        ///Список всех манин
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
                itemCount: filtrAuto.length,
                itemBuilder: (context, index) {
                  if(filtrAuto[index].length>5 && RegExp(r'(_+)').firstMatch(filtrAuto[index][4]) == null){
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child:  CellCar(
                        checkBox: reportList.contains(filtrAuto[index][0]),
                        id: filtrAuto[index][0],
                        num: filtrAuto[index][1].toString(),
                        model: filtrAuto[index][2].toString(),
                        time: filtrAuto[index][7],
                        fuel: filtrAuto[index][6] ?? '0',
                        km: filtrAuto[index][5] ?? 0,
                        coordinates: LatLng(double.parse(filtrAuto[index][4].split(', ').first),
                            double.parse(filtrAuto[index][4].split(', ').last)),
                        backgroundColorsOn: Colors.grey.shade300,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: CellCar(
                      checkBox: reportList.contains(filtrAuto[index][0]),
                      id: filtrAuto[index][0],
                      num: filtrAuto[index][1].toString(),
                      model: filtrAuto[index][2].toString(),
                      backgroundColorsOn: const Color(0xFFE8D6D6),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}


///Список Обьектов ====================================
class ListObject extends StatefulWidget {
  const ListObject({Key? key}) : super(key: key);

  @override
  _ListObjectState createState() => _ListObjectState();
}

class _ListObjectState extends State<ListObject> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Кнопки Иконки
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonIconsTwo(
              icon: Icons.add_circle_outline,
              press: () {},
            ),
            ButtonIconsTwo(
              icon: Icons.edit_outlined,
              press: () {},
            ),
            ButtonIconsTwo(
              icon: Icons.delete_outline,
              press: () {},
            ),
            ButtonIconsTwo(
              icon: Icons.filter_alt_outlined,
              press: () {},
            ),
          ],
        ),
        ///=================================
        SizedBox(height: 20),
        ///Список всех обьектов
        Expanded(
          child: ListView.builder(
              itemCount: 13,
              // allObject!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)

                    ),
                    child: Row(
                      children: [
                        Icon(Icons.account_balance_sharp,color: Color(0xff618AEE),size: 20,),
                        SizedBox(width: 7.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('станица Ленингадская',style: TextStyle(fontSize: 13),),
                            Text('ул. Красных Партизан, 1556',style: TextStyle(fontSize: 13),),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
///=====================================================