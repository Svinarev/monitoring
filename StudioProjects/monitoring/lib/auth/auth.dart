import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../home/components/SideBar/side_bar_function.dart';

///АУНТИФИКАЦИЯ LOGIN PASS
class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _login = TextEditingController();
  final _password = TextEditingController();

  void _auth() {
    final log = _login.text;
    final pass = _password.text;

    if (log == 'a' && pass == 'a') {
      final nav = Navigator.of(context);
    } else {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Text('ТАЛИСМАН',style: TextStyle(fontWeight: FontWeight.w800, fontSize: 42.0),),
                  Image.asset('img/logo.png',height: 230,width: 230,),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: Text('Логин',style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),)),
                  SizedBox(height: 10),
                  TextField(
                    controller: _login,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ВАШЕ ИМЯ',
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Пароль',style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),)),
                  SizedBox(height: 10),
                  TextField(
                    controller: _password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ПАРОЛЬ',
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 22.0),
                            primary: Color(0xff618AEE),
                          ),
                          onPressed: () async {
                            await getListAuto();
                            Navigator.pushNamed(context, '/HomePage');
                            },
                          // _auth,
                          child: Text(
                            'ВОЙТИ',
                            style:
                                TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: (){

                        },
                        child: Container(
                          width: 46,
                          height: 47,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff618AEE)
                          ),
                            child: Icon(Icons.list_rounded, color: Colors.white,size: 40,)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
