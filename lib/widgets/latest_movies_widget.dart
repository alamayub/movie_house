import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../providers/api.dart';
import 'loader.dart';
import 'movies_list_widget.dart';

class LatestMoviesWidget extends StatelessWidget {
  final bool isHorizontal;
  const LatestMoviesWidget({
    super.key,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: Api().getMoviesBy('latest'),
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
