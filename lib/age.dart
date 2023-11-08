// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: AgePredictionScreen(),
  ));
}

class AgePredictionScreen extends StatefulWidget {
  const AgePredictionScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AgePredictionScreenState createState() => _AgePredictionScreenState();
}

class _AgePredictionScreenState extends State<AgePredictionScreen> {
  String _name = '';
  String _age = '';
  String _imageURL = '';

  Future<void> _predictAge() async {
    final response = await http.get(Uri.parse('https://api.agify.io/?name=$_name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _age = data['age'].toString();
      });

      // Determina el estado según la edad
      int age = int.parse(_age);
      String statusText = '';

      if (age < 18) {
        statusText = 'Es un/una joven';
        _imageURL = 'assets/joven.png';
      } else if (age < 60) {
        statusText = 'Es un/una adult@';
        _imageURL = 'assets/adulto.jpg';
      } else {
        statusText = 'Es un/una anciano';
        _imageURL = 'assets/viejo.jpg';
      }

      // Muestra el estado en la consola
      print('$_name: $statusText');

      // Actualiza la interfaz de usuario
      setState(() {
        _statusText = statusText;
      });
    }
  }

  String _statusText = ''; // Variable para mostrar el estado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Edad'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.purple,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (text) {
                setState(() {
                  _name = text;
                });
              },
              decoration: InputDecoration(
                labelText: 'Ingresa un nombre...',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Ej: Pedro',
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _predictAge();
              },
              child: Text('Obtener Edad'),
            ),
            SizedBox(height: 16.0),
            if (_age.isNotEmpty)
              Text(
                'Edad: $_age años',
                style: TextStyle(fontSize: 20),
              ),
            if (_imageURL.isNotEmpty)
              Column(
                children: <Widget>[
                  Text(
                    _statusText,
                    style: TextStyle(fontSize: 20),
                  ),
                  CachedNetworkImage(
                    imageUrl: _imageURL,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    height: 200,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
