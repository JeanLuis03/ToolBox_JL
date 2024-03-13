// Jean Luis De Los Santos Garabito (2022-0442)

// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Clima extends StatefulWidget {
  @override
  State<Clima> createState() => _Clima();
}

class _Clima extends State<Clima> {
  String _province = '';
  String _condition = '';
  double _temperature = 0;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final response = await Dio().get(
          'https://api.weatherapi.com/v1/current.json?key=e3149ea917ec401dbba22219232710&q=Dominican republic');
      setState(() {
        _province = response.data['location']['name'];
        _condition = response.data['current']['condition']['text'];
        _temperature = response.data['current']['temp_c'];
      });
      print(_temperature); // Imprimir el valor de temp_c
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const CircleAvatar(
              radius: 150,
              backgroundImage: AssetImage('assets/images/weather.png'),
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              _province,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Text(
              _condition,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Text(
              '$_temperature °C',
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            )
          ]),
        ),
      ),
    );
  }
}
