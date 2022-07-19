import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_info/api_infor.dart';
import 'models/photo.dart';

Future<Album> fetchAlbum() async {
  final response =
      await http.get(Uri.parse(URL_GET_PHOTOS));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  }
  throw Exception();
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Quản lý Album',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.orangeAccent,
        ),
        body: FutureBuilder<Album>(
          future: fetchAlbum(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              final Album album = snapshot.data!;
              return _buildListView(context, album);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, Album album) {
    
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    print ('Width: $_width , Height: $_height');
    
    return Container(
      width: _width,
      height: _height,
      margin: const EdgeInsets.all(20),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              width: _width,
              height: 120,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      album.photos[index].url,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'id: ${album.photos[index].id}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text('title: ${album.photos[index].title}')
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: album.photos.length),
    );
  }
}
