import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/api_service.dart';
import 'movie_detail_screen.dart'; // Asegúrate de que esta ruta sea correcta

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = ApiService().fetchPopularMovies();
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
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: snapshot.data![index].posterPath.isNotEmpty
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w500${snapshot.data![index].posterPath}')
                      : null,
                  title: Text(snapshot.data![index].title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailScreen(movie: snapshot.data![index]),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No movies found.'));
          }
        },
      ),
    );
  }
}
