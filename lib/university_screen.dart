import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(
    home: UniversitiesScreen(),
  ));
}

class University {
  final String name;
  final String domain;
  final String webPage;

  University({required this.name, required this.domain, required this.webPage});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'],
      domain: json['domains'][0],
      webPage: json['web_pages'][0],
    );
  }
}

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UniversitiesScreenState createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  String countryName = 'Dominican+Republic';
  List<University> universities = [];

  Future<void> fetchUniversities(String country) async {
    final response = await http.get(
      Uri.parse('http://universities.hipolabs.com/search?country=$country'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final universitiesList = (data as List)
          .map((university) => University.fromJson(university))
          .toList();

      setState(() {
        universities = universitiesList;
      });
    } else {
      throw Exception('Carga fallida.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidades por País'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.purple,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                countryName = value;
              },
              decoration: const InputDecoration(
                labelText: 'Nombre del pais en Ingles',
                hintText: 'Ejemplo: United States',
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Colors.white),  // Color del texto de sugerencia
              ),
              style: const TextStyle(color: Colors.white),  // Color del texto ingresado
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  fetchUniversities(countryName);
                },
                child: const Text('Buscar Universidades', style: TextStyle(color: Colors.white)),  // Color del texto del botón
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: universities.length,
                itemBuilder: (context, index) {
                  final university = universities[index];
                  return ListTile(
                    title: Text(university.name, style: const TextStyle(color: Colors.white)),  // Color del título
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dominio: ${university.domain}', style: const TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            // Abre el enlace a la página web de la universidad
                            // ignore: deprecated_member_use
                            launch(university.webPage);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Visitar Sitio Web', style: TextStyle(color: Colors.black)),
                          ),  // Color del texto del botón
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
}
