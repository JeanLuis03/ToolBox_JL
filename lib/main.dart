// Jean Luis De Los Santos Garabito (2022-0442)

import 'package:flutter/material.dart';
import 'package:tarea6/acerca_de.dart';
import 'package:tarea6/clima.dart';
import 'package:tarea6/edad.dart';
import 'package:tarea6/genero.dart';
import 'package:tarea6/inicio.dart';
import 'package:tarea6/pag_wordpress.dart';
import 'package:tarea6/universidades.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jean De Los Santos | 2022-0442',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
                        primarySwatch: Colors.red),
        useMaterial3: true,

      ),
      
      home: const MyHomePage(title: 'Mobile ToolBox | JL'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int vistaPrincipal = 0;

  obtenerVista(int op){

    switch (op) {
      case 0:
        return Inicio();
      case 1:
        return Genero();
      case 2: 
        return Edad();
      case 3:
        return Universidades();
      case 4:
        return Clima();
      case 5:
        return PaginaWordPress();
      case 6:
        return AcercaDe();
      default:
    }

  }

  seleccionarVista(int op){
    setState(() {
      vistaPrincipal = op;
      Navigator.of(context).pop();
      
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 35,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,

        title: Text(widget.title,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
      ),

      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 189, 23, 23),
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('ToolBox | JL',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),), 
              accountEmail: Text('2022-0442',
                            style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/llave.jpg'),
              ),
            ),
            const SizedBox(height: 5),
            ListTile(
              title: const Text('Inicio', style: TextStyle(color: Colors.white, fontSize: 20),),
              leading: const Icon(Icons.home, color: Colors.white, size: 30,),
              onTap: () {
                seleccionarVista(0);
              },
            ),
            const SizedBox(height: 5),
            ListTile(
              title: const Text('Predecir Genero', style: TextStyle(color: Colors.white, fontSize: 20),),
              leading: const Icon(Icons.wc, color: Colors.white, size: 30,),
              onTap: () {
                seleccionarVista(1);
              },
            ),
            const SizedBox(height: 5),
            ListTile(
              title: const Text('Predecir Edad', style: TextStyle(color: Colors.white, fontSize: 20),),
              leading: const Icon(Icons.elderly, color: Colors.white, size: 30,),
              onTap: () {
                seleccionarVista(2);
              },
            ),
            const SizedBox(height: 5),
            ListTile(
              title: const Text('Universidades', style: TextStyle(color: Colors.white, fontSize: 20),),
              leading: const Icon(Icons.school, color: Colors.white, size: 30,),
              onTap: () {
                seleccionarVista(3);
              },
            ),
            const SizedBox(height: 5),
            ListTile(
              title: const Text('Clima en RD', style: TextStyle(color: Colors.white, fontSize: 20),),
              leading: const Icon(Icons.sunny_snowing, color: Colors.white, size: 30,),
              onTap: () {
                seleccionarVista(4);
              },
            ),
            const SizedBox(height: 5),
            ListTile(
              title: const Text('API WordPress', style: TextStyle(color: Colors.white, fontSize: 20),),
              leading: const Icon(Icons.api, color: Colors.white, size: 30,),
              onTap: () {
                seleccionarVista(5);
              },
            ),
            const SizedBox(height: 5),
            ListTile(
              title: const Text('Acerca de mi', style: TextStyle(color: Colors.white, fontSize: 20),),
              leading: const Icon(Icons.info, color: Colors.white, size: 30,),
              onTap: () {
                seleccionarVista(6);
              },
            ),
          ],
        ),
      ),

      body: obtenerVista(vistaPrincipal),
    );
  }
}
