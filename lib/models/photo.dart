import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Photo {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl
  });

  factory Photo.fromJson(Map<String, dynamic> json){
    return Photo(albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl']);
  }
}

class Album {
  final List<Photo> album;

  Album({required this.album});

  factory Album.fromJson(List<dynamic> parseJson){
    List<Photo> album = <Photo>[];
    album = parseJson.map((i) => Photo.fromJson(i)).toList();
    return Album(album: album);
  }
}