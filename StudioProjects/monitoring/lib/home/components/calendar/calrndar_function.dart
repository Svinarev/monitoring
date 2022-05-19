import 'package:flutter/material.dart';

class InputTimeDay extends StatelessWidget {

  TextEditingController controller;

  InputTimeDay({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44.0,
      child: TextField(
        controller: controller,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            isDense: true,                      // Added this
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(),
          )),);
  }
}
