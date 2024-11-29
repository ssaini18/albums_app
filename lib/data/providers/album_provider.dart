import 'package:http/http.dart' as http;

class AlbumProvider {
  const AlbumProvider();

  static const String baseUrl = 'https://jsonplaceholder.typicode.com/';

  Future<String> getAlbums() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}albums'));

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the response body as a JSON array
        return response.body;
      } else {
        throw Exception('Failed to load albums: ${response.statusCode}');
      }
    } catch (error) {
      // Catch and handle any errors that occur during the API request
      throw Exception('Error fetching albums: $error');
    }
  }
}
