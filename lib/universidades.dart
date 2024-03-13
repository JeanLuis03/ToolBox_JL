// Jean Luis De Los Santos Garabito (2022-0442)

// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

class Universidades extends StatefulWidget {
  @override
  State<Universidades> createState() => _Universidades();
}

class _Universidades extends State<Universidades> {
  List<dynamic> universities = [];
  bool searchPressed = false;
  TextEditingController countryController = TextEditingController();

  Future<void> fetchUniversities(String country) async {
    try {
      var response = await Dio()
          .get('http://universities.hipolabs.com/search?country=$country');
      setState(() {
        universities = response.data;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: countryController, // Controlador del TextField
              decoration: const InputDecoration(
                labelText: 'País',
                hintText: 'Colocar país en ingles',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String country =
                    countryController.text; // Obtener el valor del TextField
                if (country.isNotEmpty) {
                  setState(() {
                    searchPressed = true;
                    universities.clear(); // Limpiar la lista de universidades
                  });
                  fetchUniversities(country);
                }
              },
              child: const Text('Buscar universidades'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: universities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(universities[index]['name'],
                        style: const TextStyle(
                            color: Color.fromARGB(255, 136, 19, 19),
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dominio: ${universities[index]['domains'][0]}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            String url = universities[index]['web_pages'][0];
                            // Abre la URL en un navegador web externo
                            launch(url);
                          },
                          child: Text(
                            '${universities[index]['web_pages'][0]}',
                            style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimina del árbol de widgets
    countryController.dispose();
    super.dispose();
  }
}
