import 'dart:convert';

import 'package:exploring_photos_api/model/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExploringPhotosApi extends StatefulWidget {
  const ExploringPhotosApi({Key? key}) : super(key: key);

  @override
  State<ExploringPhotosApi> createState() => _ExploringPhotosApiState();
}

class _ExploringPhotosApiState extends State<ExploringPhotosApi> {
  final List<Photos> _photosData = [];

  Future<List<Photos>> _fetchPhotos() async {
    final http.Response response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );
    if (response.statusCode == 200) {
      var parsedJson = jsonDecode(response.body);
      for (Map<String, dynamic> json in parsedJson) {
        setState(() {
          _photosData.add(Photos.fromJson(json));
        });
      }
      return _photosData;
    } else {
      throw Exception('Unable to load Photos...');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exloring Photos Api'),
      ),
      body: ListView.builder(
        itemCount: _photosData.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: const Text('Photo Details Page'),
                    ),
                    body: Center(
                        child: Image.network(
                      _photosData[index].thumbnailUrl,
                    )),
                  ),
                ),
              );
            },
            child: Card(
              child: ListTile(
                leading: Image.network(
                  _photosData[index].url,
                ),
                title: Text(
                  _photosData[index].title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(_photosData[index].id.toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}
