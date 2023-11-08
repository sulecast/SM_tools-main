import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: GenderPredictionScreen(),
  ));
}

class GenderPredictionScreen extends StatefulWidget {
  const GenderPredictionScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GenderPredictionScreenState createState() => _GenderPredictionScreenState();
}

class _GenderPredictionScreenState extends State<GenderPredictionScreen> {
  String _name = '';
  String _gender = '';
  Color _backgroundColor = Colors.purple; // Color de fondo predeterminado

  Future<void> _predictGender(String name) async {
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['gender'] == 'male') {
        setState(() {
          _gender = 'Masculino';
          _backgroundColor = Colors.blue;
        });
      } else if (data['gender'] == 'female') {
        setState(() {
          _gender = 'Femenino';
          _backgroundColor = Colors.pink;
        });
      } else {
        setState(() {
          _gender = 'No válido';
          _backgroundColor = Colors.blueGrey;
        });
      }
    } else {
      setState(() {
        _gender = 'Error';
        _backgroundColor = Colors.blueGrey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predicción de Género'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.purple,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 250,
                height: 250,
                child: Image.asset('assets/gender.png'),
              ),
              const SizedBox(height: 5.0),
              TextField(
                onChanged: (text) {
                  setState(() {
                    _name = text;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Ingrese un nombre',
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 11.0),
              ElevatedButton(
                onPressed: () {
                  _predictGender(_name);
                },
                child: const Text('Predecir Género'),
              ),
              const SizedBox(height: 11.0),
              Container(
                color: _backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _gender,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
