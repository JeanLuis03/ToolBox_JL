// Jean Luis De Los Santos Garabito (2022-0442)

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class AcercaDe extends StatefulWidget {

  @override
  State<AcercaDe> createState() => _AcercaDe();
}

class _AcercaDe extends State<AcercaDe> {

  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      backgroundColor: Colors.white,
    
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                'Información de contacto',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/me.jpg'),
                backgroundColor: Colors.black,
              ),
              SizedBox(height: 20),
              Text(
                'Nombre: ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 211, 18, 18),
                    fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'Jean Luis De Los Santos Garabito',
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Text(
                'Correo Electrónico: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 211, 18, 18),
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '20220442@itla.edu.do',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Text(
                'Teléfono: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 211, 18, 18),
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '(829)-202-0442',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),


    );
  }
}