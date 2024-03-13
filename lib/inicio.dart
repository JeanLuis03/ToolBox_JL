// Jean Luis De Los Santos Garabito (2022-0442)

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {

  @override
  State<Inicio> createState() => _Inicio();
}

class _Inicio extends State<Inicio> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
    
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Image.asset(
            'assets/images/toolbox.png',
            width: 350,
            height: 350,
          ),
          const Text(
            'ToolBox',
            style: TextStyle(color: Color.fromARGB(255, 189, 23, 23), fontStyle: FontStyle.italic, fontSize: 35, fontWeight: FontWeight.w800),
          ),
          ],
        ),
      ),


    );
  }
}