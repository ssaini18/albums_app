import 'package:http/http.dart' as http;

class PhotoProvider {
  const PhotoProvider();

  static const String baseUrl = 'https://jsonplaceholder.typicode.com/';

  Future<String> getImages(String albumId) async {
    try {
      final response =
          await http.get(Uri.parse('${baseUrl}photos?albumId=$albumId'));

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the response body as a JSON array
        return response.body;
      } else {
        throw Exception('Failed to load images: ${response.statusCode}');
      }
    } catch (error) {
      // Catch and handle any errors that occur during the API request
      throw Exception('Error fetching images: $error');
    }
  }
}
