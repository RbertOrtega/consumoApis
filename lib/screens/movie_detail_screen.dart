import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
            SizedBox(height: 16.0),
            Text(
              movie.title,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
