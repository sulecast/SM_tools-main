// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: WeatherScreen(),
  ));
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late String _weatherDescription = '';
  late double _temperature;
  late double _humidity;
  late double _windSpeed;
  late double _pressure;

  // Agrega tu clave de API aquí
  final String apiKey = 'b266541f72ee459a349f6291a602ec08'; // Reemplaza 'TU_API_KEY' con tu clave de API real

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Santo%20Domingo,do&appid=$apiKey'));

    if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final String weatherDescription = data['weather'][0]['description'];
    final double temperature = (data['main']['temp'] - 273.15); // Convertir a grados Celsius
    final double humidity = data['main']['humidity'].toDouble(); // Humedad en porcentaje
    final double windSpeed = data['wind']['speed']; // Velocidad del viento en m/s
    final double pressure = data['main']['pressure']; // Presión atmosférica en hPa

    setState(() {
      _weatherDescription = weatherDescription;
      _temperature = temperature;
      _humidity = humidity;
      _windSpeed = windSpeed;
      _pressure = pressure;
    });
  } else {
    print('Error al cargar los datos del clima');
  }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima en República Dominicana'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            SizedBox(
                width: 250,
                height: 250,
                child: Image.asset('assets/clima.jpg'),
              ),
              const SizedBox(height: 5.0),
            const Text(
              'Clima',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Descripción del clima: $_weatherDescription',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Temperatura: $_temperature°C',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Humedad: $_humidity',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Viento: $_windSpeed',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Presion: $_pressure',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
