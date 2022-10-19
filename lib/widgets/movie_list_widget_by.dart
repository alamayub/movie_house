import 'package:flutter/material.dart';
import 'package:movie_house/widgets/movies_list_widget.dart';

import '../models/movie_model.dart';
import '../providers/api.dart';
import 'loader.dart';

class MoviesListWidgetBy extends StatelessWidget {
  final String type;
  final bool isHorizontal;

  const MoviesListWidgetBy({
    super.key,
    required this.type,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: Api().getMoviesBy(type),
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
