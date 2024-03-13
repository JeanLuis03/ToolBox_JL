// Jean Luis De Los Santos Garabito (2022-0442)

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

Persona personaFromJson(String str) => Persona.fromJson(json.decode(str));

String personaToJson(Persona data) => json.encode(data.toJson());

class Persona {
  int count;
  String name;
  String gender;
  double probability;

  Persona({
    required this.count,
    required this.name,
    required this.gender,
    required this.probability,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        count: json["count"],
        name: json["name"],
        gender: json["gender"],
        probability: json["probability"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "name": name,
        "gender": gender,
        "probability": probability,
      };
}

class Genero extends StatefulWidget {
  @override
  State<Genero> createState() => _Genero();
}

class _Genero extends State<Genero> {
  Persona? persona;
  String name = '';

  @override
  void initState() {
    super.initState();
    getPersona(name);
  }

  Future<void> getPersona(name) async {
    final response = await Dio().get('https://api.genderize.io/?name=$name');
    persona = Persona.fromJson(response.data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(
            20.0), // Puedes ajustar el valor según sea necesario
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Introduzca un nombre',
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                autofocus: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    getPersona(name);
                  });
                },
                child: const Text('Predecir Género'),
              ),
              const SizedBox(height: 20),
              if (persona?.gender == 'male')
                Card(
                  color: const Color.fromARGB(255, 172, 215, 255),
                  elevation:
                      1, // Puedes ajustar la elevación según tus preferencias
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Column(
                    children: [
                      SizedBox(height: 30),
                      Icon(
                        Icons.man,
                        color: Colors.blue,
                        size: 350,
                      )
                    ],
                  ),
                ),
              if (persona?.gender == 'female')
                Card(
                  color: const Color.fromARGB(255, 255, 172, 237),
                  elevation:
                      1, // Puedes ajustar la elevación según tus preferencias
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Column(
                    children: [
                      SizedBox(height: 30),
                      Icon(
                        Icons.woman,
                        color: Colors.pink,
                        size: 350,
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
