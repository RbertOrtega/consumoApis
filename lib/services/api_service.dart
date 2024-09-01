import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class ApiService {
  final String apiKey = 'YOUR_API_KEY';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchPopularMovies() async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['results'];
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
