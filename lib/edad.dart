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
  int age;

  Persona({
    required this.count,
    required this.name,
    required this.age,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        count: json["count"],
        name: json["name"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "name": name,
        "age": age,
      };
}

class Edad extends StatefulWidget {
  @override
  State<Edad> createState() => _Edad();
}

class _Edad extends State<Edad> {
  Persona? persona;
  String name = '';
  int age = 0;

  @override
  void initState() {
    super.initState();
    getPersona(name);
  }

  Future<void> getPersona(String name) async {
    final response = await Dio().get('https://api.agify.io/?name=$name');
    persona = Persona.fromJson(response.data);
    setState(() {
      age = persona!.age;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Introduzca su nombre',
              ),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  getPersona(name);
                });
              },
              child: const Text('Predecir Edad'),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  if (persona != null && age < 18 && age != 0)
                    Column(
                      children: [
                        Text(
                          '${persona?.name ?? 'no data'} es un/a joven de ${persona?.age ?? 'no data'} años',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/joven.jpg',
                          width: 450,
                          height: 400,
                        )
                      ],
                    ),
                  if (persona != null && age >= 18 && age <= 59)
                    Padding(
                      padding: const EdgeInsets.all(
                          20.0), // Puedes ajustar el valor según sea necesario
                      child: Column(
                        children: [
                          Text(
                            '${persona?.name ?? 'no data'} es un/a Adulto/a de ${persona?.age ?? 'no data'} años',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            'assets/images/adulto.jpg',
                            width: 450,
                            height: 400,
                          )
                        ],
                      ),
                    ),
                  if (persona != null && age >= 60)
                    Padding(
                      padding: const EdgeInsets.all(
                          20.0), // Puedes ajustar el valor según sea necesario
                      child: Column(
                        children: [
                          Text(
                            '${persona?.name ?? 'no data'} es un/a anciano/a de ${persona?.age ?? 'no data'} años',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            'assets/images/anciano.jpg',
                            width: 450,
                            height: 400,
                          )
                        ],
                      ),
                    )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
