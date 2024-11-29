import 'dart:convert';

import 'package:albums_app/data/models/photo.dart';
import 'package:albums_app/data/providers/photo_provider.dart';

class PhotoRepository {
  final PhotoProvider photoProvider;
  const PhotoRepository({required this.photoProvider});

  Future<List<Photo>> fetchImages(String albumId) async {
    try {
      var response = await photoProvider.getImages(albumId);
      List<dynamic> jsonData = json.decode(response);

      // Map the JSON data to a list of Album objects
      List<Photo> images =
          jsonData.map((item) => Photo.fromJson(item)).toList();

      return images;
    } catch (error) {
      throw Exception('Failed to load images $error');
    }
  }
}
