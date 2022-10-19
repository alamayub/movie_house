import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import '../models/movie_model.dart';
import 'movie_card.dart';

class MoviesListWidget extends StatelessWidget {
  final List<MovieModel> movies;
  final bool isHorizontal;
  const MoviesListWidget({
    Key? key,
    required this.movies,
    this.isHorizontal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return movies.isNotEmpty
        ? isHorizontal == true
            ? CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  height: 132,
                ),
                items: movies
                    .map((e) => Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: MovieCard(movieModel: e),
                        ))
                    .toList(),
              )
            : ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (_, i) => MovieCard(
                  movieModel: movies[i],
                ),
                separatorBuilder: (_, i) => const SizedBox(height: 12),
                itemCount: movies.length,
              )
        : const Center(
            child: Text('No movie found'),
          );
    // return movies.isNotEmpty ? ListView.separated(
    //   shrinkWrap: true,
    //   primary: false,
    //   padding: const EdgeInsets.all(16),
    //   itemBuilder: (_, i) => MovieCard(movieModel: movies[i]),
    //   separatorBuilder: (_, i) => const SizedBox(height: 12),
    //   itemCount: movies.length,
    // ) : const Center(
    //   child: Text('No movie found'),
    // );
  }
}
