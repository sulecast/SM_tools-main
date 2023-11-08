// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(
    home: WordPressNewsScreen(),
  ));
}

class WordPressNewsScreen extends StatefulWidget {
  const WordPressNewsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WordPressNewsScreenState createState() => _WordPressNewsScreenState();
}

class _WordPressNewsScreenState extends State<WordPressNewsScreen> {
  List<WordPressNewsItem> _newsItems = [];

  @override
  void initState() {
    super.initState();
    _fetchWordPressNews();
  }
  //https://apit-barcelona.org/wp-json/wp/v2/posts

  Future<void> _fetchWordPressNews() async {
    final response = await http.get(
        Uri.parse('https://apit-barcelona.org/wp-json/wp/v2/posts'));
        //Uri.parse('https://apit-barcelona.org/wp-json/wp/v2/posts'));
        

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<WordPressNewsItem> newsItems =
          data.map((item) => WordPressNewsItem.fromMap(item)).toList();

      setState(() {
        _newsItems = newsItems;
      });
    } else {
      print('Error al cargar noticias');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias de WordPress'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.purple,
      body: ListView.builder(
        itemCount: _newsItems.length,
        itemBuilder: (context, index) {
          final item = _newsItems[index];
          return Card(
            elevation: 10,
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                ListTile(
                  leading: Image.network(item.featuredImage),
                  title: Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    item.excerpt,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _launchURL(item.link);
                    },
                    child: const Text('Visitar'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('No se pudo abrir este enlace $url');
    }
  }
}

class WordPressNewsItem {
  final String title;
  final String excerpt;
  final String featuredImage;
  final String link;

  WordPressNewsItem({
    required this.title,
    required this.excerpt,
    required this.featuredImage,
    required this.link,
  });

  factory WordPressNewsItem.fromMap(Map<String, dynamic> map) {
    return WordPressNewsItem(
      title: map['title']['rendered'],
      excerpt: map['excerpt']['rendered'],
      featuredImage: map['jetpack_featured_media_url'] ?? '',
      link: map['link'] ?? '',
    );
  }
}
