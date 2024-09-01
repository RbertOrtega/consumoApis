import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    // Inicializa ApiService correctamente
    ApiService apiService = ApiService();
    futureMovies =
        apiService.fetchPopularMovies(); // Llama al método fetchPopularMovies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                  leading: movie.posterPath.isNotEmpty
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}')
                      : null,
                );
              },
            );
          }
        },
      ),
    );
  }
}
