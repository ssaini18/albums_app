import 'dart:convert';

import '../models/album.dart';
import '../providers/album_provider.dart';

class AlbumRepository {
  final AlbumProvider albumProvider;
  const AlbumRepository({required this.albumProvider});

  Future<List<Album>> fetchAlbums() async {
    try {
      var response = await albumProvider.getAlbums();
      List<dynamic> jsonData = json.decode(response);

      // Map the JSON data to a list of Album objects
      List<Album> albums =
          jsonData.map((item) => Album.fromJson(item)).toList();

      return albums;
    } catch (error) {
      throw Exception(
        'Failed to load albums $error',
      );
    }
  }
}
