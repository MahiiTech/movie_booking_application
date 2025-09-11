import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_application/models/movie_response_model.dart';

class ApiService {
  final String apiUrl =
      "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/videos.json";

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception("Unable to Fetch it ");
    }
  }
}
