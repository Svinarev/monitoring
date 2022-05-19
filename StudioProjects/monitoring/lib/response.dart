import 'package:flutter/material.dart';


///Адоптивность

class Response extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Response(
      {Key? key, required this.mobile, required this.tablet, required this.desktop}) : super(key: key);

  static bool isMobile(context) => MediaQuery.of(context).size.width < 900;
  static bool isTablet(context) => MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 900;
  static bool isDesktop(context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    if(isDesktop(context)){
      return desktop;
    }
    else if(isTablet(context) && tablet != null){
      return tablet;
    }
    else{
      return mobile;
    }
  }
}
