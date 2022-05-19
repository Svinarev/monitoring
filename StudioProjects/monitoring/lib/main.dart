import 'package:flutter/material.dart';
import 'package:monitoring/auth/auth.dart';
import 'package:video_js/video_js.dart';
import 'home/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

///Главная MAIN

void main() {
  VideoJsResults().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ru', ''),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/Auth',
      routes: {
        '/Auth': (BuildContext context) => Auth(),
        '/HomePage': (BuildContext context) => HomePage(stream: homeController.stream,),
        // '/VideoApp': (BuildContext context) => MyApp(),
      },
    );
  }
}

