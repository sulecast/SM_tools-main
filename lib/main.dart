// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sm_tools/age.dart';
import 'package:sm_tools/weather.dart';

import 'gender_by_name.dart';
import 'university_screen.dart';
import 'wordpress.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MainPage(),
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Asigna la clave al Scaffold
      appBar: AppBar(
        title: const Text('SM_Tools'),
        centerTitle:true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.menu), // Icono del menú
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer(); // Abre el Drawer
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black54,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const Center (
              child: UserAccountsDrawerHeader(
              
              accountName: Text("Suleika Mercedes"),
              accountEmail: Text("20210573@itla.edu.do"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/sule.jpg'),
              ),
              decoration: BoxDecoration(
              color: Color.fromARGB(255, 160, 142, 115), 
              ),
            ),
            ),
            ListTile(
              title: const Text('Acerca de', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white), ),
              onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const AboutAppScreen()));
                
              },
            ),
            ListTile(
              title: const Text('Creditos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),),
              onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const CreditsAppScreen()));
              },
            ),
            ListTile(
              title: const Text('Contacto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),),
              onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const HireAppScreen()));
              },
            ),
          ],
        ),
      ),
      body: Column(
          children: <Widget>[
            // Widget para mostrar el texto en la parte superior
            Container(
            width: 520,
            color: Colors.purple,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(35.0),
            decoration: null,
            child: const Text(
              'App de herramientas.',
              style: TextStyle(
                fontWeight: FontWeight.bold,  // Agregar negrita
                color: Colors.white,  // Cambiar el color del texto
                fontSize: 15,  // Tamaño del texto (ajusta según tus preferencias)
              ),
            ),
          ),
            // Widget para mostrar la imagen
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/confi.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Widget para mostrar el botón con nombre e icono
            Container(
              width: 520,
              color: Colors.purple,
              decoration: null,
              padding: const EdgeInsets.all(35.0), // Añade espaciado alrededor del botón
              child: ElevatedButton.icon(
                onPressed: () {
                  // Lógica cuando se presiona el botón
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CardOptions()));
                },
                icon: const Icon(Icons.input_outlined), // Icono del botón
                label: const Text('ENTRAR'), // Texto del botón
              ),
            ),
          ],
        ),
    
    );
  }
}

//Pantalla de opciones de herramientas...
class CardOptions extends StatelessWidget {
  const CardOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kit de herramientas'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.purple,
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(40),
                  child: const Text(
                    'Elige una opción:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          right: 10,
                          left: 35,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const GenderPredictionScreen()));
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.group_add_outlined, size: 80, color: Colors.yellow),
                              Text('Genero', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          right: 35,
                          left: 10,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AgePredictionScreen()));
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.child_care_outlined, size: 80, color: Colors.brown),
                              Text('Edad', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          right: 10,
                          left: 35,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WeatherScreen()));
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.wb_sunny_outlined, size: 80, color: Colors.red),
                              Text('Clima', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          right: 35,
                          left: 10,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WordPressNewsScreen()));
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.public, size: 80, color: Colors.blue),
                              Text('WordPress', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          right: 10,
                          left: 35,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const UniversitiesScreen()));
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.school_outlined, size: 80, color: Colors.orange),
                              Text('University', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
          const Positioned(
            top: 520,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  '"¡La mejor app de herramientas!"',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),
                ),
                SizedBox(height: 20, width: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


//Pantalla para la opcion "Acerca de" del menu...
class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de "SM_Tools"'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color.fromARGB(255, 132, 96, 139),
      body: Center(
        child: Container(
          height: 550,
          margin: const EdgeInsets.all(16), 
          padding: const EdgeInsets.all(16), 
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(8), 
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5, 
              ),
            ],
          ),
          child: const SingleChildScrollView( 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Acerca de la Aplicación',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 12),
                Text(
                  '¡Bienvenidos a esta aplicaión!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 6),
                Text(
                  'Aquí podrás ver información sobre el clima, predecir edad, genero, y otras cosas más.',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 6),
                Text(
                  'Gracias.',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Pantalla para la opcion "Creditos" del menu...
class CreditsAppScreen extends StatelessWidget {
  const CreditsAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creditos'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color.fromARGB(255, 132, 96, 139), 
      body: Center(
        child: Container(
          height: 550,
          margin: const EdgeInsets.all(16), 
          padding: const EdgeInsets.all(16), 
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(8), 
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5, 
              ),
            ],
          ),
          child: const SingleChildScrollView( 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                SizedBox(height: 16),
                Text(
                  'Creditos',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 16),
                Text(
                  'Desarrolladora:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 16),
                Text(
                  'Suleika Mercedes',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 16),
                Text(
                  'Persona apasionada al desarrollo.',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                SizedBox(height: 16),
                Text(
                  '26-10-2023',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Pantalla para la opcion "Contacto" del menu...
class HireAppScreen extends StatelessWidget {
  const HireAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacto"'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color.fromARGB(255, 132, 96, 139), 
      body: Center(
        child: Container(
          height: 550,
          width: 350,
          margin: const EdgeInsets.all(16), 
          padding: const EdgeInsets.all(16), 
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(8), 
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5, 
              ),
            ],
          ),
          child: const SingleChildScrollView( 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
              backgroundImage: AssetImage('assets/sule.jpg'), 
              radius: 80, 
            ),
            SizedBox(height: 20), 
            Text(
              'Suleika Mercedes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black, 
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Teléfono:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black, 
              ),
            ),
            SizedBox(height: 20),
            Text(
              '+1 829-751-0360',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            Text(
              'Correo:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '20210573@itla.edu.do',
              style: TextStyle(fontSize: 18),
            ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}