import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../providers/api.dart';
import 'loader.dart';
import 'movies_list_widget.dart';

class MyRecommendedMovies extends StatelessWidget {
  final int id;
  final bool click;
  final bool isHorizontal;
  const MyRecommendedMovies({
    super.key,
    required this.id,
    required this.click,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: Api().getRecommendedMovies(id),
      builder: (_, snap) {
        if (snap.connectionState == ConnectionState.done) {
          if (snap.hasData) {
            final List<MovieModel> movies = snap.data!;
            return MoviesListWidget(
              movies: movies,
              isHorizontal: isHorizontal,
            );
          }
          return Center(
            child: Text('Error ${snap.error.toString()}'),
          );
        }
        return const Center(
          child: Loader(),
        );
      },
    );
  }
}
